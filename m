Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7D8C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F3272074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598261295;
	bh=1IES0gm3oirDe7IZ79Li86odL9lbx2TB4xRbdXUVcBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ASSKRxxSQjQzLJ0AqS/ULiGYVXIRmxTs66rPMj+NKlQj7P707UTjVml7VSnypSwUc
	 Fb4gXO/GkiIiFEgUTGppLYWVGgGJmmmI/GirhwB5SMzVQEp7+Eij+TUs2k3r75HrUp
	 gm1MU4F7Cs13cobfeUzB3g72JEVAiFRCvOhM/rAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbgHXIvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:51:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729956AbgHXIvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:51:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 372752075B;
        Mon, 24 Aug 2020 08:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598259100;
        bh=1IES0gm3oirDe7IZ79Li86odL9lbx2TB4xRbdXUVcBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cvuwiHvjdudpbgNQnZAlNZO7nhNXcR5eGE7EeRyDapwym+UFx7McRAkBQrjg80CjV
         vlfj0TriVTyM+qvCdDibE2UihmD5THSkhjGRVq2kQnk+am8kLeM4t79KoFRzGvVGcY
         OB1VJ/SSjgPMjh+dghg4vxcNKZ5HwVkafMZLz4zM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evgeny Novikov <novikov@ispras.ru>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 20/39] media: vpss: clean up resources in init
Date:   Mon, 24 Aug 2020 10:31:19 +0200
Message-Id: <20200824082349.579327492@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082348.445866152@linuxfoundation.org>
References: <20200824082348.445866152@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index c2c68988e38ac..9884b34d6f406 100644
--- a/drivers/media/platform/davinci/vpss.c
+++ b/drivers/media/platform/davinci/vpss.c
@@ -519,19 +519,31 @@ static void vpss_exit(void)
 
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



