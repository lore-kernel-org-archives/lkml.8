Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CA9C10F25
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 00:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245DC2253D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 00:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="scj7XEzy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbgCJAGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 20:06:35 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:36680 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbgCJAGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 20:06:34 -0400
Received: by mail-vk1-f202.google.com with SMTP id l19so2110056vko.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 17:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=As2MgrbSLjrL3zAjIuYMRljole1TlaR/KGnmofKr/OU=;
        b=scj7XEzyodUmhnen3jYdeDE02J4jdpUCh+cbccA2g06kB8N1JFUfFrIz4kzRA8kltX
         VdFwDlFdsCCgnfdK/h1MvGBL/dtABPOqkBo2futvhMjQBw0Gp/2+IYYaHQz5WgDQF9Av
         E97/e1+eo0L0k9RR6/UitUT46urA4+nb6MHkm1FqDqIz7VCAl6lqWzM9GI0SHr8qpSVd
         tB8Xi7OJJ98Ukw0lLwjK2W60HknFt5VQH/J0LD03wfkt12RM2rvF4Q6blzHkwdL34M0k
         zCkB6MDdgif8mqTMgo8hFhcYdNbTWRP0Xq5wgJ3Xj4K/xr75ZZHBzN0PsKQfJOGlFYjb
         XCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=As2MgrbSLjrL3zAjIuYMRljole1TlaR/KGnmofKr/OU=;
        b=hB29TE65lyygXDRpOEF3QAxE3Am3N+ND691mAyYxcI5VbCz8SpQ0+wph8lnKTTXyTM
         Oy7+En7v5YgMT4e77WlusGtBIBk12NDfiTYg9ROkAav+Ij4HRmRkHcU9U9Ps8VoG5i0f
         C3t4SFV+CE/OsqGNp0zUs79ex9cfukMbmE6SAB/hW24hUC6GERGotYUVgEqT/yXY/Qte
         3kyCcceMIJZggpPzbZajbgcwmcIPXUTmynDDlUT1FjFYs6M5jP2UEK2YchGGgHiCe6Qi
         NS9c1FWmfYkzCLMyzEdKN90vuPOEj6qvPgDhx/ot5mzFSjNVYVi/iXb7XtPEUB5pZqjI
         K9Jg==
X-Gm-Message-State: ANhLgQ0q5c42iOnH9TLs5M8HW4YdJcMcexhD8ZystFwabE8x15UonSYJ
        MA2fge10iyWC3yxL/svbPKqaNAuhgXXQ
X-Google-Smtp-Source: ADFU+vtQE3vV+61Yrn6asBi8R07klDCVixINgWY7stZ7HDgH1/RzQnWF9XKV9S0Xt0vURx/q33zhDwPH+NMI
X-Received: by 2002:a1f:45cd:: with SMTP id s196mr6612219vka.102.1583798792197;
 Mon, 09 Mar 2020 17:06:32 -0700 (PDT)
Date:   Mon,  9 Mar 2020 17:06:17 -0700
In-Reply-To: <20200310000617.20662-1-rajatja@google.com>
Message-Id: <20200310000617.20662-5-rajatja@google.com>
Mime-Version: 1.0
References: <20200310000617.20662-1-rajatja@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v7 4/4] drm/i915: Add support for integrated privacy screen
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for an ACPI based integrated privacy screen that is
available on some systems.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v7: * Move the privacy-screen property back into drm core.
    * Do the actual HW EPS toggling at commit time.
    * Provide a sample ACPI node for reference in comments.=20
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

 drivers/gpu/drm/i915/Makefile                 |   3 +-
 drivers/gpu/drm/i915/display/intel_atomic.c   |   1 +
 drivers/gpu/drm/i915/display/intel_dp.c       |  30 ++-
 .../drm/i915/display/intel_privacy_screen.c   | 175 ++++++++++++++++++
 .../drm/i915/display/intel_privacy_screen.h   |  27 +++
 5 files changed, 234 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/display/intel_privacy_screen.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_privacy_screen.h

diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index 9f887a86e555d..da42389107f9c 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -209,7 +209,8 @@ i915-y +=3D \
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
index d043057d2fa03..fc6264b4a7f73 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic.c
+++ b/drivers/gpu/drm/i915/display/intel_atomic.c
@@ -150,6 +150,7 @@ int intel_digital_connector_atomic_check(struct drm_con=
nector *conn,
 	    new_conn_state->base.picture_aspect_ratio !=3D old_conn_state->base.p=
icture_aspect_ratio ||
 	    new_conn_state->base.content_type !=3D old_conn_state->base.content_t=
ype ||
 	    new_conn_state->base.scaling_mode !=3D old_conn_state->base.scaling_m=
ode ||
+	    new_conn_state->base.privacy_screen_status !=3D old_conn_state->base.=
privacy_screen_status ||
 	    !blob_equal(new_conn_state->base.hdr_output_metadata,
 			old_conn_state->base.hdr_output_metadata))
 		crtc_state->mode_changed =3D true;
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915=
/display/intel_dp.c
index 41c623b029464..a39b0c420b50a 100644
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
@@ -5886,6 +5887,12 @@ intel_dp_connector_register(struct drm_connector *co=
nnector)
 		dev_priv->acpi_scan_done =3D true;
 	}
