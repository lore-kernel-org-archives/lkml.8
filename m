Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C14C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC572071B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SV/fFcT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387605AbgCLA5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 20:57:36 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:48346 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387481AbgCLA5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 20:57:35 -0400
Received: by mail-pf1-f202.google.com with SMTP id h24so1759098pfn.15
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 17:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/y2DfBHFZLeDghC1UZR41SBlZKupXvp616ynoTxZM98=;
        b=SV/fFcT2tloK2zMo+2k9wlKlbaMrmAFNisfw9kLxe9ZoA4Np+tDrDDzkSKkjHMvvij
         Uv9PsRDuhz8AG/bOwby+Lh541GkOm/VshGZocjUlvgFEDNtYSK5OO9U0TEjyq7dCgxgU
         eGFLF0GIL6vAY+LFh9gHqUrGN6/jmxNhqfsI1AZRy8RZOswfhWLQkZcAl1EQpJA9p62X
         /x8N7qnmob6AsbtpexGvUh4Qt0z80SxMTzs/6FnVrivoXdS2RNxV1nsFOZjkfIUaDIJ+
         bMPeVi9VDiH5OwJG4oOI5zYCFah7NMp6weJwhC9ji200LWQzC8QGI2Ab8qGVTeaoe7cq
         8jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/y2DfBHFZLeDghC1UZR41SBlZKupXvp616ynoTxZM98=;
        b=ke5hYbQWcGuN00IHACJTaDOmVCC/XoDSHMbjo919jQRh/1X050MfWMikLcR9HAI6VP
         Jk2UgXLlZiH+uD9sUuaRRRSiChZ/rRDvE484CET8Ek2y6DOJmcQORU0fL8hkJLNmbtgw
         iwpNRzTzTKFxnHnXTLYueHtcFLdT1nzgQVFCM2A7kGL26QrBUIvQ1fFJvsbVUGPWpZJH
         DQyrOMQbvNcZcfwnNJT5MTy2nu7R6CCRPzaAKoL2s2IDYHrK1yIn/9DfXcxJ+unogJat
         sMB0J8IBX8jGE/o2vn0R+8048Rh8ckWQ9krZ831uqCmdd1iSEgJ7UTXQ+N8LTSxW5oQH
         Hbnw==
X-Gm-Message-State: ANhLgQ2Z32/Lh0eXKsisQqWWm5BkG627hzJ5f6DJHl1+OwpJPe9ao6Og
        sd9u+R03sJOvedV9VRnP2rrfwkKVjObV
X-Google-Smtp-Source: ADFU+vshLizOflftnOWAs5W4UTktoOcTU0+c29PIy5C8WM7kPuxnrhF5DwPYwb2WnQXzrBKA5lGcUBJQZ1ZW
X-Received: by 2002:a17:90a:a893:: with SMTP id h19mr1486955pjq.30.1583974653042;
 Wed, 11 Mar 2020 17:57:33 -0700 (PDT)
Date:   Wed, 11 Mar 2020 17:57:19 -0700
In-Reply-To: <20200312005722.48803-1-rajatja@google.com>
Message-Id: <20200312005722.48803-3-rajatja@google.com>
Mime-Version: 1.0
References: <20200312005722.48803-1-rajatja@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v8 2/5] drm/connector: Add support for privacy-screen property
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

Add support for generic electronic privacy screen property, that
can be added by systems that have an integrated EPS.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v8: Remove the ...destroy_privacy_screen() method and let the property
    be destroyed along with others at the time of device destruction.
    (because drm core doesn't also like properties destroyed in
     late_register()).
