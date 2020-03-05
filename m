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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1B0C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4DC120866
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZYUFsof2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgCEBXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 20:23:49 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:40554 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgCEBXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 20:23:49 -0500
Received: by mail-pg1-f201.google.com with SMTP id n16so2277771pgl.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 17:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C9EkwJ1gUg61QN8k194CxCHcCIG0/y+uw6Hl1AyDtGU=;
        b=ZYUFsof2AdnN/vxqOFzeKiPT7SkzpB/41s6WTfPp++cAv0qbgdDjJ6g5Rga20zTPBf
         gVsTD4MeMUoXCcB+Yigcrgnk5XZFiAVW/wNHUFEQSxUBuWOc4VMLHC9HhaNdfPSo4ZPe
         4Kc4pufQiFjyEB3orS6YAYWNQpQ/Dop2rQPcJtiRb11ektKq1x/7kQKp8Y8GjqGzwOgC
         EqqXorAOfzF4xN26+FaMtotHiNvsBJ/EmkGcx1l0Iq/CSDkgdarDn6oWTsh6VXUn38Dq
         l0C46YIBY9maN/qy1VA09qYcXLwOQPUjkIqftU3r+2Wa2+AZQrPHmTpatnf476pjTwrI
         CSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C9EkwJ1gUg61QN8k194CxCHcCIG0/y+uw6Hl1AyDtGU=;
        b=JHzxjAHGaAl/iT2LUf9Uu5CRwbLHdBAU00W7B9BobnMqrh7jBK8lq5JLX0gXwIvns2
         WNeUe84BUulUjPJ6n0BVYNcpHKl/PcM8t1tl5TI7WAibjavaCvodGqp37eW49TFgnNKs
         lH8bkPMWPDKQ62BGCJx384HcDkAM1n1Z9FHVhY5Ys24d2urIqKLeoYIOsdo5Q7MHVsEn
         S+nz1d7DvIxfYuYWnKUQkRZ7Nw1b8O6VzgWdHhSo785+DG/jEnCHEuIsGurYSauGMtcl
         iP0Sm3BBtTXfHMwUtUi3YF5myazI39XlfFYQlfvWia8QvU6rJxEB4Wli9Eky/EwvvmxG
         5C1w==
X-Gm-Message-State: ANhLgQ0x95nuyBJesvbU4/bC/3rjC6HZnjKCo5A0G9cPJEuOhSaJPLub
        Bk02wcriyOolHzwYq2cTD1upQ1syklij
X-Google-Smtp-Source: ADFU+vt22Y/ktG0yM2E5RHf9kr3+rTtxgnQJRQ51fjn3zDr8ksVD4tQhfSFd9ZOr4BIHrnKtguZNIHHL5bU7
X-Received: by 2002:a63:2166:: with SMTP id s38mr4787838pgm.83.1583371426342;
 Wed, 04 Mar 2020 17:23:46 -0800 (PST)
Date:   Wed,  4 Mar 2020 17:23:36 -0800
In-Reply-To: <20200305012338.219746-1-rajatja@google.com>
Message-Id: <20200305012338.219746-2-rajatja@google.com>
Mime-Version: 1.0
References: <20200305012338.219746-1-rajatja@google.com>
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

