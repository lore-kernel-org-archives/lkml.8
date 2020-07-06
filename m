Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527C7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D26820771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgGFMnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 08:43:07 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37892 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728973AbgGFMnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 08:43:07 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D2CB92004B7;
        Mon,  6 Jul 2020 14:43:04 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C68662004AF;
        Mon,  6 Jul 2020 14:43:04 +0200 (CEST)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 70119203C3;
        Mon,  6 Jul 2020 14:43:04 +0200 (CEST)
From:   Diana Craciun <diana.craciun@nxp.com>
To:     linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com,
        gregkh@linuxfoundation.org
Cc:     stuyoder@gmail.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, bharatb.linux@gmail.com,
        Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH v3 00/13] bus/fsl-mc: Extend mc-bus driver functionalities in preparation for mc-bus VFIO support
Date:   Mon,  6 Jul 2020 15:42:30 +0300
Message-Id: <20200706124243.10697-1-diana.craciun@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Diana Craciun <diana.craciun@oss.nxp.com>

The vfio-mc bus driver needs some additional services to be exported by the
mc-bus driver like:
- a way to reset the DPRC container
- driver_override support
- functions to setup/tear down a DPRC
- functions for allocating the pool of interrupts. In case of VFIO the
interrupts are not configured at probe time, but later by userspace
request

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
  bus/fsl-mc: Export a dprc scan function to be used by multiple
    entities
  bus/fsl-mc: Export a cleanup function for DPRC
  bus/fsl-mc: Add a container setup function
  bus/fsl_mc: Do not rely on caller to provide non NULL mc_io
  bus/fsl-mc: Export IRQ pool handling functions to be used by VFIO
  bus/fsl-mc: Add a new version for dprc_get_obj_region command

 drivers/bus/fsl-mc/dprc-driver.c      | 181 ++++++++++++++++----------
 drivers/bus/fsl-mc/dprc.c             | 141 ++++++++++++++++----
 drivers/bus/fsl-mc/fsl-mc-allocator.c |  12 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c       |  64 ++++++++-
 drivers/bus/fsl-mc/fsl-mc-private.h   |  31 ++---
 drivers/bus/fsl-mc/mc-io.c            |   7 +-
 include/linux/fsl/mc.h                |  37 +++++-
 7 files changed, 348 insertions(+), 125 deletions(-)

-- 
2.17.1