v7: * Initial version, formed by moving the privacy-screen property into
      drm core.
    * Break the init_property() into create_property() and attach_property()
      so that property can be created while registering connector, but
      attached in late_register() (after ACPI node detection).

 drivers/gpu/drm/drm_atomic_uapi.c |  4 +++
 drivers/gpu/drm/drm_connector.c   | 51 +++++++++++++++++++++++++++++++
 include/drm/drm_connector.h       | 24 +++++++++++++++
 3 files changed, 79 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index a1e5e262bae2d..843a8cdacd149 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -766,6 +766,8 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
 						   fence_ptr);
 	} else if (property == connector->max_bpc_property) {
 		state->max_requested_bpc = val;
+	} else if (property == connector->privacy_screen_property) {
+		state->privacy_screen_status = val;
 	} else if (connector->funcs->atomic_set_property) {
 		return connector->funcs->atomic_set_property(connector,
 				state, property, val);
@@ -842,6 +844,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
 		*val = 0;
 	} else if (property == connector->max_bpc_property) {
 		*val = state->max_requested_bpc;
+	} else if (property == connector->privacy_screen_property) {
+		*val = state->privacy_screen_status;
 	} else if (connector->funcs->atomic_get_property) {
 		return connector->funcs->atomic_get_property(connector,
 				state, property, val);
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index f632ca05960e7..9a127f67fc59b 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -1171,6 +1171,10 @@ static const struct drm_prop_enum_list dp_colorspaces[] = {
  *	can also expose this property to external outputs, in which case they
  *	must support "None", which should be the default (since external screens
  *	have a built-in scaler).
+ *
+ * privacy-screen:
+ *	This optional property can be used to enable / disable an integrated
+ *	electronic privacy screen that is available on some displays.
  */
 
 int drm_connector_create_standard_properties(struct drm_device *dev)
@@ -2137,6 +2141,53 @@ int drm_connector_set_panel_orientation_with_quirk(
 }
 EXPORT_SYMBOL(drm_connector_set_panel_orientation_with_quirk);
 
+static const struct drm_prop_enum_list privacy_screen_enum[] = {
+	{ PRIVACY_SCREEN_DISABLED, "Disabled" },
+	{ PRIVACY_SCREEN_ENABLED, "Enabled" },
+};
+
+/**
+ * drm_connector_create_privacy_screen_property -
+ *     create the drm connecter's privacy-screen property.
+ * @connector: connector for which to create the privacy-screen property
+ *
+ * This function creates the "privacy-screen" property for the
+ * connector. It is not attached.
+ */
+void
+drm_connector_create_privacy_screen_property(struct drm_connector *connector)
+{
+	if (connector->privacy_screen_property)
+		return;
+
+	connector->privacy_screen_property =
+		drm_property_create_enum(connector->dev, DRM_MODE_PROP_ENUM,
+					 "privacy-screen", privacy_screen_enum,
+					 ARRAY_SIZE(privacy_screen_enum));
+}
+EXPORT_SYMBOL(drm_connector_create_privacy_screen_property);
+
+/**
+ * drm_connector_attach_privacy_screen_property -
+ *     attach the drm connecter's privacy-screen property.
+ * @connector: connector on which to attach the privacy-screen property
+ *
+ * This function attaches the "privacy-screen" property to the
+ * connector. Initial state of privacy-screen is set to disabled.
+ */
+void
+drm_connector_attach_privacy_screen_property(struct drm_connector *connector)
+{
+	struct drm_property *prop = connector->privacy_screen_property;
+
+	if (!prop)
+		return;
+
+	drm_object_attach_property(&connector->base, prop,
+				   PRIVACY_SCREEN_DISABLED);
+}
+EXPORT_SYMBOL(drm_connector_attach_privacy_screen_property);
+
 int drm_connector_set_obj_prop(struct drm_mode_object *obj,
 				    struct drm_property *property,
 				    uint64_t value)
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 2113500b4075d..f1a42987c5693 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -254,6 +254,20 @@ enum drm_panel_orientation {
 	DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
 };
 
+/**
+ * enum drm_privacy_screen_status - privacy screen status
+ *
+ * This enum is used to track and control the state of the integrated privacy
+ * screen present on some display panels, via the "privacy-screen" property.
+ *
+ * @PRIVACY_SCREEN_DISABLED: The privacy-screen on the panel is disabled
+ * @PRIVACY_SCREEN_ENABLED:  The privacy-screen on the panel is enabled
+ **/
+enum drm_privacy_screen_status {
+	PRIVACY_SCREEN_DISABLED = 0,
+	PRIVACY_SCREEN_ENABLED = 1,
+};
+
 /*
  * This is a consolidated colorimetry list supported by HDMI and
  * DP protocol standard. The respective connectors will register
@@ -656,6 +670,8 @@ struct drm_connector_state {
 	 */
 	u8 max_bpc;
 
+	enum drm_privacy_screen_status privacy_screen_status;
+
 	/**
 	 * @hdr_output_metadata:
 	 * DRM blob property for HDR output metadata
@@ -1255,6 +1271,12 @@ struct drm_connector {
 	 */
 	struct drm_property *max_bpc_property;
 
+	/**
+	 *  @privacy_screen_property: Optional property for the connector to
+	 *  control the integrated privacy screen, if available.
+	 */
+	struct drm_property *privacy_screen_property;
+
 #define DRM_CONNECTOR_POLL_HPD (1 << 0)
 #define DRM_CONNECTOR_POLL_CONNECT (1 << 1)
 #define DRM_CONNECTOR_POLL_DISCONNECT (1 << 2)
@@ -1561,6 +1583,8 @@ int drm_connector_set_panel_orientation_with_quirk(
 	int width, int height);
 int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
 					  int min, int max);
+void drm_connector_create_privacy_screen_property(struct drm_connector *conn);
+void drm_connector_attach_privacy_screen_property(struct drm_connector *conn);
 
 /**
  * struct drm_tile_group - Tile group metadata
-- 
2.25.1.481.gfbce0eb801-goog