=20
+	/* Check for integrated Privacy screen support */
+	if (intel_privacy_screen_present(to_intel_connector(connector)))
+		drm_connector_attach_privacy_screen_property(connector);
+	else
+		drm_connector_destroy_privacy_screen_property(connector);
+
 	DRM_DEBUG_KMS("registering %s bus for %s\n",
 		      intel_dp->aux.name, connector->kdev->kobj.name);
=20
@@ -6881,9 +6888,30 @@ intel_dp_add_properties(struct intel_dp *intel_dp, s=
truct drm_connector *connect
 		drm_connector_attach_scaling_mode_property(connector, allowed_scalers);
=20
 		connector->state->scaling_mode =3D DRM_MODE_SCALE_ASPECT;
+
+		drm_connector_create_privacy_screen_property(connector);
 	}
 }
=20
+static void intel_dp_update_privacy_screen(struct intel_encoder *encoder,
+				const struct intel_crtc_state *crtc_state,
+				const struct drm_connector_state *conn_state)
+{
+	struct drm_connector *connector =3D conn_state->connector;
+
+	if (connector->privacy_screen_property)
+		intel_privacy_screen_set_val(to_intel_connector(connector),
+					     conn_state->privacy_screen_status);
+}
+
+static void intel_dp_update_pipe(struct intel_encoder *encoder,
+				 const struct intel_crtc_state *crtc_state,
+				 const struct drm_connector_state *conn_state)
+{
+	intel_dp_update_privacy_screen(encoder, crtc_state, conn_state);
+	intel_panel_update_backlight(encoder, crtc_state, conn_state);
+}
+
 static void intel_dp_init_panel_power_timestamps(struct intel_dp *intel_dp=
)
 {
 	intel_dp->panel_power_off_time =3D ktime_get_boottime();
@@ -7825,7 +7853,7 @@ bool intel_dp_init(struct drm_i915_private *dev_priv,
 	intel_encoder->compute_config =3D intel_dp_compute_config;
 	intel_encoder->get_hw_state =3D intel_dp_get_hw_state;
 	intel_encoder->get_config =3D intel_dp_get_config;
-	intel_encoder->update_pipe =3D intel_panel_update_backlight;
+	intel_encoder->update_pipe =3D intel_dp_update_pipe;
 	intel_encoder->suspend =3D intel_dp_encoder_suspend;
 	if (IS_CHERRYVIEW(dev_priv)) {
 		intel_encoder->pre_pll_enable =3D chv_dp_pre_pll_enable;
diff --git a/drivers/gpu/drm/i915/display/intel_privacy_screen.c b/drivers/=
gpu/drm/i915/display/intel_privacy_screen.c
new file mode 100644
index 0000000000000..6ff61ddf4c0a4
--- /dev/null
+++ b/drivers/gpu/drm/i915/display/intel_privacy_screen.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Intel ACPI privacy screen code
+ *
+ * Copyright =C2=A9 2020 Google Inc.
+ *
+ * This code can help detect and control an integrated EPS (electronic
+ * privacy screen) via ACPI functions. It expects an ACPI node for the
+ * drm connector device with the following elements:
+ *
+ * UUID should be "c7033113-8720-4ceb-9090-9d52b3e52d73"
+ *
+ * _ADR =3D ACPI address per Spec (also see intel_acpi_device_id_update())
+ * https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
+ * Pages 1119 - 1123.
+ *
+ * _DSM method that will perform the following functions according to
+ * Local1 argument passed to it:
+ *  - Local1 =3D 0 (EPS capabilities): Report EPS presence and capabilitie=
s.
+ *  - Local1 =3D 1 (EPS State)  :  _DSM returns 1 if EPS is enabled, 0 oth=
erwise.
+ *  - Local1 =3D 2 (EPS Enable) :  _DSM enables EPS
+ *  - Local1 =3D 3 (EPS Disable):  _DSM disables EPS
+ *
+ * Here is a sample ACPI node:
+ *
+ *  Scope (\_SB.PCI0.GFX0) // Intel graphics device (PCI device)
+ *  {
+ *      Method (_DOD, 0, NotSerialized)  // _DOD: Display Output Devices
+ *      {
+ *          Return (Package (0x01)
+ *          {
+ *              0x80010400
+ *          })
+ *      }
+ *
+ *      Device (LCD)
+ *      {
+ *          Name (_ADR, 0x80010400)  // _ADR: Address
+ *          Name (_STA, 0x0F)  // _STA: Status
+ *
+ *          Method (EPSP, 0, NotSerialized) // EPS Present
+ *          {
+ *              Return (0x01)
+ *          }
+ *
+ *          Method (EPSS, 0, NotSerialized) // EPS State
+ *          {
+ *              Local0 =3D \_SB.PCI0.GRXS (0xCD)
+ *              Return (Local0)
+ *          }
+ *
+ *          Method (EPSE, 0, NotSerialized) // EPS Enable
+ *          {
+ *              \_SB.PCI0.STXS (0xCD)
+ *          }
+ *
+ *          Method (EPSD, 0, NotSerialized) // EPS Disable
+ *          {
+ *              \_SB.PCI0.CTXS (0xCD)
+ *          }
+ *
+ *          Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
+ *          {
+ *              ToBuffer (Arg0, Local0)
+ *              If ((Local0 =3D=3D ToUUID ("c7033113-8720-4ceb-9090-9d52b3=
e52d73")))
+ *              {
+ *                  ToInteger (Arg2, Local1)
+ *                  If ((Local1 =3D=3D Zero))
+ *                  {
+ *                      Local2 =3D EPSP ()
+ *                      If ((Local2 =3D=3D One))
+ *                      {
+ *                          Return (Buffer (One)
+ *                          {
+ *                               0x0F
+ *                          })
+ *                      }
+ *                  }
+ *
+ *                  If ((Local1 =3D=3D One))
+ *                  {
+ *                      Return (EPSS ())
+ *                  }
+ *
+ *                  If ((Local1 =3D=3D 0x02))
+ *                  {
+ *                      EPSE ()
+ *                  }
+ *
+ *                  If ((Local1 =3D=3D 0x03))
+ *                  {
+ *                      EPSD ()
+ *                  }
+ *
+ *                  Return (Buffer (One)
+ *                  {
+ *                       0x00
+ *                  })
+ *              }
+ *
+ *              Return (Buffer (One)
+ *              {
+ *                   0x00
+ *              })
+ *          }
+ *      }
+ *  }
+ */
+
+#include <linux/acpi.h>
+
+#include "intel_privacy_screen.h"
+
+#define CONNECTOR_DSM_REVID 1
+
+#define CONNECTOR_DSM_FN_PRIVACY_ENABLE		2
+#define CONNECTOR_DSM_FN_PRIVACY_DISABLE	3
+
+static const guid_t drm_conn_dsm_guid =3D
+	GUID_INIT(0xC7033113, 0x8720, 0x4CEB,
+		  0x90, 0x90, 0x9D, 0x52, 0xB3, 0xE5, 0x2D, 0x73);
+
+/* Makes _DSM call to set privacy screen status */
+static void acpi_privacy_screen_call_dsm(struct intel_connector *connector=
,
+					 u64 func)
+{
+	union acpi_object *obj;
+	acpi_handle acpi_handle =3D connector->acpi_handle;
+
+	if (!acpi_handle)
+		return;
+
+	obj =3D acpi_evaluate_dsm(acpi_handle, &drm_conn_dsm_guid,
+				CONNECTOR_DSM_REVID, func, NULL);
+	if (!obj) {
+		drm_err(connector->base.dev,
+			"failed to evaluate _DSM for fn %llx\n", func);
+		return;
+	}
+
+	ACPI_FREE(obj);
+}
+
+void intel_privacy_screen_set_val(struct intel_connector *connector,
+				  enum drm_privacy_screen_status val)
+{
+	if (val =3D=3D PRIVACY_SCREEN_DISABLED)
+		acpi_privacy_screen_call_dsm(connector,
+					     CONNECTOR_DSM_FN_PRIVACY_DISABLE);
+	else if (val =3D=3D PRIVACY_SCREEN_ENABLED)
+		acpi_privacy_screen_call_dsm(connector,
+					     CONNECTOR_DSM_FN_PRIVACY_ENABLE);
+	else
+		drm_err(connector->base.dev,
+			"Cannot set privacy screen to invalid val %u\n", val);
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
+		drm_dbg_kms(connector->base.dev,
+			    "ACPI node but no privacy scrn\n");
+		return false;
+	}
+	drm_info(connector->base.dev, "supports privacy screen\n");
+	return true;
+}
diff --git a/drivers/gpu/drm/i915/display/intel_privacy_screen.h b/drivers/=
gpu/drm/i915/display/intel_privacy_screen.h
new file mode 100644
index 0000000000000..f8d2e246ea0bd
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
+				  enum drm_privacy_screen_status val);
+#else
+static bool intel_privacy_screen_present(struct intel_connector *connector=
)
+{
+	return false;
+}
+
+static void
+intel_privacy_screen_set_val(struct intel_connector *connector,
+			     enum drm_privacy_screen_status val)
+{ }
+#endif /* CONFIG_ACPI */
+
+#endif /* __DRM_PRIVACY_SCREEN_H__ */
--=20
2.25.1.481.gfbce0eb801-goog

