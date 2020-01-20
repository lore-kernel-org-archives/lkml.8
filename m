Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342EAC33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A93622314
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="gj+P8sv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgATNrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 08:47:20 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:60876 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726738AbgATNrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 08:47:20 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00KDbQJC019186;
        Mon, 20 Jan 2020 14:47:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=RQpTI3zFQW+ChdmHDDySJ08NSVtL9lOc5ZIv6JMCj74=;
 b=gj+P8sv4Kh+ikTblV4bXosCD65PqoiQrtdSjmKPqhDTn9Famk0YKrnA5y9NbgGK4AgdB
 5LUwZgXMEyEQGIGWjY7HQhZvgLnifjWudJFodUW5bv0F0gR1FJSDA2etBRn3jutiq5zn
 q1kLb+ahj90oshPM/IUOpXMWP0TPWkZuhWzx11JOoUNcEefAE4slkoxsVH7vDrfUdCOK
 WBgbOJ5raNdUAtk/hjIypmiNSZsU8pblgD9dYRDUFHPBlnqZmfWZZ4J7J9AaKoraRgGP
 uKvNxHrMvOuXg9skKPOeZmj8W0eqycQdYGyMS3DquZPfoDbyKTTJnQxiNAk2T2AjidYt UA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xkssnsg0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 14:47:05 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C7356100034;
        Mon, 20 Jan 2020 14:47:00 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 916642BF9A8;
        Mon, 20 Jan 2020 14:47:00 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG6NODE3.st.com (10.75.127.18)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Jan 2020 14:47:00
 +0100
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
Subject: [PATCH] drm/stm: ltdc: enable/disable depends on encoder
Date:   Mon, 20 Jan 2020 14:46:53 +0100
Message-ID: <1579528013-28445-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_02:2020-01-20,2020-01-20 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yannick Fertré <yannick.fertre@st.com>

When connected to a dsi host, the ltdc display controller
must send frames only after the end of the dsi panel
initialization to avoid errors when the dsi host sends
commands to the dsi panel (dsi px fifo full).
To avoid this issue, the display controller must be
enabled/disabled when the encoder is enabled/disabled.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 drivers/gpu/drm/stm/ltdc.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 719dfc5..9ef125d 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -437,9 +437,6 @@ static void ltdc_crtc_atomic_enable(struct drm_crtc *crtc,
 	/* Commit shadow registers = update planes at next vblank */
 	reg_set(ldev->regs, LTDC_SRCR, SRCR_VBR);
 
-	/* Enable LTDC */
-	reg_set(ldev->regs, LTDC_GCR, GCR_LTDCEN);
-
 	drm_crtc_vblank_on(crtc);
 }
 
@@ -453,9 +450,6 @@ static void ltdc_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	drm_crtc_vblank_off(crtc);
 
-	/* disable LTDC */
-	reg_clear(ldev->regs, LTDC_GCR, GCR_LTDCEN);
-
 	/* disable IRQ */
 	reg_clear(ldev->regs, LTDC_IER, IER_RRIE | IER_FUIE | IER_TERRIE);
 
@@ -1058,9 +1052,13 @@ static const struct drm_encoder_funcs ltdc_encoder_funcs = {
 static void ltdc_encoder_disable(struct drm_encoder *encoder)
 {
 	struct drm_device *ddev = encoder->dev;
+	struct ltdc_device *ldev = ddev->dev_private;
 
 	DRM_DEBUG_DRIVER("\n");
 
+	/* Disable LTDC */
+	reg_clear(ldev->regs, LTDC_GCR, GCR_LTDCEN);
+
 	/* Set to sleep state the pinctrl whatever type of encoder */
 	pinctrl_pm_select_sleep_state(ddev->dev);
 }
@@ -1068,6 +1066,7 @@ static void ltdc_encoder_disable(struct drm_encoder *encoder)
 static void ltdc_encoder_enable(struct drm_encoder *encoder)
 {
 	struct drm_device *ddev = encoder->dev;
+	struct ltdc_device *ldev = ddev->dev_private;
 
 	DRM_DEBUG_DRIVER("\n");
 
@@ -1078,6 +1077,9 @@ static void ltdc_encoder_enable(struct drm_encoder *encoder)
 	 */
 	if (encoder->encoder_type == DRM_MODE_ENCODER_DPI)
 		pinctrl_pm_select_default_state(ddev->dev);
+
+	/* Enable LTDC */
+	reg_set(ldev->regs, LTDC_GCR, GCR_LTDCEN);
 }
 
 static const struct drm_encoder_helper_funcs ltdc_encoder_helper_funcs = {
-- 
2.7.4

