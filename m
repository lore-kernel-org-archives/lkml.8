Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1FEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD263207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592446877;
	bh=CfjdaiD3CHfP1mp54VQFhoyb/LcS2K9xmJBfV/HAfmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GPZOz9y1p1bUyxFB1WCmZqObF5uCuUITpyL9yeHZwcexqx73hbgDKeH2V2nYBtjFY
	 jXuReMCk8u+TfYxQ3V9sYn2C+EzrCx4Twuiz5kTZOeM3A1u10zGCcl6gfrZwr8uGZv
	 uiqlpEW0xLSLB6eCM2cLJO4Htp4i7RIQtArmvDY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbgFRBSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:18:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729514AbgFRBPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:15:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C93C2088E;
        Thu, 18 Jun 2020 01:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442940;
        bh=CfjdaiD3CHfP1mp54VQFhoyb/LcS2K9xmJBfV/HAfmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rYVpqm/E0RxxVh85LGH2JCbhE/hg2PzZaBlEwgJomyJYUHpEOur8o25p4RavC9FKb
         JfGHwNVrX3Z74dyXIPqcQZPz8MaqsKPaeJ6W1CQGI0dyFX9X5cClbHqMaIGslPM8Ji
         3oYQaXibT368UOcrE9m2bFUSYJp+z6zpjDxzPUyE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Alexander Fomichev <fomichev.ru@gmail.com>,
        Jon Mason <jdmason@kudzu.us>, Sasha Levin <sashal@kernel.org>,
        linux-ntb@googlegroups.com
Subject: [PATCH AUTOSEL 5.7 351/388] NTB: perf: Don't require one more memory window than number of peers
Date:   Wed, 17 Jun 2020 21:07:28 -0400
Message-Id: <20200618010805.600873-351-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
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
index 1c93b9f5c73b..21c8a3bac1e0 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -654,7 +654,7 @@ static int perf_init_service(struct perf_ctx *perf)
 {
 	u64 mask;
 
-	if (ntb_peer_mw_count(perf->ntb) < perf->pcnt + 1) {
+	if (ntb_peer_mw_count(perf->ntb) < perf->pcnt) {
 		dev_err(&perf->ntb->dev, "Not enough memory windows\n");
 		return -EINVAL;
 	}
-- 
2.25.1

