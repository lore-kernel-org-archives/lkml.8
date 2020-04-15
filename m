Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633A3C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4194420936
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506349AbgDONWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:22:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39176 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2506231AbgDONWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 09:22:14 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8C9F94C817DDB2BDABE0;
        Wed, 15 Apr 2020 21:22:10 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Apr 2020
 21:22:03 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <tomi.valkeinen@ti.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <sebastian.reichel@collabora.com>,
        <laurent.pinchart@ideasonboard.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/omap: venc: remove unused variable 'venc_config_pal_bdghi'
Date:   Wed, 15 Apr 2020 21:21:05 +0800
Message-ID: <20200415132105.43636-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/gpu/drm/omapdrm/dss/venc.c:211:33:
 warning: 'venc_config_pal_bdghi' defined but not used [-Wunused-const-variable=]
 static const struct venc_config venc_config_pal_bdghi = {
                                 ^~~~~~~~~~~~~~~~~~~~~

It is never used, remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/omapdrm/dss/venc.c | 43 ------------------------------
 1 file changed, 43 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/venc.c b/drivers/gpu/drm/omapdrm/dss/venc.c
index 766553bb2f87..9701843ccf09 100644
--- a/drivers/gpu/drm/omapdrm/dss/venc.c
+++ b/drivers/gpu/drm/omapdrm/dss/venc.c
@@ -208,49 +208,6 @@ static const struct venc_config venc_config_ntsc_trm = {
 	.gen_ctrl				= 0x00F90000,
 };
 
-static const struct venc_config venc_config_pal_bdghi = {
-	.f_control				= 0,
-	.vidout_ctrl				= 0,
-	.sync_ctrl				= 0,
-	.hfltr_ctrl				= 0,
-	.x_color				= 0,
-	.line21					= 0,
-	.ln_sel					= 21,
-	.htrigger_vtrigger			= 0,
-	.tvdetgp_int_start_stop_x		= 0x00140001,
-	.tvdetgp_int_start_stop_y		= 0x00010001,
-	.gen_ctrl				= 0x00FB0000,
-
-	.llen					= 864-1,
-	.flens					= 625-1,
-	.cc_carr_wss_carr			= 0x2F7625ED,
-	.c_phase				= 0xDF,
-	.gain_u					= 0x111,
-	.gain_v					= 0x181,
-	.gain_y					= 0x140,
-	.black_level				= 0x3e,
-	.blank_level				= 0x3e,
-	.m_control				= 0<<2 | 1<<1,
-	.bstamp_wss_data			= 0x42,
-	.s_carr					= 0x2a098acb,
-	.l21__wc_ctl				= 0<<13 | 0x16<<8 | 0<<0,
-	.savid__eavid				= 0x06A70108,
-	.flen__fal				= 23<<16 | 624<<0,
-	.lal__phase_reset			= 2<<17 | 310<<0,
-	.hs_int_start_stop_x			= 0x00920358,
-	.hs_ext_start_stop_x			= 0x000F035F,
-	.vs_int_start_x				= 0x1a7<<16,
-	.vs_int_stop_x__vs_int_start_y		= 0x000601A7,
-	.vs_int_stop_y__vs_ext_start_x		= 0x01AF0036,
-	.vs_ext_stop_x__vs_ext_start_y		= 0x27101af,
-	.vs_ext_stop_y				= 0x05,
-	.avid_start_stop_x			= 0x03530082,
-	.avid_start_stop_y			= 0x0270002E,
-	.fid_int_start_x__fid_int_start_y	= 0x0005008A,
-	.fid_int_offset_y__fid_ext_start_x	= 0x002E0138,
-	.fid_ext_start_y__fid_ext_offset_y	= 0x01380005,
-};
-
 enum venc_videomode {
 	VENC_MODE_UNKNOWN,
 	VENC_MODE_PAL,
-- 
2.17.1


