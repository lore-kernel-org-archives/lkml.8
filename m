Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B620FC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF2520873
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Wym3iEd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbgBKPWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:22:06 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58038 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730418AbgBKPWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:22:00 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01BFLx1e022409;
        Tue, 11 Feb 2020 09:21:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581434519;
        bh=c9QMZuB0cLHoGJQA+sXczBwdRr5E9qi7QWR2NuIOFqA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Wym3iEd5wRYVdzeQDJLKGj1juLf9g9vufhIEiFFkaCskVHlvfhg+IguG0vLQAe9XP
         SzeYz5/ALUC2/V2P6gfLubpOpJy+g1Hzd6DNsYw7xz5me4JxSXHKH8VZhX3QunspJ1
         pcPPiWrpx2CehEGLWDzin9NebsChYP0/B7pW97NA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01BFLxWs110851
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Feb 2020 09:21:59 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 11
 Feb 2020 09:21:58 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 11 Feb 2020 09:21:58 -0600
Received: from sokoban.bb.dnainternet.fi (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01BFLbkk020993;
        Tue, 11 Feb 2020 09:21:56 -0600
From:   Tero Kristo <t-kristo@ti.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>,
        <linux-remoteproc@vger.kernel.org>, <afd@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <mathieu.poirier@linaro.org>,
        <linux-omap@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 08/14] remoteproc/omap: remove the platform_data header
Date:   Tue, 11 Feb 2020 17:21:19 +0200
Message-ID: <20200211152125.23819-9-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211152125.23819-1-t-kristo@ti.com>
References: <20200211152125.23819-1-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform data header for OMAP remoteproc is no longer used for
anything post ti-sysc and DT conversion, so just remove it completely.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Acked-by: Suman Anna <s-anna@ti.com>
---
 include/linux/platform_data/remoteproc-omap.h | 51 -------------------
 1 file changed, 51 deletions(-)
 delete mode 100644 include/linux/platform_data/remoteproc-omap.h

diff --git a/include/linux/platform_data/remoteproc-omap.h b/include/linux/platform_data/remoteproc-omap.h
deleted file mode 100644
index 7e3a16097672..000000000000
--- a/include/linux/platform_data/remoteproc-omap.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Remote Processor - omap-specific bits
- *
- * Copyright (C) 2011 Texas Instruments, Inc.
- * Copyright (C) 2011 Google, Inc.
- */
-
-#ifndef _PLAT_REMOTEPROC_H
-#define _PLAT_REMOTEPROC_H
-
-struct rproc_ops;
-struct platform_device;
-
-/*
- * struct omap_rproc_pdata - omap remoteproc's platform data
- * @name: the remoteproc's name
- * @oh_name: omap hwmod device
- * @oh_name_opt: optional, secondary omap hwmod device
- * @firmware: name of firmware file to load
- * @mbox_name: name of omap mailbox device to use with this rproc
- * @ops: start/stop rproc handlers
- * @device_enable: omap-specific handler for enabling a device
- * @device_shutdown: omap-specific handler for shutting down a device
- * @set_bootaddr: omap-specific handler for setting the rproc boot address
- */
-struct omap_rproc_pdata {
-	const char *name;
-	const char *oh_name;
-	const char *oh_name_opt;
-	const char *firmware;
-	const char *mbox_name;
-	const struct rproc_ops *ops;
-	int (*device_enable)(struct platform_device *pdev);
-	int (*device_shutdown)(struct platform_device *pdev);
-	void (*set_bootaddr)(u32);
-};
-
-#if defined(CONFIG_OMAP_REMOTEPROC) || defined(CONFIG_OMAP_REMOTEPROC_MODULE)
-
-void __init omap_rproc_reserve_cma(void);
-
-#else
-
-static inline void __init omap_rproc_reserve_cma(void)
-{
-}
-
-#endif
-
-#endif /* _PLAT_REMOTEPROC_H */
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
