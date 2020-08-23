Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05978C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 08:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C642320767
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 08:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wPzq5BXX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f7WO+Wpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgHWI07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 04:26:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36840 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgHWI04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 04:26:56 -0400
Date:   Sun, 23 Aug 2020 08:25:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598171214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=wIulMwNvh9KDOFTt4xoI0rBBKxDjZgxmw/KMv8JdaSg=;
        b=wPzq5BXX6JBTPQRa3++Cqz0GtfzAeo9JhyYS2GzLRW+lqk8Ai1oX+TTX17RwZLboHHZ0Ud
        C56FjkJUGoZCR71uPrLlc2r/xJJxQJTEhXcFRkxUMyjZrsFTUSnbQ1ZRpkk67UJ7qCeWPO
        jQZ2S0CUVLsfSWgDBIoqeDpUzfte6B+xZRkQb5x+qdZ32bN4whT1ZkNRLivuaT/GxDl/LA
        7sCdDXUy0duoiHh8pvyPdBwHceRMg8qF50Y0pIjuQWCfqRnkdI5tgNo296RPQZZ1oGf4jK
        A+8MaExAyPu+C/x+gMGd3EHy2VvsnqbpV4Es1dDKf3XNSAoLolXu6kvG5J9uDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598171214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=wIulMwNvh9KDOFTt4xoI0rBBKxDjZgxmw/KMv8JdaSg=;
        b=f7WO+WpvFMdFkdlxW+4eprtPkDOQubCmnGtr0SobEPlTQ+23a5a7QwjW2127YBIsX/01Rq
        7mx//aTj8RQu8iAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v5.9-rc2
References: <159817113401.5783.14776307451257171431.tglx@nanos>
Message-ID: <159817113762.5783.6214320432160748743.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-08-23

up to:  6a3ea3e68b8a: x86/entry/64: Do not use RDPID in paranoid entry to accomodate KVM


A single fix for x86 which removes the RDPID usage from the paranoid entry
path and unconditionally uses LSL to retrieve the CPU number. RDPID depends
on MSR_TSX_AUX.  KVM has an optmization to avoid expensive MRS read/writes
on VMENTER/EXIT. It caches the MSR values and restores them either when
leaving the run loop, on preemption or when going out to user
space. MSR_TSX_AUX is part of that lazy MSR set, so after writing the guest
value and before the lazy restore any exception using the paranoid entry
will read the guest value and use it as CPU number to retrieve the GSBASE
value for the current CPU when FSGSBASE is enabled. As RDPID is only used
in that particular entry path, there is no reason to burden VMENTER/EXIT
with two extra MSR writes. Remove the RDPID optimization, which is not even
backed by numbers from the paranoid entry path instead.


Thanks,

	tglx

------------------>
Sean Christopherson (1):
      x86/entry/64: Do not use RDPID in paranoid entry to accomodate KVM


 arch/x86/entry/calling.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 98e4d8886f11..ae9b0d4615b3 100644
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

