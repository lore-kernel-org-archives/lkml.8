Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20D9C2D0ED
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FEB206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbgC3LmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 07:42:03 -0400
Received: from foss.arm.com ([217.140.110.172]:51342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728764AbgC3LmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 07:42:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CA73101E;
        Mon, 30 Mar 2020 04:42:02 -0700 (PDT)
Received: from a075553-lin.blr.arm.com (a075553-lin.blr.arm.com [10.162.17.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B84253F52E;
        Mon, 30 Mar 2020 04:42:00 -0700 (PDT)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: [PATCH v2 2/2] arm64: Kconfig: ptrauth: Add binutils version check to fix mismatch
Date:   Mon, 30 Mar 2020 17:11:39 +0530
Message-Id: <1585568499-21585-2-git-send-email-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585568499-21585-1-git-send-email-amit.kachhap@arm.com>
References: <1585568499-21585-1-git-send-email-amit.kachhap@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent addition of ARM64_PTR_AUTH exposed a mismatch issue with binutils.
9.1+ versions of gcc inserts a section note .note.gnu.property but this
can be used properly by binutils version greater than 2.33.1. If older
binutils are used then the following warnings are generated,

aarch64-linux-ld: warning: arch/arm64/kernel/vdso/vgettimeofday.o: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0000000
aarch64-linux-objdump: warning: arch/arm64/lib/csum.o: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0000000
aarch64-linux-nm: warning: .tmp_vmlinux1: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0000000

This patch enables ARM64_PTR_AUTH when gcc and binutils versions are
compatible with each other. Older gcc which do not insert such section
continue to work as before.

This scenario may not occur with clang as a recent commit 3b446c7d27ddd06
("arm64: Kconfig: verify binutils support for ARM64_PTR_AUTH") masks
binutils version lesser then 2.34.

Reported-by: kbuild test robot <lkp@intel.com>
Suggested-by: Vincenzo Frascino <Vincenzo.Frascino@arm.com>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
Changes since v1[1]:
 * Separated GCC and CLANG checks as suggested by Catalin.
 * Added comments in Kconfig entry.

[1]: https://lkml.org/lkml/2020/3/26/626 

 arch/arm64/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e6712b6..4391a4f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1503,7 +1503,10 @@ config ARM64_PTR_AUTH
 	default y
 	depends on !KVM || ARM64_VHE
 	depends on (CC_HAS_SIGN_RETURN_ADDRESS || CC_HAS_BRANCH_PROT_PAC_RET) && AS_HAS_PAC
-	depends on CC_IS_GCC || (CC_IS_CLANG && AS_HAS_CFI_NEGATE_RA_STATE)
+	# GCC 9.1 version inserts a section note .note.gnu.property for PAC
+	# which can be used properly by binutils version 2.33.1 and higher.
+	depends on !CC_IS_GCC || GCC_VERSION < 90100 || LD_VERSION >= 233010000
+	depends on !CC_IS_CLANG || AS_HAS_CFI_NEGATE_RA_STATE
 	depends on (!FUNCTION_GRAPH_TRACER || DYNAMIC_FTRACE_WITH_REGS)
 	help
 	  Pointer authentication (part of the ARMv8.3 Extensions) provides
-- 
2.7.4

