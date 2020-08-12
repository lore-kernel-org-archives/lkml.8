Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D272C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 08:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D7C4206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 08:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgHLIbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 04:31:43 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:55544 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgHLIbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 04:31:42 -0400
Received: from localhost (unknown [192.168.167.32])
        by lucky1.263xmail.com (Postfix) with ESMTP id 684A1A1B42;
        Wed, 12 Aug 2020 16:31:35 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [103.29.142.67])
        by smtp.263.net (postfix) whith ESMTP id P37123T139693005121280S1597221089119037_;
        Wed, 12 Aug 2020 16:31:34 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <ad9528e0bf7ae9b013df868bd4c7e1c9>
X-RL-SENDER: algea.cao@rock-chips.com
X-SENDER: algea.cao@rock-chips.com
X-LOGIN-NAME: algea.cao@rock-chips.com
X-FST-TO: a.hajda@samsung.com
X-SENDER-IP: 103.29.142.67
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Algea Cao <algea.cao@rock-chips.com>
To:     a.hajda@samsung.com, kuankuan.y@gmail.com, hjc@rock-chips.com,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        sam@ravnborg.org, airlied@linux.ie, heiko@sntech.de,
        jernej.skrabec@siol.net, algea.cao@rock-chips.com,
        Laurent.pinchart@ideasonboard.com,
        laurent.pinchart+renesas@ideasonboard.com, jonas@kwiboo.se,
        mripard@kernel.org, darekm@google.com,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, cychiang@chromium.org,
        linux-kernel@vger.kernel.org, narmstrong@baylibre.com,
        jbrunet@baylibre.com, maarten.lankhorst@linux.intel.com,
        daniel@ffwll.ch
Subject: [PATCH 0/6] Support change dw-hdmi output color
Date:   Wed, 12 Aug 2020 16:31:20 +0800
Message-Id: <20200812083120.743-1-algea.cao@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support userspace to set hdmi output color via hdmi properties.
Add hdmi atomic_begin/atomic_flush to make sure screen don't flash
when updating color.


Algea Cao (6):
  drm: Add connector atomic_begin/atomic_flush
  drm: bridge: dw-hdmi: Implement connector atomic_begin/atomic_flush
  drm: bridge: dw-hdmi: Introduce previous_pixelclock/previous_tmdsclock
  drm/rockchip: dw_hdmi: Add vendor hdmi properties
  drm/rockchip: dw_hdmi: Add get_output_bus_format
  drm: bridge: dw-hdmi: Get output bus format when dw-hdmi is the only
    bridge

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c   | 123 ++++++++++-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.h   |   4 +
 drivers/gpu/drm/drm_atomic_helper.c         |  46 ++++
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 221 ++++++++++++++++++++
 include/drm/bridge/dw_hdmi.h                |  23 ++
 include/drm/drm_modeset_helper_vtables.h    |  19 ++
 6 files changed, 428 insertions(+), 8 deletions(-)

-- 
2.25.1



