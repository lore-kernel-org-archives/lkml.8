Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851F9C2D0E8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56DB220772
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uubu9Ksq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbgCaK5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 06:57:44 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37494 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730510AbgCaK5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 06:57:43 -0400
Received: by mail-ed1-f68.google.com with SMTP id de14so24545220edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 03:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=50njG3BRzhgqk7OU18IsJGY20KNwvqHHLF9KB0zfsgo=;
        b=Uubu9KsqB8aCbhmVIfpW06NMwyishZIZ2ihsBkeCXyNwiVNn0xzBG/t83sDY8fr1Op
         qrEMYSkr+0QcC0iR4AEETCyc3j6Cb0oC4l/9qmwEkkn4DOuEL3//xA/Z7Bo1LmNQJfbo
         r1g5SVaFr0kCEr/ygGrytLj2wEpQV5F3Jmn/4m0wf6l3DAOQXSyzqX3OIas/camKKxO4
         Qu2CROFOeCkgD5hClnp3CIXwQDzI0ujwZcotnH018B/3m+kJQZPss82uZyxPm+WtXVKj
         VO22dvOX6Seml5X4fPJxnspl/9+jyDDoWYyZ+4oGjRmHlz9M2GAu7aStN1xkns14W3ms
         ACpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=50njG3BRzhgqk7OU18IsJGY20KNwvqHHLF9KB0zfsgo=;
        b=kMO2mI4hLGqQGgIhZW6VUW8ScGH93cwLkXfsmy7wjtGCg4+QGgLbC3dCuvIU0ifYQF
         XYHWZcMTOKAy+qmvTpbT+QOXWBm/vaqv8MAic96+w8UgBry4Rtje0ZJDcw+rZv8OzUG2
         oKhW7XLATZt4SyHu0P28ufMsejsamxUIM/qJOY7GtbUdZ6BnC+NZ/DZalSRuuaP84M4a
         ezDM9z2zVKbYu4Qf0C6OOb7/PoRudF+FoS8BGl6g3P12Z0rV/ShMUauk0Hm+jEz5QM61
         efxVCPOHkKMxJAm+q9m8ApTbRyU39ZckNqSnOTuN2+Vbm4OPVAhX/5cfINKFxylAllcV
         5cow==
X-Gm-Message-State: ANhLgQ36qSlTqMkdqYTjGPgP44hsw//iUiTcRBLf2PG3laqP3dw3Fdhj
        b0xa07VQHh5Weuc6Xgmhl/c=
X-Google-Smtp-Source: ADFU+vsWMpvsp0nEUUTlASEHri4BOKFbOh2sLTwceT3PcFHSP/2PEQLKrAyUTMhL1W2IflOao7aZSg==
X-Received: by 2002:a05:6402:351:: with SMTP id r17mr15613299edw.216.1585652261683;
        Tue, 31 Mar 2020 03:57:41 -0700 (PDT)
Received: from smtp.gmail.com ([2001:818:e238:a000:51c6:2c09:a768:9c37])
        by smtp.gmail.com with ESMTPSA id j11sm335968ejk.39.2020.03.31.03.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 03:57:41 -0700 (PDT)
Date:   Tue, 31 Mar 2020 07:57:34 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Konig <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Rodrigo.Siqueira@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] drm/amd/display: cleanup codestyle type
 BLOCK_COMMENT_STYLE on dc_link
Message-ID: <e353f1223561ccfa1ab3fc00a5ab996064a418f9.1585651869.git.melissa.srw@gmail.com>
References: <cover.1585651869.git.melissa.srw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1585651869.git.melissa.srw@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Solve comments alignment problems on dc_link file

Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 25 +++++++++++--------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 67cfff1586e9..f580b533db5f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -64,11 +64,11 @@
 enum {
 	PEAK_FACTOR_X1000 = 1006,
 	/*
-	* Some receivers fail to train on first try and are good
-	* on subsequent tries. 2 retries should be plenty. If we
-	* don't have a successful training then we don't expect to
-	* ever get one.
-	*/
+	 * Some receivers fail to train on first try and are good
+	 * on subsequent tries. 2 retries should be plenty. If we
+	 * don't have a successful training then we don't expect to
+	 * ever get one.
+	 */
 	LINK_TRAINING_MAX_VERIFY_RETRY = 2
 };
 
@@ -270,7 +270,8 @@ static enum ddc_transaction_type get_ddc_transaction_type(
 	case SIGNAL_TYPE_DISPLAY_PORT_MST:
 		/* MST does not use I2COverAux, but there is the
 		 * SPECIAL use case for "immediate dwnstrm device
-		 * access" (EPR#370830). */
+		 * access" (EPR#370830).
+		 */
 		transaction_type = DDC_TRANSACTION_TYPE_I2C_OVER_AUX;
 		break;
 
@@ -369,7 +370,8 @@ bool dc_link_is_dp_sink_present(struct dc_link *link)
 	/* Open GPIO and set it to I2C mode */
 	/* Note: this GpioMode_Input will be converted
 	 * to GpioConfigType_I2cAuxDualMode in GPIO component,
-	 * which indicates we need additional delay */
+	 * which indicates we need additional delay
+	 */
 
 	if (GPIO_RESULT_OK != dal_ddc_open(
 		ddc, GPIO_MODE_INPUT, GPIO_DDC_CONFIG_TYPE_MODE_I2C)) {
@@ -414,14 +416,16 @@ static enum signal_type link_detect_sink(
 		link->link_enc->id, link->link_id);
 
 	/* Internal digital encoder will detect only dongles
-	 * that require digital signal */
+	 * that require digital signal
+	 */
 
 	/* Detection mechanism is different
 	 * for different native connectors.
 	 * LVDS connector supports only LVDS signal;
 	 * PCIE is a bus slot, the actual connector needs to be detected first;
 	 * eDP connector supports only eDP signal;
-	 * HDMI should check straps for audio */
+	 * HDMI should check straps for audio
+	 */
 
 	/* PCIE detects the actual connector on add-on board */
 
@@ -432,7 +436,8 @@ static enum signal_type link_detect_sink(
 	switch (link->link_id.id) {
 	case CONNECTOR_ID_HDMI_TYPE_A: {
 		/* check audio support:
-		 * if native HDMI is not supported, switch to DVI */
+		 * if native HDMI is not supported, switch to DVI
+		 */
 		struct audio_support *aud_support = &link->dc->res_pool->audio_support;
 
 		if (!aud_support->hdmi_audio_native)
-- 
2.25.1

