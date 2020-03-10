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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6115AC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 00:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3181724655
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 00:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GrS+pcj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgCJAG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 20:06:27 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:37812 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbgCJAG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 20:06:26 -0400
Received: by mail-pg1-f202.google.com with SMTP id q29so7539726pgk.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 17:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VDuOhbt4EtVAr5HqP/z/JEAhJ6aufU2qBAQhX8Irrmg=;
        b=GrS+pcj6aRCeWKMOofPnAlbvuD551qH8x0F3XmDw6A3bEjIm8CdBeBzk8YPDrzjD0s
         60fz0+NNvEPN2e7OgoN2O2oCMh1+e5iR69wFFjYkM6zemzHcqwkv+D2dzcZWd0jmrdU8
         FwN2gT7wobMh9LXMaGkMXQPdSH9aPWM0g2IlCrnkoxLhviqrDSgx9IpKpJjsmqhh/OWE
         FZZfsWusbJK822c6Q0OnyDbwFnhz6kNpYj4Oc0zwCnFA+4P522se/fLtdHlxMYMIFesB
         iHjIZi+7gKh3BW/TbfRZeBMzlJDiWzv8tz9LQLK+2+I9aRCoMWYh9EVKdMPm06/FkVK9
         2PvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VDuOhbt4EtVAr5HqP/z/JEAhJ6aufU2qBAQhX8Irrmg=;
        b=BXWm3M8oZ+O69WIkE5XxFuR38o5vPkC1QH36/Sf7wob3Fyb/40KO/n5IuoJGadp4y6
         yqJysVWbfInxL6uUCckn3z0qoEX6DSnNxnzuD4pG13P0B/tELArKsWktXVD6nET3f4lp
         mHAnPND8DYsAlCUct8ioS7pUOpSoXGV3uwR7jWdMYGq3u1ewzTRHOpObr8ZiEINFnI6n
         0N8n3E9JqaNRqMTqHNewebOv4HzpsP6n/NdPQ3XxRdO6ArwrzfIfZJk6cY480x9LgqL0
         m1LQzLfC4EA5mhg0+amzg/nTGRRAdOirQcpxlriQB/E8m2+e2l1qHb1d074fxMuDYdoj
         AD5w==
X-Gm-Message-State: ANhLgQ2N8k6jmTKjBoHGj8CI6g/h3Gj9ZimCHrTrEHWJj1YQ55YJF59P
        O9d/PMN33voTEwsZ2eJ/OzYNXxeTkcal
X-Google-Smtp-Source: ADFU+vtIdSBAQ/U0X6peaC3aYMgqWZSFYK7uWpMZKYsfO/SGNw2kHtAhYM7t3936cdiRunMRrME0efqVEQLM
X-Received: by 2002:a17:90b:4010:: with SMTP id ie16mr190054pjb.185.1583798784825;
 Mon, 09 Mar 2020 17:06:24 -0700 (PDT)
Date:   Mon,  9 Mar 2020 17:06:14 -0700
In-Reply-To: <20200310000617.20662-1-rajatja@google.com>
Message-Id: <20200310000617.20662-2-rajatja@google.com>
Mime-Version: 1.0
References: <20200310000617.20662-1-rajatja@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v7 1/4] intel_acpi: Rename drm_dev local variable to dev
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

