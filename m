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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D187CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 23:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFE3B2192A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 23:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4EL+9xS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgFQXlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 19:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbgFQXlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 19:41:04 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7D2C06174E;
        Wed, 17 Jun 2020 16:41:02 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i27so4961534ljb.12;
        Wed, 17 Jun 2020 16:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OcOqz11XDX1GFeXdHeD+rrzTbKQ6O43sVtDhODmNqc0=;
        b=I4EL+9xSGNrxK6Z2hdF8hp2JFC0Q71MdVSv9gkIsSfmBiXE3tO953ygNuEyhWzWq/Y
         kt5sgsr0FU2tTuUPnCvyEy7uo41zYwtq/dc73J6ghXA2pAHLwbp5yDmdG5/9Lj7ZsKVB
         e95PwhYCe6jdiPXV9LN4hyWDXJXW7lEadkgGY1uzMk4kXxOOVB6yJQDhIC+MAszjYRK0
         HzWexz6TTLOMQLkNeq0V64kYu3nwoGtyZKNUAtmX+v9HIHye607uCpTMNtke6/agA4AN
         aHu0CkuCGO4alJutuER72zo7mtz4yAcvRq0eFLnDx7ATn2lh86AUYnSifHlgJcewZFde
         Y+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OcOqz11XDX1GFeXdHeD+rrzTbKQ6O43sVtDhODmNqc0=;
        b=WBh6dcj6lkRnh6ykFoxl4uUcRhokulMkdv3uh8yq05dQL+FEDUjhsah6B6juYFiySo
         egspPZWr+cjdQTR0khSXwe94dg/XC/+BEhMVkhMiPcUqbAD94TVGgg6jxCC6G7NPOTTt
         t0Tkgac2Ucv3VtkshqTrV1g0R/5yND0/sBS8nbQTwdBLyWb+YOeQXlkTFjRpdKFbg86u
         F0VsDVCw8SVseOr/6F7Y8ov59XsFcEEBujYeJID55p53kyECWl4Xp5OLrr1ODABqZcyR
         e3YHc6dji1hT/nozaoORzrl2UneoIB8TrUme7ERQdUL7mPTxlLE5UfeouZyDVUGUqZjx
         FlvA==
X-Gm-Message-State: AOAM533djdn2TYs/ydB5Ud/GPusded6ceF7flvi8TZqZIkWHF8y2vS23
        EUVM2834hXsv+Es92wtyDbo=
X-Google-Smtp-Source: ABdhPJzwtCosDXfqxKV938U918086QPW2Y3T4a+nySVKa/edKjWK6dOc4Uodf6FWGzHT3zqti2DCHg==
X-Received: by 2002:a2e:9b8f:: with SMTP id z15mr879391lji.185.1592437260890;
        Wed, 17 Jun 2020 16:41:00 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id c8sm287871lfc.46.2020.06.17.16.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 16:41:00 -0700 (PDT)
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
Subject: [PATCH v3 0/3] 180 degrees rotation support for NVIDIA Tegra DRM
Date:   Thu, 18 Jun 2020 02:40:37 +0300
Message-Id: <20200617234040.1094-1-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series adds 180° display plane rotation support to the NVIDIA Tegra
DRM driver which is needed for devices that have display panel physically
mounted upside-down, like Nexus 7 tablet device for example [1]. Since
DRM panel rotation is a new thing for a userspace, currently only
Opentegra Xorg driver [2] and a recent Weston [3] have support for the
rotated display panels, but this is more than good enough for the starter.

[1] https://patchwork.ozlabs.org/project/linux-tegra/patch/20200607154327.18589-3-digetx@gmail.com/
[2] https://github.com/grate-driver/xf86-video-opentegra/commit/28eb20a3959bbe5bc3a3b67e55977093fd5114ca
[3] https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/315

Changelog:

v3: - Factored out the panel patches into standalone series [4] because
      this series doesn't have hard dependency on the panel patches and it
      should be nicer to review and apply the properly grouped patches.

    - The DRM_MODE_ROTATE_180 now isn't passed to drm_rotation_simplify(),
      like it was suggested by Ville Syrjälä in the comment to v2.

    - Added clarifying comment for the tegra_fb_is_bottom_up() in the code.

[4] https://lore.kernel.org/lkml/20200617231842.30671-1-digetx@gmail.com/T/#t

Dmitry Osipenko (3):
  drm/tegra: plane: Rename bottom_up to reflect_y
  drm/tegra: plane: Support horizontal reflection
  drm/tegra: plane: Support 180° rotation

 drivers/gpu/drm/tegra/dc.c    | 46 ++++++++++++++++++++++++++++-------
 drivers/gpu/drm/tegra/dc.h    |  3 ++-
 drivers/gpu/drm/tegra/plane.c |  3 ++-
 drivers/gpu/drm/tegra/plane.h |  3 ++-
 4 files changed, 43 insertions(+), 12 deletions(-)

-- 
2.26.0

