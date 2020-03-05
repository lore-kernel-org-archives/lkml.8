Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5FAC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DF020870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GM2z4ud+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgCEBX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 20:23:56 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:57289 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgCEBXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 20:23:54 -0500
Received: by mail-pg1-f202.google.com with SMTP id k67so2263571pga.23
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 17:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=xVbKhPYa03B/7Fj2wzK9whmItxLhEu9PIS8rQfMj+SU=;
        b=GM2z4ud+9K0JKzbxsFheloVDdBaQxSOGR7UIizgqv6Fz3VfjncftQN2pKYvj/ugTrJ
         mMLygJcH56f9wyVkGssID3FkFnLLrIPZAIW6W4LRnh+L2ihE5QKtAmn2oqIIpUFk1apN
         8d38W5ToUj9qvA1qIicW38AR0EroTnBYVFjbJ33csWp+zI4q8tuJFR/VkHAf6bTlZRIe
         IPeY1Jx9dlQ5AiAz0ocL2KKG8XzORqbjzlMCzPHjKEP3Kupx/yzVN/JcRTfgh5nE8trH
         P6YObwrzcc3Uha/ST7nirtLf3DxrE4c0hojx9bg92k3iePINHFff5+OoApSeTOvBobrT
         ml+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=xVbKhPYa03B/7Fj2wzK9whmItxLhEu9PIS8rQfMj+SU=;
        b=NtoCCmXvFez0ziYuctJ7W+ulJKdUXFM0MS/XLXct17uOQ46AzASA+gK/g3dMaaXApV
         dH3KtuPT+DlqbvJVZeVnQBSnyjnQ7ItpUX4u9HT/7Y7cKM6RuWd9yXYb1L/ntru6aXgh
         en5PhoJcGW7wNUrH7BxsYpKpmDln5+OeEJz04ob0ShDLQeQZfV3+VmV8wKFR/HZWppGI
         bIwkGjFzyVVsA7xCzsicOXWLIJp2pOWuBhdu7+OdeT8JgCtDx8aBiRYRBJmgpY4CpCZ7
         PgjyoCZV4trbotz768hab2NSCR8rOCMQw5OUDUtSg+Pf8e+yfladO5XVx+hgFS8T7KqN
         78DQ==
X-Gm-Message-State: ANhLgQ2oAFBFiJ/lmEQcjc/qtkxobeWDJIycISfskPUXvXZppiPOVmgh
        KKp7D+u4mBRzlFw4V5D+MXULt+myTXDI
X-Google-Smtp-Source: ADFU+vu9pNnubG4QZFewleUzGXkCy2THuipbLYTYtQx0hzQy+4owF20BomGvEjVc33UZsofb5kI0PQhzFQ/O
X-Received: by 2002:a65:488d:: with SMTP id n13mr5008755pgs.91.1583371431651;
 Wed, 04 Mar 2020 17:23:51 -0800 (PST)
Date:   Wed,  4 Mar 2020 17:23:38 -0800
In-Reply-To: <20200305012338.219746-1-rajatja@google.com>
Message-Id: <20200305012338.219746-4-rajatja@google.com>
Mime-Version: 1.0
References: <20200305012338.219746-1-rajatja@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v6 3/3] drm/i915: Add support for integrated privacy screens
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
        Tomoki Maruichi <maruichit@lenovo.com>, groeck@google.com
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain laptops now come with panels that have integrated privacy
screens on them. This patch adds support for such panels by adding
a privacy-screen property to the intel_connector for the panel, that
the userspace can then use to control and check the status.

Identifying the presence of privacy screen, and controlling it, is done
via ACPI _DSM methods.

Currently, this is done only for the Intel display ports. But in future,
this can be done for any other ports if the hardware becomes available
(e.g. external monitors supporting integrated privacy screens?).

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v6: Always initialize prop in intel_attach_privacy_screen_property()
v5: fix a cosmetic checkpatch warning
v4: Fix a typo in intel_privacy_screen.h
v3: * Change license to GPL-2.0 OR MIT
    * Move privacy screen enum from UAPI to intel_display_types.h
    * Rename parameter name and some other minor changes.
