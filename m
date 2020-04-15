Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67777C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 03:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A1D7206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 03:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="J2JBgb+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634738AbgDODAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 23:00:18 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17557 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbgDOC5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 22:57:52 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9678220000>; Tue, 14 Apr 2020 19:57:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 14 Apr 2020 19:57:51 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 14 Apr 2020 19:57:51 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Apr
 2020 02:57:51 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 15 Apr 2020 02:57:51 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.171.241]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e96782e0003>; Tue, 14 Apr 2020 19:57:50 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <frankc@nvidia.com>, <hverkuil@xs4all.nl>,
        <sakari.ailus@iki.fi>, <helen.koike@collabora.com>
CC:     <digetx@gmail.com>, <sboyd@kernel.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v7 8/9] dt-bindings: reset: Add ID for Tegra210 VI reset
Date:   Tue, 14 Apr 2020 19:57:42 -0700
Message-ID: <1586919463-30542-9-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586919463-30542-1-git-send-email-skomatineni@nvidia.com>
References: <1586919463-30542-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586919458; bh=KEZ1lHNwQNYea9tamUq6xhOd3Wa4inGS2Z794lURij8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=J2JBgb+yrKQXv+Yi2bb/8GZfYpN7N6EqfuuPZeCJoBwZhmTgFaNZJSmbo1nAD2t46
         l8fS9e+JYRIPgkDUFzs4jfWdDqcF65GlCQgSexlEcUWHcQPyfeFCMrnVbm2UI8ACha
         t7lbJ/Lm3gcvsAKMNdPH6PlhSlxMtIx3TKMh8j792UfbkLHF3ep3BqObHH0eaNfyS+
         WXwWNIbt2YDLFclYTNRBT1F3Kc9sy013xiQu7GRvuGfYs7kywO++jCsfhpvmdLkJuh
         JHBqHKVaWbWgSdLAMfbdDioy2PzgSt+FXSPgJDTetMoG/Y4IfsVBDq66mgRQUcyvnA
         uA1w/+ySupKNw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds ID for Tegra210 VI controller reset to use with
device tree.

Acked-by: Rob Herring <robh@kernel.org>
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

