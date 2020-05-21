Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED6AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7011420671
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbgEUQMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 12:12:18 -0400
Received: from inva021.nxp.com ([92.121.34.21]:54722 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729720AbgEUQMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 12:12:18 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D78FD2003E3;
        Thu, 21 May 2020 18:12:16 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CBD862003E0;
        Thu, 21 May 2020 18:12:16 +0200 (CEST)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 76C2F20564;
        Thu, 21 May 2020 18:12:16 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, laurentiu.tudor@nxp.com
Cc:     linux-kernel@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH] bus: fsl-mc: allocate resources when there is no scan in progress
Date:   Thu, 21 May 2020 19:12:03 +0300
Message-Id: <20200521161203.10989-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate resources from the fsl-mc bus only when a scan of the bus is
not happening. This is useful when functional devices on the bus, such
as DPNI, DPSW etc, request some kind of allocatable object but the scan
of the bus is still in progress, thus those resources are not yet
available. Catch this early and notify the upper layer driver of the
condition.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-allocator.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
index cc7bb900f524..794ddc9589dc 100644
--- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
+++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
@@ -184,6 +184,9 @@ int __must_check fsl_mc_resource_allocate(struct fsl_mc_bus *mc_bus,
 	BUILD_BUG_ON(ARRAY_SIZE(fsl_mc_pool_type_strings) !=
 		     FSL_MC_NUM_POOL_TYPES);
 
+	if (!mutex_trylock(&mc_bus->scan_mutex))
+		return -ENXIO;
+
 	*new_resource = NULL;
 	if (pool_type < 0 || pool_type >= FSL_MC_NUM_POOL_TYPES)
 		goto out;
@@ -197,7 +200,7 @@ int __must_check fsl_mc_resource_allocate(struct fsl_mc_bus *mc_bus,
 					    struct fsl_mc_resource, node);
 
 	if (!resource) {
-		error = -ENXIO;
+		error = -ENOMEM;
 		dev_err(&mc_bus_dev->dev,
 			"No more resources of type %s left\n",
 			fsl_mc_pool_type_strings[pool_type]);
@@ -220,6 +223,7 @@ int __must_check fsl_mc_resource_allocate(struct fsl_mc_bus *mc_bus,
 	mutex_unlock(&res_pool->mutex);
 	*new_resource = resource;
 out:
+	mutex_unlock(&mc_bus->scan_mutex);
 	return error;
 }
 EXPORT_SYMBOL_GPL(fsl_mc_resource_allocate);
-- 
2.17.1

