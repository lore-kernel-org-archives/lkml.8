Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B8CC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 08:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A30C214DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 08:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsnposRa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgA3Ic7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 03:32:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41028 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgA3Ic6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 03:32:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so2906636wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 00:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mqV0fT/ncaD/YJHsfmzv5rFTbuhd1bc0cBkD/akkLbo=;
        b=TsnposRa7WGz3pW9s2iNyMfXZFQ1Yemb7dUagN7tNileYwzO4ngKM8x9lbcBfEy+ox
         fqJGQCO79zE7Ow5Imb+HH84PJDERG0tRbUpqxyhcDCZAd5ktHP9tVVDxBo2jqyYJxa2d
         KJTKbFs3FIMLb65xysD+yOwNcZOikrWla8ivKYQHQvh1dXC30pF9afNnj5R9gUa5zU3B
         RJk30F98m9B3X/5UbewtUVosa3oBst9khOvtS2rFrruQkgivziULa+zCUqzI+nGpx1FK
         hAOfam2aaau3RFaaj9mI6px6DuJPlEVhxXnneitWEpjtyfEvJWj96OPQ9Uk3LclNkEMp
         7eLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mqV0fT/ncaD/YJHsfmzv5rFTbuhd1bc0cBkD/akkLbo=;
        b=CovpTY/S56wMpj5WZcfhewOAgcRF4grI8lILKc/d32Ch9H2nu3HVYjUYTGLXV6yTTd
         bId5DkM2dcxqCVWmhOdNmc+bTHkQYFKQJkulQJTGEhJ5V3G3VyhJbW1dJr2HG5npZTqB
         tM2lE47HjdZsVJVjwHn1MzqKTfsqT8JkOhChee0qTU/4h0jj/h3mWT4qbmjHq+cR1IOV
         0EUJiB7et4dMAWi+6BnlKxrWvxsJrE4jrGR5c2H5rNtuhNOjGvWQ96QeM/gE+jpjxg8/
         4oGHo7XmPZKWX0bv/Cvlrein/iTq45IdDjWHMYT4L/dtrBNTdA2dWlga/aWJdehEvTnu
         zRQg==
X-Gm-Message-State: APjAAAWP4u13dR7E6TWdGEUVYWiA8uTw/UZ127Eo8w/uLw7sHUahmriK
        Ucuk6OWHCo+lbDmk9yp+fVo=
X-Google-Smtp-Source: APXvYqzhWu4jNdP+y3/zt5zjD4vcBLtUfg0SjJ1rRRzk5YdW7N5GNjD0DKCK/Ymul9yo9ED2ueahHw==
X-Received: by 2002:a5d:46d0:: with SMTP id g16mr3829899wrs.287.1580373175435;
        Thu, 30 Jan 2020 00:32:55 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id i11sm6363678wrs.10.2020.01.30.00.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 00:32:54 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] drm/i915/tc: automatic conversion to drm_device based logging macros.
Date:   Thu, 30 Jan 2020 11:32:23 +0300
Message-Id: <20200130083229.12889-7-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130083229.12889-1-wambui.karugax@gmail.com>
References: <20200130083229.12889-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts most uses of the printk based logging macros to the struct
drm_device based logging macros in i915/display/intel_tc.c using the
following coccinelle script that matches based on the existence of a
struct drm_i915_private device:
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

Checkpatch warnings were addressed manually.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_tc.c | 33 ++++++++++++++-----------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_tc.c b/drivers/gpu/drm/i915/display/intel_tc.c
index 7773169b7331..01508e447836 100644
--- a/drivers/gpu/drm/i915/display/intel_tc.c
+++ b/drivers/gpu/drm/i915/display/intel_tc.c
@@ -181,8 +181,9 @@ static u32 tc_port_live_status_mask(struct intel_digital_port *dig_port)
 				PORT_TX_DFLEXDPSP(dig_port->tc_phy_fia));
 
 	if (val == 0xffffffff) {
-		DRM_DEBUG_KMS("Port %s: PHY in TCCOLD, nothing connected\n",
-			      dig_port->tc_port_name);
+		drm_dbg_kms(&i915->drm,
+			    "Port %s: PHY in TCCOLD, nothing connected\n",
+			    dig_port->tc_port_name);
 		return mask;
 	}
 
@@ -210,8 +211,9 @@ static bool icl_tc_phy_status_complete(struct intel_digital_port *dig_port)
 	val = intel_uncore_read(uncore,
 				PORT_TX_DFLEXDPPMS(dig_port->tc_phy_fia));
 	if (val == 0xffffffff) {
-		DRM_DEBUG_KMS("Port %s: PHY in TCCOLD, assuming not complete\n",
-			      dig_port->tc_port_name);
+		drm_dbg_kms(&i915->drm,
+			    "Port %s: PHY in TCCOLD, assuming not complete\n",
+			    dig_port->tc_port_name);
 		return false;
 	}
 
@@ -228,8 +230,9 @@ static bool icl_tc_phy_set_safe_mode(struct intel_digital_port *dig_port,
 	val = intel_uncore_read(uncore,
 				PORT_TX_DFLEXDPCSSS(dig_port->tc_phy_fia));
 	if (val == 0xffffffff) {
-		DRM_DEBUG_KMS("Port %s: PHY in TCCOLD, can't set safe-mode to %s\n",
-			      dig_port->tc_port_name,
+		drm_dbg_kms(&i915->drm,
+			    "Port %s: PHY in TCCOLD, can't set safe-mode to %s\n",
+			    dig_port->tc_port_name,
 			      enableddisabled(enable));
 
 		return false;
@@ -243,8 +246,9 @@ static bool icl_tc_phy_set_safe_mode(struct intel_digital_port *dig_port,
 			   PORT_TX_DFLEXDPCSSS(dig_port->tc_phy_fia), val);
 
 	if (enable && wait_for(!icl_tc_phy_status_complete(dig_port), 10))
-		DRM_DEBUG_KMS("Port %s: PHY complete clear timed out\n",
-			      dig_port->tc_port_name);
+		drm_dbg_kms(&i915->drm,
+			    "Port %s: PHY complete clear timed out\n",
+			    dig_port->tc_port_name);
 
 	return true;
 }
@@ -258,8 +262,9 @@ static bool icl_tc_phy_is_in_safe_mode(struct intel_digital_port *dig_port)
 	val = intel_uncore_read(uncore,
 				PORT_TX_DFLEXDPCSSS(dig_port->tc_phy_fia));
 	if (val == 0xffffffff) {
-		DRM_DEBUG_KMS("Port %s: PHY in TCCOLD, assume safe mode\n",
-			      dig_port->tc_port_name);
+		drm_dbg_kms(&i915->drm,
+			    "Port %s: PHY in TCCOLD, assume safe mode\n",
+			    dig_port->tc_port_name);
 		return true;
 	}
 
@@ -415,10 +420,10 @@ static void intel_tc_port_reset_mode(struct intel_digital_port *dig_port,
 	icl_tc_phy_disconnect(dig_port);
 	icl_tc_phy_connect(dig_port, required_lanes);
 
-	DRM_DEBUG_KMS("Port %s: TC port mode reset (%s -> %s)\n",
-		      dig_port->tc_port_name,
-		      tc_port_mode_name(old_tc_mode),
-		      tc_port_mode_name(dig_port->tc_mode));
+	drm_dbg_kms(&i915->drm, "Port %s: TC port mode reset (%s -> %s)\n",
+		    dig_port->tc_port_name,
+		    tc_port_mode_name(old_tc_mode),
+		    tc_port_mode_name(dig_port->tc_mode));
 }
 
 static void
-- 
2.25.0

