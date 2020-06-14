Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B37C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 17:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5615B20776
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 17:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8Oh+lSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgFNRXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 13:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgFNRXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 13:23:20 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F88C05BD43;
        Sun, 14 Jun 2020 10:23:20 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y11so16427143ljm.9;
        Sun, 14 Jun 2020 10:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DoRr46QhZzu0HYtQht+6OOn/uSyoSM/yNa2CkMx8bbU=;
        b=f8Oh+lSoSCkVY/0YlicukXiWjUqLz/HYxP0U6jvwdYBi5gDOGiBl/oELXD49rw8YzR
         E1qNDohgiFrb3XNcxlfWa/uzuVGnZHXd+ak8Uca1njRJaNmreEcmqY6v/sYDk90r+jpG
         IeLL8EcukkC49BqJAHe8raVvYo5NjKs2xqDfOKGuAFine6bRWuvu/+0CtMO+wyHaKjo4
         BaQOaMVGLAHi4bexKQuznFlg8QgLI6W2iOMGMlkllCLySgBrfeo7bSgKTZfqM1GIVuiT
         Rw1eLxAg2V8tlWhxKuQl0t98kdYWR+hedXsk0TlMwrQev7a64vBT9ZtjeQFxzPMcdcUD
         1OvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DoRr46QhZzu0HYtQht+6OOn/uSyoSM/yNa2CkMx8bbU=;
        b=EQ5QSwiCbEW8Jwn4XOHU7y6UPaPLJNXjBgMYzuh6FZUGCWa8CmHdGgA8okEmvlvFaR
         epF93L/yUsvs7Qj1FJgNRoBxg7tK7pbX1v1cN5owXfWjl3fgaElihBCJUddaYEwexXWH
         HYQNWrPdsi9/CpS4QFnmZSS69rfAzLVvDEuHVDDvgpJhyKKkp+nGtXZzGY6ByWTX5HjB
         3eHlGJrvwm4LAfrfmhdCtbMHRsu4Tn5hT1rIqobAQschWCmQl5J+FIfTorD9TGAy66Cx
         kmdd9qujfrFIYtpk0JPQvMMpioxMmlTauhNC/cCQdL5z1UNoQBVdjt/tbD0tLLaj3esB
         WMpQ==
X-Gm-Message-State: AOAM533P60aZdFBIY0nj/CNB7dIkI9+4Xg5zhVy4/DOwZFN4/I3R3Vy0
        5O+VPziRqfmvUqKpvomOND5brgSA
X-Google-Smtp-Source: ABdhPJynr0Oqx6i5Cq+XWwMGVpYqQ9pToiSFkSouw+lixWm0qm2sn+p2xRDaApoDSVO8nh2oCCbdAQ==
X-Received: by 2002:a2e:b8c2:: with SMTP id s2mr12065988ljp.368.1592155398456;
        Sun, 14 Jun 2020 10:23:18 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id m14sm55144lfp.18.2020.06.14.10.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 10:23:17 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/6] Support DRM bridges on NVIDIA Tegra
Date:   Sun, 14 Jun 2020 20:22:28 +0300
Message-Id: <20200614172234.8856-1-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds initial support for the DRM bridges to NVIDIA Tegra DRM
driver. This is required by newer device-trees where we model the LVDS
encoder bridge properly.

Changelog:

v7: - Removed the obscure unused structs (which GCC doesn't detect, but CLANG
      does) in the patch "Wrap directly-connected panel into DRM bridge",
      which was reported by kernel test robot for v6.

v6: - Added r-b and acks from Rob Herring and Sam Ravnborg.

    - Rebased on a recent linux-next, patches now apply without fuzz.

v5: - Added new patches that make drm_of_find_panel_or_bridge() more usable
      if graph isn't defined in a device-tree:

        of_graph: add of_graph_get_local_port()
        drm/of: Make drm_of_find_panel_or_bridge() to check graph's presence

    - Updated "Support DRM bridges" patch to use drm_of_find_panel_or_bridge()
      directly and added WARN_ON(output->panel || output->bridge) sanity-check.

    - Added new "Wrap directly-connected panel into DRM bridge" patch, as
      was suggested by Laurent Pinchart.

v4: - Following review comments that were made by Laurent Pinchart to the v3,
      we now create and use the "bridge connector".

v3: - Following recommendation from Sam Ravnborg, the new bridge attachment
      model is now being used, i.e. we ask bridge to *not* create a connector
      using the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag.

    - The bridge is now created only for the RGB (LVDS) output, and only
      when necessary. For now we don't need bridges for HDMI or DSI outputs.

    - I noticed that we're leaking OF node in the panel's error code path,
      this is fixed now by the new patch "Don't leak OF node on error".

v2: - Added the new "rgb: Don't register connector if bridge is used"
      patch, which hides the unused connector provided by the Tegra DRM
      driver when bridge is used, since bridge provides its own connector
      to us.

Dmitry Osipenko (6):
  of_graph: add of_graph_get_local_port()
  drm/of: Make drm_of_find_panel_or_bridge() to check graph's presence
  drm/tegra: output: Don't leak OF node on error
  drm/tegra: output: Support DRM bridges
  drm/tegra: output: rgb: Support LVDS encoder bridge
  drm/tegra: output: rgb: Wrap directly-connected panel into DRM bridge

 drivers/gpu/drm/drm_of.c       |  13 ++++-
 drivers/gpu/drm/tegra/drm.h    |   2 +
 drivers/gpu/drm/tegra/output.c |  21 +++++--
 drivers/gpu/drm/tegra/rgb.c    | 102 +++++++++++++++++----------------
 drivers/of/property.c          |  32 ++++++++---
 include/linux/of_graph.h       |   7 +++
 6 files changed, 114 insertions(+), 63 deletions(-)

-- 
2.26.0

