Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7E4C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFA520704
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686735;
	bh=1tcWBKbHwODMcpHBvb0yrTax8IjC2JFD9olAldecZLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qAd3oiZEcne3kwIC6OAfnQ+RQI9u6DpUVRFQ141GGBG14IG/g9NA1Xh9ZbWzKRLpm
	 mWDlebDa4qohf9bckSGnIwd6DcrRDyccyE4IRQHxvfkkwRE0L0LqsccEyr3QZGWbfH
	 aIPX+nb4qbT/pSa+m2hrp7t569qUeeHotrH5sLnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbgAVJg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:36:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:51808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731035AbgAVJgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:36:20 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 601152467A;
        Wed, 22 Jan 2020 09:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685779;
        bh=1tcWBKbHwODMcpHBvb0yrTax8IjC2JFD9olAldecZLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WeNR49sI7zdTzPk2q9PPMEmsO/uBYSvF6U1WE47jKCqbwDv82u00tAODLYHMX4FD6
         ZpxVpE1uV2G2mwg690VNx6KsyxvTmOvJAZ047UbWNZKum4UrkBLf0RcfFijxuNiSC5
         5wKF+zuFyJ+F/S7ekqhsRaXAY2hWQ7pllbHAcPZA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Meng Li <Meng.Li@windriver.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 76/97] arm64: dts: agilex/stratix10: fix pmu interrupt numbers
Date:   Wed, 22 Jan 2020 10:29:20 +0100
Message-Id: <20200122092808.561812289@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092755.678349497@linuxfoundation.org>
References: <20200122092755.678349497@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinh Nguyen <dinguyen@kernel.org>

[ Upstream commit 210de0e996aee8e360ccc9e173fe7f0a7ed2f695 ]

Fix up the correct interrupt numbers for the PMU unit on Agilex
and Stratix10.

Fixes: 78cd6a9d8e15 ("arm64: dts: Add base stratix 10 dtsi")
Cc: linux-stable <stable@vger.kernel.org>
Reported-by: Meng Li <Meng.Li@windriver.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index e79f3defe002..c2ad4f97cef0 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -56,10 +56,10 @@
 
 	pmu {
 		compatible = "arm,armv8-pmuv3";
-		interrupts = <0 120 8>,
-			     <0 121 8>,
-			     <0 122 8>,
-			     <0 123 8>;
+		interrupts = <0 170 4>,
+			     <0 171 4>,
+			     <0 172 4>,
+			     <0 173 4>;
 		interrupt-affinity = <&cpu0>,
 				     <&cpu1>,
 				     <&cpu2>,
-- 
2.20.1



