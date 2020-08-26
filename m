Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CEAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A55D72083B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgHZJ0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:26:23 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56208 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbgHZJ0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:26:04 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 389BC1A08E7;
        Wed, 26 Aug 2020 11:26:02 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2B7051A16B9;
        Wed, 26 Aug 2020 11:26:02 +0200 (CEST)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id CA6A5202CA;
        Wed, 26 Aug 2020 11:26:01 +0200 (CEST)
From:   Diana Craciun <diana.craciun@oss.nxp.com>
To:     linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com
Cc:     stuyoder@gmail.com, leoyang.li@nxp.com, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, bharatb.linux@gmail.com,
        Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH v4 00/13] bus/fsl-mc: Extend mc-bus driver functionalities in preparation for mc-bus VFIO support
Date:   Wed, 26 Aug 2020 12:25:14 +0300
Message-Id: <20200826092527.4992-1-diana.craciun@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vfio-mc bus driver needs some additional services to be exported by the
mc-bus driver like:
- a way to reset the DPRC container
- driver_override support
- functions to setup/tear down a DPRC
- functions for allocating the pool of interrupts. In case of VFIO the
interrupts are not configured at probe time, but later by userspace
request

v3 -> v4
- Rebased on the latest kernel.
- Exported a dprc_remove function

v2 -> v3
- Add a new version for dprc_get_obj_region
- Export the cacheability bus specific bits defines

v1 -> v2
- Remove driver_override propagation through various functions
- Cache the DPRC API version

The patches are related with "vfio/fsl-mc: VFIO support for FSL-MC
devices" patches, but the series were split because they are targeting
different subsystems. However, the mc-bus patches may suffer changes
when addressing the VFIO review comments.

The patches do not address the comment regarding moving driver_override
in the core code. I prefer not to tie these patches on that change and
address that separately.

Bharat Bhushan (3):
  bus/fsl-mc: add support for 'driver_override' in the mc-bus
  bus/fsl-mc: Add dprc-reset-container support
  bus/fsl-mc: Extend ICID size from 16bit to 32bit

Diana Craciun (10):
  bus/fsl-mc: Do no longer export the total number of irqs outside
    dprc_scan_objects
  bus/fsl-mc: Add a new parameter to dprc_scan_objects function
  bus/fsl-mc: Set the QMAN/BMAN region flags
  bus/fsl-mc: Cache the DPRC API version
  bus/fsl-mc: Export dprc_scan/dprc_remove functions to be used by
    multiple entities
  bus/fsl-mc: Export a cleanup function for DPRC
  bus/fsl-mc: Add a container setup function
  bus/fsl_mc: Do not rely on caller to provide non NULL mc_io
  bus/fsl-mc: Export IRQ pool handling functions to be used by VFIO
  bus/fsl-mc: Add a new version for dprc_get_obj_region command

 drivers/bus/fsl-mc/dprc-driver.c      | 175 ++++++++++++++++----------
 drivers/bus/fsl-mc/dprc.c             | 141 +++++++++++++++++----
 drivers/bus/fsl-mc/fsl-mc-allocator.c |  12 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c       |  64 +++++++++-
 drivers/bus/fsl-mc/fsl-mc-private.h   |  31 ++---
 drivers/bus/fsl-mc/mc-io.c            |   7 +-
 include/linux/fsl/mc.h                |  41 +++++-
 7 files changed, 349 insertions(+), 122 deletions(-)

-- 
2.17.1

