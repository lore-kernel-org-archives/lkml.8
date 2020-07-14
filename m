Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9FDC433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 383EE22B3A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752803;
	bh=mSN9oBUWcUYye87703cbgBNrreVEIMovySJxJEBFV40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A9FxCkOenSWzxx2aLWzPnK7S7LA/gr52uYIfWKMzKCcIgzkCATQs2t/LUo1G2+zBv
	 aOZje3K3k0pMWZU115hSj7/KP9cQyz46Lt4a/ToiQDzpBDF3HtxdCQW3XOzAOdhV/x
	 yNqBoV4tt9oJ/+5li6O/cy+EpxBJ+8dVpk7RjTyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbgGNSxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:53:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730595AbgGNSxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:53:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21AB222CAD;
        Tue, 14 Jul 2020 18:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752793;
        bh=mSN9oBUWcUYye87703cbgBNrreVEIMovySJxJEBFV40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fkBiSEXyIf+KfpdQ0bEBzyvPubJPj9Onp+OtRazXo1STdo8hnGUnoL0qUIcSHmi1Y
         jxmbxmFZ3ga9J4kLJ0gIVEFQJf5FWewTjzk4AoZNVISyuBzTLzj7/9HMa9pkePWcP1
         2QO/0SRfrTAB1rPwhq2Qhx3a8lHu78ZMzG48qcJg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>
Subject: [PATCH 5.4 082/109] KVM: arm64: Annotate hyp NMI-related functions as __always_inline
Date:   Tue, 14 Jul 2020 20:44:25 +0200
Message-Id: <20200714184109.478042495@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184105.507384017@linuxfoundation.org>
References: <20200714184105.507384017@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Elisei <alexandru.elisei@arm.com>

commit 7733306bd593c737c63110175da6c35b4b8bb32c upstream.

The "inline" keyword is a hint for the compiler to inline a function.  The
functions system_uses_irq_prio_masking() and gic_write_pmr() are used by
the code running at EL2 on a non-VHE system, so mark them as
__always_inline to make sure they'll always be part of the .hyp.text
section.

This fixes the following splat when trying to run a VM:

[   47.625273] Kernel panic - not syncing: HYP panic:
[   47.625273] PS:a00003c9 PC:0000ca0b42049fc4 ESR:86000006
[   47.625273] FAR:0000ca0b42049fc4 HPFAR:0000000010001000 PAR:0000000000000000
[   47.625273] VCPU:0000000000000000
[   47.647261] CPU: 1 PID: 217 Comm: kvm-vcpu-0 Not tainted 5.8.0-rc1-ARCH+ #61
[   47.654508] Hardware name: Globalscale Marvell ESPRESSOBin Board (DT)
[   47.661139] Call trace:
[   47.663659]  dump_backtrace+0x0/0x1cc
[   47.667413]  show_stack+0x18/0x24
[   47.670822]  dump_stack+0xb8/0x108
[   47.674312]  panic+0x124/0x2f4
[   47.677446]  panic+0x0/0x2f4
[   47.680407] SMP: stopping secondary CPUs
[   47.684439] Kernel Offset: disabled
[   47.688018] CPU features: 0x240402,20002008
[   47.692318] Memory Limit: none
[   47.695465] ---[ end Kernel panic - not syncing: HYP panic:
[   47.695465] PS:a00003c9 PC:0000ca0b42049fc4 ESR:86000006
[   47.695465] FAR:0000ca0b42049fc4 HPFAR:0000000010001000 PAR:0000000000000000
[   47.695465] VCPU:0000000000000000 ]---

The instruction abort was caused by the code running at EL2 trying to fetch
an instruction which wasn't mapped in the EL2 translation tables. Using
objdump showed the two functions as separate symbols in the .text section.

Fixes: 85738e05dc38 ("arm64: kvm: Unmask PMR before entering guest")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: James Morse <james.morse@arm.com>
Link: https://lore.kernel.org/r/20200618171254.1596055-1-alexandru.elisei@arm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/arch_gicv3.h |    2 +-
 arch/arm64/include/asm/cpufeature.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -109,7 +109,7 @@ static inline u32 gic_read_pmr(void)
 	return read_sysreg_s(SYS_ICC_PMR_EL1);
 }
 
-static inline void gic_write_pmr(u32 val)
+static __always_inline void gic_write_pmr(u32 val)
 {
 	write_sysreg_s(val, SYS_ICC_PMR_EL1);
 }
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -601,7 +601,7 @@ static inline bool system_supports_gener
 		 cpus_have_const_cap(ARM64_HAS_GENERIC_AUTH_IMP_DEF));
 }
 
-static inline bool system_uses_irq_prio_masking(void)
+static __always_inline bool system_uses_irq_prio_masking(void)
 {
 	return IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) &&
 	       cpus_have_const_cap(ARM64_HAS_IRQ_PRIO_MASKING);