v2: Formed by splitting the original patch into multiple patches.
    - All code has been moved into i915 now.
    - Privacy screen is a i915 property
    - Have a local state variable to store the prvacy screen. Don't read
      it from hardware.

 drivers/gpu/drm/i915/Makefile                 |  3 +-
 drivers/gpu/drm/i915/display/intel_atomic.c   | 13 +++-
 .../gpu/drm/i915/display/intel_connector.c    | 35 +++++++++
 .../gpu/drm/i915/display/intel_connector.h    |  1 +
 .../drm/i915/display/intel_display_types.h    | 18 +++++
 drivers/gpu/drm/i915/display/intel_dp.c       |  6 ++
 .../drm/i915/display/intel_privacy_screen.c   | 72 +++++++++++++++++++
 .../drm/i915/display/intel_privacy_screen.h   | 27 +++++++
 8 files changed, 171 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/display/intel_privacy_screen.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_privacy_screen.h

diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index 991a8c537d123..825951b4cd006 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -208,7 +208,8 @@ i915-y +=3D \
 	display/intel_vga.o
 i915-$(CONFIG_ACPI) +=3D \
 	display/intel_acpi.o \
-	display/intel_opregion.o
+	display/intel_opregion.o \
+	display/intel_privacy_screen.o
 i915-$(CONFIG_DRM_FBDEV_EMULATION) +=3D \
 	display/intel_fbdev.o
=20
diff --git a/drivers/gpu/drm/i915/display/intel_atomic.c b/drivers/gpu/drm/=
i915/display/intel_atomic.c
index d043057d2fa03..4ed537c877777 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic.c
+++ b/drivers/gpu/drm/i915/display/intel_atomic.c
@@ -40,6 +40,7 @@
 #include "intel_global_state.h"
 #include "intel_hdcp.h"
 #include "intel_psr.h"
+#include "intel_privacy_screen.h"
 #include "intel_sprite.h"
=20
 /**
@@ -60,11 +61,14 @@ int intel_digital_connector_atomic_get_property(struct =
drm_connector *connector,
 	struct drm_i915_private *dev_priv =3D to_i915(dev);
 	struct intel_digital_connector_state *intel_conn_state =3D
 		to_intel_digital_connector_state(state);
+	struct intel_connector *intel_connector =3D to_intel_connector(connector)=
;
=20
 	if (property =3D=3D dev_priv->force_audio_property)
 		*val =3D intel_conn_state->force_audio;
 	else if (property =3D=3D dev_priv->broadcast_rgb_property)
 		*val =3D intel_conn_state->broadcast_rgb;
+	else if (property =3D=3D intel_connector->privacy_screen_property)
+		*val =3D intel_conn_state->privacy_screen_status;
 	else {
 		drm_dbg_atomic(&dev_priv->drm,
 			       "Unknown property [PROP:%d:%s]\n",
@@ -93,15 +97,18 @@ int intel_digital_connector_atomic_set_property(struct =
drm_connector *connector,
 	struct drm_i915_private *dev_priv =3D to_i915(dev);
 	struct intel_digital_connector_state *intel_conn_state =3D
 		to_intel_digital_connector_state(state);
+	struct intel_connector *intel_connector =3D to_intel_connector(connector)=
;
=20
 	if (property =3D=3D dev_priv->force_audio_property) {
 		intel_conn_state->force_audio =3D val;
 		return 0;
-	}
-
-	if (property =3D=3D dev_priv->broadcast_rgb_property) {
+	} else if (property =3D=3D dev_priv->broadcast_rgb_property) {
 		intel_conn_state->broadcast_rgb =3D val;
 		return 0;
+	} else if (property =3D=3D intel_connector->privacy_screen_property) {
+		intel_privacy_screen_set_val(intel_connector, val);
+		intel_conn_state->privacy_screen_status =3D val;
+		return 0;
 	}
=20
 	drm_dbg_atomic(&dev_priv->drm, "Unknown property [PROP:%d:%s]\n",
diff --git a/drivers/gpu/drm/i915/display/intel_connector.c b/drivers/gpu/d=
rm/i915/display/intel_connector.c
index 903e49659f561..55f80219cb269 100644
--- a/drivers/gpu/drm/i915/display/intel_connector.c
+++ b/drivers/gpu/drm/i915/display/intel_connector.c
@@ -297,3 +297,38 @@ intel_attach_colorspace_property(struct drm_connector =
*connector)
 	drm_object_attach_property(&connector->base,
 				   connector->colorspace_property, 0);
 }
+
+static const struct drm_prop_enum_list privacy_screen_enum[] =3D {
+	{ PRIVACY_SCREEN_DISABLED, "Disabled" },
+	{ PRIVACY_SCREEN_ENABLED, "Enabled" },
+};
+
+/**
+ * intel_attach_privacy_screen_property -
+ *     create and attach the connecter's privacy-screen property. *
+ * @connector: connector for which to init the privacy-screen property
+ *
+ * This function creates and attaches the "privacy-screen" property to the
+ * connector. Initial state of privacy-screen is set to disabled.
+ */
+void
+intel_attach_privacy_screen_property(struct drm_connector *connector)
+{
+	struct intel_connector *intel_connector =3D to_intel_connector(connector)=
;
+	struct drm_property *prop =3D intel_connector->privacy_screen_property;
+
+	if (!prop) {
+		prop =3D drm_property_create_enum(connector->dev,
+						DRM_MODE_PROP_ENUM,
+						"privacy-screen",
+						privacy_screen_enum,
+					    ARRAY_SIZE(privacy_screen_enum));
+		if (!prop)
+			return;
+
+		intel_connector->privacy_screen_property =3D prop;
+	}
+
+	drm_object_attach_property(&connector->base, prop,
+				   PRIVACY_SCREEN_DISABLED);
+}
diff --git a/drivers/gpu/drm/i915/display/intel_connector.h b/drivers/gpu/d=
rm/i915/display/intel_connector.h
index 93a7375c8196d..61005f37a3385 100644
--- a/drivers/gpu/drm/i915/display/intel_connector.h
+++ b/drivers/gpu/drm/i915/display/intel_connector.h
@@ -31,5 +31,6 @@ void intel_attach_force_audio_property(struct drm_connect=
or *connector);
 void intel_attach_broadcast_rgb_property(struct drm_connector *connector);
 void intel_attach_aspect_ratio_property(struct drm_connector *connector);
 void intel_attach_colorspace_property(struct drm_connector *connector);
