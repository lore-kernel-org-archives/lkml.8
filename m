Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16529C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D2E20775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Z6mHaE2E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgCXRTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:19:18 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:55988 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727231AbgCXRTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:19:17 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E3BD74050A;
        Tue, 24 Mar 2020 17:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1585070357; bh=5jpnq54XJHVyKdtK2ilj2VKnRPLNG0vB+S9snG16b+o=;
        h=From:To:Cc:Subject:Date:From;
        b=Z6mHaE2EPkseUJzW3ecM6rDhihFKYmeEXlQFWTNaPW/mi23fOlrG3Kpfp627zcdua
         1uYxvN3odnDj3BvxDCOf53kQeur9CXvGSQgClV0MTpE8pQ61OJQCWuxo7wytHm2wwH
         AznVO7gFKzaP69emDCLoTMGz64YUAd3gLoLFX8s3Xsj6xuBsZHLDx68bZKvUXPdBx0
         SRID1z1Z5YOnC5YC9brN1yjAC0DM7/BXX5mOn4TDjWzmUgXKzg5UojvNepcoBCXMuq
         fDbILVxcPlaxCFeVA1wauKngEH7EEr2qtx1jtpSN1so1T0DgTo8eshuZTrVrDrMYep
         ZzCz492Rf91zw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 66A45A005B;
        Tue, 24 Mar 2020 17:19:14 +0000 (UTC)
From:   Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>
Subject: [PATCH 0/4] drm: Add support for IPK DSI Host Driver
Date:   Tue, 24 Mar 2020 18:18:18 +0100
Message-Id: <cover.1585067507.git.angelo.ribeiro@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the display subsystem in the Synopsys
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

 .../bindings/display/snps,dw-ipk-dsi.yaml          | 163 ++++++
 .../bindings/display/snps,dw-ipk-vpg.yaml          |  77 +++
 MAINTAINERS                                        |   8 +
 drivers/gpu/drm/Kconfig                            |   2 +
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/ipk/Kconfig                        |  22 +
 drivers/gpu/drm/ipk/Makefile                       |   8 +
 drivers/gpu/drm/ipk/dw-drv.c                       | 189 +++++++
 drivers/gpu/drm/ipk/dw-ipk.h                       |  30 ++
 drivers/gpu/drm/ipk/dw-mipi-dsi-ipk.c              | 556 ++++++++++++++++++++
 drivers/gpu/drm/ipk/dw-vpg.c                       | 559 +++++++++++++++++++++
 drivers/gpu/drm/ipk/dw-vpg.h                       |  55 ++
 12 files changed, 1670 insertions(+)
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

