Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F1BC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 00:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203A72253D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 00:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OwEEliHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbgCJAGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 20:06:34 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:48149 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbgCJAGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 20:06:32 -0400
Received: by mail-pg1-f201.google.com with SMTP id f14so1951427pgj.15
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 17:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0dn6tQL9TsXka+X0j836mxBEiLCvG4Lhf+VkAeM8ljA=;
        b=OwEEliHUsJh53bEe9J9sJWifPwr3SJo+WklcoJvNKCjG/0hZFyKMeXsXmlSjApEV4t
         ch29RjmcETLqUivMVVV8YBFmQYYUoE3jkLX2iYsLcobgj/hhyKJCNyTa/2sT+zQAHknf
         vj1bPUSBQdw68mG1ILU3aeRGdDnBLVFFeHqegn2diHUR/VeoX50puLxqScQmLdRjKXSt
         0iuwlXbGpteM8nmM+9UnQlb0YHdnFvSTSJZ/VYJI1iA4Ji11ZHJyBv8F5t4aI9aaxJzL
         OlU9uVbmOglstHwJ6xA+8bcYY2T2P+Hd8QPheKXKyWkeFH5NJiViW8oaOZNTQQSAJonY
         VyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0dn6tQL9TsXka+X0j836mxBEiLCvG4Lhf+VkAeM8ljA=;
        b=MPLyvjQ9OU+C52PhHjrQu3J//BxleLmw8PLLPP88FxIBukyejLh6cz2L0kuq5futqO
         BfF1LsWSQPqIqGFf1duzYukEAT7mtwOE+EfH0ApVV6LBCHGXbLKNifcTTWwmvp2q/Rh2
         cs59hjXk7sO+1LEVegXlmXMkdMVy8gOV0oKRWRspIEyOh7mKoB3Nk4tjFSu+ggWSC6x6
         5pAVhoR0HVUcFwigTarBR8Rn2UJm0+l7fcCXg/TGeaGDzrCad/9HhKy0IFH4l4oOqlcp
         7EeX6LXiLrukfR2GJTdWIAoBSRXfQyUm4a/IoXX7FxgdcU4DjyiWfXs4LSfUkkyECbia
         TpcA==
X-Gm-Message-State: ANhLgQ03ths9JL8wGkrGT9B0iPaLR53DoHlKllsf3p8a5vJwGAMIfanL
        m3uuC6g8FuWzVjYcySxOyYYL3YLYeM3J
X-Google-Smtp-Source: ADFU+vu2LjEHz45oSktpxxd0XCmvjRR+U3V1uda1HW+vAKpJ7XElRVu8FQbGhqkvK/N+vmwGacwBigItTC4/
X-Received: by 2002:a17:90a:e648:: with SMTP id ep8mr1906653pjb.42.1583798789648;
 Mon, 09 Mar 2020 17:06:29 -0700 (PDT)
Date:   Mon,  9 Mar 2020 17:06:16 -0700
In-Reply-To: <20200310000617.20662-1-rajatja@google.com>
Message-Id: <20200310000617.20662-4-rajatja@google.com>
Mime-Version: 1.0
References: <20200310000617.20662-1-rajatja@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v7 3/4] drm/i915: Lookup and attach ACPI device node for connectors
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
v7: Look for ACPI node in ->late_register() hook.
    Do the scan only once per drm_device (instead of 1 per drm_connector)
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
 drivers/gpu/drm/i915/display/intel_dp.c       | 15 +++++++++++-
 drivers/gpu/drm/i915/i915_drv.h               |  2 ++
 4 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
index 3e6831cca4ac1..5679f6882922e 100644
--- a/drivers/gpu/drm/i915/display/intel_acpi.c
+++ b/drivers/gpu/drm/i915/display/intel_acpi.c
@@ -222,13 +222,26 @@ static u32 acpi_display_type(struct intel_connector *connector)
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
+	struct acpi_device *conn_dev, *parent;
+	u64 conn_addr;
 	u8 display_index[16] = {};
 
+	parent = ACPI_COMPANION(&dev->pdev->dev);
+
 	/* Populate the ACPI IDs for all connectors for a given drm_device */
 	drm_connector_list_iter_begin(dev, &conn_iter);
 	for_each_intel_connector_iter(connector, &conn_iter) {
@@ -242,6 +255,17 @@ void intel_acpi_device_id_update(struct drm_i915_private *dev_priv)
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
+		conn_dev = acpi_find_child_device(parent, conn_addr, false);
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
index 0a417cd2af2bc..41c623b029464 100644
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
@@ -5863,6 +5864,7 @@ static int intel_dp_get_modes(struct drm_connector *connector)
 static int
 intel_dp_connector_register(struct drm_connector *connector)
 {
+	struct drm_i915_private *dev_priv = to_i915(connector->dev);
 	struct intel_dp *intel_dp = intel_attached_dp(to_intel_connector(connector));
 	int ret;
 
@@ -5872,6 +5874,18 @@ intel_dp_connector_register(struct drm_connector *connector)
 
 	intel_connector_debugfs_add(connector);
 
+	/*
+	 * Lookup the ACPI node corresponding to the connector. This needs
+	 * to be done in ->late_register() hook since it needs to iterate
+	 * over all the connectors after they are registered. Calling it
+	 * once for the device is enough since a single call() will update
+	 * for all connectors.
+	 */
+	if (!dev_priv->acpi_scan_done) {
+		intel_acpi_device_id_update(dev_priv);
+		dev_priv->acpi_scan_done = true;
+	}
+
 	DRM_DEBUG_KMS("registering %s bus for %s\n",
 		      intel_dp->aux.name, connector->kdev->kobj.name);
 
@@ -6867,7 +6881,6 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *connect
 		drm_connector_attach_scaling_mode_property(connector, allowed_scalers);
 
 		connector->state->scaling_mode = DRM_MODE_SCALE_ASPECT;
-
 	}
 }
 
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 19195bde4921b..4e23d7a4a2129 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -1189,6 +1189,8 @@ struct drm_i915_private {
 
 	bool ipc_enabled;
 
+	bool acpi_scan_done;
+
 	/* Used to save the pipe-to-encoder mapping for audio */
 	struct intel_encoder *av_enc_map[I915_MAX_PIPES];
 
-- 
2.25.1.481.gfbce0eb801-goog

