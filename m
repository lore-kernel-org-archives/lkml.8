Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A4BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 01:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A26120672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 01:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594689022;
	bh=Pk8aeQTNGXLd65Y0bMXMm2CwYzXKyRyf2N3Xo9qefVo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zujNDud11oy4YLh9f2RgKLb1MV9Og3yckpZG/cWw/JV2THxATH6XJTTrum+OxIBfs
	 93yvI148IAjhTwnYtmqzxhWT/bbPG7w5Ybn/lguFEA6j9GjNa1f2cxngiyvrJIUYkM
	 nUGTsnoaQouFZTOR/bR4Pf8h2RWpN9qXLdxV8Av4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGNBKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 21:10:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbgGNBKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 21:10:20 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F079421883
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 01:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594689020;
        bh=Pk8aeQTNGXLd65Y0bMXMm2CwYzXKyRyf2N3Xo9qefVo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eNnt/qNNQloZDxji3IdvTtCAdCx9y+RXRFzqDS29Qi5wpf2qIyCHpvCNGDdY7GhND
         1iYvD8JkXdFyOpOr8aiFFWxqzBx+L1EOt/mNsaaSMsR9NtNkOnoSxjikRbvyf7GvF+
         MFwLY+WZfO0U6QsEqjsqQKNiMU8j+Wwe5zgLTJAA=
Received: by mail-wr1-f53.google.com with SMTP id f2so19165821wrp.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 18:10:19 -0700 (PDT)
X-Gm-Message-State: AOAM531RY6fEC7rnM7ufh5iTz0k11bFo95uMH/1V7K9ib3vbpcQgoKit
        jpwpvLE9JC24RBTi0bQP/qyI5CCZvoQYoogOg8+Uog==
X-Google-Smtp-Source: ABdhPJykwHfKVAjkTDdcx2bfj+UOczUsGyGQhFKObrGuskZldy67xMoHufZXZBH/oNkeHxgR3gdTC8cUj/fdSlihrj0=
X-Received: by 2002:adf:a111:: with SMTP id o17mr2109421wro.257.1594689018526;
 Mon, 13 Jul 2020 18:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200710224525.21966-1-bshanks@codeweavers.com>
 <85F5E233-6C81-419F-8FE2-D9B93169E4DA@zytor.com> <20200713234528.GA21221@ranerica-svr.sc.intel.com>
In-Reply-To: <20200713234528.GA21221@ranerica-svr.sc.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 13 Jul 2020 18:10:07 -0700
X-Gmail-Original-Message-ID: <CALCETrVHh4oiGXD3aySFvH52AhJcBpmUaMyocAmEo8PybKq6TQ@mail.gmail.com>
Message-ID: <CALCETrVHh4oiGXD3aySFvH52AhJcBpmUaMyocAmEo8PybKq6TQ@mail.gmail.com>
Subject: Re: [PATCH v5] x86/umip: Add emulation/spoofing for SLDT and STR instructions
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Brendan Shanks <bshanks@codeweavers.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andreas Rammhold <andi@notmuch.email>,
        "Moger, Babu" <Babu.Moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 4:45 PM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> On Sat, Jul 11, 2020 at 02:49:54PM -0700, hpa@zytor.com wrote:
