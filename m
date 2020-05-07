Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED571C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7E892078C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgEGHfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 03:35:46 -0400
Received: from inva021.nxp.com ([92.121.34.21]:50116 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgEGHfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 03:35:45 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5C619200F19;
        Thu,  7 May 2020 09:35:43 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4DDB1200F10;
        Thu,  7 May 2020 09:35:43 +0200 (CEST)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id F394A203C5;
        Thu,  7 May 2020 09:35:42 +0200 (CEST)
From:   Diana Craciun <diana.craciun@oss.nxp.com>
To:     linux-kernel@vger.kernel.org
Cc:     laurentiu.tudor@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH v2 00/12] bus/fsl-mc: Extend mc-bus driver functionalities in preparation for mc-bus VFIO support
Date:   Thu,  7 May 2020 10:34:19 +0300
Message-Id: <20200507073431.2710-1-diana.craciun@oss.nxp.com>
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

Diana Craciun (9):
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

 drivers/bus/fsl-mc/dprc-driver.c      | 181 ++++++++++++++++----------
 drivers/bus/fsl-mc/dprc.c             | 103 +++++++++++++--
 drivers/bus/fsl-mc/fsl-mc-allocator.c |  12 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c       |  64 ++++++++-
 drivers/bus/fsl-mc/fsl-mc-private.h   |  28 ++--
 drivers/bus/fsl-mc/mc-io.c            |   7 +-
 include/linux/fsl/mc.h                |  29 ++++-
 7 files changed, 313 insertions(+), 111 deletions(-)

-- 
2.17.1

