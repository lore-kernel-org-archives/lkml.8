Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBAAC2BA18
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3C320737
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390656AbgDCJhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 05:37:11 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:42453 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgDCJhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 05:37:08 -0400
X-Originating-IP: 93.29.109.196
Received: from localhost.localdomain (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 0C3D040019;
        Fri,  3 Apr 2020 09:36:58 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v5 0/2] drm: LogiCVC display controller support
Date:   Fri,  3 Apr 2020 11:36:15 +0200
Message-Id: <20200403093617.760278-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces support for the LogiCVC display controller.
The controller is a bit unusual since it is usually loaded as
programmable logic on Xilinx FPGAs or Zynq-7000 SoCs.
More details are presented on the main commit for the driver.

More information about the controller is available on the dedicated
web page: https://www.logicbricks.com/Products/logiCVC-ML.aspx

Changes since v4:
- Updated to internal DRM API changes (rebased on drm-misc-next);
- Added Kconfig dependency on OF;
- Added MAINTAINERS entry;
- Used drm_err and dev_err instead of DRM_ERROR where possible;
- Various cosmetic changes.

Changes since v3:
- Rebased on latest drm-misc;
- Improved event lock wrapping;
- Added collect tag;
- Added color-key support patch (not for merge, for reference only).

Changes since v2:
- Fixed and slightly improved dt schema.

Changes since v1:
- Switched dt bindings documentation to dt schema;
- Described more possible dt parameters;
- Added support for the lvds-3bit interface;
- Added support for grabbing syscon regmap from parent node;
- Removed layers count property and count layers child nodes instead.

Cheers!

Paul Kocialkowski (2):
  dt-bindings: display: Document the Xylon LogiCVC display controller
  drm: Add support for the LogiCVC display controller

 .../display/xylon,logicvc-display.yaml        | 313 +++++++++
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/Kconfig                       |   2 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/logicvc/Kconfig               |   9 +
 drivers/gpu/drm/logicvc/Makefile              |   4 +
 drivers/gpu/drm/logicvc/logicvc_crtc.c        | 272 ++++++++
 drivers/gpu/drm/logicvc/logicvc_crtc.h        |  23 +
 drivers/gpu/drm/logicvc/logicvc_drm.c         | 471 ++++++++++++++
 drivers/gpu/drm/logicvc/logicvc_drm.h         |  60 ++
 drivers/gpu/drm/logicvc/logicvc_interface.c   | 240 +++++++
 drivers/gpu/drm/logicvc/logicvc_interface.h   |  32 +
 drivers/gpu/drm/logicvc/logicvc_layer.c       | 603 ++++++++++++++++++
 drivers/gpu/drm/logicvc/logicvc_layer.h       |  65 ++
 drivers/gpu/drm/logicvc/logicvc_mode.c        | 104 +++
 drivers/gpu/drm/logicvc/logicvc_mode.h        |  15 +
 drivers/gpu/drm/logicvc/logicvc_of.c          | 205 ++++++
 drivers/gpu/drm/logicvc/logicvc_of.h          |  28 +
 drivers/gpu/drm/logicvc/logicvc_regs.h        |  88 +++
 19 files changed, 2541 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml
 create mode 100644 drivers/gpu/drm/logicvc/Kconfig
 create mode 100644 drivers/gpu/drm/logicvc/Makefile
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_crtc.c
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_crtc.h
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_drm.c
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_drm.h
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_interface.c
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_interface.h
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_layer.c
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_layer.h
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_mode.c
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_mode.h
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_of.c
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_of.h
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_regs.h

-- 
2.26.0

