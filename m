Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862FDC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6541F20708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gc0fAMPb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/OSTOmhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgGHTxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 15:53:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53434 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgGHTxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 15:53:47 -0400
Message-Id: <20200708195322.344731916@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594238025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qENerA8I1NYDNTLbmvsdZ/rAWI2IBukjDbybqGSssqQ=;
        b=gc0fAMPbSU3zL9Bs/acFj+hz9yYiBq0d3OOqc5MRGE8WxPXGuiuMQaBuxUq45JYmAuoICR
        /kv4Z9EN+/wkOA85iN1BHLDyE63rzZZ6i7HslVzjuSAxvBeRjs1FBc/0ktTl1Adpw891pg
        YqRJ7tFPKuf0w53mgty57JXY4FO5dKT7cTvFRfB4CC2c0ZUmPHeE/WV1hkoku1ssGTqD00
        OtqHu2lzrH+mCM4TlfSrjgaOrAe2HHsUnwplm15H5WVrry1oLo6W6mp2vt9BQPEoLXLmHg
        wqlUS8g8/7N6L5EfytZ4HgL7R8z8fUnAlT2G1U+buy1kR1QtjH8I8XRZjaBvmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594238025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qENerA8I1NYDNTLbmvsdZ/rAWI2IBukjDbybqGSssqQ=;
        b=/OSTOmhI0F9Ns2LuLU4M9LGunENk/fmZBEGTUExRHYK/1UcyLAi1/OFQ+StCGVSzUKvQPj
        rRqNH4Gcucm6qmDg==
Date:   Wed, 08 Jul 2020 21:52:00 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        kvm@vger.kernel.org,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>
Subject: [patch V2 7/7] x86/kvm/vmx: Use native read/write_cr2()
References: <20200708195153.746357686@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

read/write_cr2() go throuh the paravirt XXL indirection, but nested VMX in
a XEN_PV guest is not supported.

Use the native variants.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kvm/vmx/vmx.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6683,13 +6683,13 @@ static noinstr void vmx_vcpu_enter_exit(
 	else if (static_branch_unlikely(&mds_user_clear))
 		mds_clear_cpu_buffers();
 
-	if (vcpu->arch.cr2 != read_cr2())
-		write_cr2(vcpu->arch.cr2);
+	if (vcpu->arch.cr2 != native_read_cr2())
+		native_write_cr2(vcpu->arch.cr2);
 
 	vmx->fail = __vmx_vcpu_run(vmx, (unsigned long *)&vcpu->arch.regs,
 				   vmx->loaded_vmcs->launched);
 
-	vcpu->arch.cr2 = read_cr2();
+	vcpu->arch.cr2 = native_read_cr2();
 
 	/*
 	 * VMEXIT disables interrupts (host state), but tracing and lockdep

