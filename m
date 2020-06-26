Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF01C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 11:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ED7620781
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 11:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="piGvjJWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgFZLp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 07:45:28 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5414 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgFZLp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 07:45:27 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef5dfca0000>; Fri, 26 Jun 2020 04:45:14 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 26 Jun 2020 04:45:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 26 Jun 2020 04:45:26 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Jun
 2020 11:45:26 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 26 Jun 2020 11:45:26 +0000
Received: from sandipan-pc.nvidia.com (Not Verified[10.24.42.163]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ef5dfd30005>; Fri, 26 Jun 2020 04:45:25 -0700
From:   Sandipan Patra <spatra@nvidia.com>
To:     <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <bbasu@nvidia.com>, <kyarlagadda@nvidia.com>, <snikam@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sandipan Patra <spatra@nvidia.com>
Subject: [PATCH V2] soc/tegra: Add defines for Tegra186+ chip IDs
Date:   Fri, 26 Jun 2020 17:15:22 +0530
Message-ID: <1593171922-30632-1-git-send-email-spatra@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593171914; bh=BgWrz3LobCvabK952Ra1bHLyKwA055+LRfD8cMuVjFU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=piGvjJWvAujdlUTO47pRt4xpAFsnMuE5auJjTt2I2Rq7JSml1SCibdypWQyoYymD1
         grhil1tnIcZctuy9mlXFlk0qbB9iqZU1ErCYKYQqqOsoYXd/EboClATmU3x4tWbE5D
         6Ky9PSkRLSUhHc0jWO50ZSSqqEC2F6jEf8wCImC4jttJ5mPsqfpnH2bkYkpCb8aAga
         5ozl2FvVyeQ7z4MSrT5o/AgW8waIBuraXMrSPsJ0rB7HCNVvgcYizXpY1gSPZZ00Aw
         goUXy0jBNZKbAMYjMzac1uQoTYBJsXZjwrAYGY0+uyQT65vteyZ5V2pjZO6uDv67jy
         X9RF3ZsNlMLIQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the chip IDs for NVIDIA Tegra186, Tegra194 and Tegra234
SoC families.

Signed-off-by: Sandipan Patra <spatra@nvidia.com>
---
V2:
  - Precise commit message

 include/soc/tegra/fuse.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/soc/tegra/fuse.h b/include/soc/tegra/fuse.h
index 252ea20..4a5236b 100644
--- a/include/soc/tegra/fuse.h
+++ b/include/soc/tegra/fuse.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2012-2020, NVIDIA CORPORATION.  All rights reserved.
  */
 
 #ifndef __SOC_TEGRA_FUSE_H__
@@ -12,6 +12,9 @@
 #define TEGRA124	0x40
 #define TEGRA132	0x13
 #define TEGRA210	0x21
+#define TEGRA186	0x18
+#define TEGRA194	0x19
+#define TEGRA234	0x23
 
 #define TEGRA_FUSE_SKU_CALIB_0	0xf0
 #define TEGRA30_FUSE_SATA_CALIB	0x124
-- 
2.7.4

