Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EE3C3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2082084E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GsDLhkZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgCEBTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 20:19:51 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:46823 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgCEBTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 20:19:50 -0500
Received: by mail-pg1-f202.google.com with SMTP id s18so2270269pgd.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 17:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=C9EkwJ1gUg61QN8k194CxCHcCIG0/y+uw6Hl1AyDtGU=;
        b=GsDLhkZMIEv9Ej06Re07oGqTUeN2KIqnyE1PyJebG3AiwxrNMzy6cA7FbNZIlcPZ62
         eajxd2DGNBSvUlm0m74/gSau0MwgbU9Ue7JfA58M0/f/tYZNvV8isvsg5q/Bxy5F62Hu
         C1bH7nfhem8ohlZ7trw3kEyFpCS94UQ6n5YXi72iUNj2UQrtOkb61BI//u12W4r+ZeIu
         O5RpEvgOVC+crxEXEpV1OYIYyf9B22fFpLTM7L3ReU+MzdmTlAdbxgHnOuD9QyANIfCk
         y2TNvYBfsu7Si2FCxBBPbHPwT37pOg8Qc5EJEkliy4FWFlmaiUqqqL0XuapXx5qKY/Gy
         amXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=C9EkwJ1gUg61QN8k194CxCHcCIG0/y+uw6Hl1AyDtGU=;
        b=TZH+uuKISOUlWK33d6kC/52moasObk+eUL/eLh/u26YS0JYWOKDx9UMz4StXbxbrXv
         TjrqHkhIoNBsnwz+48MgrX4Ju3dRNef+rPiQ+vwBGBS/m/7RxClKOSyilbTiNph0tS2g
         6AI13wyGPeqnZc+zWpj0u4CNJFqtMftMvPSDE0CMn0fabHc/77cmt9RKzIiqNGRTzaWL
         SZH7axoOsX47HT8fi3VizKfFwl8xWevtgOh9IC/UKvM7LO+VBXcJ/3h49Thb/YR1Qpwe
         peQBVJtNeM4tXVp1Z7f3CafXb/tHreT/lqbIfkYjYl/GspN3OcShyRli5VjpZpJK6Wqm
         WUxA==
X-Gm-Message-State: ANhLgQ3d1ja6+s8ux4THR/utUsDX+jn0wdbX7XBwas0X99FuX8/aIIXV
        5rmntMVbJqJQj7AeQoo5nQ1l4pomkGbx
X-Google-Smtp-Source: ADFU+vtK9ayimG+QWi91+mM6FMKWb3R87v0c84ZF0OEt7KbKfhUlWJrA5oGjJks6ePvEpIzXnBMKqRiQwMwF
X-Received: by 2002:a63:5713:: with SMTP id l19mr5168665pgb.216.1583371189438;
 Wed, 04 Mar 2020 17:19:49 -0800 (PST)
Date:   Wed,  4 Mar 2020 17:19:41 -0800
Message-Id: <20200305011943.214146-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v6 1/3] intel_acpi: Rename drm_dev local variable to dev
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

Change the struct drm_device * local variable from drm_dev to dev
per the feedback received here:
https://lkml.org/lkml/2020/1/24/1143

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v6: Initial patch (v6 to match other patches in the set) 

 drivers/gpu/drm/i915/display/intel_acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
index e21fb14d5e07b..3e6831cca4ac1 100644
--- a/drivers/gpu/drm/i915/display/intel_acpi.c
+++ b/drivers/gpu/drm/i915/display/intel_acpi.c
@@ -224,13 +224,13 @@ static u32 acpi_display_type(struct intel_connector *connector)
 
 void intel_acpi_device_id_update(struct drm_i915_private *dev_priv)
 {
-	struct drm_device *drm_dev = &dev_priv->drm;
+	struct drm_device *dev = &dev_priv->drm;
 	struct intel_connector *connector;
 	struct drm_connector_list_iter conn_iter;
 	u8 display_index[16] = {};
 
 	/* Populate the ACPI IDs for all connectors for a given drm_device */
-	drm_connector_list_iter_begin(drm_dev, &conn_iter);
+	drm_connector_list_iter_begin(dev, &conn_iter);
 	for_each_intel_connector_iter(connector, &conn_iter) {
 		u32 device_id, type;
 
-- 
2.25.0.265.gbab2e86ba0-goog

