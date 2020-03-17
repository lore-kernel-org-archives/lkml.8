Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F82EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0712C20738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584456928;
	bh=EQt8XNF67n6Qz/qYgjsQ6OrZnV8PGeVV9kM2E6Xo1RM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uljFVTGICv39APIMxlxT/w2gZ3G6pAVjiNFstzmOp5Jgh2O3vGcwu/LJGZz/DH6HL
	 oWHi+/noox6ApV+iqkr8ybqXLKrYwEEdU/gvkdygvVQxU5EcKxSYQlL3NO/fek0m7P
	 bTi9CcfQGV9rrN/c9zTvdThxLXcvDEDwO0bRdols=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgCQOyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:54:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbgCQOya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:54:30 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F90F20724;
        Tue, 17 Mar 2020 14:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584456870;
        bh=EQt8XNF67n6Qz/qYgjsQ6OrZnV8PGeVV9kM2E6Xo1RM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RueX3oIjzReC6mbi0x8E5FbR4B6JmuuosRjGYhQfoJP6FUW5I1d87YHLzroI3VqHr
         aTlyextonkTgWKILznM0gPhOolMhHWhoCwjS4lmyZRoAF6OcqNFTe24gxlNj44gMMY
         nLp9fwI1zZvq+RkAkB/vMntVV6cEiLmBE7xn/ETw=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jEDbw-000AMH-Bc; Tue, 17 Mar 2020 15:54:28 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 01/17] docs: amu: supress some Sphinx warnings
Date:   Tue, 17 Mar 2020 15:54:10 +0100
Message-Id: <d12f2ee809ee078c1e5e6d6da6dd9465f35109e2.1584456635.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1584456635.git.mchehab+huawei@kernel.org>
References: <cover.1584456635.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add extra blank lines on some places, in order to avoid those
warnings when building the docs:

    Documentation/arm64/amu.rst:26: WARNING: Unexpected indentation.
    Documentation/arm64/amu.rst:60: WARNING: Unexpected indentation.
    Documentation/arm64/amu.rst:81: WARNING: Unexpected indentation.
    Documentation/arm64/amu.rst:108: WARNING: Unexpected indentation.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/arm64/amu.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/arm64/amu.rst b/Documentation/arm64/amu.rst
index 5057b11100ed..452ec8b115c2 100644
--- a/Documentation/arm64/amu.rst
+++ b/Documentation/arm64/amu.rst
@@ -23,6 +23,7 @@ optional external memory-mapped interface.
 
 Version 1 of the Activity Monitors architecture implements a counter group
 of four fixed and architecturally defined 64-bit event counters.
+
   - CPU cycle counter: increments at the frequency of the CPU.
   - Constant counter: increments at the fixed frequency of the system
     clock.
@@ -57,6 +58,7 @@ counters, only the presence of the extension.
 
 Firmware (code running at higher exception levels, e.g. arm-tf) support is
 needed to:
+
  - Enable access for lower exception levels (EL2 and EL1) to the AMU
    registers.
  - Enable the counters. If not enabled these will read as 0.
@@ -78,6 +80,7 @@ are not trapped in EL2/EL3.
 
 The fixed counters of AMUv1 are accessible though the following system
 register definitions:
+
  - SYS_AMEVCNTR0_CORE_EL0
  - SYS_AMEVCNTR0_CONST_EL0
  - SYS_AMEVCNTR0_INST_RET_EL0
@@ -93,6 +96,7 @@ Userspace access
 ----------------
 
 Currently, access from userspace to the AMU registers is disabled due to:
+
  - Security reasons: they might expose information about code executed in
    secure mode.
  - Purpose: AMU counters are intended for system management use.
@@ -105,6 +109,7 @@ Virtualization
 
 Currently, access from userspace (EL0) and kernelspace (EL1) on the KVM
 guest side is disabled due to:
+
  - Security reasons: they might expose information about code executed
    by other guests or the host.
 
-- 
2.24.1

