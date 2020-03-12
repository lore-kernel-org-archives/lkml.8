Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D81BC5ACBF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9E0206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="efL3jKd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgCLS4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:56:45 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:47293 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgCLS4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 14:56:43 -0400
Received: by mail-pg1-f202.google.com with SMTP id j19so4101766pgh.14
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 11:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yKydufKP/ns8vSLXNlwT3JfiYrMh37sQlU3YjUrV4Jk=;
        b=efL3jKd1frjr47HPIp3A6sTLRh+G1Lvygg05lOy3NCsGO4VQNc6JCfh/ytBSRhYmI/
         Yil0a0BO3ugn6VxvfGBO+f8D78aBRwi+JFDI6A9CunOhr3bQvSYW5UUcyRwrV5spcAwl
         8w/TWsq5RsTnXFxBF4wfuVdXWiOabrxfk7vYih+V8n2X+pH48ocg/3iWjaAvzyodIbyw
         m8nuraxRPboOTyaqdkRY+sfZHbvQqBIO7Nbcp6mGezRjhdFz6DEFfAOhaFiKtkH1RpY1
         a3yFIRD5Bky62p3vswtTVt9DqViBZjMRsI8Cu2EPoaWxrrlwJ68XQo4nTitRXlChskMY
         DU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yKydufKP/ns8vSLXNlwT3JfiYrMh37sQlU3YjUrV4Jk=;
        b=m5rhF/nt7sb6phxclmrJbx4Ko92wJJ1Ckgw2KFm3VPwJ5okZ8I+VQ9GPPBaUysrMU5
         0LxnI8V7QY7UlwRn1BssEwDUqHJox7al31efW7qcf1fv8MVqq23zTAJNZOGC/8nYw67m
         9vJHp4adhxWMg7P7tPLMSo18fdcGxi74s2cVr1GDFwiQYC0IBXzuwQ8KHJnDNEw68gtI
         1v0RdsToFth7ASXxqkoe2j9OxhrjBW1jgsbM6Q+qIOLiVAflwpkwmWwlOMW2lppRs7m1
         ucO9UCIYMLozCVzMqyIZkdBDuCTH4STFUn0IMKBb3qD4VIKMlh6MTBKnrrveZGAS+CuT
         E8mQ==
X-Gm-Message-State: ANhLgQ2T4Gj70sVYIUns+Cg3TtnHjGMegyL/TAu2lnWAqRfdelX/0evu
        7Q3YpeVKlVOf7kbYnvQMSChGghsqRLFT
X-Google-Smtp-Source: ADFU+vt2xGYOdsAFCv3gaZb8KvtjUOPrTof06wPvb1ZSGq+6dW5O4G5xoMPFnWn89k/orabsaHeunIsg9q8I
X-Received: by 2002:a17:90a:628a:: with SMTP id d10mr5687898pjj.25.1584039401240;
 Thu, 12 Mar 2020 11:56:41 -0700 (PDT)
Date:   Thu, 12 Mar 2020 11:56:27 -0700
In-Reply-To: <20200312185629.141280-1-rajatja@google.com>
Message-Id: <20200312185629.141280-4-rajatja@google.com>
Mime-Version: 1.0
References: <20200312185629.141280-1-rajatja@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v9 3/5] drm/i915: Lookup and attach ACPI device node for connectors
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
v9: same as v8
v8: Also print the connector name in debug message.
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

 drivers/gpu/drm/i915/display/intel_acpi.c     | 26 +++++++++++++++++++
 .../drm/i915/display/intel_display_types.h    |  5 ++++
 drivers/gpu/drm/i915/display/intel_dp.c       | 14 ++++++++++
 drivers/gpu/drm/i915/i915_drv.h               |  2 ++
 4 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
index 3e6831cca4ac1..c203fdd7fda8d 100644
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
@@ -242,6 +255,19 @@ void intel_acpi_device_id_update(struct drm_i915_private *dev_priv)
 		device_id |= display_index[type]++ << ACPI_DISPLAY_INDEX_SHIFT;
 
 		connector->acpi_device_id = device_id;
+
+		/* Build the _ADR to look for */
+		conn_addr = device_id | ACPI_DEVICE_ID_SCHEME |
+				ACPI_BIOS_CAN_DETECT;
+
+		drm_dbg_kms(dev, "%s: Looking for ACPI node at _ADR=%llX\n",
+			    connector->base.kdev ?
+				dev_name(connector->base.kdev) : "NONAME",
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
index 0a417cd2af2bc..3ddc424b028c1 100644
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
@@ -5864,6 +5865,7 @@ static int
 intel_dp_connector_register(struct drm_connector *connector)
 {
 	struct intel_dp *intel_dp = intel_attached_dp(to_intel_connector(connector));
+	struct drm_i915_private *dev_priv = to_i915(connector->dev);
 	int ret;
 
 	ret = intel_connector_register(connector);
@@ -5872,6 +5874,18 @@ intel_dp_connector_register(struct drm_connector *connector)
 
 	intel_connector_debugfs_add(connector);
 
+	/*
+	 * Lookup the ACPI node corresponding to the connector. This needs
+	 * to be done in ->late_register() hook since it needs to iterate
+	 * over all the connectors after they are registered. Calling it
+	 * once for the device is enough since a single call will update
+	 * for all connectors.
+	 */
+	if (!dev_priv->acpi_scan_done) {
+		intel_acpi_device_id_update(dev_priv);
+		dev_priv->acpi_scan_done = true;
+	}
+
 	DRM_DEBUG_KMS("registering %s bus for %s\n",
 		      intel_dp->aux.name, connector->kdev->kobj.name);
 
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

