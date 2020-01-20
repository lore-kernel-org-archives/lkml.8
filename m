Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC97C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6764721D7E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgATRGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 12:06:15 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38146 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATRGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 12:06:15 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 9F2C02912D9
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 0/5] drm/rockchip: Fix unbind/bind
Date:   Mon, 20 Jan 2020 14:05:57 -0300
Message-Id: <20200120170602.3832-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is an attempt to fix the unbind/bind crash
(due to an use-after-free bug) found on rockchip-drm driver.

The problem lies in the way the driver uses the component API.
Currently, rockchip_drm_unbind calls component_unbind_all before
drm_mode_config_cleanup, the former releasing the memory
where the DRM objects are embedded.

The series goal is basically to fix all the components,
making proper use of the respective .destroy hooks,
making sure there are no use-after-free or double-free issues.

The first patch is likely the most controversial, which is required
because component_bind_all will call component_unbind without
calling drm_mode_config_cleanup, if any component fails to bind.
As mentioned above, this is problematic in the DRM framework.

Thanks!
Ezequiel

Ezequiel Garcia (5):
  component: Add an API to cleanup before unbind
  drm/rockchip: Fix the device unbind order
  drm/rockchip: vop: Fix CRTC unbind
  drm/rockchip: lvds: Fix component unbind
  drm/rockchip: rk3066_hdmi: Cleanup component unbind

 drivers/base/component.c                    |  9 +++-
 drivers/gpu/drm/rockchip/rk3066_hdmi.c      |  8 +--
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 20 +++++---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 56 ++++++++-------------
 drivers/gpu/drm/rockchip/rockchip_lvds.c    | 20 ++++----
 include/linux/component.h                   | 10 +++-
 6 files changed, 60 insertions(+), 63 deletions(-)

-- 
2.25.0

