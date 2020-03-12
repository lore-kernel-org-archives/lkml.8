Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A40EC5ACC0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424FD2072F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FYhpNVF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387533AbgCLA5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 20:57:40 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:47544 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387596AbgCLA5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 20:57:39 -0400
Received: by mail-vk1-f202.google.com with SMTP id m5so1671038vkg.14
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 17:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=9+NZL60hxKQVqLsC6LWr9zYj9I18UQ9y4TN5uOQMD5E=;
        b=FYhpNVF+Anhsb+ZCWqSGGuuOKlkVy2qEQjJdcJrxALzcFBRafcG+QuDIFNyefJcE0U
         oybNevbBU1b91/WoRDa2pk0jYi5b9wfl9FRx2dQKzsyTjFbZGV8p9rF4U+e6m6hswIsL
         sfWrZK7AnA97wBrPVf7tnBulMSEjwgwpiE2G5SMtkIM27LNmadVR3sLu3yg1SU9J69PW
         7tzpcxMROI5Wtiy586p20ZfcGrNN6w9U7b4VQ/vNLIq1LdHFYJWbp+t6skpzs/psb6w2
         zf/Lk74SHVUspL8gyI2J/wHOLQn58f0NKyuJ7P20OnoUa/QbEsHa8P4zFakYj7M+cOOM
         AmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=9+NZL60hxKQVqLsC6LWr9zYj9I18UQ9y4TN5uOQMD5E=;
        b=I5bTzZjBXHKMA1MVWdrVI7Gg5SI2JaqdnPwzmQsKCrMFiMD8HSnObktSG+9XHcgyp+
         mDszAYg+fRCH2WNFRUSrmjIZGkRBmgZeek1AbAha2ghwplthONkRlAd5HWIiyQ37aIgm
         W/kJhjMw+3MWvVAMW4dMApe9rEv4tDFLlSkG+TvQEAwzGGa0140DmDYaoyl7T9QT9Jb5
         blZ9UBYrdNXTl1b2NIoH1HLTX9fkr/wVd+72E/430msqZb4eGhHjA+exdf5RLkSkBwoX
         8j/kRMT8B/kI/Wvasc28iDbMUsIAjvU6o7qSs4vXD8wiD1Kp1k7SVo7l2j5zkuioz85a
         0uag==
X-Gm-Message-State: ANhLgQ2fbCWhVsOBgUPEuOUZJ/qDRE9IY9iS4zw3dBelrRxkE3chLSes
        glIN1bxn45O2uUaKYw0tDJqnsGN2t6o1
X-Google-Smtp-Source: ADFU+vtDaZvaf7oRnHi/dLlI6NjupwIimtwcS2AG3lGB96kzAsYgjBQqUml5Skxbv8u1hHcuXEOQt0Nbt+Ks
X-Received: by 2002:a1f:9948:: with SMTP id b69mr3867845vke.13.1583974658082;
 Wed, 11 Mar 2020 17:57:38 -0700 (PDT)
Date:   Wed, 11 Mar 2020 17:57:21 -0700
In-Reply-To: <20200312005722.48803-1-rajatja@google.com>
Message-Id: <20200312005722.48803-5-rajatja@google.com>
Mime-Version: 1.0
References: <20200312005722.48803-1-rajatja@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v8 4/5] drm/i915: Add helper code for ACPI privacy screen
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

Add helper functions that can allow i915 to detect and control
an integrated privacy screen via ACPI methods. These shall be used
in the next patch.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v8: Initial version. formed by refactoring the previous patch 4.
    print the connector name in the debug messages.

 drivers/gpu/drm/i915/Makefile                 |   3 +-
 .../drm/i915/display/intel_privacy_screen.c   | 184 ++++++++++++++++++
 .../drm/i915/display/intel_privacy_screen.h   |  27 +++
 3 files changed, 213 insertions(+), 1 deletion(-)
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
diff --git a/drivers/gpu/drm/i915/display/intel_privacy_screen.c b/drivers/=
gpu/drm/i915/display/intel_privacy_screen.c
new file mode 100644
index 0000000000000..66039103c821b
--- /dev/null
+++ b/drivers/gpu/drm/i915/display/intel_privacy_screen.c
@@ -0,0 +1,184 @@
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
+#define CONN_NAME(conn)						\
+	(conn->base.kdev ? dev_name(conn->base.kdev) : "NONAME")
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
+	struct drm_device *drm =3D connector->base.dev;
+
+	if (!acpi_handle)
+		return;
+
+	obj =3D acpi_evaluate_dsm(acpi_handle, &drm_conn_dsm_guid,
+				CONNECTOR_DSM_REVID, func, NULL);
+	if (!obj) {
+		drm_err(drm, "%s: failed to evaluate _DSM for fn %llx\n",
+			CONN_NAME(connector), func);
+		return;
+	}
+
+	ACPI_FREE(obj);
+}
+
+void intel_privacy_screen_set_val(struct intel_connector *connector,
+				  enum drm_privacy_screen_status val)
+{
+	struct drm_device *drm =3D connector->base.dev;
+
+	if (val =3D=3D PRIVACY_SCREEN_DISABLED) {
+		drm_dbg_kms(drm, "%s: disabling privacy-screen\n",
+			    CONN_NAME(connector));
+		acpi_privacy_screen_call_dsm(connector,
+					     CONNECTOR_DSM_FN_PRIVACY_DISABLE);
+	} else {
+		drm_dbg_kms(drm, "%s: enabling privacy-screen\n",
+			    CONN_NAME(connector));
+		acpi_privacy_screen_call_dsm(connector,
+					     CONNECTOR_DSM_FN_PRIVACY_ENABLE);
+	}
+}
+
+bool intel_privacy_screen_present(struct intel_connector *connector)
+{
+	acpi_handle handle =3D connector->acpi_handle;
+	struct drm_device *drm =3D connector->base.dev;
+
+	if (handle &&
+	    acpi_check_dsm(handle, &drm_conn_dsm_guid,
+			   CONNECTOR_DSM_REVID,
+			   1 << CONNECTOR_DSM_FN_PRIVACY_ENABLE |
+			   1 << CONNECTOR_DSM_FN_PRIVACY_DISABLE)) {
+		drm_info(drm, "%s: supports ACPI privacy-screen\n",
+			 CONN_NAME(connector));
+		return true;
+	}
+
+	drm_dbg_kms(drm, "%s: doesn't support ACPI privacy-screen\n",
+		    CONN_NAME(connector));
+	return false;
+}
diff --git a/drivers/gpu/drm/i915/display/intel_privacy_screen.h b/drivers/=
gpu/drm/i915/display/intel_privacy_screen.h
new file mode 100644
index 0000000000000..8655745ff9085
--- /dev/null
+++ b/drivers/gpu/drm/i915/display/intel_privacy_screen.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright =C2=A9 2020 Google Inc.
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

