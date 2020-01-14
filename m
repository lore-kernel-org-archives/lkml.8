Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B792C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C4424658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7jAJHf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgANTbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:31:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36537 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANTbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:31:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so13405162wru.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 11:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XU3df1UrRKDXcpcQHNFwUN0kOKaJVsq9R83HuMFlYmk=;
        b=N7jAJHf9q7vg451kF3fb+8EhrByNUfz1vq+5OYJjQXQlZhUQGX+LBBKEtVQDNxoGjW
         isaKMu7LvMS1gD22tNOrzkn9I5Qjq8UU/Tm0JLjwnaru8dLPbhCJ5xQc3h7z4agEyHbD
         ZOr0xTEMDNDuM7Lgidw8V49AiLykdivK73t3IH2PpljY+rtJDnMQrQPTa95lY2DnkCCT
         XMNot8jNOMSmh4ZuFpgnXlg5QrY8R5rYVeMjBI6zeFFfKIUa9WG0Cv+8IjK80UUrXQiZ
         82P1TybaIbA98QKCDMoO0130yg6/O1oJmKr/GMoM3Kv183F86gh5ErLOMqB4dZkzhF64
         ue6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XU3df1UrRKDXcpcQHNFwUN0kOKaJVsq9R83HuMFlYmk=;
        b=pi9HFZB01iyk+vYDMKtSra25iuXUtnjqWS43BR8RGZPMaDlnpQGhOPRrA/ulkXTTju
         xbiVin3l0P+Wk8iVfBgmY6fxOr/ffBJBD88ehhhH+UR+wqIE5KFT1GpbxMtQCwbqCkeT
         Xr9jEy/cTGgLz+sOryws5cHdokgSMec7U8ZgtYPZ03fMocFVfacK2f2G5gmNM1Vd/+sL
         sv5LhfeAZSUPUxEm7JmC+QKGNJQ/+bRkErgH35MXgzYlpEvQnPDnlAvDTFJangiRavXv
         azHnpehb8asy7L5mXm/X7olPr16PryKSMwB7psmgwYhKHIjTQVhanPA+IK+W90UGXAGC
         u5Mw==
X-Gm-Message-State: APjAAAVHpEyveLEBZMkvhv2fxXZ/aZpauUhxLiqQGkxLEYlllgv/8sYp
        1Oynm1nqKEbCov5Y+b8Ah8Fn7LCID+k=
X-Google-Smtp-Source: APXvYqxrP4DV0i8/Qt7Sw2OrX4i1isPayf/eUqQFjZMhgtzdquHIT1vraTP2u649g15aNLACI2r5hg==
X-Received: by 2002:a5d:6a88:: with SMTP id s8mr26099761wru.173.1579030289475;
        Tue, 14 Jan 2020 11:31:29 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id e8sm21050418wrt.7.2020.01.14.11.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 11:31:28 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/audio: convert to using drm_dbg_kms()
Date:   Tue, 14 Jan 2020 22:31:23 +0300
Message-Id: <20200114193123.5314-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert from the drm_dbg() logging macro to the drm_dbg_kms() macro in
modesetting code.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_audio.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_audio.c b/drivers/gpu/drm/i915/display/intel_audio.c
index 57208440bf6d..771a677c905b 100644
--- a/drivers/gpu/drm/i915/display/intel_audio.c
+++ b/drivers/gpu/drm/i915/display/intel_audio.c
@@ -361,7 +361,7 @@ static void g4x_audio_codec_enable(struct intel_encoder *encoder,
 	I915_WRITE(G4X_AUD_CNTL_ST, tmp);
 
 	len = min(drm_eld_size(eld) / 4, len);
-	drm_dbg(&dev_priv->drm, "ELD size %d\n", len);
+	drm_dbg_kms(&dev_priv->drm, "ELD size %d\n", len);
 	for (i = 0; i < len; i++)
 		I915_WRITE(G4X_HDMIW_HDMIEDID, *((const u32 *)eld + i));
 
@@ -710,9 +710,10 @@ void intel_audio_codec_enable(struct intel_encoder *encoder,
 			    "Bogus ELD on [CONNECTOR:%d:%s]\n",
 			    connector->base.id, connector->name);
 
-	drm_dbg(&dev_priv->drm, "ELD on [CONNECTOR:%d:%s], [ENCODER:%d:%s]\n",
-		connector->base.id, connector->name,
-		connector->encoder->base.id, connector->encoder->name);
+	drm_dbg_kms(&dev_priv->drm,
+		    "ELD on [CONNECTOR:%d:%s], [ENCODER:%d:%s]\n",
+		    connector->base.id, connector->name,
+		    connector->encoder->base.id, connector->encoder->name);
 
 	connector->eld[6] = drm_av_sync_delay(connector, adjusted_mode) / 2;
 
-- 
2.24.1

