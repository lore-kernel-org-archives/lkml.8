Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3225C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10E220735
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bT1CrWbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387592AbgCLA5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 20:57:32 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:51672 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387481AbgCLA5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 20:57:31 -0400
Received: by mail-vk1-f201.google.com with SMTP id c127so1659359vkh.18
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 17:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zfQL1NufXJXKszWu72jE1H3reXD9X3Cw+0IUbEiABbs=;
        b=bT1CrWbV4OeJpGXX03s+OUjA04G+CjGZX2Tf3a3Uc+hxyENfPUI+C5i/B3FF5a9Cwc
         KUXD8rZSh+N82h8RwgutzToHhe2EW0u3Cl24Fy4uDwxSGZn5xQ1ffJ7Wf83wi1GHWAQk
         Wrseo8utA4nuxC0luM2akfn665xHAB9f10uuUc9f7Mzsi0Hc+vT8w8fp1ecaKUJBCDae
         ZgyNCq8WxyiiD8e/bmHFSWLCmqyUhdJRXe6xAvu5mxI2vSCcPQDZ7aUevFVjhRvBdStg
         1tGQSxOewrQmYz+mdiT4w5beVHsK3h1XiLqXRCXLA4T1xx0UU0wYqzjL/BUx3oudUkWz
         bQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zfQL1NufXJXKszWu72jE1H3reXD9X3Cw+0IUbEiABbs=;
        b=j9IAehVdsNiWW855VS2y7PjQ7L/WBIOuiEiq8PHsCBYnImd101fonOBp9BRILAhAsG
         3pkrMXh3PaQV2mryiFd7DrUsvyJenDusOffrwAKmCFHrVMC2a9dJd6BjmrqrdVymw8L5
         TadICPyGdcGf5So1P3y+T2AUX8p50fS/lLrHR08bvIZbb6QBTnRRUeZaGCdvhJnnDrVr
         deyDFTbSierf0iXDjc3n/r5vTNZv/IVXSbLjTPfV9h/PpTgrOlGeXP19nDQpd4ziqklC
         crmJP9dUwViSCcNFOhCDgXA9AcBWWfDQN8Xuz4sM/Yl47EkIQ70fcIlw9ktImnSuIDZO
         KBkw==
X-Gm-Message-State: ANhLgQ0xhA2im8fDbctr196wOPmy5OZeEJGRRf3V4dInELskRn5aA5mp
        6NOFy70vzFg8q/ms7qggKHnqxVwpAJUH
X-Google-Smtp-Source: ADFU+vudXPpltJWf5kCHaXEyXnesLFR5gJzoEWgqDEP7sXpXeSYgwHh/qrrl5VAWvaMLl86pkFonQ4bkM/3U
X-Received: by 2002:a67:7dd0:: with SMTP id y199mr3632675vsc.158.1583974650664;
 Wed, 11 Mar 2020 17:57:30 -0700 (PDT)
Date:   Wed, 11 Mar 2020 17:57:18 -0700
In-Reply-To: <20200312005722.48803-1-rajatja@google.com>
Message-Id: <20200312005722.48803-2-rajatja@google.com>
Mime-Version: 1.0
References: <20200312005722.48803-1-rajatja@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v8 1/5] intel_acpi: Rename drm_dev local variable to dev
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
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com,
        Jani Nikula <jani.nikula@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the struct drm_device * local variable from drm_dev to dev
per the feedback received here:
https://lkml.org/lkml/2020/1/24/1143

Signed-off-by: Rajat Jain <rajatja@google.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
---
v8: same as v7
v7: same as v6
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
2.25.1.481.gfbce0eb801-goog

