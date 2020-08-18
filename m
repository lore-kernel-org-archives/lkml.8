Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44584C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A4842086A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597762756;
	bh=02EOwybU6zhy34SUyOD0Ww16vKKFrDWg2vE1jWYZ+6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W87C6pMa+9US0U7Wtd0CKAhbk2XwHDbCtXfGHoBWFhCfBmSGzshtQnGE4Y97wldls
	 vu0aDNoMTvxxj0LQG4nioCfN9wSvMNVKhiLJqPfzA8hX4nCuP24Yx0FHKTfnutH33K
	 Ns+iO9SFVWuWClkpgtSDopeTZCyXfWTJjZZnuzGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgHRO7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:59:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727896AbgHRO7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:59:05 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E67920825;
        Tue, 18 Aug 2020 14:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597762745;
        bh=02EOwybU6zhy34SUyOD0Ww16vKKFrDWg2vE1jWYZ+6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cxGylnSpau9RoN+mCyhoeAydKOo0uG1HBzvHjhJWNtGFxKpGqcqplkQ66ls9VGTE9
         pghkvHxTx4aG5aUZvg/PBnJ84MnigsTcOWA9LznCWcfrOd6gboutGVY/jlrLeSeSzE
         IPdNCwDPQExqozo4XgSnbF++o+2V5X0l26IbteBc=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k834p-00EGAg-3d; Tue, 18 Aug 2020 16:59:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] staging: spmi: hisi-spmi-controller: change compatible string
Date:   Tue, 18 Aug 2020 16:58:55 +0200
Message-Id: <f34062e82b5d5ee49aab4f9055b44e42e5023f0a.1597762400.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597762400.git.mchehab+huawei@kernel.org>
References: <cover.1597762400.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the chipset name at the compatible string, as other
HiSilicon chipsets with SPMI bus might require something
different.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hisi-spmi-controller.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/hikey9xx/hisi-spmi-controller.c b/drivers/staging/hikey9xx/hisi-spmi-controller.c
index 513d962b8bce..66a0b296e06f 100644
--- a/drivers/staging/hikey9xx/hisi-spmi-controller.c
+++ b/drivers/staging/hikey9xx/hisi-spmi-controller.c
@@ -324,7 +324,8 @@ static int spmi_del_controller(struct platform_device *pdev)
 }
 
 static const struct of_device_id spmi_controller_match_table[] = {
-	{	.compatible = "hisilicon,spmi-controller",
+	{
+		.compatible = "hisilicon,kirin970-spmi-controller",
 	},
 	{}
 };
-- 
2.26.2

