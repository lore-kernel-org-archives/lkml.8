Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F80C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 951402070A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ADDI7RP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgFZK3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 06:29:35 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6584 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbgFZK3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 06:29:34 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef5cdaf0000>; Fri, 26 Jun 2020 03:27:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 26 Jun 2020 03:29:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 26 Jun 2020 03:29:34 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Jun
 2020 10:29:33 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 26 Jun 2020 10:29:33 +0000
Received: from sandipan-pc.nvidia.com (Not Verified[10.24.42.163]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ef5ce0c0000>; Fri, 26 Jun 2020 03:29:33 -0700
From:   Sandipan Patra <spatra@nvidia.com>
To:     <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <bbasu@nvidia.com>, <kyarlagadda@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sandipan Patra <spatra@nvidia.com>
Subject: [PATCH] soc/tegra: Add Tegra Soc Version support
Date:   Fri, 26 Jun 2020 15:59:29 +0530
Message-ID: <1593167369-25901-1-git-send-email-spatra@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593167279; bh=7cjKs1cB/crFEXpLHx7HRhQ2ahnYIqDjrNTb6qpUink=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=ADDI7RP+SPERRsk/RWfebfJ2/OGRbg/u5M9nNPPcRIk97L7VDq2j8nQpqW6M4MVqZ
         kpXLcwACt65+xv8Ar4HL52MSU1W2xQZ8B8lhuk0CtS8Kj2wjNDZqzLhATRmNftD/Zw
         LSM78rxYVUvlGDbPWdK4SsHottjJjZJH2/gg26jKHhBeeBIQdFBP2qLrUvhI+vauCL
         zIucSbo/yt91cwQltDE4VVd/AMoq1gn/8KoMQMR2MnxlcN8IHzk4AUj7lcXBBf8Kdb
         Pq6sfP+k2cWQ1ZvSZsklx9ajQurrR93X70RSoQDkDX6GwQYXq6YprwlyO01X6SVsxk
         /JXWlwN3kT6Uw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the chip IDs for NVIDIA Tegra186, Tegra194 and Tegra234
SoC family.

Signed-off-by: Sandipan Patra <spatra@nvidia.com>
---
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

