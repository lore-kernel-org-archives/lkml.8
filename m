Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30044C0044D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0B12072F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T4T7iRek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387580AbgCLA53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 20:57:29 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:47074 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387481AbgCLA53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 20:57:29 -0400
Received: by mail-pf1-f201.google.com with SMTP id f75so2621918pfa.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 17:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=sei44eoljO70BQTRmM/UvmF8MrB7eTx6LtWSPNoZXds=;
        b=T4T7iRekar5ZIxwrvQxe3HvHCJpb2oLeUGHCNohdw8sqcT+F+yCqOpLBpmBLtwukB5
         zXnW2C571C8qx/GVByfeMpQGiEjtzCaVS6MyjfOqOxsC/S1K5BahZAs60IZ0XNE1G2Hz
         oWJaah+eorGWc/Gt+SV18LNHqaiiU7Ra/rQUiDyJz8YpOmpHQf881pLXWqWWTnrIG9xp
         xaaCJrqGivEdS4NX+PJnxMUrZ2L9v0l/E/aR0fWIaps4HDYOx3CNbMtLQUXtRFM+pN3C
         rwQ1cvvbDRLCYiycdpkjaQ4IDRN4XrCb0Z7EeC7sdHjyn/o6xQSZWmo2mqLHspas4qWW
         mTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=sei44eoljO70BQTRmM/UvmF8MrB7eTx6LtWSPNoZXds=;
        b=B3hwVcmGgdTMdEsmhPPPTMMH19rAvuwWTF8ZqrGo+MVwY3ORT1tWZx2RaK5qk0L/rE
         lhPrfKOTmZnyFmNTrZo9dyMOYtkR6uWSjSPiFXdzd1iE9UH6k6B58MhfyfVsa6mrnVao
         Xy0T2Xycw+TFp06ZLpP1nbHGD2XlHUuo9iKeQJ3US0NVBDN48APpJAerF/fzL6MAG/uV
         SVE4YVeuHALXRLE74kDLtYZHsbAvy6TLC82fjoiF3KX5AtsSXjQCrKhoGfKYSPQFVQ6P
         rtSZGxYk2tvM+19n910ehrqgfdRFD4/WmluXOBnCWbP8G2yiNfqd6xbK/hgh9oLPMJul
         4kqQ==
X-Gm-Message-State: ANhLgQ1AEZtfMc858Tw+BnTjSPLs+kRdE6X278E+p9mpbP2ph6rVtd0F
        3Bdbc9Mbqdtz9sJfHHkVOiczErda6p1K
X-Google-Smtp-Source: ADFU+vueKqfD5oH+ZMgo/VSjBEC/kZSY8+bu/uN24FhFc6J20lIsRGi+drzdDsHdvjfQ+t/HUa/T8WAxDlOn
X-Received: by 2002:a17:90b:1989:: with SMTP id mv9mr1462161pjb.72.1583974647951;
 Wed, 11 Mar 2020 17:57:27 -0700 (PDT)
Date:   Wed, 11 Mar 2020 17:57:17 -0700
Message-Id: <20200312005722.48803-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v8 0/5] drm/i915: Support for integrated privacy screens
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

This patchset adds support for integrated privacy screen on some laptops
using the ACPI methods to detect and control the feature.

Rajat Jain (5):
  intel_acpi: Rename drm_dev local variable to dev
  drm/connector: Add support for privacy-screen property
  drm/i915: Lookup and attach ACPI device node for connectors
  drm/i915: Add helper code for ACPI privacy screen
  drm/i915: Enable support for integrated privacy screen

 drivers/gpu/drm/drm_atomic_uapi.c             |   4 +
 drivers/gpu/drm/drm_connector.c               |  51 +++++
 drivers/gpu/drm/i915/Makefile                 |   3 +-
 drivers/gpu/drm/i915/display/intel_acpi.c     |  30 ++-
 drivers/gpu/drm/i915/display/intel_atomic.c   |   2 +
 drivers/gpu/drm/i915/display/intel_ddi.c      |   1 +
 .../drm/i915/display/intel_display_types.h    |   5 +
 drivers/gpu/drm/i915/display/intel_dp.c       |  48 ++++-
 drivers/gpu/drm/i915/display/intel_dp.h       |   5 +
 .../drm/i915/display/intel_privacy_screen.c   | 184 ++++++++++++++++++
 .../drm/i915/display/intel_privacy_screen.h   |  27 +++
 drivers/gpu/drm/i915/i915_drv.h               |   2 +
 include/drm/drm_connector.h                   |  24 +++
 13 files changed, 382 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/display/intel_privacy_screen.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_privacy_screen.h

-- 
2.25.1.481.gfbce0eb801-goog