+void intel_attach_privacy_screen_property(struct drm_connector *connector)=
;
=20
 #endif /* __INTEL_CONNECTOR_H__ */
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/g=
pu/drm/i915/display/intel_display_types.h
index d70612cc1ba2a..de20effb3e073 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -442,6 +442,23 @@ struct intel_connector {
 	struct work_struct modeset_retry_work;
=20
 	struct intel_hdcp hdcp;
+
+	/* Optional "privacy-screen" property for the connector panel */
+	struct drm_property *privacy_screen_property;
+};
+
+/**
+ * enum intel_privacy_screen_status - privacy_screen status
+ *
+ * This enum is used to track and control the state of the integrated priv=
acy
+ * screen present on some display panels, via the "privacy-screen" propert=
y.
+ *
+ * @PRIVACY_SCREEN_DISABLED: The privacy-screen on the panel is disabled
+ * @PRIVACY_SCREEN_ENABLED:  The privacy-screen on the panel is enabled
+ **/
+enum intel_privacy_screen_status {
+	PRIVACY_SCREEN_DISABLED =3D 0,
+	PRIVACY_SCREEN_ENABLED =3D 1,
 };
=20
 struct intel_digital_connector_state {
@@ -449,6 +466,7 @@ struct intel_digital_connector_state {
=20
 	enum hdmi_force_audio force_audio;
 	int broadcast_rgb;
+	enum intel_privacy_screen_status privacy_screen_status;
 };
=20
 #define to_intel_digital_connector_state(x) container_of(x, struct intel_d=
igital_connector_state, base)
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915=
/display/intel_dp.c
index 171821113d362..ff76c799364d0 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -62,6 +62,7 @@
 #include "intel_lspcon.h"
 #include "intel_lvds.h"
 #include "intel_panel.h"
+#include "intel_privacy_screen.h"
 #include "intel_psr.h"
 #include "intel_sideband.h"
 #include "intel_tc.h"
