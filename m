Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E701EC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C81862098B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgD0IWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:22:05 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:52978 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726003AbgD0IWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:22:05 -0400
X-IronPort-AV: E=Sophos;i="5.73,323,1583161200"; 
   d="scan'208";a="45816323"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 27 Apr 2020 17:22:03 +0900
Received: from renesas-VirtualBox.ree.adwin.renesas.com (unknown [172.29.51.26])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id A203E41D982B;
        Mon, 27 Apr 2020 17:21:58 +0900 (JST)
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Icenowy Zheng <icenowy@aosc.io>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Vivek Unune <npcomplete13@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3]
Date:   Mon, 27 Apr 2020 09:21:46 +0100
Message-Id: <1587975709-2092-1-git-send-email-gareth.williams.jx@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds DRM support for the Digital Blocks db9000
LCD controller with RZ/N1 specific changes and updates simple-panel to
include the associated panel. As this has not previously been
documented, also include a yaml file to provide this.

Gareth Williams (3):
  drm/db9000: Add Digital Blocks DB9000 LCD Controller
  drm/db9000: Add bindings documentation for LCD controller
  drm/panel: simple: Add Newhaven ATXL#-CTP panel

 .../devicetree/bindings/display/db9000,du.yaml     |  87 ++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 drivers/gpu/drm/Kconfig                            |   2 +
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/digital-blocks/Kconfig             |  13 +
 drivers/gpu/drm/digital-blocks/Makefile            |   3 +
 drivers/gpu/drm/digital-blocks/db9000-du.c         | 953 +++++++++++++++++++++
 drivers/gpu/drm/digital-blocks/db9000-du.h         | 192 +++++
 drivers/gpu/drm/panel/panel-simple.c               |  27 +
 9 files changed, 1280 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/db9000,du.yaml
 create mode 100644 drivers/gpu/drm/digital-blocks/Kconfig
 create mode 100644 drivers/gpu/drm/digital-blocks/Makefile
 create mode 100644 drivers/gpu/drm/digital-blocks/db9000-du.c
 create mode 100644 drivers/gpu/drm/digital-blocks/db9000-du.h

-- 
2.7.4