> > On July 10, 2020 3:45:25 PM PDT, Brendan Shanks <bshanks@codeweavers.com> wrote:
> > >Add emulation/spoofing of SLDT and STR for both 32- and 64-bit
> > >processes.
> > >
> > >Wine users have found a small number of Windows apps using SLDT that
> > >were crashing when run on UMIP-enabled systems.
> > >
> > >Reported-by: Andreas Rammhold <andi@notmuch.email>
> > >Originally-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > >Signed-off-by: Brendan Shanks <bshanks@codeweavers.com>
> > >---
> > >
> > >v5: Capitalize instruction names in comments.
> > >
> > > arch/x86/kernel/umip.c | 40 +++++++++++++++++++++++++++-------------
> > > 1 file changed, 27 insertions(+), 13 deletions(-)
> > >
> > >diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
> > >index 8d5cbe1bbb3b..2c304fd0bb1a 100644
> > >--- a/arch/x86/kernel/umip.c
> > >+++ b/arch/x86/kernel/umip.c
> > >@@ -45,11 +45,12 @@
> > >* value that, lies close to the top of the kernel memory. The limit for
> > >the GDT
> > >  * and the IDT are set to zero.
> > >  *
> > >- * Given that SLDT and STR are not commonly used in programs that run
> > >on WineHQ
> > >- * or DOSEMU2, they are not emulated.
> > >- *
> > >- * The instruction smsw is emulated to return the value that the
> > >register CR0
> > >+ * The instruction SMSW is emulated to return the value that the
> > >register CR0
> > >  * has at boot time as set in the head_32.
> > >+ * SLDT and STR are emulated to return the values that the kernel
> > >programmatically
> > >+ * assigns:
> > >+ * - SLDT returns (GDT_ENTRY_LDT * 8) if an LDT has been set, 0 if
> > >not.
> > >+ * - STR returns (GDT_ENTRY_TSS * 8).
> > >  *
> > >  * Emulation is provided for both 32-bit and 64-bit processes.
> > >  *
> > >@@ -244,16 +245,34 @@ static int emulate_umip_insn(struct insn *insn,
> > >int umip_inst,
> > >             *data_size += UMIP_GDT_IDT_LIMIT_SIZE;
> > >             memcpy(data, &dummy_limit, UMIP_GDT_IDT_LIMIT_SIZE);
> > >
> > >-    } else if (umip_inst == UMIP_INST_SMSW) {
> > >-            unsigned long dummy_value = CR0_STATE;
> > >+    } else if (umip_inst == UMIP_INST_SMSW || umip_inst == UMIP_INST_SLDT
> > >||
> > >+               umip_inst == UMIP_INST_STR) {
> > >+            unsigned long dummy_value;
> > >+
> > >+            if (umip_inst == UMIP_INST_SMSW) {
> > >+                    dummy_value = CR0_STATE;
> > >+            } else if (umip_inst == UMIP_INST_STR) {
> > >+                    dummy_value = GDT_ENTRY_TSS * 8;
> > >+            } else if (umip_inst == UMIP_INST_SLDT) {
> > >+#ifdef CONFIG_MODIFY_LDT_SYSCALL
> > >+                    down_read(&current->mm->context.ldt_usr_sem);
> > >+                    if (current->mm->context.ldt)
> > >+                            dummy_value = GDT_ENTRY_LDT * 8;
> > >+                    else
> > >+                            dummy_value = 0;
> > >+                    up_read(&current->mm->context.ldt_usr_sem);
> > >+#else
> > >+                    dummy_value = 0;
> > >+#endif
> > >+            }
> > >
> > >             /*
> > >-             * Even though the CR0 register has 4 bytes, the number
> > >+             * For these 3 instructions, the number
> > >              * of bytes to be copied in the result buffer is determined
> > >              * by whether the operand is a register or a memory location.
> > >              * If operand is a register, return as many bytes as the operand
> > >              * size. If operand is memory, return only the two least
> > >-             * siginificant bytes of CR0.
> > >+             * siginificant bytes.
> > >              */
> > >             if (X86_MODRM_MOD(insn->modrm.value) == 3)
> > >                     *data_size = insn->opnd_bytes;
> > >@@ -261,7 +280,6 @@ static int emulate_umip_insn(struct insn *insn, int
> > >umip_inst,
> > >                     *data_size = 2;
> > >
> > >             memcpy(data, &dummy_value, *data_size);
> > >-    /* STR and SLDT  are not emulated */
> > >     } else {
> > >             return -EINVAL;
> > >     }
> > >@@ -383,10 +401,6 @@ bool fixup_umip_exception(struct pt_regs *regs)
> > >     umip_pr_warn(regs, "%s instruction cannot be used by applications.\n",
> > >                     umip_insns[umip_inst]);
> > >
> > >-    /* Do not emulate (spoof) SLDT or STR. */
> > >-    if (umip_inst == UMIP_INST_STR || umip_inst == UMIP_INST_SLDT)
> > >-            return false;
> > >-
> > >     umip_pr_warn(regs, "For now, expensive software emulation returns the
> > >result.\n");
> > >
> > >     if (emulate_umip_insn(&insn, umip_inst, dummy_data, &dummy_data_size,
> >
> > It's there any reason for SLDT to not *always* return a fixed value? "An LDT has been assigned" is formally a kernel internal property, separate from the property of whenever there are user space enteies in the LDT.
>
> But isn't it true that sldt returns 0 if the application has not set an
> LDT and non-zero otherwise?
>
> In native_set_ldt() I see that the the LDT register is set to 0 if the
> table has no entries and to GDT_ENTRY_LDT*8 otherwise.
>
> Please correct me if I understand this wrong.

You're understanding the LDT right, but that's none of the user's
business.  hpa may well be right -- unless it actively causes
problems, we might as well return a constant value.
