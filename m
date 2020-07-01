Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3A7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A20A206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="fb7cuRhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbgGAMEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:04:21 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48742 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730103AbgGAMEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:04:20 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061BsUri021383;
        Wed, 1 Jul 2020 14:04:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=Ljx3jsZZFIQ7xSm8ZJvSzuKpK0meAfEeFxtF2zZEFYc=;
 b=fb7cuRhLxGzcX8nKWbKjpT7OfnBxp+qNk7oCqA/ls3qEgUKwWWFqJvftpNRJNQ36k9dm
 76X4hOkHhyMKsvcaTfXqwcYlRxmjwqpXv2+9hcVrVNrcMw4plpoIthjokrHSozxqDNtB
 qKEVWde2MeJjGX4Vx9lVGmmJYXHxfaDtZlb7Ihss/6Qg5G8hA769U3rjli3oKjwfUiaZ
 2oR9PaLMR0+MDrPZbFIkuE9NPNoHF8ovdXf98HeX2tclZ2Ppo0Q4SF80YrSYJkSrAhuE
 9O2CK8Wqcpj/dGlbWYApLDibhJtQofNa3eSB/N12B+i5U1YXGy0+jLXhhf+YLzEKrvtC WA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31ww0g9sx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 14:04:07 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 605A810002A;
        Wed,  1 Jul 2020 14:04:06 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 43F922B2CE5;
        Wed,  1 Jul 2020 14:04:06 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Jul 2020 14:04:05
 +0200
From:   Yannick Fertre <yannick.fertre@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/stm: ltdc: remove call of pm-runtime functions
Date:   Wed, 1 Jul 2020 14:04:02 +0200
Message-ID: <20200701120402.6444-1-yannick.fertre@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_07:2020-07-01,2020-07-01 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not necessary to suspend or stop the ltdc clocks
to modify the pixel clock.

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 drivers/gpu/drm/stm/ltdc.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 3f590d916e91..6e28f707092f 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -506,15 +506,7 @@ static bool ltdc_crtc_mode_fixup(struct drm_crtc *crtc,
 				 struct drm_display_mode *adjusted_mode)
 {
 	struct ltdc_device *ldev = crtc_to_ltdc(crtc);
-	struct drm_device *ddev = crtc->dev;
 	int rate = mode->clock * 1000;
-	bool runtime_active;
-	int ret;
-
-	runtime_active = pm_runtime_active(ddev->dev);
-
-	if (runtime_active)
-		pm_runtime_put_sync(ddev->dev);
 
 	if (clk_set_rate(ldev->pixel_clk, rate) < 0) {
 		DRM_ERROR("Cannot set rate (%dHz) for pixel clk\n", rate);
@@ -523,14 +515,6 @@ static bool ltdc_crtc_mode_fixup(struct drm_crtc *crtc,
 
 	adjusted_mode->clock = clk_get_rate(ldev->pixel_clk) / 1000;
 
-	if (runtime_active) {
-		ret = pm_runtime_get_sync(ddev->dev);
-		if (ret) {
-			DRM_ERROR("Failed to fixup mode, cannot get sync\n");
-			return false;
-		}
-	}
-
 	DRM_DEBUG_DRIVER("requested clock %dkHz, adjusted clock %dkHz\n",
 			 mode->clock, adjusted_mode->clock);
 
-- 
2.17.1

