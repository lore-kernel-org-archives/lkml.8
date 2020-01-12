Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A48CC33CA2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 19:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226562053B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 19:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsysWW+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733312AbgALTyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 14:54:18 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55136 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732957AbgALTyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 14:54:16 -0500
Received: by mail-pj1-f65.google.com with SMTP id kx11so3236110pjb.4;
        Sun, 12 Jan 2020 11:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pYiyrxSsqumcvpzwZTQHLIKdGxUGHFSQS+ACeQLRkd4=;
        b=bsysWW+xSYtCy6JFgc4b/mT28AWSCu1Fly7PqqM89EZ+2n6SigyyY8UQZ2TN1I+nxf
         SXYC27/QCOdyWXtYSTMKX8eIS//8LJ67bGWbswIsNLT4pg/4Dy+pTmAG+tTONYDTMuF2
         D+5CEVNsDH9K7fOLMHQZb73e5pENtrwXZU4MFmEiNCQTFN5QrR5Y2swaXUeYl5U6qstP
         l3BeHuH+y1abGA3hxlYraoehR1bRpCIqkwZ4hgDpUAVaOUKfRjrfOCdkWElzXr9dtvgx
         EGkA4gufgH1PVb5NvETFnRXVVWOZjPvP6peAUqWXJw8Fj0z6ioSaPT3LNOq0p7J0UFhJ
         LR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pYiyrxSsqumcvpzwZTQHLIKdGxUGHFSQS+ACeQLRkd4=;
        b=t5fQFc1Yz1/BnTNbT1ydcFIwdsWP9M4rXohJRbmOPg7TSDivtrr2OFBaZNAzQMkboL
         T2T1XsjC0jmXUzkCicJ+IQQps9UZ6vFSlWJ/UPRR9NwtXWDD9VblXm+GsD7V7AQ4func
         AB8dadqoo6a4tl2OpFZIKiryCO0Bm+L0JsGqifd1AX8G6+GHbqpBfrm4h4u6BonOtWhl
         1DQonuTYvef7iWpLz7+XnPFS/F8i3vXbK+veQKZ4fRLyZXSJb7ouL6A34cI24ZpFTGnq
         lwfXJt0tya1YXX5cFJie3mwJ+88Z6ngw3ekpEUnxYfn7+qEWZBpvlKFeLtcUWNiDmeTp
         dd0Q==
X-Gm-Message-State: APjAAAUgxEYMrEpA58S5WCrlh1sjc7cVTCV5nC2aClmglKKpFyojFXrv
        REq8MkmeFK519In2huFewNM=
X-Google-Smtp-Source: APXvYqyIfIaZyY/HMtFTotO+OF76VyqFC1eZb41+BkHfihd10BTHs7UaVYxIQFSzLafrZFeSghHMsw==
X-Received: by 2002:a17:90a:36af:: with SMTP id t44mr18335650pjb.25.1578858855425;
        Sun, 12 Jan 2020 11:54:15 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id f81sm11341209pfa.118.2020.01.12.11.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 11:54:14 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Brian Masney <masneyb@onstation.org>,
        Douglas Anderson <dianders@chromium.org>,
        Fabio Estevam <festevam@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/4] drm/msm: support firmware-name for zap fw (v2)
Date:   Sun, 12 Jan 2020 11:53:57 -0800
Message-Id: <20200112195405.1132288-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200112195405.1132288-1-robdclark@gmail.com>
References: <20200112195405.1132288-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Since zap firmware can be device specific, allow for a firmware-name
property in the zap node to specify which firmware to load, similarly to
the scheme used for dsp/wifi/etc.

v2: only need a single error msg when we can't load from firmware-name
    specified path, and fix comment [Bjorn A.]

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 30 ++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 112e8b8a261e..456bb5af1717 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -26,6 +26,7 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
 {
 	struct device *dev = &gpu->pdev->dev;
 	const struct firmware *fw;
+	const char *signed_fwname = NULL;
 	struct device_node *np, *mem_np;
 	struct resource r;
 	phys_addr_t mem_phys;
@@ -58,8 +59,31 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
 
 	mem_phys = r.start;
 
-	/* Request the MDT file for the firmware */
-	fw = adreno_request_fw(to_adreno_gpu(gpu), fwname);
+	/*
+	 * Check for a firmware-name property.  This is the new scheme
+	 * to handle firmware that may be signed with device specific
+	 * keys, allowing us to have a different zap fw path for different
+	 * devices.
+	 *
+	 * If the firmware-name property is found, we bypass the
+	 * adreno_request_fw() mechanism, because we don't need to handle
+	 * the /lib/firmware/qcom/* vs /lib/firmware/* case.
+	 *
+	 * If the firmware-name property is not found, for backwards
+	 * compatibility we fall back to the fwname from the gpulist
+	 * table.
+	 */
+	of_property_read_string_index(np, "firmware-name", 0, &signed_fwname);
+	if (signed_fwname) {
+		fwname = signed_fwname;
+		ret = request_firmware_direct(&fw, fwname, gpu->dev->dev);
+		if (ret)
+			fw = ERR_PTR(ret);
+	} else {
+		/* Request the MDT file from the default location: */
+		fw = adreno_request_fw(to_adreno_gpu(gpu), fwname);
+	}
+
 	if (IS_ERR(fw)) {
 		DRM_DEV_ERROR(dev, "Unable to load %s\n", fwname);
 		return PTR_ERR(fw);
@@ -95,7 +119,7 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
 	 * not.  But since we've already gotten through adreno_request_fw()
 	 * we know which of the two cases it is:
 	 */
-	if (to_adreno_gpu(gpu)->fwloc == FW_LOCATION_LEGACY) {
+	if (signed_fwname || (to_adreno_gpu(gpu)->fwloc == FW_LOCATION_LEGACY)) {
 		ret = qcom_mdt_load(dev, fw, fwname, pasid,
 				mem_region, mem_phys, mem_size, NULL);
 	} else {
-- 
2.24.1

