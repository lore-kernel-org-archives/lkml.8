Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB884C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6DCA206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgENOdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:33:15 -0400
Received: from foss.arm.com ([217.140.110.172]:37746 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727930AbgENOc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:32:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9939A1396;
        Thu, 14 May 2020 07:32:58 -0700 (PDT)
Received: from seattle-bionic.arm.com.Home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FCAB3F71E;
        Thu, 14 May 2020 07:32:57 -0700 (PDT)
From:   Oliver Swede <oli.swede@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/13] arm64: Store the arguments to copy_*_user on the stack
Date:   Thu, 14 May 2020 14:32:24 +0000
Message-Id: <20200514143227.605-11-oli.swede@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200514143227.605-1-oli.swede@arm.com>
References: <20200514143227.605-1-oli.swede@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This preserves the initial arguments of the user copy calls so that
they can be restored by the fixup routines.

The values in the relevant three registers (x0/dstin, x1/src,
x2/count) may be modified by the optimized memcpy algorithm for large
copy sizes, and this stores them before it begins executing.

The stack is used instead of other general-purpose registers due to
resource constraints: the algorithm is optimized with respect to the
Procedure Call Standard in the Arm ABI, which assumes that x0-x17
can be used as scratch registers and utilizes all of them during
copying, but leaves alone the rest that have specific uses in the
broader system. As there are no more temporary registers, the stack
can be used to preserve the initial arguments to provide fixup
routines with more information to use in the calculation of the
number of bytes that failed to copy.

The stack pointer is restored to its initial position, either from
the fixup code in the case of a fault, or at the end of the copy
algorithm otherwise (uaccess_finish is extended to restore the sp,
and this code is also moved to copy_template_user.S as it is common
to all of the copy routines that access userspace memory).

Signed-off-by: Oliver Swede <oli.swede@arm.com>
---
 arch/arm64/lib/copy_from_user.S     | 3 ---
 arch/arm64/lib/copy_in_user.S       | 3 ---
 arch/arm64/lib/copy_template_user.S | 6 ++++++
 arch/arm64/lib/copy_to_user.S       | 3 ---
 arch/arm64/lib/copy_user_fixup.S    | 1 +
 5 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
index 9c3805725bea..45009fb07081 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -111,9 +111,6 @@
 
 SYM_FUNC_START(__arch_copy_from_user)
 #include "copy_template_user.S"
-.Luaccess_finish:
-	mov	x0, #0
-	ret
 SYM_FUNC_END(__arch_copy_from_user)
 EXPORT_SYMBOL(__arch_copy_from_user)
 #include "copy_user_fixup.S"
diff --git a/arch/arm64/lib/copy_in_user.S b/arch/arm64/lib/copy_in_user.S
index bdf9bfecf31f..c1647a9b3a22 100644
--- a/arch/arm64/lib/copy_in_user.S
+++ b/arch/arm64/lib/copy_in_user.S
@@ -118,9 +118,6 @@
 
 SYM_FUNC_START(__arch_copy_in_user)
 #include "copy_template_user.S"
-.Luaccess_finish:
-	mov	x0, #0
-	ret
 SYM_FUNC_END(__arch_copy_in_user)
 EXPORT_SYMBOL(__arch_copy_in_user)
 #include "copy_user_fixup.S"
diff --git a/arch/arm64/lib/copy_template_user.S b/arch/arm64/lib/copy_template_user.S
index 3db24dcdab05..1d13daf314b0 100644
--- a/arch/arm64/lib/copy_template_user.S
+++ b/arch/arm64/lib/copy_template_user.S
@@ -21,4 +21,10 @@
 L(copy_non_uao):
 #undef L
 #define L(l) .Lnuao ## l
+	str     x2, [sp, #-16]!		// count
+	stp     x0, x1, [sp, #-16]!	// dstin, src
 #include "copy_template.S"
+.Luaccess_finish:
+	add	sp, sp, 32
+	mov	x0, #0
+	ret
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index b936bc10594e..ac10d2d32b03 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -111,9 +111,6 @@
 
 SYM_FUNC_START(__arch_copy_to_user)
 #include "copy_template_user.S"
-.Luaccess_finish:
-	mov	x0, #0
-	ret
 SYM_FUNC_END(__arch_copy_to_user)
 EXPORT_SYMBOL(__arch_copy_to_user)
 #include "copy_user_fixup.S"
diff --git a/arch/arm64/lib/copy_user_fixup.S b/arch/arm64/lib/copy_user_fixup.S
index 117c37598691..fe9f5ac19605 100644
--- a/arch/arm64/lib/copy_user_fixup.S
+++ b/arch/arm64/lib/copy_user_fixup.S
@@ -5,5 +5,6 @@ addr	.req	x15
 .align	2
 9998:
 	// TODO: add accurate fixup
+	add	sp, sp, 32
 	ret
 
-- 
2.17.1

