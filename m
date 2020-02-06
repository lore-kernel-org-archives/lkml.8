Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E505C352A3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCAF21741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNthv9lv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgBFIA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 03:00:58 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34652 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbgBFIAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 03:00:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so5951736wrr.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 00:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GF+GwZVlFfWX394NfNiHt+gnPUWs7Vyd/x0Y4+mn0tM=;
        b=QNthv9lvjk8WgJGMBvtOmYYtJUxJnDQpIorUEni4zx8ayZy4etFIqyv/EZtpIQUZz8
         nc+ERxwsG2hIh9P3q3GfEA4225MBtji50hmxTH2GJmHdSxOOB52epxJyUZ4mNsOSIjxo
         bDqAaFXKGU8gtm5UJBY23N0/Bt04AD36zS+h6wYcIqXuRjE15zg3u2zWIWV17FfCoGwO
         lTGJGhK8FlXKm6v56yqiY4Uh6Iyh9EcU1K0DXm9OElGgq+YqlG7SHLQL8JoAvOHj6V4K
         NdcBG2wKX237+yyyUDVjDB84EQkbicdHGUQSheOJErHlJDfQA4hOPZZtkY+f8Ql/vA6e
         G8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GF+GwZVlFfWX394NfNiHt+gnPUWs7Vyd/x0Y4+mn0tM=;
        b=DONXo0SNkpJpAtCXNpWP4rRbXQHWCRjEohgir2xI/yURHZ0j9CGVGMGdEehyTU1PVv
         NBlDXyFKYjcDelDNP4fSYFhRsDHiN+5IAp0qh57aYHD+TinObe9f49BAHGGkE1cKVeu7
         B/GR01CQcINYiXEAuSQK3nx4vJearIqJ+DuEGfhzxtcTSKESmPFlMLe2DkkBneE8XUg8
         kkP1W4DqPrftTN2QDJ4QqgwDtFgu0oJ25m8l6XmomOrEgqzpG1IX+ieJotdsqcWVwV4r
         54+t8RuYc0t8p9w7Y01YrQVbtpw9/3srbxGr1UVZhrwXcNVnhq2j3R8qSnZnMKtoWQZQ
         czuQ==
X-Gm-Message-State: APjAAAXFYXchqZ9JC5PMKHqAV9VRReLu60P89GEShbMl1nPsBa58FWmj
        QoinhTG8oNrG9YmIheGorGc=
X-Google-Smtp-Source: APXvYqxY5m9lMPSFLgSHzLNIslhGA9YWF2I+0JCofW0ZigJ6YK/4apfv0DUmS9szJRbgf5zJgAOrvQ==
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr2362010wrm.356.1580976053144;
        Thu, 06 Feb 2020 00:00:53 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id u8sm2635132wmm.15.2020.02.06.00.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 00:00:52 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/12] drm/i915/combo_phy: convert to struct drm_device logging macros.
Date:   Thu,  6 Feb 2020 11:00:09 +0300
Message-Id: <20200206080014.13759-9-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206080014.13759-1-wambui.karugax@gmail.com>
References: <20200206080014.13759-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion of the printk based drm logging macros to the struct
drm_device based logging macros in i915/display/intel_combo_phy.c.
This transformation was achieved using the following coccinelle script
that matches based on the existence of a drm_i915_private device
pointer:
@@
identifier fn, T;
@@

