Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A25DC33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13AC2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lOrYLvb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgANHYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 02:24:31 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13193 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbgANHYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 02:24:30 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1d6c770000>; Mon, 13 Jan 2020 23:23:35 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 Jan 2020 23:24:29 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 Jan 2020 23:24:29 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Jan
 2020 07:24:29 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 14 Jan 2020 07:24:29 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.169.242]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e1d6cac0001>; Mon, 13 Jan 2020 23:24:28 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <spujar@nvidia.com>, <josephl@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 01/22] dt-bindings: clock: tegra: Add IDs for OSC clocks
Date:   Mon, 13 Jan 2020 23:24:06 -0800
Message-ID: <1578986667-16041-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
References: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578986615; bh=4p5PIBxwtEEfb+01/btqQjCdO4ySfH88+0attSXq/Pk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=lOrYLvb7LgZ1K1W05iTx9b0R8ntz/4WBhu/HQ0tBYteWT49Q1o3KsRzE9DdOPi+Xx
         jGEBOq2qv0K9KvbtFH5vefUVycWLpvzFBqjmygDLEuhMJ0B8WK7QpXMn5mk3lpEm5x
         0sySKNIyhBC4y1VKf7kH1eIVNNUseylTDgt2XBL9YTEjZrfzF90RYHNrMxkdv1dI1e
         tvImJSIfYBKG2CPawkPWRbMIAKm6LZL5cCg1IWLBQBQEKTYs8JxQNxeVq4ztQm5rSd
         FB6M2WlI3I//K9PuY4G+/o59ZyR+VT/oKIWU4UsJwgjinxM7nfOc6fDGq00urOAKlq
         W0KR87nVzEykw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra has OSC, OSC_DIV2 and OSC_DIV4 clocks from OSC pads which are
the possible parents of Tegra PMC clocks clk_out_1, clk_out_2, and
clk_out_3 for Tegra30 through Tegra210.

So, this patch adds ids for these clocks.

Tested-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 include/dt-bindings/clock/tegra114-car.h        | 4 +++-
 include/dt-bindings/clock/tegra124-car-common.h | 4 +++-
 include/dt-bindings/clock/tegra210-car.h        | 4 +++-
 include/dt-bindings/clock/tegra30-car.h         | 4 +++-
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/dt-bindings/clock/tegra114-car.h b/include/dt-bindings/clock/tegra114-car.h
index bb5c2c999c05..df59aaf5bf34 100644
--- a/include/dt-bindings/clock/tegra114-car.h
+++ b/include/dt-bindings/clock/tegra114-car.h
@@ -228,6 +228,8 @@
 #define TEGRA114_CLK_CLK_M 201
 #define TEGRA114_CLK_CLK_M_DIV2 202
 #define TEGRA114_CLK_CLK_M_DIV4 203
+#define TEGRA114_CLK_OSC_DIV2 202
+#define TEGRA114_CLK_OSC_DIV4 203
 #define TEGRA114_CLK_PLL_REF 204
 #define TEGRA114_CLK_PLL_C 205
 #define TEGRA114_CLK_PLL_C_OUT1 206
@@ -274,7 +276,7 @@
 #define TEGRA114_CLK_CLK_OUT_2 246
 #define TEGRA114_CLK_CLK_OUT_3 247
 #define TEGRA114_CLK_BLINK 248
-/* 249 */
+#define TEGRA114_CLK_OSC 249
 /* 250 */
 /* 251 */
 #define TEGRA114_CLK_XUSB_HOST_SRC 252
diff --git a/include/dt-bindings/clock/tegra124-car-common.h b/include/dt-bindings/clock/tegra124-car-common.h
index 0c4f5be0a742..2a9acd592bff 100644
--- a/include/dt-bindings/clock/tegra124-car-common.h
+++ b/include/dt-bindings/clock/tegra124-car-common.h
@@ -227,6 +227,8 @@
 #define TEGRA124_CLK_CLK_M 201
 #define TEGRA124_CLK_CLK_M_DIV2 202
 #define TEGRA124_CLK_CLK_M_DIV4 203
+#define TEGRA124_CLK_OSC_DIV2 202
+#define TEGRA124_CLK_OSC_DIV4 203
 #define TEGRA124_CLK_PLL_REF 204
 #define TEGRA124_CLK_PLL_C 205
 #define TEGRA124_CLK_PLL_C_OUT1 206
@@ -273,7 +275,7 @@
 #define TEGRA124_CLK_CLK_OUT_2 246
 #define TEGRA124_CLK_CLK_OUT_3 247
 #define TEGRA124_CLK_BLINK 248
-/* 249 */
+#define TEGRA124_CLK_OSC 249
 /* 250 */
 /* 251 */
 #define TEGRA124_CLK_XUSB_HOST_SRC 252
diff --git a/include/dt-bindings/clock/tegra210-car.h b/include/dt-bindings/clock/tegra210-car.h
index 44f60623f99b..7a8f10b9a66d 100644
--- a/include/dt-bindings/clock/tegra210-car.h
+++ b/include/dt-bindings/clock/tegra210-car.h
@@ -262,6 +262,8 @@
 #define TEGRA210_CLK_CLK_M 233
 #define TEGRA210_CLK_CLK_M_DIV2 234
 #define TEGRA210_CLK_CLK_M_DIV4 235
+#define TEGRA210_CLK_OSC_DIV2 234
+#define TEGRA210_CLK_OSC_DIV4 235
 #define TEGRA210_CLK_PLL_REF 236
 #define TEGRA210_CLK_PLL_C 237
 #define TEGRA210_CLK_PLL_C_OUT1 238
@@ -355,7 +357,7 @@
 #define TEGRA210_CLK_PLL_A_OUT_ADSP 323
 #define TEGRA210_CLK_PLL_A_OUT0_OUT_ADSP 324
 /* 325 */
-/* 326 */
+#define TEGRA210_CLK_OSC 326
 /* 327 */
 /* 328 */
 /* 329 */
diff --git a/include/dt-bindings/clock/tegra30-car.h b/include/dt-bindings/clock/tegra30-car.h
index 3c90f1535551..7b542c10fc27 100644
--- a/include/dt-bindings/clock/tegra30-car.h
+++ b/include/dt-bindings/clock/tegra30-car.h
@@ -196,6 +196,8 @@
 #define TEGRA30_CLK_CLK_M 171
 #define TEGRA30_CLK_CLK_M_DIV2 172
 #define TEGRA30_CLK_CLK_M_DIV4 173
+#define TEGRA30_CLK_OSC_DIV2 172
+#define TEGRA30_CLK_OSC_DIV4 173
 #define TEGRA30_CLK_PLL_REF 174
 #define TEGRA30_CLK_PLL_C 175
 #define TEGRA30_CLK_PLL_C_OUT1 176
@@ -243,7 +245,7 @@
 #define TEGRA30_CLK_HCLK 217
 #define TEGRA30_CLK_PCLK 218
 /* 219 */
-/* 220 */
+#define TEGRA30_CLK_OSC 220
 /* 221 */
 /* 222 */
 /* 223 */
-- 
2.7.4

