Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A1CC33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBD9205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699054;
	bh=s7Eug05bdiIlbMdyu6b3KiI5dqFWE03BlqSQCZUnISo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o4g6jjS2+13bJdQEp+2lFjm4y7n+KT0B0JLVyc4RjJg5YLB7fSEKJHRa1erwrOdk3
	 CaBReKSMn7hVDt2Sr5jkp9KOmQ80Gx7EYNk/JoGvS7g+2jTcz3lraSnxasynD8xVPP
	 cgICeLCLmWtq20IedwD7/RKZBWE5fYCTgjmm7hS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgAVNRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:17:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:32920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgAVNRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:17:32 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C41A205F4;
        Wed, 22 Jan 2020 13:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699052;
        bh=s7Eug05bdiIlbMdyu6b3KiI5dqFWE03BlqSQCZUnISo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZCSpVF2TXDGj/gVegg7/BUOjyQX8kAWgpu7Gl1Qc5XUHksSBfplIfcVuZFijenW5Q
         srUudMkydID11sqTe6qRtB6B4lULR4/bidFdIxBuiH06mbAGp9xKbBj7WRW1An7G9s
         LyLRB3B+wV4VuSI0awNwEwrUqwEDA4hUnkSAx1sM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Meng Li <Meng.Li@windriver.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 5.4 028/222] arm64: dts: agilex/stratix10: fix pmu interrupt numbers
Date:   Wed, 22 Jan 2020 10:26:54 +0100
Message-Id: <20200122092835.470566254@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinh Nguyen <dinguyen@kernel.org>

commit 210de0e996aee8e360ccc9e173fe7f0a7ed2f695 upstream.

Fix up the correct interrupt numbers for the PMU unit on Agilex
and Stratix10.

Fixes: 78cd6a9d8e15 ("arm64: dts: Add base stratix 10 dtsi")
Cc: linux-stable <stable@vger.kernel.org>
Reported-by: Meng Li <Meng.Li@windriver.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi |    8 ++++----
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi     |    8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -61,10 +61,10 @@
 
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
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -47,10 +47,10 @@
 
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


