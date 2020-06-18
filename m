Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E00BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D73FC20739
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592446271;
	bh=G8BSZs6KA0xwX2Q79YxelNJnPH/BksrqjktLIHO0830=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nNAkoW+xOXQ7Tsy1ai1VYRUyatnsLG0gptd91HkeFb36SKkBlDJov4D1JuUDal/Cq
	 EZ+6MttMpw3gFTFuk+zyOLzbP6BJokxy/9FrGnlqxntFaXCZn+7bsKImiyqbLRcoUt
	 uGKsFaSsUC+EqE6WGiPhCMPW4QBNpyKFEAcy01lI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbgFRCLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:11:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728407AbgFRBVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:21:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B47421974;
        Thu, 18 Jun 2020 01:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443302;
        bh=G8BSZs6KA0xwX2Q79YxelNJnPH/BksrqjktLIHO0830=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ctsi6t3quBH0Jp80WmzXF7nHPg108tGUCnZqCbTHq8/BIry5Y4pURjZ0TaQkpERLj
         YFNewSbB+yejU/AV1IFPeOvGBomrxHwpYqFFrynZwYvYAEmf8/MXVfgzpAnm1ZGyE/
         fcWvyEEdGD19DvSoUuRAPSJyDdZmGVbvWXzvm9u8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Alexander Fomichev <fomichev.ru@gmail.com>,
        Jon Mason <jdmason@kudzu.us>, Sasha Levin <sashal@kernel.org>,
        linux-ntb@googlegroups.com
Subject: [PATCH AUTOSEL 5.4 241/266] NTB: perf: Don't require one more memory window than number of peers
Date:   Wed, 17 Jun 2020 21:16:06 -0400
Message-Id: <20200618011631.604574-241-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Logan Gunthorpe <logang@deltatee.com>

[ Upstream commit a9c4211ac918ade1522aced6b5acfbe824722f7d ]

ntb_perf should not require more than one memory window per peer. This
was probably an off-by-one error.

Fixes: 5648e56d03fa ("NTB: ntb_perf: Add full multi-port NTB API support")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Allen Hubbe <allenbh@gmail.com>
Tested-by: Alexander Fomichev <fomichev.ru@gmail.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ntb/test/ntb_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 52c29791fc02..3817eadab2cf 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -653,7 +653,7 @@ static int perf_init_service(struct perf_ctx *perf)
 {
 	u64 mask;
 
-	if (ntb_peer_mw_count(perf->ntb) < perf->pcnt + 1) {
+	if (ntb_peer_mw_count(perf->ntb) < perf->pcnt) {
 		dev_err(&perf->ntb->dev, "Not enough memory windows\n");
 		return -EINVAL;
 	}
-- 
2.25.1

