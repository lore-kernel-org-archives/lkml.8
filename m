Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC79CC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E332084E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cRIOvuMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgCEBTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 20:19:55 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:41101 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgCEBTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 20:19:54 -0500
Received: by mail-pl1-f202.google.com with SMTP id g2so2030129plg.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 17:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mCF91NKean3cZSjdJ9yCVdLO2tsfZeI0WmZfI6eVTDk=;
        b=cRIOvuMM/KB/+yXT73mgH926YkSuf4IA8CjD6CbbQMA3I2M+/YROU3ols9Uq3+ZvuY
         DZVfTO1qIf2wBGzZkgA6XHmJiez4Dr+23vpzLHNyvvF/K6a6gbCP5uzzSdralmG8Xsfx
         emVD1VBTpeGq5CWSA5SNlHWEmmZQ9MYG+OQIOzv+A2jsbCXP4bwKiiPd4keR5hZn1ZYn
         OuTOo7umFh9KBuCefmqdbntymuWlzrDITfpGxpUz/CKolKeXVylsB7ACLrBBgoJIUrTi
         2cPLimR/puTtaCsSRReuPt/pqbgEBjTpofBfmC3xqVepbqONHuaOh/BRijOG3kD+hNgC
         XCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mCF91NKean3cZSjdJ9yCVdLO2tsfZeI0WmZfI6eVTDk=;
        b=NwQpczbMad+MqgTggrRZxSpoVlnV34mxwkqFPG5QIjxxgMi1PtuF3Mk1JFFRDM5bRn
         keANBZOnqWCqTMr7sC6cxSCC5eViYHsNtnn78J9VCUx/EKRwYp3so2ovxWaxffRGkTeO
         XAdORucXgFTTS4pAIpil1TePW0ZYN2Kq75VBC2FfGThsX7jjFzf4cjy3+sLsNFIpSxX7
         6cPr60i7JLGOan8J6/Vpq4ZOL/gmh8hdKnf/a0Ui1RHszT5u+GEA7SzCr09SyjiZ2RUC
         GQ3n//CPGmgITZglsqfAzcJvjEu2c+R4sZ6+fK+/k1EzUDQWcFMOXi++ZtvSDFcH0APZ
         Mtzw==
X-Gm-Message-State: ANhLgQ1kdUMSnOmn6Q+p0XSpgllHjO3giFEuTJnlhQExWVs8sG89LF3z
        xfHsHIR49JtlSg09xK4kAgwzalC36Ysy
X-Google-Smtp-Source: ADFU+vsrZjL7EsUFa5FFWR4DJkWc2f1Qsbvz4xZr8cL8IJ1ZwfR4TO7SFvoiP7JcQnGOmQoNjtWCSwL1USx+
X-Received: by 2002:a63:4c66:: with SMTP id m38mr5158694pgl.313.1583371191993;
 Wed, 04 Mar 2020 17:19:51 -0800 (PST)
Date:   Wed,  4 Mar 2020 17:19:42 -0800
In-Reply-To: <20200305011943.214146-1-rajatja@google.com>
Message-Id: <20200305011943.214146-2-rajatja@google.com>
Mime-Version: 1.0
References: <20200305011943.214146-1-rajatja@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v6 2/3] drm/i915: Lookup and attach ACPI device node for connectors
From:   Rajat Jain <rajatja@google.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        "=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=" 
        <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Imre Deak <imre.deak@intel.com>,
        "=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?=" <jose.souza@intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, gregkh@linuxfoundation.org,
        mathewk@google.com, Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@denx.de>,
        seanpaul@google.com, Duncan Laurie <dlaurie@google.com>,
        jsbarnes@google.com, Thierry Reding <thierry.reding@gmail.com>,
        mpearson@lenovo.com, Nitin Joshi1 <njoshi1@lenovo.com>,
        Sugumaran Lacshiminarayanan <slacshiminar@lenovo.com>,
        Tomoki Maruichi <maruichit@lenovo.com>
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lookup and attach ACPI nodes for intel connectors. The lookup is done
in compliance with ACPI Spec 6.3
https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
(Ref: Pages 1119 - 1123).

