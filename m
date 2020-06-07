Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7101EC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 20:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 401782053B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 20:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="PT5/SPwD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgFGUZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 16:25:27 -0400
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:9485 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgFGUZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 16:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:to:cc:content-type:content-transfer-encoding;
        s=001; bh=9+UFvR2HLQ1OtsQEFQDlYZvMrwIZ+EbLi39KqEqSC5c=;
        b=PT5/SPwDAKr7hCt/j9ChohbEuXIFE9HVYER3FGySHJCRHG8yfhB5E5ill2UxtU5r+Oll
        ahdPcZND/NfLoiG/dgAGsTGi8C8EG6vGNDhFFZ7UhkZ2jnl1J6j1Tc9hwk5pKPAzJeNt+3
        YJfqoUmq/C7tUiJfY2lPmGR0UToA2v3Ng=
Received: by filterdrecv-p3mdw1-6f5df8956d-x2qpw with SMTP id filterdrecv-p3mdw1-6f5df8956d-x2qpw-20-5EDD4D35-1
        2020-06-07 20:25:25.100926506 +0000 UTC m=+346300.487522929
Received: from bionic.localdomain (unknown)
        by ismtpd0001p1lon1.sendgrid.net (SG) with ESMTP
        id zJEc6mt4Tsa6oQIoDupI0g
        Sun, 07 Jun 2020 20:25:24.908 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] drm: rockchip: add NV15 and NV20 support
Date:   Sun, 07 Jun 2020 20:25:25 +0000 (UTC)
Message-Id: <20200607202521.18438-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.17.1
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h6O1z6Pg2iWyq5iV4?=
 =?us-ascii?Q?A+F4I6TvUqYcjYtDAgN2Hadv6t1FKJVFTvJ+DT8?=
 =?us-ascii?Q?LaIMpqOITdDIRmvVNs35SgjYXThyqH1kd6iaExO?=
 =?us-ascii?Q?R90pp6lr8CkFY4cDML31=2FBkIMO2LIq+GtHuReav?=
 =?us-ascii?Q?t32QWEkXhPVkqLFsMb5z=2F1Kv0WvITuAHEopipmr?=
 =?us-ascii?Q?PCqn2V36JAyTakxZJCy9w=3D=3D?=
To:     Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Ben Davis <ben.davis@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for displaying 10-bit 4:2:0 and 4:2:2 formats produced
by the Rockchip Video Decoder on RK322X, RK3288, RK3328, RK3368 and RK3399.

First patch adds a new fourcc 10-bit YUV format with 4:2:2 sub-sampling.
Second patch adds support for using the the two new fourcc formats.
Both depend on "drm: drm_fourcc: add NV15, Q410, Q401 YUV formats" at [1].

This series can also be found at [2], and can be tested on RK3399 using an
upcoming rkvdec series at [3] together with ffmpeg at [4] and kodi-gbm or mpv.

[1] https://patchwork.freedesktop.org/series/76326/
[2] https://github.com/Kwiboo/linux-rockchip/commits/next-20200605-fmt_10
[3] https://github.com/Kwiboo/linux-rockchip/commits/next-20200605-rkvdec
[4] https://github.com/Kwiboo/FFmpeg/commits/v4l2-request-hwaccel-4.2.2-rkvdec

Regards,
Jonas

Jonas Karlman (2):
  drm: drm_fourcc: add NV20 YUV format
  drm: rockchip: add NV15 and NV20 support

 drivers/gpu/drm/drm_fourcc.c                |  4 +++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 27 ++++++++++++++++--
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |  1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 31 +++++++++++++++++----
 include/uapi/drm/drm_fourcc.h               |  1 +
 5 files changed, 56 insertions(+), 8 deletions(-)

-- 
2.17.1

