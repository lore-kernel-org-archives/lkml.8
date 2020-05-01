Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D18C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A204620857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588344486;
	bh=iXyhKhh+1fNQQ4ERHn54u278GymZAlFq0J2Td5h58IE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tYmo3FDD6CzdIcI8uhBBuynImELwQuIObJW+mYPfm1HsZ6gSeVp2LfZIczvUa5tcX
	 aQZW1TYGlgroyWPebeEltRvT82KT8/Aj66sFOJsQcK14k4pYxi7H3nTZhRKcTF9vyC
	 4VhXbhTF7oBq5MkQNyOUMw3zTSmdTEcNafrPy/GU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbgEAOry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 10:47:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729438AbgEAOpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 10:45:08 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB06124980;
        Fri,  1 May 2020 14:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588344306;
        bh=iXyhKhh+1fNQQ4ERHn54u278GymZAlFq0J2Td5h58IE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eZsYIcuRRt1RHBXRYygOd4y0HG2lcZMHsjP5ps2tWPLrSktUpr9ufUhnXcwEWngXl
         thzMqEAOQF8g1VaKg6q4Cgc0pNb5TQP8QDULjkzPhj+2EX9XomHr20mT2VE0m0lzrU
         XpgLU9KuRDL3SFuwbsDIc6TCSXLm3NfyTrPYn1S4=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUWuT-00FCdy-MS; Fri, 01 May 2020 16:45:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH 18/37] docs: networking: device drivers: convert davicom/dm9000.txt to ReST
Date:   Fri,  1 May 2020 16:44:40 +0200
Message-Id: <d55ecefde142ab8d033d85b654ad98ed5481c884.1588344146.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588344146.git.mchehab+huawei@kernel.org>
References: <cover.1588344146.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- add SPDX header;
- add a document title;
- mark lists as such;
- mark tables as such;
- mark code blocks and literals as such;
- use the right horizontal tag markup;
- adjust identation, whitespaces and blank lines where needed;
- add to networking/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../davicom/{dm9000.txt => dm9000.rst}        | 24 +++++++++++--------
 .../networking/device_drivers/index.rst       |  1 +
 2 files changed, 15 insertions(+), 10 deletions(-)
 rename Documentation/networking/device_drivers/davicom/{dm9000.txt => dm9000.rst} (92%)

diff --git a/Documentation/networking/device_drivers/davicom/dm9000.txt b/Documentation/networking/device_drivers/davicom/dm9000.rst
similarity index 92%
rename from Documentation/networking/device_drivers/davicom/dm9000.txt
rename to Documentation/networking/device_drivers/davicom/dm9000.rst
index 5552e2e575c5..d5458da01083 100644
--- a/Documentation/networking/device_drivers/davicom/dm9000.txt
+++ b/Documentation/networking/device_drivers/davicom/dm9000.rst
@@ -1,7 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
 DM9000 Network driver
 =====================
 
 Copyright 2008 Simtec Electronics,
+
 	  Ben Dooks <ben@simtec.co.uk> <ben-linux@fluff.org>
 
 
@@ -30,9 +34,9 @@ These resources should be specified in that order, as the ordering of the
 two address regions is important (the driver expects these to be address
 and then data).
 
-An example from arch/arm/mach-s3c2410/mach-bast.c is:
+An example from arch/arm/mach-s3c2410/mach-bast.c is::
 
-static struct resource bast_dm9k_resource[] = {
+  static struct resource bast_dm9k_resource[] = {
 	[0] = {
 		.start = S3C2410_CS5 + BAST_PA_DM9000,
 		.end   = S3C2410_CS5 + BAST_PA_DM9000 + 3,
@@ -48,14 +52,14 @@ static struct resource bast_dm9k_resource[] = {
 		.end   = IRQ_DM9000,
 		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
 	}
-};
+  };
 
-static struct platform_device bast_device_dm9k = {
+  static struct platform_device bast_device_dm9k = {
 	.name		= "dm9000",
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(bast_dm9k_resource),
 	.resource	= bast_dm9k_resource,
-};
+  };
 
 Note the setting of the IRQ trigger flag in bast_dm9k_resource[2].flags,
 as this will generate a warning if it is not present. The trigger from
@@ -64,13 +68,13 @@ handler to ensure that the IRQ is setup correctly.
 
 This shows a typical platform device, without the optional configuration
 platform data supplied. The next example uses the same resources, but adds
-the optional platform data to pass extra configuration data:
+the optional platform data to pass extra configuration data::
 
-static struct dm9000_plat_data bast_dm9k_platdata = {
+  static struct dm9000_plat_data bast_dm9k_platdata = {
 	.flags		= DM9000_PLATF_16BITONLY,
-};
+  };
 
-static struct platform_device bast_device_dm9k = {
+  static struct platform_device bast_device_dm9k = {
 	.name		= "dm9000",
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(bast_dm9k_resource),
@@ -78,7 +82,7 @@ static struct platform_device bast_device_dm9k = {
 	.dev		= {
 		.platform_data = &bast_dm9k_platdata,
 	}
-};
+  };
 
 The platform data is defined in include/linux/dm9000.h and described below.
 
diff --git a/Documentation/networking/device_drivers/index.rst b/Documentation/networking/device_drivers/index.rst
index 0b39342e2a1f..e8db57fef2e9 100644
--- a/Documentation/networking/device_drivers/index.rst
+++ b/Documentation/networking/device_drivers/index.rst
@@ -33,6 +33,7 @@ Contents:
    aquantia/atlantic
    chelsio/cxgb
    cirrus/cs89x0
+   davicom/dm9000
 
 .. only::  subproject and html
 
-- 
2.25.4

