Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34443C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 23:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E960021556
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 23:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ok19fZx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgFQXUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 19:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgFQXUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 19:20:16 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C62C06174E;
        Wed, 17 Jun 2020 16:20:15 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s1so5015814ljo.0;
        Wed, 17 Jun 2020 16:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wYFXhzh5n3W0/+lsSdfHJjbCv4Q6beTMubTyt25bamU=;
        b=Ok19fZx0y2mHLKiAFpRmandHU0EoDjRfBaaPQEgbhcBR5HFtheqTZFCu67x3oKJEOr
         /u+YWV6c19XxE6Iha3+er0DYXVVlkgxVuYncg1OvFNYWz0oMDUd1TeUjNEA9QmqrY+Il
         3xzE0DNI027haL3l9sHmKQNS8ek0ZJpcpDVIiWYtQPYGUuI2DqieNWdTBLpzpKICon+N
         phAQFHbPaJI2VA2mFzM78W6f+qx1V6uKthNVC1uBSXbUlAThaFvTLCl3VEB/YHa5wKtG
         s8Ck65117L+Wb6cI5MivXM7pfxMYg+R7joJESSDY9/GYgy2gCoMwWlR8ixr+a3igZyZu
         ++8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wYFXhzh5n3W0/+lsSdfHJjbCv4Q6beTMubTyt25bamU=;
        b=jG+Cw2VkghYr+5R/L++3+B6c13l6SYlU7xR+iJv6hflMl5WyasbqRz5LLxPQ8EFFqH
         2VxBjrED5CGjjWc512zGPmDE9SY0ikRYufnQnlK3kkLAORcbaOUEQqSzRVqVX85VWWK/
         YBqgjpl8fAWZBpyofY1nBqDLPrSLtmeSRQ4U0+r35SvhikH8Hwfu0H/WtuW6TpsM3+D6
         RED3pB1OqN/gDm74i+8P3MgQAdbtv862TvBvHXwPMFUfVxMhNOloEHyG2lBwDK60F6fg
         BKlokcs6xFJou+fBeNzRpCnFzQZL54mVfL6T+58F69t6gGFexsM1kRVmGduSEKbrVl04
         Jb8w==
X-Gm-Message-State: AOAM533mqlVE7+ZmvpHxKqgQ26nqCuAxhMx9G/3Jf+ORGhHb8Ipg77Fi
        JEWEaExPEx6FuBAM2WwQ5f0=
X-Google-Smtp-Source: ABdhPJy2asig9o4HQkeA6kr0/BZUFzr0Cw199sxDaJ65mXseg932jHDoFA0AVplbmsVwcK8/VX91vg==
X-Received: by 2002:a2e:1412:: with SMTP id u18mr833931ljd.309.1592436013810;
        Wed, 17 Jun 2020 16:20:13 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id x3sm235100ljc.82.2020.06.17.16.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 16:20:13 -0700 (PDT)
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
Subject: [PATCH v11 0/4] Panel rotation patches
Date:   Thu, 18 Jun 2020 02:18:38 +0300
Message-Id: <20200617231842.30671-1-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
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

We need the rotation support for the Nexus 7 tablet device which is pending
to become supported by upstream kernel, the device has display panel mounted
upside-down and it uses panel-lvds [2].

[1] https://lkml.org/lkml/2020/3/5/1119
[2] https://patchwork.ozlabs.org/project/linux-tegra/patch/20200607154327.18589-3-digetx@gmail.com/

Changelog:

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
2.26.0

