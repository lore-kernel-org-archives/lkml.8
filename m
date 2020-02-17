Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEF2C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1DF820718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="fd40BdlF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgBQOr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 09:47:28 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41551 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbgBQOr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 09:47:28 -0500
Received: by mail-qk1-f195.google.com with SMTP id d11so16358005qko.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 06:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l4NNnDQyXR42LBMQRBfPRxnO5itE33bk8+h08qVfM+w=;
        b=fd40BdlFc0ZSsGQeaZ/sDzf0NCoa7sKnsBMdIYRd6exfvedBAXmPxjD+g60no3Q+6g
         fMYFizyGDvpUk6u115Uu1daEyTI1abA5x6HK2O73ZeAEggGFoFXJnyvHLl1qdI0923Qi
         8qw4+CYkbk7zhEMRD928oald5Jv2kVN7ANSeCzZJW47a/SIhfYLEO3xMsXJFAYEBGXk/
         A4TjuEyLsgGvM4u1THTaCprKjtf40JdZwl9ZyWd5JkCruDAK4xgdbGuwcFpVCi+AEJQw
         LYqdHE0fY0LQiXNPsGKzRbi4Kynqj+4xQhZmVM4/4M4oWyGI6a1HF8O0X/XBPuMyNk8W
         +NUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l4NNnDQyXR42LBMQRBfPRxnO5itE33bk8+h08qVfM+w=;
        b=ighsA0dojCuFKK8SY6aKYDueTKD9U0I5pl6T+ls84q+OoUXAZv76CRITvXOm8g7nlv
         MEKX/zYcbUHqiPrhiax8YsmyMkZzLHfGHieAzFys+5/9Qp2g2GFMBfsqIUGbIXrCgRAM
         sgpFDU94e180xCEYVkAexH81HruZCaidFcxG8ocy7CHfv6kQ6s6wUa2tKSYQUIXGtJfO
         2NCDWOW9SUu0c/OppEBFuxEtMRfH13G+1dOl/8RVMlkxfRtC6zFFfRb8F2Q4t+O/13T/
         WbbUyQ2v+9B51QT3q6UrZgLivYzC5f2DNEFr0MkHnp/Mtk+BoN7CbyBqfpqZI5cIpkHT
         i94A==
X-Gm-Message-State: APjAAAXReFmfV+4i2Av7gqjY3KEHJvpJylm/y+fEDN8Et0Iuu2hsHiay
        LehuQQFQ9lCepR0axac6xizJ5g==
X-Google-Smtp-Source: APXvYqz83/y4bnkuJtKKYBPAPh8fNlPsTpp9aGlnSnYWpC6/muLktI2S/3H8NWew6d/CD/Cyu5+Jnw==
X-Received: by 2002:a37:e81:: with SMTP id 123mr11048325qko.193.1581950846372;
        Mon, 17 Feb 2020 06:47:26 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h13sm281713qtu.23.2020.02.17.06.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2020 06:47:25 -0800 (PST)
Message-ID: <1581950844.7365.82.camel@lca.pw>
Subject: Re: [PATCH] kvm/emulate: fix a -Werror=cast-function-type
From:   Qian Cai <cai@lca.pw>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 17 Feb 2020 09:47:24 -0500
In-Reply-To: <28680b99-d043-ee02-dab3-b5ce8c2e625b@redhat.com>
References: <1581695768-6123-1-git-send-email-cai@lca.pw>
         <20200214165923.GA20690@linux.intel.com> <1581700124.7365.70.camel@lca.pw>
         <CALMp9eTRn-46oKg5a9h79EZOvHGwT=8ZZN15Zmy5NUYsd+r8wQ@mail.gmail.com>
         <1581707646.7365.72.camel@lca.pw>
         <28680b99-d043-ee02-dab3-b5ce8c2e625b@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-14 at 20:33 +0100, Paolo Bonzini wrote:
