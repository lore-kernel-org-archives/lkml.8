Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40761C2BA1B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 01:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A67E20737
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 01:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bzmcSmNV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgDDBZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:25:39 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8305 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgDDBZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 21:25:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e87e1cd0000>; Fri, 03 Apr 2020 18:24:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 03 Apr 2020 18:25:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 03 Apr 2020 18:25:20 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 4 Apr
 2020 01:25:20 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 4 Apr 2020 01:25:19 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.164.193]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e87e1fe0008>; Fri, 03 Apr 2020 18:25:19 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <frankc@nvidia.com>, <hverkuil@xs4all.nl>,
        <sakari.ailus@iki.fi>, <helen.koike@collabora.com>
CC:     <digetx@gmail.com>, <sboyd@kernel.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v6 8/9] dt-bindings: reset: Add ID for Tegra210 VI reset
Date:   Fri, 3 Apr 2020 18:25:06 -0700
Message-ID: <1585963507-12610-9-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585963507-12610-1-git-send-email-skomatineni@nvidia.com>
References: <1585963507-12610-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585963470; bh=L8ndW8+Uxj7JNOHxtp4ihFZmkMPUeCnBtUyBLpK+IFo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=bzmcSmNVAroSrnmECtU5PBrQ2Eh/fvjnZW4I7aH7hOlnKB/iTdeSDAjm7wE9No/gq
         en/JScX0+Ew1uDRLUb429P8yxFh7F0VRCtOCb7+npCTF/B/ZTTBW41nUSwsCfVkxXu
         y8sfrdVcb9ART2NXmkDODVVIVAtuT1F5vVRRwowBgucMm8rNfQdEFvCU6EzTj4ZhJP
         ZOaUGVnNs5Z4tsu4y0fj6h4q0sCpoB1Ggk4k5Jm242O+CejGEJyCjaOuVnfFp7fut2
         fZERG4hxdALX/MyNHWGnR18PmTm9O/beExheOhRfpGcrlCoNUJcdqo0UEZsk1HXZBv
         hLACOS5eTiMPw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds ID for Tegra210 VI controller reset to use with
device tree.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 include/dt-bindings/reset/tegra210-car.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/reset/tegra210-car.h b/include/dt-bindings/reset/tegra210-car.h
index 9dc84ec..8755946 100644
--- a/include/dt-bindings/reset/tegra210-car.h
+++ b/include/dt-bindings/reset/tegra210-car.h
@@ -10,5 +10,6 @@
 #define TEGRA210_RESET(x)		(7 * 32 + (x))
 #define TEGRA210_RST_DFLL_DVCO		TEGRA210_RESET(0)
 #define TEGRA210_RST_ADSP		TEGRA210_RESET(1)
+#define TEGRA210_RST_VI			20
 
 #endif	/* _DT_BINDINGS_RESET_TEGRA210_CAR_H */
-- 
2.7.4

