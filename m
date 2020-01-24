Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D735C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67603222D9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579858796;
	bh=iflJxlVj9GP6HYMkPZJAfQd+eNQgJamxdRr6nK2NHJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DJ6bFCkgtqSf78m8VYZ7WQZhlzks1/kmgzt9b+bJET73ZsD/n583XQfj/z5kafKUo
	 DI82BhtTLENwdICPJVOAuEvKWY0n7EaOfCZkQtljDAoAS8Pgn+Nw2UVdokYJWwCpLY
	 Tj1aeiu1qDeP3fXdT8xTSNPdIXxQjGUZyy+B/vfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731666AbgAXJj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:39:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:36564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731634AbgAXJjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:39:23 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40EEC20838;
        Fri, 24 Jan 2020 09:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579858762;
        bh=iflJxlVj9GP6HYMkPZJAfQd+eNQgJamxdRr6nK2NHJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KOcT5Ug6DvT+wHuUPByyIR9TJx/DCj3Q9HhSUvHU9NOTxxjorFUSPkkyZs3/+s5B+
         Xw/vWILaHS0QGX95u7FVhfpjG+/HCR8cP44Y+GBsYZ6iMd9wxWe6LzDlTHcTTBwX+Z
         TG2XecQoHzn8pqN5iHeYCKDPz2RMthKVAryocBCY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kubakici@wp.pl>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.4 033/102] mt7601u: fix bbp version check in mt7601u_wait_bbp_ready
Date:   Fri, 24 Jan 2020 10:30:34 +0100
Message-Id: <20200124092811.239592861@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092806.004582306@linuxfoundation.org>
References: <20200124092806.004582306@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

commit 15e14f76f85f4f0eab3b8146e1cd3c58ce272823 upstream.

Fix bbp ready check in mt7601u_wait_bbp_ready. The issue is reported by
coverity with the following error:

Logical vs. bitwise operator
The expression's value does not depend on the operands; inadvertent use
of the wrong operator is a likely logic error.

Addresses-Coverity-ID: 1309441 ("Logical vs. bitwise operator")
Fixes: c869f77d6abb ("add mt7601u driver")
Acked-by: Jakub Kicinski <kubakici@wp.pl>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/mediatek/mt7601u/phy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/mediatek/mt7601u/phy.c
+++ b/drivers/net/wireless/mediatek/mt7601u/phy.c
@@ -213,7 +213,7 @@ int mt7601u_wait_bbp_ready(struct mt7601
 
 	do {
 		val = mt7601u_bbp_rr(dev, MT_BBP_REG_VERSION);
-		if (val && ~val)
+		if (val && val != 0xff)
 			break;
 	} while (--i);
 


