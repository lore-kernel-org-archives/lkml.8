Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F25EC11D40
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C42B2465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="iVuQuXM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgBTGgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:36:08 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13783 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgBTGgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:36:08 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4e28b60000>; Wed, 19 Feb 2020 22:35:34 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 19 Feb 2020 22:36:07 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 19 Feb 2020 22:36:07 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Feb
 2020 06:36:06 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 20 Feb 2020 06:36:06 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e4e28d10000>; Wed, 19 Feb 2020 22:36:05 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <perex@perex.cz>, <tiwai@suse.com>, <robh+dt@kernel.org>
CC:     <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <digetx@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <mkumard@nvidia.com>, <viswanathl@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <atalambedu@nvidia.com>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v3 09/10] arm64: tegra: enable AHUB modules for few Tegra chips
Date:   Thu, 20 Feb 2020 12:04:51 +0530
Message-ID: <1582180492-25297-10-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582180492-25297-1-git-send-email-spujar@nvidia.com>
References: <1582180492-25297-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582180534; bh=RhJ+lWyhA2ppFzYLGMVMn9WlbW0bu/BA3FC96dMah5I=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=iVuQuXM7I75fwDpZpwR0VdnwZHosxNgEN1/T8YqMokHHsCGkejXQ425/trk+QrwNy
         EoOeMXFwcf7STV0E7hV85M9faDFBPD7qmgDl4U3aeWmUKNiqcChDBsw6tLaaUtd34b
         4UJqlo0xP7GeccqCN7QAPry1pnZgVry0EaVsm8LdWMcqZYC2+DOkjTO2+1OBOfNZy7
         4V0iM/tGM6yGXvGb4PBRJ9fzQ5dLqUO/aRtervExCRfPIQpvzBfRUnL+w+jbUV6KF5
         p9tfIfX8OL02zLskhkMQiUTDBLz7tNHV10kaOTPj7J959aeckSEDG+Jhs50Rh/pQdW
         pHUdfgttBMVBA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables AHUB, ADMAIF modules for following Tegra platforms.
Along with this specific instances of I/O modules are enabled as per
the board design.

 * Jetson TX1
   - I2S1, I2S2, I2S3, I2S4 and I2S5
   - DMIC1, DMIC2 and DMIC3

 * Jetson TX2
   - I2S1, I2S2, I2S3, I2S4, I2S5 and I2S6
   - DMIC1, DMIC2 and DMIC3
   - DSPK2

 * Jetson AGX Xavier
   - I2S1, I2S2, I2S4 and I2S6
   - DMIC2 and DMIC3
   - DSPK1

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts | 48 ++++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts | 36 ++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts | 40 ++++++++++++++++++
 3 files changed, 124 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
index d7628f5..2f120fb 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
@@ -20,6 +20,54 @@
 		interrupt-controller@2a40000 {
 			status = "okay";
 		};
+
+		ahub@2900800 {
+			status = "okay";
+
+			admaif@290f000 {
+				status = "okay";
+			};
+
+			i2s@2901000 {
+				status = "okay";
+			};
+
+			i2s@2901100 {
+				status = "okay";
+			};
+
+			i2s@2901200 {
+				status = "okay";
+			};
+
+			i2s@2901300 {
+				status = "okay";
+			};
+
+			i2s@2901400 {
+				status = "okay";
+			};
+
+			i2s@2901500 {
+				status = "okay";
+			};
+
+			dmic@2904000 {
+				status = "okay";
+			};
+
+			dmic@2904100 {
+				status = "okay";
+			};
+
+			dmic@2904200 {
+				status = "okay";
+			};
+
+			dspk@2905100 {
+				status = "okay";
+			};
+		};
 	};
 
 	i2c@3160000 {
diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
index f9f874d..a0b2931 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
@@ -21,6 +21,42 @@
 			interrupt-controller@2a40000 {
 				status = "okay";
 			};
+
+			ahub@2900800 {
+				status = "okay";
+
+				admaif@290f000 {
+					status = "okay";
+				};
+
+				i2s@2901000 {
+					status = "okay";
+				};
+
+				i2s@2901100 {
+					status = "okay";
+				};
+
+				i2s@2901300 {
+					status = "okay";
+				};
+
+				i2s@2901500 {
+					status = "okay";
+				};
+
+				dmic@2904100 {
+					status = "okay";
+				};
+
+				dmic@2904200 {
+					status = "okay";
+				};
+
+				dspk@2905000 {
+					status = "okay";
+				};
+			};
 		};
 
 		ddc: i2c@31c0000 {
diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
index a3cafe3..c8d2c21 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
@@ -123,5 +123,45 @@
 		agic@702f9000 {
 			status = "okay";
 		};
+
+		ahub@702d0800 {
+			status = "okay";
+
+			admaif@702d0000 {
+				status = "okay";
+			};
+
+			i2s@702d1000 {
+				status = "okay";
+			};
+
+			i2s@702d1100 {
+				status = "okay";
+			};
+
+			i2s@702d1200 {
+				status = "okay";
+			};
+
+			i2s@702d1300 {
+				status = "okay";
+			};
+
+			i2s@702d1400 {
+				status = "okay";
+			};
+
+			dmic@702d4000 {
+				status = "okay";
+			};
+
+			dmic@702d4100 {
+				status = "okay";
+			};
+
+			dmic@702d4200 {
+				status = "okay";
+			};
+		};
 	};
 };
-- 
2.7.4

