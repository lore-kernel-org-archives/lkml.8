Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43460C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2194D20775
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgCSPlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 11:41:04 -0400
Received: from inva020.nxp.com ([92.121.34.13]:41338 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727462AbgCSPlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:41:04 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DC8AB1A010D;
        Thu, 19 Mar 2020 16:41:02 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D00B71A0117;
        Thu, 19 Mar 2020 16:41:02 +0100 (CET)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 82FB8205C2;
        Thu, 19 Mar 2020 16:41:02 +0100 (CET)
From:   Diana Craciun <diana.craciun@oss.nxp.com>
To:     linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com,
        stuyoder@gmail.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, bharatb.yadav@gmail.com
Cc:     Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH 00/10] bus/fsl-mc: Extend mc-bus driver functionalities in preparation for mc-bus VFIO support
Date:   Thu, 19 Mar 2020 17:40:41 +0200
Message-Id: <20200319154051.30609-1-diana.craciun@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vfio-mc bus driver needs some additional services to be exported by the
mc-bus driver like:
- a way to reset the DPRC container
- support for driver_override such taht the objects within a DPRC to be
bind to the VFIO driver
- functions to setup/tear dowan a DPRC
- functions for allocating the pool of interrupts. In case of VFIO the
interrupts are not configured at probe time, but later, when the userspace
configures the interrupts.

Bharat Bhushan (3):
  bus/fsl-mc: add support for 'driver_override' in the mc-bus
  bus/fsl-mc: Propagate driver_override for a child DPRC's children
  bus/fsl-mc: Add dprc-reset-container support

Diana Craciun (7):
  bus/fsl-mc: Do no longer export the total number of irqs outside dprc_scan_objects
  bus/fsl-mc: Add a new parameter to dprc_scan_objects function
  bus/fsl-mc: Set the QMAN/BMAN region flags
  bus/fsl-mc: Export a dprc scan function to be used by multiple
    entities
  bus/fsl-mc: Export a cleanup function for DPRC
  bus/fsl-mc: Add a container setup function
  bus/fsl-mc: Export IRQ pool handling functions to be used by VFIO

 drivers/bus/fsl-mc/dprc-driver.c      | 184 ++++++++++++++++----------
 drivers/bus/fsl-mc/dprc.c             |  41 ++++++
 drivers/bus/fsl-mc/fsl-mc-allocator.c |  12 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c       |  81 +++++++++++-
 drivers/bus/fsl-mc/fsl-mc-private.h   |  23 +---
 drivers/bus/fsl-mc/mc-io.c            |   7 +-
 include/linux/fsl/mc.h                |  27 ++++
 7 files changed, 279 insertions(+), 96 deletions(-)

-- 
2.17.1

