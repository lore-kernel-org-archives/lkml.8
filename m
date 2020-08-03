Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EA5C433E3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 615F820678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AH3KVJBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHCKKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 06:10:17 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53160 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgHCKKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:10:16 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 073AABmU049033;
        Mon, 3 Aug 2020 05:10:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596449411;
        bh=qI4WtFsUXwjJLuzdoapD+eXMPPT9PE2tKpRezoxY2ho=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=AH3KVJBtuxg4PFL4CfffesTYWnYjQkdvPiWkuAZZ1c1zV2zORBYhkm7S5ssIYgw55
         uizyC6K4Vd3vzrVrATEv0yIrBaRZ0JEt+3gWjW90jec3gFwue0dmva7WFfXW5VyZ/m
         Y82dMNztnsYyNbOi4DlzuF4Zy7wlS7GmDGtx8J38=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 073AAB8x041194;
        Mon, 3 Aug 2020 05:10:11 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 3 Aug
 2020 05:10:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 3 Aug 2020 05:10:10 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 073AA51G062951;
        Mon, 3 Aug 2020 05:10:08 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>,
        <linux-arm-kernel@lists.infradead.org>, <nm@ti.com>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>, <nsekhar@ti.com>,
        <kishon@ti.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dmaengine: ti: k3-psil: Use soc_device_match to get the psil map
Date:   Mon, 3 Aug 2020 13:11:27 +0300
Message-ID: <20200803101128.20885-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803101128.20885-1-peter.ujfalusi@ti.com>
References: <20200803101128.20885-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of separate of_machine_is_compatible() it is better to use
soc_device_match() and soc_device_attribute struct to get the PSI-L map
for the booted device.

By using soc_device_match() it is easier to add support for new devices.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-psil.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/ti/k3-psil.c b/drivers/dma/ti/k3-psil.c
index fb7c8150b0d1..3ca29aabac93 100644
--- a/drivers/dma/ti/k3-psil.c
+++ b/drivers/dma/ti/k3-psil.c
@@ -9,11 +9,18 @@
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/sys_soc.h>
 
 #include "k3-psil-priv.h"
 
 static DEFINE_MUTEX(ep_map_mutex);
-static struct psil_ep_map *soc_ep_map;
+static const struct psil_ep_map *soc_ep_map;
+
+static const struct soc_device_attribute k3_soc_devices[] = {
+	{ .family = "AM65X", .data = &am654_ep_map },
+	{ .family = "J721E", .data = &j721e_ep_map },
+	{ /* sentinel */ }
+};
 
 struct psil_endpoint_config *psil_get_ep_config(u32 thread_id)
 {
@@ -21,15 +28,17 @@ struct psil_endpoint_config *psil_get_ep_config(u32 thread_id)
 
 	mutex_lock(&ep_map_mutex);
 	if (!soc_ep_map) {
-		if (of_machine_is_compatible("ti,am654")) {
-			soc_ep_map = &am654_ep_map;
-		} else if (of_machine_is_compatible("ti,j721e")) {
-			soc_ep_map = &j721e_ep_map;
+		const struct soc_device_attribute *soc;
+
+		soc = soc_device_match(k3_soc_devices);
+		if (soc) {
+			soc_ep_map = soc->data;
 		} else {
 			pr_err("PSIL: No compatible machine found for map\n");
 			mutex_unlock(&ep_map_mutex);
 			return ERR_PTR(-ENOTSUPP);
 		}
+
 		pr_debug("%s: Using map for %s\n", __func__, soc_ep_map->name);
 	}
 	mutex_unlock(&ep_map_mutex);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