> On 14/02/20 20:14, Qian Cai wrote:
> > > It seems misguided to define a local variable just to get an implicit
> > > cast from (void *) to (fastop_t). Sean's first suggestion gives you
> > > the same implicit cast without the local variable. The second
> > > suggestion makes both casts explicit.
> > 
> > OK, I'll do a v2 using the first suggestion which looks simpler once it passed
> > compilations.
> > 
> 
> Another interesting possibility is to use an unnamed union of a
> (*execute) function pointer and a (*fastop) function pointer.
> 

This?

diff --git a/arch/x86/include/asm/kvm_emulate.h
b/arch/x86/include/asm/kvm_emulate.h
index 03946eb3e2b9..2a8f2bd2e5cf 100644
--- a/arch/x86/include/asm/kvm_emulate.h
+++ b/arch/x86/include/asm/kvm_emulate.h
@@ -292,6 +292,14 @@ enum x86emul_mode {
 #define X86EMUL_SMM_MASK             (1 << 6)
 #define X86EMUL_SMM_INSIDE_NMI_MASK  (1 << 7)
 
+/*
+ * fastop functions are declared as taking a never-defined fastop parameter,
+ * so they can't be called from C directly.
+ */
+struct fastop;
+
+typedef void (*fastop_t)(struct fastop *);
+
 struct x86_emulate_ctxt {
 	const struct x86_emulate_ops *ops;
 
@@ -324,7 +332,10 @@ struct x86_emulate_ctxt {
 	struct operand src;
 	struct operand src2;
 	struct operand dst;
-	int (*execute)(struct x86_emulate_ctxt *ctxt);
+	union {
+		int (*execute)(struct x86_emulate_ctxt *ctxt);
+		fastop_t fop;
+	};
 	int (*check_perm)(struct x86_emulate_ctxt *ctxt);
 	/*
 	 * The following six fields are cleared together,
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index ddbc61984227..dd19fb3539e0 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -191,25 +191,6 @@
 #define NR_FASTOP (ilog2(sizeof(ulong)) + 1)
 #define FASTOP_SIZE 8
 
-/*
- * fastop functions have a special calling convention:
- *
- * dst:    rax        (in/out)
- * src:    rdx        (in/out)
- * src2:   rcx        (in)
- * flags:  rflags     (in/out)
- * ex:     rsi        (in:fastop pointer, out:zero if exception)
- *
- * Moreover, they are all exactly FASTOP_SIZE bytes long, so functions for
- * different operand sizes can be reached by calculation, rather than a jump
- * table (which would be bigger than the code).
- *
- * fastop functions are declared as taking a never-defined fastop parameter,
- * so they can't be called from C directly.
- */
-
-struct fastop;
-
 struct opcode {
 	u64 flags : 56;
 	u64 intercept : 8;
@@ -311,8 +292,19 @@ static void invalidate_registers(struct x86_emulate_ctxt
*ctxt)
 #define ON64(x)
 #endif
 
-typedef void (*fastop_t)(struct fastop *);
-
+/*
+ * fastop functions have a special calling convention:
+ *
+ * dst:    rax        (in/out)
+ * src:    rdx        (in/out)
+ * src2:   rcx        (in)
+ * flags:  rflags     (in/out)
+ * ex:     rsi        (in:fastop pointer, out:zero if exception)
+ *
+ * Moreover, they are all exactly FASTOP_SIZE bytes long, so functions for
+ * different operand sizes can be reached by calculation, rather than a jump
+ * table (which would be bigger than the code).
+ */
 static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 
 #define __FOP_FUNC(name) \
@@ -5683,7 +5675,7 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
 
 	if (ctxt->execute) {
 		if (ctxt->d & Fastop)
-			rc = fastop(ctxt, (fastop_t)ctxt->execute);
+			rc = fastop(ctxt, ctxt->fop);
 		else
 			rc = ctxt->execute(ctxt);
 		if (rc != X86EMUL_CONTINUE)
