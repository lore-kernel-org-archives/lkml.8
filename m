Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B27CC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195202187F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgANVsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:48:22 -0500
Received: from inva021.nxp.com ([92.121.34.21]:54814 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgANVsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:48:21 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EC927200507;
        Tue, 14 Jan 2020 22:48:19 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ED0012000EA;
        Tue, 14 Jan 2020 22:48:13 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5B31A40285;
        Wed, 15 Jan 2020 05:48:06 +0800 (SGT)
From:   Han Xu <han.xu@nxp.com>
To:     vkoul@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        esben@geanix.com, boris.brezillon@collabora.com
Cc:     festevam@gmail.com, linux-imx@nxp.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, han.xu@nxp.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] gpmi/mxs-dma runtime pm patch set
Date:   Wed, 15 Jan 2020 05:43:57 +0800
Message-Id: <1579038243-28550-1-git-send-email-han.xu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enable the system pm and runtime pm for mxs-dma and refine the gpmi
runtime pm code

Han Xu (6):
  dmaengine: mxs: change the way to register probe function
  dmaengine: mxs: add the remove function
  dmaengine: mxs: add the power management functions
  dmaengine: mxs: switch from dma_coherent to dma_pool
  mtd: rawnand: gpmi: refine the runtime pm ops
  mtd: rawnand: gpmi: set the pinctrl state for suspend/reusme

 drivers/dma/mxs-dma.c                      | 155 ++++++++++++++++++---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c |  60 ++++----
 2 files changed, 167 insertions(+), 48 deletions(-)

-- 
2.17.1

