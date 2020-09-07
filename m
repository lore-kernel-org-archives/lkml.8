Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3392C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8048021481
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UW3UusVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgIGHvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgIGHvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:51:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3803EC061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 00:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=CfGrQwjIWWxrzVTImftPzeOSlroe1EbyaTjb+reuL5c=; b=UW3UusVQMUtadow+L2UMRBtB6X
        WLHdUZJXzFHu/ViQBy+Mwp0zznlR2+ZQTz/pkM1lh0c16Xb1coRvO0w/g7BuP1IWFPxq/HvFeJ/0d
        dfh7pziiw4754ImbFT1MCoYPpdIBoPwOnOMgPjxMIrPpi6tlBC+Tlixo/V/jDXeuJWNq0ZRID7U2U
        28CvZlN9dXbrpR18Xw8RtxA/j1hiDuD590ec/9F8Xp2qJT97pgs4dwjx3zSerGHJb1oJL+HZdhVm3
        oLep23PitbL/U8n6r6XsUS9btOM6xoWR1UtAtt0ViA8EZH7HC3hSDWMFxHsz19+SGgBTgkmSDjgdf
        gSCJ0Bsw==;
Received: from [2001:4bb8:184:af1:e178:97b2:ac6b:4e16] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFBwH-0001Oi-Tj; Mon, 07 Sep 2020 07:51:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2] /dev/zero: also implement ->read
Date:   Mon,  7 Sep 2020 09:51:43 +0200
Message-Id: <20200907075143.2023440-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe reported a major speedup due to avoiding the iov_iter
overhead, so just add this trivial function.

Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---

Changes since v1:
 - fix the Suggested-by: tag
 - report the actually read bytes in case of a partial clear_user
 - remove an impossible to hit conditional

 drivers/char/mem.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index abd4ffdc8cdebc..94c2b556cf9728 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -726,6 +726,33 @@ static ssize_t read_iter_zero(struct kiocb *iocb, struct iov_iter *iter)
 	return written;
 }
 
+static ssize_t read_zero(struct file *file, char __user *buf,
+			 size_t count, loff_t *ppos)
+{
+	size_t cleared = 0;
+
+	while (count) {
+		size_t chunk = min_t(size_t, count, PAGE_SIZE);
+		size_t left;
+
+		left = clear_user(buf + cleared, chunk);
+		if (unlikely(left)) {
+			cleared += (chunk - left);
+			if (!cleared)
+				return -EFAULT;
+			break;
+		}
+		cleared += chunk;
+		count -= chunk;
+
+		if (signal_pending(current))
+			break;
+		cond_resched();
+	}
+
+	return cleared;
+}
+
 static int mmap_zero(struct file *file, struct vm_area_struct *vma)
 {
 #ifndef CONFIG_MMU
@@ -921,6 +948,7 @@ static const struct file_operations zero_fops = {
 	.llseek		= zero_lseek,
 	.write		= write_zero,
 	.read_iter	= read_iter_zero,
+	.read		= read_zero,
 	.write_iter	= write_iter_zero,
 	.mmap		= mmap_zero,
 	.get_unmapped_area = get_unmapped_area_zero,
-- 
2.28.0

