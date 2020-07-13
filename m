Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEEEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 23:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92E1A2137B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 23:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgGMXpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 19:45:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:24613 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgGMXpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 19:45:38 -0400
IronPort-SDR: I6EppEDsVgJH+g2g+OknSX4UDP4IO5Ua4/3gkVAMQ6vbSmaNaMx6vApZ+9xxlfXcBRNIfLzehO
 HjH/GS0MxEkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="233607085"
X-IronPort-AV: E=Sophos;i="5.75,349,1589266800"; 
   d="scan'208";a="233607085"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 16:45:37 -0700
IronPort-SDR: Kn5c0eppcv/+I+CBXbdhsKMm9ww93BO3a1BtOr84OLqvCUZqDFUcbto6KorA635qVJGYP4mDx1
 msDKcKqUo4Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,349,1589266800"; 
   d="scan'208";a="307650546"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jul 2020 16:45:37 -0700
Date:   Mon, 13 Jul 2020 16:45:28 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     hpa@zytor.com
Cc:     Brendan Shanks <bshanks@codeweavers.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, ebiederm@xmission.com,
        andi@notmuch.email, Babu.Moger@amd.com
Subject: Re: [PATCH v5] x86/umip: Add emulation/spoofing for SLDT and STR
 instructions
Message-ID: <20200713234528.GA21221@ranerica-svr.sc.intel.com>
References: <20200710224525.21966-1-bshanks@codeweavers.com>
 <85F5E233-6C81-419F-8FE2-D9B93169E4DA@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85F5E233-6C81-419F-8FE2-D9B93169E4DA@zytor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 11, 2020 at 02:49:54PM -0700, hpa@zytor.com wrote:
> On July 10, 2020 3:45:25 PM PDT, Brendan Shanks <bshanks@codeweavers.com> wrote:
> >Add emulation/spoofing of SLDT and STR for both 32- and 64-bit
> >processes.
> >
> >Wine users have found a small number of Windows apps using SLDT that
> >were crashing when run on UMIP-enabled systems.
> >
> >Reported-by: Andreas Rammhold <andi@notmuch.email>
> >Originally-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> >Signed-off-by: Brendan Shanks <bshanks@codeweavers.com>
> >---
> >
> >v5: Capitalize instruction names in comments.
> >
> > arch/x86/kernel/umip.c | 40 +++++++++++++++++++++++++++-------------
> > 1 file changed, 27 insertions(+), 13 deletions(-)
> >
> >diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
> >index 8d5cbe1bbb3b..2c304fd0bb1a 100644
> >--- a/arch/x86/kernel/umip.c
> >+++ b/arch/x86/kernel/umip.c
> >@@ -45,11 +45,12 @@
> >* value that, lies close to the top of the kernel memory. The limit for
> >the GDT
> >  * and the IDT are set to zero.
> >  *
> >- * Given that SLDT and STR are not commonly used in programs that run
> >on WineHQ
> >- * or DOSEMU2, they are not emulated.
> >- *
> >- * The instruction smsw is emulated to return the value that the
> >register CR0
> >+ * The instruction SMSW is emulated to return the value that the
> >register CR0
> >  * has at boot time as set in the head_32.
> >+ * SLDT and STR are emulated to return the values that the kernel
> >programmatically
> >+ * assigns:
> >+ * - SLDT returns (GDT_ENTRY_LDT * 8) if an LDT has been set, 0 if
> >not.
> >+ * - STR returns (GDT_ENTRY_TSS * 8).
> >  *
> >  * Emulation is provided for both 32-bit and 64-bit processes.
> >  *
> >@@ -244,16 +245,34 @@ static int emulate_umip_insn(struct insn *insn,
> >int umip_inst,
> > 		*data_size += UMIP_GDT_IDT_LIMIT_SIZE;
> > 		memcpy(data, &dummy_limit, UMIP_GDT_IDT_LIMIT_SIZE);
> > 
> >-	} else if (umip_inst == UMIP_INST_SMSW) {
> >-		unsigned long dummy_value = CR0_STATE;
> >+	} else if (umip_inst == UMIP_INST_SMSW || umip_inst == UMIP_INST_SLDT
> >||
> >+		   umip_inst == UMIP_INST_STR) {
> >+		unsigned long dummy_value;
> >+
> >+		if (umip_inst == UMIP_INST_SMSW) {
> >+			dummy_value = CR0_STATE;
> >+		} else if (umip_inst == UMIP_INST_STR) {
> >+			dummy_value = GDT_ENTRY_TSS * 8;
> >+		} else if (umip_inst == UMIP_INST_SLDT) {
> >+#ifdef CONFIG_MODIFY_LDT_SYSCALL
> >+			down_read(&current->mm->context.ldt_usr_sem);
> >+			if (current->mm->context.ldt)
> >+				dummy_value = GDT_ENTRY_LDT * 8;
> >+			else
> >+				dummy_value = 0;
> >+			up_read(&current->mm->context.ldt_usr_sem);
> >+#else
> >+			dummy_value = 0;
> >+#endif
> >+		}
> > 
> > 		/*
> >-		 * Even though the CR0 register has 4 bytes, the number
> >+		 * For these 3 instructions, the number
> > 		 * of bytes to be copied in the result buffer is determined
> > 		 * by whether the operand is a register or a memory location.
> > 		 * If operand is a register, return as many bytes as the operand
> > 		 * size. If operand is memory, return only the two least
> >-		 * siginificant bytes of CR0.
> >+		 * siginificant bytes.
> > 		 */
> > 		if (X86_MODRM_MOD(insn->modrm.value) == 3)
> > 			*data_size = insn->opnd_bytes;
> >@@ -261,7 +280,6 @@ static int emulate_umip_insn(struct insn *insn, int
> >umip_inst,
> > 			*data_size = 2;
> > 
> > 		memcpy(data, &dummy_value, *data_size);
> >-	/* STR and SLDT  are not emulated */
> > 	} else {
> > 		return -EINVAL;
> > 	}
> >@@ -383,10 +401,6 @@ bool fixup_umip_exception(struct pt_regs *regs)
> >	umip_pr_warn(regs, "%s instruction cannot be used by applications.\n",
> > 			umip_insns[umip_inst]);
> > 
> >-	/* Do not emulate (spoof) SLDT or STR. */
> >-	if (umip_inst == UMIP_INST_STR || umip_inst == UMIP_INST_SLDT)
> >-		return false;
> >-
> >	umip_pr_warn(regs, "For now, expensive software emulation returns the
> >result.\n");
> > 
> > 	if (emulate_umip_insn(&insn, umip_inst, dummy_data, &dummy_data_size,
> 
> It's there any reason for SLDT to not *always* return a fixed value? "An LDT has been assigned" is formally a kernel internal property, separate from the property of whenever there are user space enteies in the LDT.

But isn't it true that sldt returns 0 if the application has not set an
LDT and non-zero otherwise?

In native_set_ldt() I see that the the LDT register is set to 0 if the
table has no entries and to GDT_ENTRY_LDT*8 otherwise.

Please correct me if I understand this wrong.

Thanks and BR,
Ricardo
