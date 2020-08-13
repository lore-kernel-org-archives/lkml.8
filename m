Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AA6C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 21:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96FD9204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 21:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u2CJnwQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgHMV4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 17:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgHMV4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 17:56:31 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5811BC061757;
        Thu, 13 Aug 2020 14:56:31 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id b11so3811964lfe.10;
        Thu, 13 Aug 2020 14:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PzeeHUlrLr61C7JvJ6pH3B5N/JEP/ZCyFmvXdO98Mgo=;
        b=u2CJnwQQkKvug28WtHist7QpT6JyKtfrPoAVYzZWavwMLdZG3LJ0Ij9Nz3caK+urbx
         urCap+pdkMAucM/w1WOVzxkD22GgGc+0oo/dxxd2E+K1sPAVikyYN6kGTbixi2v0lvQp
         zNX295YgwYUVovrZfucNUJ6JYdQYdejGkITMRCQ3nx0pv9PuLtpgfCWcpPQsVwnVG+7M
         R0wOv6t0A10GpqnlhfL3oSsE06E74HYPh3PsCL8xHvdSfk1guCz8LAxim0t2+V/ONog1
         P0B5DMfgOpAGWp6Fi7RIJ56+3q8zQtZt2WyNkLbh8ieGDfJmtTgY0TaNUCta2BdTceOD
         CIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PzeeHUlrLr61C7JvJ6pH3B5N/JEP/ZCyFmvXdO98Mgo=;
        b=jrAXsBlqDYmHuM6nyGBYaDwlrR7sUsrZRu+9J0qO1epOlqGpC8p+NGrjTM5ELVYVFM
         GIMQ7PnuqeW3MrFeLrSru78to/oRMIC1nCPvyErgaN0+LNfydEgndXXZ4MZQkqcfymLX
         8S6mjsTcpHLHaWOaMnKbQMzjpVSS3aE7FPs1CFAYGBXEoetKrCSJ+hL2dL7z0Z6LJv7C
         hbDrTPOIlLuCg7l03NQH/BB7sxAGnnafUAI69bLDMvXjIbSDkGIlrNYEbzxZ3HHHhmmT
         f0297T127YOT8DXrD7FxnDKfSVAJ7to1zezL/Y9VU091bbd1YUfa5TymcP685Kj3G8lY
         3Rew==
X-Gm-Message-State: AOAM532S1zYGe2/ZBTbLAxiZKtJ0Kv8GPgLOclulKj7AlJcyY45PDxON
        reLHfLfOKk0m3nwt10xydXw=
X-Google-Smtp-Source: ABdhPJxKcz4O1AEDWJ/fIGU/BkBFKp9jenhUiSsUX4BAhvj7gZaCikC5OYaSSo8/REOZJow3PFKVDQ==
X-Received: by 2002:a05:6512:2010:: with SMTP id a16mr3065769lfb.196.1597355789762;
        Thu, 13 Aug 2020 14:56:29 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id z20sm1349977ljk.97.2020.08.13.14.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 14:56:29 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Daniel Stone <daniel@fooishbar.org>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v12 0/4] Panel rotation patches
Date:   Fri, 14 Aug 2020 00:56:05 +0300
Message-Id: <20200813215609.28643-1-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series adds support for display panel's DT rotation property. It's a
continuation of the work that was initially started by Derek Basehore for
the panel driver that is used by some Mediatek device [1]. I picked up the
Derek's patches and added my t-b and r-b tags to them, I also added
rotation support to the panel-lvds and panel-simple drivers.

We need the rotation support for the Nexus 7 tablet device which is now
supported by the upstream kernel, the device has display panel mounted
upside-down and it uses panel-lvds [2].

[1] https://lkml.org/lkml/2020/3/5/1119
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi?#n1036

Changelog:

v12: - No code changes. The v11 missed v5.9 release, re-sending patches
       for the v5.10 kernel. Please review and apply patches to linux-next,
       thanks in advance!

v11: - This series is factored out from this patchset [3] because these
       patches do not have hard dependency on the Tegra DRM patches and
       it should be nicer to review and apply the properly grouped patches.

     - Initially [3] only touched the panel-lvds driver and Emil Velikov
       suggested that it will be better to support more panels in the review
       comments to [3]. So I included the Derek's patch for the BOE panel
       and added rotation support to the panel-simple driver. I tested that
       panel-lvds and panel-simple work properly with the rotated panel using
       the Opentegra Xorg driver [4] and Wayland Weston [5].

     - The panel-lvds driver now prints a error message if rotation property
       fails to be parsed.

[3] https://lore.kernel.org/lkml/20200614200121.14147-1-digetx@gmail.com/
[4] https://github.com/grate-driver/xf86-video-opentegra/commit/28eb20a3959bbe5bc3a3b67e55977093fd5114ca
[5] https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/315

Derek Basehore (2):
  drm/panel: Add helper for reading DT rotation
  drm/panel: Read panel orientation for BOE TV101WUM-NL6

Dmitry Osipenko (2):
  drm/panel: lvds: Read panel orientation
  drm/panel-simple: Read panel orientation

 drivers/gpu/drm/drm_panel.c                   | 43 +++++++++++++++++++
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    |  6 +++
 drivers/gpu/drm/panel/panel-lvds.c            | 10 +++++
 drivers/gpu/drm/panel/panel-simple.c          | 11 +++++
 include/drm/drm_panel.h                       |  9 ++++
 5 files changed, 79 insertions(+)

-- 
2.27.0

