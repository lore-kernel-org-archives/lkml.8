Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972EAC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 20:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 694572071A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 20:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huWfunRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgFNUB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 16:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbgFNUBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 16:01:45 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38929C08C5C2;
        Sun, 14 Jun 2020 13:01:43 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id o4so642316lfi.7;
        Sun, 14 Jun 2020 13:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eyeaYzeQX7ccLjnwiymvagyxejIqtIT2ra5PuWujjzM=;
        b=huWfunRd9o8izmq8clvCzaVTN/lEYRrSHD9pJ+wLb7vl0rdY72NAHw8wOmHniXhuDh
         amsqUmwpLcz+GON705A2GfRQG1iYBH2Twv/RioQ//2fGjFEcWniI5CEWPrm0wPePm+VD
         dcjgmUBX7+kWBXt+0B0zAFPNoFhyxJkGB8LSxiNjE8XH3m87IvGiaPQMJoMnSg0E1Eik
         A6nuQRbxkKOZFzGwNG9N/oGcpb7NVwPPrCFD3T7jTzsIFPS8HRgPs/DchYNJwk1mHXaU
         cJ3m203wFec2IkUbrtTQtg4L6SdvHRSBqwf5QHhr9Q/1ASpzM9T07wxc852GGu6kXbl6
         H9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eyeaYzeQX7ccLjnwiymvagyxejIqtIT2ra5PuWujjzM=;
        b=c/EP2RcBKL0s6XnYut+0aE2ULWfLv/5MhQNXq/MDGiOJ9+oavN1EPOCzDt4lkELTOR
         PJ9lr/R22B1Y5Rf5DrVr6ptkzCrhAm3JS5T9tL9mknWOqEP9bjVW2a7HpME1XZ8wDkLX
         SdGe/p0NI4xzR3AxYVP9kD2mBKebo0DGlKB7urZGfseO+Aqqy5jn65Y2TYvF/Lu+D0hi
         vWV9ypK9IlpD9CCG7xDlvPirufy+02OWsX8iI+uTCbE8ebcQMSJkbc8JDVoasAtplIlO
         +p2KtwazDn/J2RHgxxAfgG1mW0lZ+PeT1em8xCzjGknPkC/l5XaUjcIdIKaOD49tiJ63
         zo3w==
X-Gm-Message-State: AOAM530prMVkX34TbeGDeINFxrF/7Kv8FTtYpaLHiPhrLlX3XwbxZqAl
        7SvHamDAmIAInDJEEgF3x1M=
X-Google-Smtp-Source: ABdhPJywA20RCBGKn37WbaaGhZeic/ZVAiBmfPA7Mnftr3GiywM/pb5B6AVXLylwpr+0Vq3t9EQiyw==
X-Received: by 2002:a19:c3d5:: with SMTP id t204mr11970529lff.50.1592164901434;
        Sun, 14 Jun 2020 13:01:41 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id 144sm1422105lfm.87.2020.06.14.13.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 13:01:40 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] 180 degrees rotation support for NVIDIA Tegra DRM
Date:   Sun, 14 Jun 2020 23:01:16 +0300
Message-Id: <20200614200121.14147-1-digetx@gmail.com>
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
Opentegra Xorg driver handles the rotated display panel [2], but this
is good enough for the start.

Note that later on it should be possible to implement a transparent 180°
display rotation for Tegra DRM driver which will remove the need to have
a bleeding edge userspace that knows how to rotate display planes and I'm
slowly working on it. For the starter we can go with the minimal rotation
support, so it's not a blocker.

This series is based on the work that was made by Derek Basehore for the
Mediatek driver [3], his patch is included into this patchset. I added
my tested-by tag to the Derek's patch.

Please review and apply, thanks in advance!

[1] https://patchwork.ozlabs.org/project/linux-tegra/patch/20200607154327.18589-3-digetx@gmail.com/
[2] https://github.com/grate-driver/xf86-video-opentegra/commit/28eb20a3959bbe5bc3a3b67e55977093fd5114ca
[3] https://lkml.org/lkml/2020/3/5/1119

Changelog:

v2: - Dropped "drm/panel: Set display info in panel attach" patch, which
      turned out to be obsolete now.

    - Renamed the cover-latter, hopefully this will fix the bouncing emails.

Derek Basehore (1):
  drm/panel: Add helper for reading DT rotation

Dmitry Osipenko (4):
  drm/panel: lvds: Set up panel orientation
  drm/tegra: plane: Rename bottom_up to reflect_y
  drm/tegra: plane: Support horizontal reflection mode
  drm/tegra: plane: Support 180° rotation

 drivers/gpu/drm/drm_panel.c        | 43 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/panel/panel-lvds.c |  8 ++++++
 drivers/gpu/drm/tegra/dc.c         | 43 ++++++++++++++++++++++++------
 drivers/gpu/drm/tegra/dc.h         |  3 ++-
 drivers/gpu/drm/tegra/plane.c      |  3 ++-
 drivers/gpu/drm/tegra/plane.h      |  3 ++-
 include/drm/drm_panel.h            |  9 +++++++
 7 files changed, 101 insertions(+), 11 deletions(-)

-- 
2.26.0

