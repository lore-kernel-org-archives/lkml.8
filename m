Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1D6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 05:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09565207ED
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 05:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="o4Vu2bQN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgEZFGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 01:06:19 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1452 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgEZFGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 01:06:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ecca3770000>; Mon, 25 May 2020 22:04:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 25 May 2020 22:06:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 25 May 2020 22:06:17 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 May
 2020 05:06:17 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 26 May 2020 05:06:17 +0000
Received: from sandipan-pc.nvidia.com (Not Verified[10.24.42.163]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ecca3c50001>; Mon, 25 May 2020 22:06:16 -0700
From:   Sandipan Patra <spatra@nvidia.com>
To:     <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <u.kleine-koenig@pengutronix.de>, <kamil@wypas.org>,
        <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>
CC:     <bbasu@nvidia.com>, <bbiswas@nvidia.com>,
        <linux-pwm@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sandipan Patra <spatra@nvidia.com>
Subject: [PATCH 2/2] arm64: tegra: Add pwm-fan profile settings
Date:   Tue, 26 May 2020 10:36:05 +0530
Message-ID: <1590469565-14953-2-git-send-email-spatra@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590469565-14953-1-git-send-email-spatra@nvidia.com>
References: <1590469565-14953-1-git-send-email-spatra@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590469495; bh=XQiGWOGFzg3l+QIfS45QIJAE9J403LC3AAuTqpFbPj4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=o4Vu2bQNYOmORHo3E4N3VM2YnDjSdCgPiPw+JT6WKKvUWogGR9uX/a4JK4FFCginm
         6CWpkHmRz4bGTKPJNCOZrwuGReH9xMH0lXc0U+Mn2G5rZ7OB3Sx2N3ZCNb9BxhFGvR
         c5pCdGGcvjVG6YSyWjtNtCz1LC02QTOSrq14lBSfU3vAv0eSOkJb6hh4zLYXompGPO
         WulcGOZdMuNW3TO0iELI3PdMgAYaCeu24gSqShSewxs445f5ONx7NWrgioGwMdV+8H
         vlsDE6RVrgdofNftW6VDCP0WXXXm2gHRUdxVFag8QNf2O+2mabB+H6f7zXfQGO+QIH
         3JJ/0i9Zog9AQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for profiles in device tree to allow
different fan settings for trip point temp/hyst/pwm.

Signed-off-by: Sandipan Patra <spatra@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
index e15d1ea..ff2b980 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
@@ -219,10 +219,19 @@
 
 	fan: fan {
 		compatible = "pwm-fan";
-		pwms = <&pwm4 0 45334>;
-
-		cooling-levels = <0 64 128 255>;
 		#cooling-cells = <2>;
+		pwms = <&pwm4 0 45334>;
+		profiles {
+			default = "quiet";
+			quiet {
+				state_cap = <4>;
+				cooling-levels = <0 77 120 160 255 255 255 255 255 255>;
+			};
+			cool {
+				state_cap = <4>;
+				cooling-levels = <0 77 120 160 255 255 255 255 255 255>;
+			};
+		};
 	};
 
 	gpio-keys {
-- 
2.7.4