@@ -6841,6 +6842,7 @@ intel_dp_add_properties(struct intel_dp *intel_dp, st=
ruct drm_connector *connect
 {
 	struct drm_i915_private *dev_priv =3D to_i915(connector->dev);
 	enum port port =3D dp_to_dig_port(intel_dp)->base.port;
+	struct intel_connector *intel_connector =3D to_intel_connector(connector)=
;
=20
 	if (!IS_G4X(dev_priv) && port !=3D PORT_A)
 		intel_attach_force_audio_property(connector);
@@ -6871,6 +6873,10 @@ intel_dp_add_properties(struct intel_dp *intel_dp, s=
truct drm_connector *connect
=20
 		/* Lookup the ACPI node corresponding to the connector */
 		intel_acpi_device_id_update(dev_priv);
+
+		/* Check for integrated Privacy screen support */
+		if (intel_privacy_screen_present(intel_connector))
+			intel_attach_privacy_screen_property(connector);
 	}
 }
=20
diff --git a/drivers/gpu/drm/i915/display/intel_privacy_screen.c b/drivers/=
gpu/drm/i915/display/intel_privacy_screen.c
new file mode 100644
index 0000000000000..c8a5b64f94fb7
--- /dev/null
+++ b/drivers/gpu/drm/i915/display/intel_privacy_screen.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Intel ACPI privacy screen code
+ *
+ * Copyright =C2=A9 2019 Google Inc.
+ */
+
+#include <linux/acpi.h>
+
+#include "intel_privacy_screen.h"
+
+#define CONNECTOR_DSM_REVID 1
+
+#define CONNECTOR_DSM_FN_PRIVACY_ENABLE		2
+#define CONNECTOR_DSM_FN_PRIVACY_DISABLE		3
+
+static const guid_t drm_conn_dsm_guid =3D
+	GUID_INIT(0xC7033113, 0x8720, 0x4CEB,
+		  0x90, 0x90, 0x9D, 0x52, 0xB3, 0xE5, 0x2D, 0x73);
+
+/* Makes _DSM call to set privacy screen status */
+static void acpi_privacy_screen_call_dsm(acpi_handle conn_handle, u64 func=
)
+{
+	union acpi_object *obj;
+
+	obj =3D acpi_evaluate_dsm(conn_handle, &drm_conn_dsm_guid,
+				CONNECTOR_DSM_REVID, func, NULL);
+	if (!obj) {
+		DRM_DEBUG_DRIVER("failed to evaluate _DSM for fn %llx\n", func);
+		return;
+	}
+
+	ACPI_FREE(obj);
+}
+
+void intel_privacy_screen_set_val(struct intel_connector *connector,
+				  enum intel_privacy_screen_status val)
+{
+	acpi_handle acpi_handle =3D connector->acpi_handle;
+
+	if (!acpi_handle)
+		return;
+
+	if (val =3D=3D PRIVACY_SCREEN_DISABLED)
+		acpi_privacy_screen_call_dsm(acpi_handle,
+					     CONNECTOR_DSM_FN_PRIVACY_DISABLE);
+	else if (val =3D=3D PRIVACY_SCREEN_ENABLED)
+		acpi_privacy_screen_call_dsm(acpi_handle,
+					     CONNECTOR_DSM_FN_PRIVACY_ENABLE);
+	else
+		DRM_WARN("%s: Cannot set privacy screen to invalid val %u\n",
+			 dev_name(connector->base.dev->dev), val);
+}
+
+bool intel_privacy_screen_present(struct intel_connector *connector)
+{
+	acpi_handle handle =3D connector->acpi_handle;
+
+	if (!handle)
+		return false;
+
+	if (!acpi_check_dsm(handle, &drm_conn_dsm_guid,
+			    CONNECTOR_DSM_REVID,
+			    1 << CONNECTOR_DSM_FN_PRIVACY_ENABLE |
+			    1 << CONNECTOR_DSM_FN_PRIVACY_DISABLE)) {
+		DRM_WARN("%s: Odd, connector ACPI node but no privacy scrn?\n",
+			 dev_name(connector->base.dev->dev));
+		return false;
+	}
+	DRM_DEV_INFO(connector->base.dev->dev, "supports privacy screen\n");
+	return true;
+}
diff --git a/drivers/gpu/drm/i915/display/intel_privacy_screen.h b/drivers/=
gpu/drm/i915/display/intel_privacy_screen.h
new file mode 100644
index 0000000000000..74013a7885c70
--- /dev/null
+++ b/drivers/gpu/drm/i915/display/intel_privacy_screen.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright =C2=A9 2019 Google Inc.
+ */
+
+#ifndef __DRM_PRIVACY_SCREEN_H__
+#define __DRM_PRIVACY_SCREEN_H__
+
+#include "intel_display_types.h"
+
+#ifdef CONFIG_ACPI
+bool intel_privacy_screen_present(struct intel_connector *connector);
+void intel_privacy_screen_set_val(struct intel_connector *connector,
+				  enum intel_privacy_screen_status val);
+#else
+static bool intel_privacy_screen_present(struct intel_connector *connector=
)
+{
+	return false;
+}
+
+static void
+intel_privacy_screen_set_val(struct intel_connector *connector,
+			     enum intel_privacy_screen_status val)
+{ }
+#endif /* CONFIG_ACPI */
+
+#endif /* __DRM_PRIVACY_SCREEN_H__ */
--=20
2.25.0.265.gbab2e86ba0-goog

