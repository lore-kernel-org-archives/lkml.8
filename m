Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA1DC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9968B206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qNG+O3Oa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgCLS4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:56:39 -0400
Received: from mail-pj1-f73.google.com ([209.85.216.73]:39567 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLS4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 14:56:37 -0400
Received: by mail-pj1-f73.google.com with SMTP id d22so1011635pjx.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 11:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JBus33rcs/bxtojDIFRczNVDzpMKB2gTKUUCnsJQjXM=;
        b=qNG+O3OaXtIR4EVLDkbXpJmCGwwH0i2/ujAzXea7h4V0j0DYPohIv61RB487KHkCF5
         soMKjDyWkM6rpKnel1JMoInJARXQ9xPiB5ckgSz6n/ZSbU2JLMfQe2GBEH1wOhBBKg2t
         C5qNDZfF7C7NNXyPOXd5ufRRGRHjwDmZV/JOrca+KRLv/basJSprM0PSKzrpoAHCdlP3
         qxqqEVxvdFJTXvM4GUgy3UZbpZgnJbjSmY15voSyDf/HDerQtYvdABe/tXCp1aJgdKW5
         WFuFLdrMtNRlejjbvskrqkSQQh4IIJOR/Mdn/8st8BHwMe7kKUS+1JTG3MVVCRqSyoBf
         PfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JBus33rcs/bxtojDIFRczNVDzpMKB2gTKUUCnsJQjXM=;
        b=j3GLMImEfGs05wmY29YzBdzHozf3r4fp+bDGuPhREFyusN/ieMDhCLIWQyeHwYnuKD
         1eudZXXBkhoEqyFsRjM4kExzQpAPlRXoXyLg0vGNMg1AfQGzLttNb3F21yRECQ3lY261
         Tx8xUjtikqCCYi9k9oIb4G2LJoNkxRkOykS8Q3wTq+Str6BastqxImALzsA451/qhBG6
         Crg46QJ8lNtV1VmjJQD4qHbGgAL7g0aIepAzS2CvIx9Lc8xrgEI/SgaAb0dcofNC/sQz
         /Q+U7Rsgf1oZHwDuPitNNtOD8CHsuDs8sHL5Xh0sZ813AevDlkGESqH1FHA3cp7i2bMO
         1JzA==
X-Gm-Message-State: ANhLgQ1vpd4quwfH4NwXl8iJvEswcE/JlmK7Jb8eVN/uLCczXJtZa1wq
        HjhAQF7KNWp/9se4S6eT8XsfYhGxhZjU
X-Google-Smtp-Source: ADFU+vsFXW6TpnOJQxY5oJqxDW7a5dbVCvhzOlHQriPAMggKhWGdyFqIyMpSFvpC0A9aqAn7xRDRUwKwl9Qy
X-Received: by 2002:a17:90a:1c01:: with SMTP id s1mr5671706pjs.84.1584039396514;
 Thu, 12 Mar 2020 11:56:36 -0700 (PDT)
Date:   Thu, 12 Mar 2020 11:56:25 -0700
In-Reply-To: <20200312185629.141280-1-rajatja@google.com>
Message-Id: <20200312185629.141280-2-rajatja@google.com>
Mime-Version: 1.0
References: <20200312185629.141280-1-rajatja@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v9 1/5] intel_acpi: Rename drm_dev local variable to dev
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
v9: Same as v8
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

