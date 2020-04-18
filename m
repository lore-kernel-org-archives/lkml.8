Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15335C38A2F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 17:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD2AE22209
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 17:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6kMX8/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgDRRHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 13:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgDRRHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 13:07:19 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45948C061A0C;
        Sat, 18 Apr 2020 10:07:19 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id l19so2795252lje.10;
        Sat, 18 Apr 2020 10:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UjhBLAJmzhN057qQPLR85nlezCd0Cbg3wKL62JA+F0Y=;
        b=h6kMX8/a/MD+21migy24dxFEqMf8aW6xXDbzepMropt4ZX8BHN3GOTPCB9P4/mWpfC
         +zorigm2j4U6S9MKaU5zWQzA9Oek7rSlqwU7x5LeHtxj3w1+7hIoKiK0nI+eKB9bhRxp
         BMTGfoe93olsIYCuJ6TWCK2m+09QR/m0F61d0ue8dFpZE7wPF3moZSILOtqf0BEhrgJD
         sjcsOAd+kpRcbGfBeXpkdJSCmhN7KmwXcgj5dsqlkQaZSuqFAG8hlJaIUtDAAmYF0LGa
         QglQCB/UuKgn86AN+Q712QZ2/xoXbQgDHpQPG8yMGSin3tZhOFN0K2lM/ABXT4mESoKq
         Aw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UjhBLAJmzhN057qQPLR85nlezCd0Cbg3wKL62JA+F0Y=;
        b=i3oHYzh/4nzlaKoKME9IFCYM6cmYcc9jnClD/FqZXHOwObI/5cjglbbRgibpgxjLu0
         DjSk4wR1evqcoEmNhiga/czZx4u7jvUZnU9qXmgToopOkqzzr2svOWFngk0EQix8lniP
         CNf7B7XOqADiETFEwrLWyBMBHB7ix7iPEuVCj4N7G9t8UaOwElEPIZIzkBxGHydA/dJQ
         q81G0DQs/hJZ7YS4mJs+3AyAGDxagOkJDYVdsGHais630mV/qUBkQKKpNFtWH5MKbgE0
         /QxoBEG7bwpWeIk40/khC+aJvlOkcg3tEWgD2z0cM+i8+M+f7hj4rIgSzBNchfLs0GBz
         xpRA==
X-Gm-Message-State: AGi0PuYUTHRJ064qT6Ca+8Fr8ZyNAA4uxKJr/h97O8dU+JsRmx3+mRv1
        tZWU0+XSTQUd6vDIYkLPNqU=
X-Google-Smtp-Source: APiQypJO9Q9iUvGnqWW4hjfAjTVkvpc+Xh9pA8t+jnQA9ei8M3XpSh8CGKey1LqD9LuS39c/Z617jg==
X-Received: by 2002:a2e:7006:: with SMTP id l6mr5124806ljc.269.1587229637344;
        Sat, 18 Apr 2020 10:07:17 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id e15sm8768909ljb.25.2020.04.18.10.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 10:07:16 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/6] Support DRM bridges on NVIDIA Tegra
Date:   Sat, 18 Apr 2020 20:06:57 +0300
Message-Id: <20200418170703.1583-1-digetx@gmail.com>
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

    - Please notice that the first "Support DRM bridges" patch was previously
      sent out as a standalone v1 change.

Dmitry Osipenko (6):
  of_graph: add of_graph_get_local_port()
  drm/of: Make drm_of_find_panel_or_bridge() to check graph's presence
  drm/tegra: output: Don't leak OF node on error
  drm/tegra: output: Support DRM bridges
  drm/tegra: output: rgb: Support LVDS encoder bridge
  drm/tegra: output: rgb: Wrap directly-connected panel into DRM bridge

 drivers/gpu/drm/drm_of.c       | 13 +++++-
 drivers/gpu/drm/tegra/drm.h    |  2 +
 drivers/gpu/drm/tegra/output.c | 21 +++++++--
 drivers/gpu/drm/tegra/rgb.c    | 85 +++++++++++++++++++++-------------
 drivers/of/property.c          | 32 +++++++++----
 include/linux/of_graph.h       |  7 +++
 6 files changed, 114 insertions(+), 46 deletions(-)

-- 
2.26.0