This can be useful for any connector specific platform properties. (This
will be used for privacy screen in next patch).

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v6: Addressed minor comments from Jani at
    https://lkml.org/lkml/2020/1/24/1143
     - local variable renamed.
     - used drm_dbg_kms()
     - used acpi_device_handle()
     - Used opaque type acpi_handle instead of void*
v5: same as v4
v4: Same as v3
v3: fold the code into existing acpi_device_id_update() function
v2: formed by splitting the original patch into ACPI lookup, and privacy
    screen property. Also move it into i915 now that I found existing code
    in i915 that can be re-used.

 drivers/gpu/drm/i915/display/intel_acpi.c     | 24 +++++++++++++++++++
 .../drm/i915/display/intel_display_types.h    |  5 ++++
 drivers/gpu/drm/i915/display/intel_dp.c       |  3 +++
 3 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
index 3e6831cca4ac1..870c1ad98df92 100644
--- a/drivers/gpu/drm/i915/display/intel_acpi.c
+++ b/drivers/gpu/drm/i915/display/intel_acpi.c
@@ -222,11 +222,22 @@ static u32 acpi_display_type(struct intel_connector *connector)
 	return display_type;
 }
 
+/*
+ * Ref: ACPI Spec 6.3
+ * https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
+ * Pages 1119 - 1123 describe, what I believe, a standard way of
+ * identifying / addressing "display panels" in the ACPI. It provides
+ * a way for the ACPI to define devices for the display panels attached
+ * to the system. It thus provides a way for the BIOS to export any panel
+ * specific properties to the system via ACPI (like device trees).
+ */
 void intel_acpi_device_id_update(struct drm_i915_private *dev_priv)
 {
 	struct drm_device *dev = &dev_priv->drm;
 	struct intel_connector *connector;
 	struct drm_connector_list_iter conn_iter;
+	struct acpi_device *conn_dev;
+	u64 conn_addr;
 	u8 display_index[16] = {};
 
 	/* Populate the ACPI IDs for all connectors for a given drm_device */
@@ -242,6 +253,19 @@ void intel_acpi_device_id_update(struct drm_i915_private *dev_priv)
 		device_id |= display_index[type]++ << ACPI_DISPLAY_INDEX_SHIFT;
 
 		connector->acpi_device_id = device_id;
+
+		/* Build the _ADR to look for */
+		conn_addr = device_id | ACPI_DEVICE_ID_SCHEME |
+				ACPI_BIOS_CAN_DETECT;
+
+		drm_dbg_kms(dev, "Checking connector ACPI node at _ADR=%llX\n",
+			    conn_addr);
+
+		/* Look up the connector device, under the PCI device */
+		conn_dev = acpi_find_child_device(
+					ACPI_COMPANION(&dev->pdev->dev),
+					conn_addr, false);
+		connector->acpi_handle = acpi_device_handle(conn_dev);
 	}
 	drm_connector_list_iter_end(&conn_iter);
 }
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 5e00e611f077f..d70612cc1ba2a 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -411,9 +411,14 @@ struct intel_connector {
 	 */
 	struct intel_encoder *encoder;
 
+#ifdef CONFIG_ACPI
 	/* ACPI device id for ACPI and driver cooperation */
 	u32 acpi_device_id;
 
+	/* ACPI handle corresponding to this connector display, if found */
+	acpi_handle acpi_handle;
+#endif
+
 	/* Reads out the current hw, returning true if the connector is enabled
 	 * and active (i.e. dpms ON state). */
 	bool (*get_hw_state)(struct intel_connector *);
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 0a417cd2af2bc..171821113d362 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -44,6 +44,7 @@
 #include "i915_debugfs.h"
 #include "i915_drv.h"
 #include "i915_trace.h"
+#include "intel_acpi.h"
 #include "intel_atomic.h"
 #include "intel_audio.h"
 #include "intel_connector.h"
@@ -6868,6 +6869,8 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *connect
 
 		connector->state->scaling_mode = DRM_MODE_SCALE_ASPECT;
 
+		/* Lookup the ACPI node corresponding to the connector */
+		intel_acpi_device_id_update(dev_priv);
 	}
 }
 
-- 
2.25.0.265.gbab2e86ba0-goog

