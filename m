Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA51AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 14:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A50492075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 14:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pcyjF1S6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DjxMqSSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgHUOWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgHUOVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 10:21:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E91AC061573;
        Fri, 21 Aug 2020 07:21:55 -0700 (PDT)
Date:   Fri, 21 Aug 2020 14:21:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598019710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y2DFeXJNPuolDylpb3isSZwbqmOXxlSF3hwLU1zC9DM=;
        b=pcyjF1S6TrWlazAe6CDtL5jdgrKb6+wE7Go/S1TOIZk5cINZDoYPtXfSy+8oY1l/BrGeIF
        F0xkXoi3I22g2XOcH4AFmKRISZWZ4mcJLtESKGs9V4FA6FgCHzHHHAbK/pauGvzSQS7Ztv
        Ncd/kUgfiaVnXxazkqk2MolUNc0Ol0VUqIMEWZjcE3IIyw+779IdCQhgYLOd2hc7hfXn85
        87/wyQI/KD3mWnK8S184Qo6jpIwNq9mQ0v3KIdtqSpexTU85WTQGmBh7vMpK3BnHB6M0yx
        fVuAqiCIFtTwiYdlT9QLUEvW7WvFLlYf8uM+MwTpyrTt+SH9CLJ2LmUR9xUSNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598019710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y2DFeXJNPuolDylpb3isSZwbqmOXxlSF3hwLU1zC9DM=;
        b=DjxMqSSfcFUTtU/YDCocR6utWvQKs2cn2N0MMIVEJxffTDTnIcP6ApJ9Yp5+0Rkr1G17DW
        4/nJY2UVboehkCDA==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry/64: Do not use RDPID in paranoid entry to
 accomodate KVM
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821105229.18938-1-pbonzini@redhat.com>
References: <20200821105229.18938-1-pbonzini@redhat.com>
MIME-Version: 1.0
Message-ID: <159801970916.3192.4141400413119808645.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     6a3ea3e68b8a8a26c4aaac03432ed92269c9a14e
Gitweb:        https://git.kernel.org/tip/6a3ea3e68b8a8a26c4aaac03432ed92269c9a14e
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 21 Aug 2020 06:52:29 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Aug 2020 16:15:27 +02:00

x86/entry/64: Do not use RDPID in paranoid entry to accomodate KVM

KVM has an optmization to avoid expensive MRS read/writes on
VMENTER/EXIT. It caches the MSR values and restores them either when
leaving the run loop, on preemption or when going out to user space.

The affected MSRs are not required for kernel context operations. This
changed with the recently introduced mechanism to handle FSGSBASE in the
paranoid entry code which has to retrieve the kernel GSBASE value by
accessing per CPU memory. The mechanism needs to retrieve the CPU number
and uses either LSL or RDPID if the processor supports it.

Unfortunately RDPID uses MSR_TSC_AUX which is in the list of cached and
lazily restored MSRs, which means between the point where the guest value
is written and the point of restore, MSR_TSC_AUX contains a random number.

If an NMI or any other exception which uses the paranoid entry path happens
in such a context, then RDPID returns the random guest MSR_TSC_AUX value.

As a consequence this reads from the wrong memory location to retrieve the
kernel GSBASE value. Kernel GS is used to for all regular this_cpu_*()
operations. If the GSBASE in the exception handler points to the per CPU
memory of a different CPU then this has the obvious consequences of data
corruption and crashes.

As the paranoid entry path is the only place which accesses MSR_TSX_AUX
(via RDPID) and the fallback via LSL is not significantly slower, remove
the RDPID alternative from the entry path and always use LSL.

The alternative would be to write MSR_TSC_AUX on every VMENTER and VMEXIT
which would be inflicting massive overhead on that code path.

[ tglx: Rewrote changelog ]

Fixes: eaad981291ee3 ("x86/entry/64: Introduce the FIND_PERCPU_BASE macro")
Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
Debugged-by: Tom Lendacky <thomas.lendacky@amd.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200821105229.18938-1-pbonzini@redhat.com
---
 arch/x86/entry/calling.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 98e4d88..ae9b0d4 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -374,12 +374,14 @@ For 32-bit we have the following conventions - kernel is built with
  * Fetch the per-CPU GSBASE value for this processor and put it in @reg.
  * We normally use %gs for accessing per-CPU data, but we are setting up
  * %gs here and obviously can not use %gs itself to access per-CPU data.
+ *
+ * Do not use RDPID, because KVM loads guest's TSC_AUX on vm-entry and
+ * may not restore the host's value until the CPU returns to userspace.
+ * Thus the kernel would consume a guest's TSC_AUX if an NMI arrives
+ * while running KVM's run loop.
  */
 .macro GET_PERCPU_BASE reg:req
-	ALTERNATIVE \
-		"LOAD_CPU_AND_NODE_SEG_LIMIT \reg", \
-		"RDPID	\reg", \
-		X86_FEATURE_RDPID
+	LOAD_CPU_AND_NODE_SEG_LIMIT \reg
 	andq	$VDSO_CPUNODE_MASK, \reg
 	movq	__per_cpu_offset(, \reg, 8), \reg
 .endm
