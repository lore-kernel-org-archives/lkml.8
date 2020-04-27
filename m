Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBB7C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2977C206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HIYDC723"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgD0OAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:00:47 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:46510 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726786AbgD0OAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:00:47 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 06A19C033C;
        Mon, 27 Apr 2020 14:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1587996046; bh=np9+0SGRO5CaLrwr1Pizf5LJopqBu07ZFdqwDx9Fs1Q=;
        h=From:To:Cc:Subject:Date:From;
        b=HIYDC723zkMlQHI8NzCRQP2ThO+woMb/tkOCy8o3bXBb1pa3DpTNV++gMeuQTfsfR
         wQgu0wipPf792I3GgsQYeSrbY0xFR+ElX00w2CalqK+OHuFecp0L5ski6Bb8nPStux
         q0r/JVPCI6cl1d5AhgTsZr7Z+nlB4Kqz+Mf73EGSJRw7uxsDfl4xOCxJjCF/knfFUH
         c7KE0WaCHRqM5LNHyJKOz3S7hegB0cbr0rv7R2ukFLcf36zUXWCtLPH41aQ0xUR1Br
         1I1ticdTJPhYnLjWANpxJsoqS6RTRtnuV4gxEJ8gKoww55MHa69rxhtiOHEPsyLTrV
         /5FTguflHuZUw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 2C463A005C;
        Mon, 27 Apr 2020 14:00:41 +0000 (UTC)
From:   Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>
Subject: [PATCH v3 0/4] drm: Add support for IPK DSI Host Driver
Date:   Mon, 27 Apr 2020 16:00:32 +0200
Message-Id: <cover.1587992776.git.angelo.ribeiro@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for the display subsystem in the Synopsys
DesignWare IPK devices.

The display pipeline is limited and does not have access to memory, the
validation is done using a VPG (Video Pattern Generator), as DPI
stimulus for the DW MIPI DSI Host.

A Synopsys DesignWare MIPI DSI Host v1.40 is used in the IPK device, that
so far, is fully compatible with the driver dw-mipi-dsi.

To activate the VPG use the sysfs pattern variable, assigning values from
0 (shutdown) to 4. The usage of the VPG and the Synopsys DesignWare MIPI
DSI Host internal video generator is mutually exclusive.

The submission of this driver aims to be used as a work base for the
submission of enhancements over the Synopsys DesignWare MIPI DSI Host.

Angelo Ribeiro (4):
  dt-bindings: display: Add IPK DSI subsystem bindings
  drm: ipk: Add DRM driver for DesignWare IPK DSI
  drm: ipk: Add extensions for DW MIPI DSI Host driver
  MAINTAINERS: Add IPK MIPI DSI Host driver entry

 .../bindings/display/snps,dw-ipk-dsi.yaml          | 159 ++++++
 .../bindings/display/snps,dw-ipk-vpg.yaml          |  73 +++
 MAINTAINERS                                        |   8 +
 drivers/gpu/drm/Kconfig                            |   2 +
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/ipk/Kconfig                        |  22 +
 drivers/gpu/drm/ipk/Makefile                       |   6 +
 drivers/gpu/drm/ipk/dw-drv.c                       | 169 +++++++
 drivers/gpu/drm/ipk/dw-ipk.h                       |  26 +
 drivers/gpu/drm/ipk/dw-mipi-dsi-ipk.c              | 557 +++++++++++++++++++++
 drivers/gpu/drm/ipk/dw-vpg.c                       | 412 +++++++++++++++
 drivers/gpu/drm/ipk/dw-vpg.h                       |  48 ++
 12 files changed, 1483 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/snps,dw-ipk-dsi.yaml
 create mode 100644 Documentation/devicetree/bindings/display/snps,dw-ipk-vpg.yaml
 create mode 100644 drivers/gpu/drm/ipk/Kconfig
 create mode 100644 drivers/gpu/drm/ipk/Makefile
 create mode 100644 drivers/gpu/drm/ipk/dw-drv.c
 create mode 100644 drivers/gpu/drm/ipk/dw-ipk.h
 create mode 100644 drivers/gpu/drm/ipk/dw-mipi-dsi-ipk.c
 create mode 100644 drivers/gpu/drm/ipk/dw-vpg.c
 create mode 100644 drivers/gpu/drm/ipk/dw-vpg.h

-- 
2.7.4

