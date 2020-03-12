Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE1DC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A0620663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KxXhraTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgCLS4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:56:35 -0400
Received: from mail-pj1-f73.google.com ([209.85.216.73]:54614 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLS4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 14:56:35 -0400
Received: by mail-pj1-f73.google.com with SMTP id p3so3804295pjo.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 11:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=sei44eoljO70BQTRmM/UvmF8MrB7eTx6LtWSPNoZXds=;
        b=KxXhraTRYvbP6q/v3MOA1GEiCSzG3LudoXZy2DXZQrHJDt/gha0YdQwnS6nMDp7gcH
         efZSqSb3CpTXZNTe2F1559U+nYlcqB+4V79EWQo+lcjlD3KxXgAjgJstD3vW3IhTjYSO
         i7fVtSUXzr5cHQjlF+V+SZtHlwq/pYKTmakQ+245oRzZG9wgbXmJ2DIQAktYl+CZ0sN5
         mzqLs3SnstAJfCnP711IpzNM7DOs61XZezkYZ9JoQtu0mg0rzH/SIKKPifg2xQwdL9tc
         4w76XECPdz+3NVC+c2hmF/plc5spgHTGEU2RyJYqeDGpOK6BNcsOfjiPG0THuqEnW5jl
         JDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=sei44eoljO70BQTRmM/UvmF8MrB7eTx6LtWSPNoZXds=;
        b=mXAYhH/qWtbiM4ZBmJKMDN4dKyLKueWoZEoAwmVpk7sgfq5B8F2s6XLWqz2pzjC3K9
         mcjmQ2icydgZ9wRnCn1DXSexrd4wLiwPtAdAF12NnZ8rTouX19hxmDqYvUfBprckrUFv
         rwRvV0aJYf3dcgbPp856+YHn2ZZ8CtPVUKTz2giKkiZAb5cRm8caAf57PqC1Hhi6gYvf
         IE2DzlAkjseZib2/dh5xTZ7vNmBtIBwPDKRVX4IeCl9sSA17zWGvdqym+ltI8BlE2MaZ
         vhb9X7oQKVhydLZxQABU3awvF2S9q/Tf4Fj9VRWigPIUz3eL3jS/LIF9OEy6I32F8/QW
         KNmg==
X-Gm-Message-State: ANhLgQ0PRs08mImLK1i025yRj8OcPlqH/exy92UNyeCWId98NMX3U2Ac
        EQMp4zktd8OJ5hMpsVichzy36r72Sgzq
X-Google-Smtp-Source: ADFU+vuYLz7wtRk2dXjXy2q6XhwL+1erGQc9nvzXs6bt9R+vf+zDpaz3AfTjx5/wkKQXoxHsgkgKTjeMI8X9
X-Received: by 2002:a17:90a:30c7:: with SMTP id h65mr5835404pjb.44.1584039393995;
 Thu, 12 Mar 2020 11:56:33 -0700 (PDT)
Date:   Thu, 12 Mar 2020 11:56:24 -0700
Message-Id: <20200312185629.141280-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v9 0/5] drm/i915 Support for integrated privacy screen
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

