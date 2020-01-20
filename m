Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B0AC33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B36720678
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OK/DzpV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgATOY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:24:26 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8648 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgATOYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 09:24:23 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e25b7ec0002>; Mon, 20 Jan 2020 06:23:40 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 20 Jan 2020 06:24:22 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 20 Jan 2020 06:24:22 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Jan
 2020 14:24:22 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 20 Jan 2020 14:24:22 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e25b8110000>; Mon, 20 Jan 2020 06:24:22 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <perex@perex.cz>, <tiwai@suse.com>, <robh+dt@kernel.org>
CC:     <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <mkumard@nvidia.com>,
        <viswanathl@nvidia.com>, <rlokhande@nvidia.com>,
        <dramesh@nvidia.com>, <atalambedu@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 9/9] arm64: tegra: enable AHUB modules for few Tegra chips
Date:   Mon, 20 Jan 2020 19:53:18 +0530
Message-ID: <1579530198-13431-10-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579530198-13431-1-git-send-email-spujar@nvidia.com>
References: <1579530198-13431-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579530220; bh=QLJog4DfYyxTa/pGhw8zE2jdA/xz/qI7iFpPR8p4Zno=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=OK/DzpV4HbhmKsexkuMvmA+q3VySwGYKQRrylVrBUtDATeRaxSP5ESUf9CLgPpKfN
         9G/FyJkD+6uAxeRL3vBBRW5hMmIuoggLp6wT/tAdXfrtry2Xm0MOj6jA0Q8q1Wwxmp
         92GGVO6XLpzTmT6S2/UIU4Vnzlypu+AjhMT7fb85Nlu3rgZvtaC1uRrdMGWNjIadMP
         KAA8cINzkNN5xI/RY7pqDCim7t3pKJBYER+EEhPAgl4jM8Zkv5RUxRKSK7STW9dyh9
         X7MPNRU+tq7o/Hx4H774UPIVXKmclkoZJI4o/P+l4ng1ZV8/GzP5r+tj25mWQtbKDT
         YwZn5Mfuir6Ig==
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
index f1de4ff..717993c 100644
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
index 985e7d8..f5d5832 100644
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

