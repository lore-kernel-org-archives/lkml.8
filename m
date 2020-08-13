Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D787C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 22:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07E7A20771
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 22:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxAUxvrg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgHMWHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 18:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgHMWHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 18:07:06 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2941CC061757;
        Thu, 13 Aug 2020 15:07:06 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id m22so7862797ljj.5;
        Thu, 13 Aug 2020 15:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Ysu8KrstKJsXPbkwkVItOAIAaYVSsgcZTJ2gKC2O1I=;
        b=KxAUxvrgwR3I2pKBP5QTLzVQP0xoAxZ+CMYA5FL6oNPR+yc357ql9y+Z4hNbaksnkM
         vu86VzKgSZSz8utCP5M+2/IWHy4zTx3IUwRVSeHoKO8OaTTe6D/mtbvKOEgcITXr77xg
         uq8BD6IEIQIGYgjRycD1ak6l3lnJAfaLr/KTURE1aj/Zqb9AKEvo2r/FtK3UBhAPYMY1
         FfyPjyZcBOpM7m9L7y4p/iM3iykm5fmsNZ+enM/cY0AkjCL4fNCgKMhI5N5To8a1+TjE
         mrlEDyoEY6Ps8321tWfpto4FnhKFIs2v3o45HH6PF9vz4GcnrfnnK0w9wBiLf/8TixkF
         Qcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Ysu8KrstKJsXPbkwkVItOAIAaYVSsgcZTJ2gKC2O1I=;
        b=sFczNC13/i4QAeZd7ZWeDS1LggOKUHimN6UfK86qNsSMSM/6V66GpErQVgkhxvGdfd
         GAnZRnRs9A1mpdrAWqghu5duaVgZNakvTHJxg1o/Et1wJR6l6OdPaQZt3uqoQfu5Owwj
         DJOqS9pe0SHvK3fynbO0PwDeL5uwdcnc3NB+VRY4zncqtQyBT8z+MPSOOfYUnOxNzMLO
         OpLzzGGLl2JBa8N9ISYITmtVV7HiMpPC7I7xwWc9d5QNa00VcwrLmlLYeSqWw1fe7MVS
         ETpJFic+2uN1ZYhm9dSuyXcSLZWwPDsEINlLgxPqj8Khdg0ZwKbob13rNtnF219HX1NJ
         W2jA==
X-Gm-Message-State: AOAM533TSk9XoMCo+DDdcVmcJcpdrxl2kTwZbm8SPbnF6xIxF/eBDKDr
        U/DA5PUodyrYfgusWN9P5lqD98qQ
X-Google-Smtp-Source: ABdhPJwlvzEAqLKr4E+m8miJjz2G5rz6UVpDHH6Mzqw7j0fFAKTOFbtYuFWieIV4pwxHpS78FYSpnQ==
X-Received: by 2002:a2e:a58a:: with SMTP id m10mr2800647ljp.247.1597356424639;
        Thu, 13 Aug 2020 15:07:04 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id z20sm1354452ljk.97.2020.08.13.15.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 15:07:04 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v10 0/4] Support DRM bridges on NVIDIA Tegra
Date:   Fri, 14 Aug 2020 01:06:52 +0300
Message-Id: <20200813220656.30838-1-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds initial support for the DRM bridges to NVIDIA Tegra DRM
driver. This is required by newer device-trees where we model the LVDS
encoder bridge properly. In particular this series is needed in order to
light up display panels of recently merged Acer A500 and Nexus 7 devices.

Changelog:

v10: - No changes. Patches missed v5.9 kernel, re-sending for v5.10.
       @Thierry, please pick up this series into linux-next or let me
       know what needs to be changed, thanks in advance!

v9: - Dropped the of-graph/drm-of patches from this series because they
      are now factored out into a standalone series [1].

      [1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=186813

    - The "drm/panel-simple: Add missing connector type for some panels"
      patch of v8 was already applied.

v8: - The new of_graph_get_local_port() helper is replaced with the
      of_graph_presents(), which simply checks the graph presence in a
      given DT node. Thank to Laurent Pinchart for the suggestion!

    - The of_graph_get_local_port() is still there, but now it isn't a public
      function anymore. In the review to v7 Laurent Pinchart suggested that
      the function's doc-comments and name could be improved and I implemented
      these suggestions in v8.

    - A day ago I discovered that devm_drm_panel_bridge_add() requires
      panel to have connector type to be properly set, otherwise function
      rejects panels with the incomplete description. So, I checked what
      LVDS panels are used on Tegra and fixed the missing connector types
      in this new patch:

        drm/panel-simple: Add missing connector type for some panels

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


Dmitry Osipenko (4):
  drm/tegra: output: Don't leak OF node on error
  drm/tegra: output: Support DRM bridges
  drm/tegra: output: rgb: Support LVDS encoder bridge
  drm/tegra: output: rgb: Wrap directly-connected panel into DRM bridge

 drivers/gpu/drm/tegra/drm.h    |   2 +
 drivers/gpu/drm/tegra/output.c |  21 +++++--
 drivers/gpu/drm/tegra/rgb.c    | 102 +++++++++++++++++----------------
 3 files changed, 72 insertions(+), 53 deletions(-)

-- 
2.27.0

