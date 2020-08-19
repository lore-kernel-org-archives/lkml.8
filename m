Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695C1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AB8B2063A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597838798;
	bh=AplyS5ahJiDqgsjYpd/jC+3AT97g9u4ZTna2SJacBFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ijdMY18MwLMlGfzLpj1/UINyGdt20e4O5KHBC1cd7tVlTJ3N5JQgrr+ryd5V6/lGK
	 UIN8ft3xvvNN6xuphu4FPTrwsWvWUfPboRsQ6BRqtu3I3TMGc00FQW1FEiRmY0rgAQ
	 rsOj+YsWU0Qn45yqEtW9I/BkwSAKlTnT3aSzNkuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgHSMGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:06:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728215AbgHSLrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:47:40 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A427A22D6E;
        Wed, 19 Aug 2020 11:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597837582;
        bh=AplyS5ahJiDqgsjYpd/jC+3AT97g9u4ZTna2SJacBFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sqfyjKCQjF+itcV0BTVmvJI7N0arDtNR3lzIWAIjq8bgi6fCzysL/K+Q+Esm4nH+9
         W97EQfekA9GOfwCqLaZMSzwfvOlYwi6HEykdVMUY4fp5CcEZ/Tp4KreWoJujw11tZn
         2V/3z/XDsv9Le+FN2p0MzgF3nDroRsKOT4cvivOk=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k8MXs-00EubJ-IH; Wed, 19 Aug 2020 13:46:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xiubin Zhang <zhangxiubin1@huawei.com>,
        Liwei Cai <cailiwei@hisilicon.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 31/49] staging: hikey9xx/gpu: fix driver name
Date:   Wed, 19 Aug 2020 13:45:59 +0200
Message-Id: <14e05c0ea88671dc2e40282a4e5a0833117e673d.1597833138.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597833138.git.mchehab+huawei@kernel.org>
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/gpu/kirin9xx_dw_drm_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_dw_drm_dsi.c b/drivers/staging/hikey9xx/gpu/kirin9xx_dw_drm_dsi.c
index 09d035038c1a..99be8dfe05e6 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_dw_drm_dsi.c
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_dw_drm_dsi.c
@@ -2074,7 +2074,7 @@ static struct platform_driver dsi_driver = {
 	.probe = dsi_probe,
 	.remove = dsi_remove,
 	.driver = {
-		.name = "dw-dsi",
+		.name = "kirin9xx-dw-dsi",
 		.of_match_table = dsi_of_match,
 	},
 };
-- 
2.26.2

