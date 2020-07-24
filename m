Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DD5C433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 16:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E5A620674
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 16:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgGXQEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 12:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgGXQEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 12:04:06 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA797C0619D3;
        Fri, 24 Jul 2020 09:04:05 -0700 (PDT)
Received: from cap.home.8bytes.org (p5b006776.dip0.t-ipconnect.de [91.0.103.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 17C58C5E;
        Fri, 24 Jul 2020 18:04:02 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>,
        hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Stunes <mstunes@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v5 11/75] x86/boot/compressed/64: Disable red-zone usage
Date:   Fri, 24 Jul 2020 18:02:32 +0200
Message-Id: <20200724160336.5435-12-joro@8bytes.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200724160336.5435-1-joro@8bytes.org>
References: <20200724160336.5435-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The x86-64 ABI defines a red-zone on the stack:

  The 128-byte area beyond the location pointed to by %rsp is considered
  to be reserved and shall not be modified by signal or interrupt
  handlers. Therefore, functions may use this area for temporary data
  that is not needed across function calls. In particular, leaf
  functions may use this area for their entire stack frame, rather than
  adjusting the stack pointer in the prologue and epilogue. This area is
  known as the red zone.

This is not compatible with exception handling, because the IRET frame
written by the hardware at the stack pointer and the functions to handle
the exception will overwrite the temporary variables of the interrupted
function, causing undefined behavior. So disable red-zones for the
pre-decompression boot code.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/boot/Makefile            | 2 +-
 arch/x86/boot/compressed/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index fe605205b4ce..4d6a16a47e9f 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -66,7 +66,7 @@ targets += cpustr.h
 
 # ---------------------------------------------------------------------------
 
-KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP
+KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP -mno-red-zone
 KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
 KBUILD_CFLAGS	+= $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 5a828fde7a42..416f52ab39ec 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -32,7 +32,7 @@ KBUILD_CFLAGS := -m$(BITS) -O2
 KBUILD_CFLAGS += -fno-strict-aliasing $(call cc-option, -fPIE, -fPIC)
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 cflags-$(CONFIG_X86_32) := -march=i386
-cflags-$(CONFIG_X86_64) := -mcmodel=small
+cflags-$(CONFIG_X86_64) := -mcmodel=small -mno-red-zone
 KBUILD_CFLAGS += $(cflags-y)
 KBUILD_CFLAGS += -mno-mmx -mno-sse
 KBUILD_CFLAGS += $(call cc-option,-ffreestanding)
-- 
2.27.0