fn(...,struct drm_i915_private *T,...) {
<+...
(
-DRM_INFO(
+drm_info(&T->drm,
...)
|
-DRM_ERROR(
+drm_err(&T->drm,
...)
|
-DRM_WARN(
+drm_warn(&T->drm,
...)
|
-DRM_DEBUG(
+drm_dbg(&T->drm,
...)
|
-DRM_DEBUG_DRIVER(
+drm_dbg(&T->drm,
...)
|
-DRM_DEBUG_KMS(
+drm_dbg_kms(&T->drm,
...)
|
-DRM_DEBUG_ATOMIC(
+drm_dbg_atomic(&T->drm,
...)
)
...+>
}

@@
identifier fn, T;
@@

fn(...) {
...
struct drm_i915_private *T = ...;
<+...
(
-DRM_INFO(
+drm_info(&T->drm,
...)
|
-DRM_ERROR(
+drm_err(&T->drm,
...)
|
-DRM_WARN(
+drm_warn(&T->drm,
...)
|
-DRM_DEBUG(
+drm_dbg(&T->drm,
...)
|
-DRM_DEBUG_KMS(
+drm_dbg_kms(&T->drm,
...)
|
-DRM_DEBUG_DRIVER(
+drm_dbg(&T->drm,
...)
|
-DRM_DEBUG_ATOMIC(
+drm_dbg_atomic(&T->drm,
...)
)
...+>
}

This converts DRM_DEBUG/DRM_DEBUG_DRIVER to drm_dbg().
New checkpatch warnings were addressed manually.

References: https://lists.freedesktop.org/archives/dri-devel/2020-January/253381.html
Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 .../gpu/drm/i915/display/intel_combo_phy.c    | 23 +++++++++++--------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_combo_phy.c b/drivers/gpu/drm/i915/display/intel_combo_phy.c
index dc5525ee8dee..9ff05ec12115 100644
--- a/drivers/gpu/drm/i915/display/intel_combo_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_combo_phy.c
@@ -97,10 +97,11 @@ static bool check_phy_reg(struct drm_i915_private *dev_priv,
 	u32 val = intel_de_read(dev_priv, reg);
 
 	if ((val & mask) != expected_val) {
-		DRM_DEBUG_DRIVER("Combo PHY %c reg %08x state mismatch: "
-				 "current %08x mask %08x expected %08x\n",
-				 phy_name(phy),
-				 reg.reg, val, mask, expected_val);
+		drm_dbg(&dev_priv->drm,
+			"Combo PHY %c reg %08x state mismatch: "
+			"current %08x mask %08x expected %08x\n",
+			phy_name(phy),
+			reg.reg, val, mask, expected_val);
 		return false;
 	}
 
@@ -172,7 +173,8 @@ static void cnl_combo_phys_uninit(struct drm_i915_private *dev_priv)
 	u32 val;
 
 	if (!cnl_combo_phy_verify_state(dev_priv))
-		DRM_WARN("Combo PHY HW state changed unexpectedly.\n");
+		drm_warn(&dev_priv->drm,
+			 "Combo PHY HW state changed unexpectedly.\n");
 
 	val = intel_de_read(dev_priv, CHICKEN_MISC_2);
 	val |= CNL_COMP_PWR_DOWN;
@@ -212,7 +214,8 @@ static bool ehl_vbt_ddi_d_present(struct drm_i915_private *i915)
 	 * in the log and let the internal display win.
 	 */
 	if (ddi_d_present)
-		DRM_ERROR("VBT claims to have both internal and external displays on PHY A.  Configuring for internal.\n");
+		drm_err(&i915->drm,
+			"VBT claims to have both internal and external displays on PHY A.  Configuring for internal.\n");
 
 	return false;
 }
@@ -308,8 +311,9 @@ static void icl_combo_phys_init(struct drm_i915_private *dev_priv)
 		u32 val;
 
 		if (icl_combo_phy_verify_state(dev_priv, phy)) {
-			DRM_DEBUG_DRIVER("Combo PHY %c already enabled, won't reprogram it.\n",
-					 phy_name(phy));
+			drm_dbg(&dev_priv->drm,
+				"Combo PHY %c already enabled, won't reprogram it.\n",
+				phy_name(phy));
 			continue;
 		}
 
@@ -368,7 +372,8 @@ static void icl_combo_phys_uninit(struct drm_i915_private *dev_priv)
 
 		if (phy == PHY_A &&
 		    !icl_combo_phy_verify_state(dev_priv, phy))
-			DRM_WARN("Combo PHY %c HW state changed unexpectedly\n",
+			drm_warn(&dev_priv->drm,
+				 "Combo PHY %c HW state changed unexpectedly\n",
 				 phy_name(phy));
 
 		/*
-- 
2.25.0

