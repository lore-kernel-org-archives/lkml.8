Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EF9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB7C207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597882013;
	bh=KsG7lhYjGtEOo5pRqW4HDh0Yda+6027PDm5WZMqw23Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cExlaDR6Dg4b4DV5EAjLOM27AnOmK+MDs8x6JdTs2rmLE7VxVTvjwTBsBAvuKmbwT
	 fFTs1PSbRIfJMMEKD9BYsceAnM59sYpny4Rg8CeeavvpVpapnOs5IGbe8KeRhh33ty
	 c7sFgFZv5p0bgJ1rQpEhz4ITwVpEO6ZeSg5s7bLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgHTAGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 20:06:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728306AbgHTADf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 20:03:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E256207FB;
        Thu, 20 Aug 2020 00:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597881814;
        bh=KsG7lhYjGtEOo5pRqW4HDh0Yda+6027PDm5WZMqw23Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P/V8AUaJizyZwv4rJ675bg6KDPLHA+YAzdZ+HusadRagT4NyvZjp+2ibeqRMHtyhv
         6j8cC4gtWs5CFHdT/+2kt8g24+0h4GzB37O2EZA2EG5QkFogTMtaPWhjae6rBVOaWK
         JI7e44YvMM/HLgCutAclpAM65GQ1Oy53mZgOb+m0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Evgeny Novikov <novikov@ispras.ru>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 04/13] media: vpss: clean up resources in init
Date:   Wed, 19 Aug 2020 20:03:19 -0400
Message-Id: <20200820000328.215755-4-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820000328.215755-1-sashal@kernel.org>
References: <20200820000328.215755-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeny Novikov <novikov@ispras.ru>

[ Upstream commit 9c487b0b0ea7ff22127fe99a7f67657d8730ff94 ]

If platform_driver_register() fails within vpss_init() resources are not
cleaned up. The patch fixes this issue by introducing the corresponding
error handling.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/davinci/vpss.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/davinci/vpss.c b/drivers/media/platform/davinci/vpss.c
index 2ee4cd9e6d80f..d984f45c03149 100644
--- a/drivers/media/platform/davinci/vpss.c
+++ b/drivers/media/platform/davinci/vpss.c
@@ -514,19 +514,31 @@ static void vpss_exit(void)
 
 static int __init vpss_init(void)
 {
+	int ret;
+
 	if (!request_mem_region(VPSS_CLK_CTRL, 4, "vpss_clock_control"))
 		return -EBUSY;
 
 	oper_cfg.vpss_regs_base2 = ioremap(VPSS_CLK_CTRL, 4);
 	if (unlikely(!oper_cfg.vpss_regs_base2)) {
-		release_mem_region(VPSS_CLK_CTRL, 4);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_ioremap;
 	}
 
 	writel(VPSS_CLK_CTRL_VENCCLKEN |
-		     VPSS_CLK_CTRL_DACCLKEN, oper_cfg.vpss_regs_base2);
+	       VPSS_CLK_CTRL_DACCLKEN, oper_cfg.vpss_regs_base2);
+
+	ret = platform_driver_register(&vpss_driver);
+	if (ret)
+		goto err_pd_register;
+
+	return 0;
 
-	return platform_driver_register(&vpss_driver);
+err_pd_register:
+	iounmap(oper_cfg.vpss_regs_base2);
+err_ioremap:
+	release_mem_region(VPSS_CLK_CTRL, 4);
+	return ret;
 }
 subsys_initcall(vpss_init);
 module_exit(vpss_exit);
-- 
2.25.1

