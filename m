Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53E8C2BA1B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 03:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705822080C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 03:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WYUqTBJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgDHDxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 23:53:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgDHDxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 23:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=VZlXPS69mqPnDD5f5q6GFfvEK1EUQzBlAkMBMX1ZF/M=; b=WYUqTBJ4IHsy3qmtIVa7HTHelQ
        F2hR86QMdIWr+gbEsrPWmRrTXMIgCeWjNdlPWfradlM2VgFNHLZaVCbTKl3OFxLkTaxGwDM6DUthT
        uCTcHFndqnHFhoojxxgCsKTi0vuG+mzVnZsZgjZeiaSnOgAv6JK0MImsBeFniZFmZRDJiPK8bZn3W
        edqLNjN7erZx22FJ3yDk6knQdYoafZVzl/wmacMKv+Vv43czDRa0daFqsmeSDRWoogNh9K6x4rC1y
        XJptPCZEtuJ4PeCdXX2lEfJ1a5W/h2VckIhCNE25OT2umGmG4Iti1W15DFzM1siFVYYeHxSbqHpM1
        97TNZ+Yw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jM1mP-0003Tl-AZ; Wed, 08 Apr 2020 03:53:33 +0000
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] Documentation: arm64: fix amu.rst doc warnings
Message-ID: <ffbdd805-7322-1943-38cf-8bb9a2e7fe9e@infradead.org>
Date:   Tue, 7 Apr 2020 20:53:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix bullet list formatting to eliminate doc warnings:

Documentation/arm64/amu.rst:26: WARNING: Unexpected indentation.
Documentation/arm64/amu.rst:60: WARNING: Unexpected indentation.
Documentation/arm64/amu.rst:81: WARNING: Unexpected indentation.
Documentation/arm64/amu.rst:108: WARNING: Unexpected indentation.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 Documentation/arm64/amu.rst |   47 ++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 21 deletions(-)

--- linux-next-20200407.orig/Documentation/arm64/amu.rst
+++ linux-next-20200407/Documentation/arm64/amu.rst
@@ -23,13 +23,14 @@ optional external memory-mapped interfac
 
 Version 1 of the Activity Monitors architecture implements a counter group
 of four fixed and architecturally defined 64-bit event counters.
-  - CPU cycle counter: increments at the frequency of the CPU.
-  - Constant counter: increments at the fixed frequency of the system
-    clock.
-  - Instructions retired: increments with every architecturally executed
-    instruction.
-  - Memory stall cycles: counts instruction dispatch stall cycles caused by
-    misses in the last level cache within the clock domain.
+
+- CPU cycle counter: increments at the frequency of the CPU.
+- Constant counter: increments at the fixed frequency of the system
+  clock.
+- Instructions retired: increments with every architecturally executed
+  instruction.
+- Memory stall cycles: counts instruction dispatch stall cycles caused by
+  misses in the last level cache within the clock domain.
 
 When in WFI or WFE these counters do not increment.
 
@@ -57,11 +58,12 @@ counters, only the presence of the exten
 
 Firmware (code running at higher exception levels, e.g. arm-tf) support is
 needed to:
- - Enable access for lower exception levels (EL2 and EL1) to the AMU
-   registers.
- - Enable the counters. If not enabled these will read as 0.
- - Save/restore the counters before/after the CPU is being put/brought up
-   from the 'off' power state.
+
+- Enable access for lower exception levels (EL2 and EL1) to the AMU
+  registers.
+- Enable the counters. If not enabled these will read as 0.
+- Save/restore the counters before/after the CPU is being put/brought up
+  from the 'off' power state.
 
 When using kernels that have this feature enabled but boot with broken
 firmware the user may experience panics or lockups when accessing the
@@ -78,10 +80,11 @@ are not trapped in EL2/EL3.
 
 The fixed counters of AMUv1 are accessible though the following system
 register definitions:
- - SYS_AMEVCNTR0_CORE_EL0
- - SYS_AMEVCNTR0_CONST_EL0
- - SYS_AMEVCNTR0_INST_RET_EL0
- - SYS_AMEVCNTR0_MEM_STALL_EL0
+
+- SYS_AMEVCNTR0_CORE_EL0
+- SYS_AMEVCNTR0_CONST_EL0
+- SYS_AMEVCNTR0_INST_RET_EL0
+- SYS_AMEVCNTR0_MEM_STALL_EL0
 
 Auxiliary platform specific counters can be accessed using
 SYS_AMEVCNTR1_EL0(n), where n is a value between 0 and 15.
@@ -93,9 +96,10 @@ Userspace access
 ----------------
 
 Currently, access from userspace to the AMU registers is disabled due to:
- - Security reasons: they might expose information about code executed in
-   secure mode.
- - Purpose: AMU counters are intended for system management use.
+
+- Security reasons: they might expose information about code executed in
+  secure mode.
+- Purpose: AMU counters are intended for system management use.
 
 Also, the presence of the feature is not visible to userspace.
 
@@ -105,8 +109,9 @@ Virtualization
 
 Currently, access from userspace (EL0) and kernelspace (EL1) on the KVM
 guest side is disabled due to:
- - Security reasons: they might expose information about code executed
-   by other guests or the host.
+
+- Security reasons: they might expose information about code executed
+  by other guests or the host.
 
 Any attempt to access the AMU registers will result in an UNDEFINED
 exception being injected into the guest.

