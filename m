Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BCFC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C86C2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgGQPsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 11:48:10 -0400
Received: from inva020.nxp.com ([92.121.34.13]:40588 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbgGQPsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 11:48:09 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 41EC41A0906;
        Fri, 17 Jul 2020 17:48:08 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3521A1A026D;
        Fri, 17 Jul 2020 17:48:08 +0200 (CEST)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id E581020466;
        Fri, 17 Jul 2020 17:48:07 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     laurentiu.tudor@nxp.com, Grigore Popescu <grigore.popescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 3/3] bus: fsl-mc: probe the allocatable objects first
Date:   Fri, 17 Jul 2020 18:48:00 +0300
Message-Id: <20200717154800.17169-4-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717154800.17169-1-ioana.ciornei@nxp.com>
References: <20200717154800.17169-1-ioana.ciornei@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grigore Popescu <grigore.popescu@nxp.com>

Because the DPNIs are probed before DPMCPs and other objects that need
to be allocated, messages like "No more resources of type X left" are
printed by the fsl-mc bus driver. This patch resolves the issue by probing
the allocatable objects first and then any other object that may use
them.

Signed-off-by: Grigore Popescu <grigore.popescu@nxp.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/bus/fsl-mc/dprc-driver.c | 57 ++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 17 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index c8b1c3842c1a..3512d1b95821 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -27,7 +27,16 @@ static bool fsl_mc_device_match(struct fsl_mc_device *mc_dev,
 {
 	return mc_dev->obj_desc.id == obj_desc->id &&
 	       strcmp(mc_dev->obj_desc.type, obj_desc->type) == 0;
+}
 
+static bool fsl_mc_obj_desc_is_allocatable(struct fsl_mc_obj_desc *obj)
+{
+	if (strcmp(obj->type, "dpmcp") == 0 ||
+	    strcmp(obj->type, "dpcon") == 0 ||
+	    strcmp(obj->type, "dpbp") == 0)
+		return true;
+	else
+		return false;
 }
 
 static int __fsl_mc_device_remove_if_not_in_mc(struct device *dev, void *data)
@@ -150,6 +159,27 @@ static void check_plugged_state_change(struct fsl_mc_device *mc_dev,
 	}
 }
 
+static void fsl_mc_obj_device_add(struct fsl_mc_device *mc_bus_dev,
+				  struct fsl_mc_obj_desc *obj_desc)
+{
+	int error;
+	struct fsl_mc_device *child_dev;
+
+	/*
+	 * Check if device is already known to Linux:
+	 */
+	child_dev = fsl_mc_device_lookup(obj_desc, mc_bus_dev);
+	if (child_dev) {
+		check_plugged_state_change(child_dev, obj_desc);
+		put_device(&child_dev->dev);
+	} else {
+		error = fsl_mc_device_add(obj_desc, NULL, &mc_bus_dev->dev,
+					  &child_dev);
+		if (error < 0)
+			return;
+	}
+}
+
 /**
  * dprc_add_new_devices - Adds devices to the logical bus for a DPRC
  *
@@ -166,30 +196,23 @@ static void dprc_add_new_devices(struct fsl_mc_device *mc_bus_dev,
 				 struct fsl_mc_obj_desc *obj_desc_array,
 				 int num_child_objects_in_mc)
 {
-	int error;
 	int i;
 
+	/* probe the allocable objects first */
 	for (i = 0; i < num_child_objects_in_mc; i++) {
-		struct fsl_mc_device *child_dev;
 		struct fsl_mc_obj_desc *obj_desc = &obj_desc_array[i];
 
-		if (strlen(obj_desc->type) == 0)
-			continue;
+		if (strlen(obj_desc->type) > 0 &&
+		    fsl_mc_obj_desc_is_allocatable(obj_desc))
+			fsl_mc_obj_device_add(mc_bus_dev, obj_desc);
+	}
 
-		/*
-		 * Check if device is already known to Linux:
-		 */
-		child_dev = fsl_mc_device_lookup(obj_desc, mc_bus_dev);
-		if (child_dev) {
-			check_plugged_state_change(child_dev, obj_desc);
-			put_device(&child_dev->dev);
-			continue;
-		}
+	for (i = 0; i < num_child_objects_in_mc; i++) {
+		struct fsl_mc_obj_desc *obj_desc = &obj_desc_array[i];
 
-		error = fsl_mc_device_add(obj_desc, NULL, &mc_bus_dev->dev,
-					  &child_dev);
-		if (error < 0)
-			continue;
+		if (strlen(obj_desc->type) > 0 &&
+		    !fsl_mc_obj_desc_is_allocatable(obj_desc))
+			fsl_mc_obj_device_add(mc_bus_dev, obj_desc);
 	}
 }
 
-- 
2.25.1

