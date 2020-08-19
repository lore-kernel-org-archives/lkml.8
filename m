Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE5FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6278207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597837723;
	bh=sWOX5FKJVo25rvcaBRtNV8C2NIEpxpnCUg9AT1YPfsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IqV8dHHt/GFTlO2mRwpjbmHJNzea5//tVE1D8jtMgqQDALHsLJX88m8OW14bqie6r
	 HswJ806WLW7ITaCaQhEh5cvQTCQdUqxfcjWslDUvIgi7ofQSAI4WAEGJ7aIdo5uY91
	 /4RUN5TLjlQzQTlW31jLwV9sGOxtbtLyISUvgpkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgHSLsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 07:48:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728028AbgHSLqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:46:22 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB59320897;
        Wed, 19 Aug 2020 11:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597837581;
        bh=sWOX5FKJVo25rvcaBRtNV8C2NIEpxpnCUg9AT1YPfsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GGOjksER+WVH39ZhhD4lUqDN11Z4YpQ+FAIihEHjewNmZzlQ9z/5xAFzOmPGBJm4c
         6/nUj9eWSvK9la6CjHZVSPG25sHzdsI6X2/9et0QWTFYF4t+vvkTk1T4I42wCAAy4r
         l1FRYJY/kzeiEFiTSTVy5wYFntgnmEekCJo4S5YI=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k8MXr-00EuaO-PA; Wed, 19 Aug 2020 13:46:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Xiubin Zhang <zhangxiubin1@huawei.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Liwei Cai <cailiwei@hisilicon.com>,
        Wanchun Zheng <zhengwanchun@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/49] staging: hikey9xx/gpu: Add support 10.1 inch special HDMI displays.
Date:   Wed, 19 Aug 2020 13:45:39 +0200
Message-Id: <352fea9bd94aa12d603744f2b2f2de3fb297442f.1597833138.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597833138.git.mchehab+huawei@kernel.org>
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiubin Zhang <zhangxiubin1@huawei.com>

Adjust pixel clock for compatibility with 10.1 inch special displays.

Signed-off-by: Xiubin Zhang <zhangxiubin1@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/gpu/kirin_drm_dss.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/hikey9xx/gpu/kirin_drm_dss.c b/drivers/staging/hikey9xx/gpu/kirin_drm_dss.c
index 11d847e2da3d..693f5499c8d0 100644
--- a/drivers/staging/hikey9xx/gpu/kirin_drm_dss.c
+++ b/drivers/staging/hikey9xx/gpu/kirin_drm_dss.c
@@ -270,6 +270,10 @@ static void dss_ldi_set_mode(struct dss_crtc *acrtc)
 		else
 			clk_Hz = mode->clock * 1000UL;
 
+		/* Adjust pixel clock for compatibility with 10.1 inch special displays. */
+		if (mode->clock == 148500 && mode->width_mm == 532 && mode->height_mm == 299)
+			clk_Hz = 152000 * 1000UL;
+
 		DRM_INFO("HDMI real need clock = %llu \n", clk_Hz);
 		hdmi_pxl_ppll7_init(ctx, clk_Hz);
 		adj_mode->clock = clk_Hz / 1000;
-- 
2.26.2

