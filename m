Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74985C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5534C221EA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592442898;
	bh=J2w+gquTMvhqzqlR0tLvqdneEX5xmKscX23mghhpHwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NDtW9pwUbOwDKFftfZFtvrtx+QegYBQOFo4d2JsQy1mrBGhfaUqy35wNwgXRdKXOW
	 yN+NyNE1SRg6d+f47t9alnVC19fdn0821AWFu75b+rDD/KZylxihQSSpR04noorTc1
	 bCu7bdE19ivuMBL8InAveTmjoioUhBYqwtEvRv1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbgFRBO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:14:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728892AbgFRBN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:13:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32BBB21924;
        Thu, 18 Jun 2020 01:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442809;
        bh=J2w+gquTMvhqzqlR0tLvqdneEX5xmKscX23mghhpHwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oJJvqkPe1ud1HW6xC4HoaXI0TJ95S8rxMD9tE9jzwJ/uiR6KCkVdFKqKGecF4VrPY
         4IYPXTRqHeZe+c+tDtFnCXU2/kaCAZIggUcscMNBzAgBtB2/ElTt5FtumZ75P1mTim
         q/Ea9arF3g8bRtW/tdcT6ncU7MMpTGHbZGH0D9Pw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 248/388] arm64: tegra: Fix flag for 64-bit resources in 'ranges' property
Date:   Wed, 17 Jun 2020 21:05:45 -0400
Message-Id: <20200618010805.600873-248-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vidya Sagar <vidyas@nvidia.com>

[ Upstream commit 3482a7afb261e2de9269a7f9ad0f4a3a82a83a53 ]

Fix flag in PCIe controllers device-tree nodes 'ranges' property to correctly
represent 64-bit resources.

Fixes: 2602c32f15e7 ("arm64: tegra: Add P2U and PCIe controller nodes to Tegra194 DT")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index f4ede86e32b4..3c928360f4ed 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -1387,7 +1387,7 @@ pcie@14100000 {
 
 		bus-range = <0x0 0xff>;
 		ranges = <0x81000000 0x0  0x30100000 0x0  0x30100000 0x0 0x00100000   /* downstream I/O (1MB) */
-			  0xc2000000 0x12 0x00000000 0x12 0x00000000 0x0 0x30000000   /* prefetchable memory (768MB) */
+			  0xc3000000 0x12 0x00000000 0x12 0x00000000 0x0 0x30000000   /* prefetchable memory (768MB) */
 			  0x82000000 0x0  0x40000000 0x12 0x30000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
 	};
 
@@ -1432,7 +1432,7 @@ pcie@14120000 {
 
 		bus-range = <0x0 0xff>;
 		ranges = <0x81000000 0x0  0x32100000 0x0  0x32100000 0x0 0x00100000   /* downstream I/O (1MB) */
-			  0xc2000000 0x12 0x40000000 0x12 0x40000000 0x0 0x30000000   /* prefetchable memory (768MB) */
+			  0xc3000000 0x12 0x40000000 0x12 0x40000000 0x0 0x30000000   /* prefetchable memory (768MB) */
 			  0x82000000 0x0  0x40000000 0x12 0x70000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
 	};
 
@@ -1477,7 +1477,7 @@ pcie@14140000 {
 
 		bus-range = <0x0 0xff>;
 		ranges = <0x81000000 0x0  0x34100000 0x0  0x34100000 0x0 0x00100000   /* downstream I/O (1MB) */
-			  0xc2000000 0x12 0x80000000 0x12 0x80000000 0x0 0x30000000   /* prefetchable memory (768MB) */
+			  0xc3000000 0x12 0x80000000 0x12 0x80000000 0x0 0x30000000   /* prefetchable memory (768MB) */
 			  0x82000000 0x0  0x40000000 0x12 0xb0000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
 	};
 
@@ -1522,7 +1522,7 @@ pcie@14160000 {
 
 		bus-range = <0x0 0xff>;
 		ranges = <0x81000000 0x0  0x36100000 0x0  0x36100000 0x0 0x00100000   /* downstream I/O (1MB) */
-			  0xc2000000 0x14 0x00000000 0x14 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
+			  0xc3000000 0x14 0x00000000 0x14 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
 			  0x82000000 0x0  0x40000000 0x17 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
 	};
 
@@ -1567,7 +1567,7 @@ pcie@14180000 {
 
 		bus-range = <0x0 0xff>;
 		ranges = <0x81000000 0x0  0x38100000 0x0  0x38100000 0x0 0x00100000   /* downstream I/O (1MB) */
-			  0xc2000000 0x18 0x00000000 0x18 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
+			  0xc3000000 0x18 0x00000000 0x18 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
 			  0x82000000 0x0  0x40000000 0x1b 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
 	};
 
@@ -1616,7 +1616,7 @@ pcie@141a0000 {
 
 		bus-range = <0x0 0xff>;
 		ranges = <0x81000000 0x0  0x3a100000 0x0  0x3a100000 0x0 0x00100000   /* downstream I/O (1MB) */
-			  0xc2000000 0x1c 0x00000000 0x1c 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
+			  0xc3000000 0x1c 0x00000000 0x1c 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
 			  0x82000000 0x0  0x40000000 0x1f 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
 	};
 
-- 
2.25.1

