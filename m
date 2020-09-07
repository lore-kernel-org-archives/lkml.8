Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5745CC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D65BE208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V17bMqD9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgIGI1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbgIGI1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:27:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8C2C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 01:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=qnwYE2OXqJPyGJ1Z6lt7Krlp010h2nSE4niWx+cXvY8=; b=V17bMqD9tDMFdzBW/auH/HdokX
        rpBj8Bb+K1/gIlR8+SmJgTttJ/k6k+EeynpdvcINSQ/L/aiHxpV4AriI0n/Uzd+weRqdw81HDIWRr
        6EjElxjLHaK+bZlnOxG3rSx1/XOAjAq35fbTFxGql+TmyPhvnqGCVDcrxTMOcE3yXRGDElWvS6ZDF
        Ulfpu9EZoTTJcbuH02L9gmmTJH1AmNv3kS9Yfy6yKw+h55ddcmAorxK86yBelyRx8RDA2wBXROr4J
        jNjP1oJA3OPui9Aehd1Tj5U8a0GHE/X9uO23y8QgpWKNDzTBl+B72Lzsh68sCXUpiblM/j6TrsfOx
        M8feRwwg==;
Received: from 213-225-10-73.nat.highway.a1.net ([213.225.10.73] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFCUP-0003Zp-Ld; Mon, 07 Sep 2020 08:27:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] /dev/zero: fixups for ->read
Date:   Mon,  7 Sep 2020 10:27:00 +0200
Message-Id: <20200907082700.2057137-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported the cleared bytes in case of a partial clear_user instead
of -EFAULT, and remove a pointless conditional, as cleared must be
non-zero by the time we hit the signal_pending check.

Reported-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/char/mem.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 1dc99ab158457a..94c2b556cf9728 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -733,14 +733,20 @@ static ssize_t read_zero(struct file *file, char __user *buf,
 
 	while (count) {
 		size_t chunk = min_t(size_t, count, PAGE_SIZE);
+		size_t left;
 
-		if (clear_user(buf + cleared, chunk))
-			return cleared ? cleared : -EFAULT;
+		left = clear_user(buf + cleared, chunk);
+		if (unlikely(left)) {
+			cleared += (chunk - left);
+			if (!cleared)
+				return -EFAULT;
+			break;
+		}
 		cleared += chunk;
 		count -= chunk;
 
 		if (signal_pending(current))
-			return cleared ? cleared : -ERESTARTSYS;
+			break;
 		cond_resched();
 	}
 
-- 
2.28.0

