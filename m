Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50C1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 899C82078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JO2qFpcL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kaDmGAGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730608AbgHTR1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729448AbgHTR1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:27:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3639FC061385;
        Thu, 20 Aug 2020 10:27:43 -0700 (PDT)
Date:   Thu, 20 Aug 2020 17:27:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597944460;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EneEtsyJ/gl6AXrGRnO0QcF3H1K2WoJHKidgfUg0wQM=;
        b=JO2qFpcLfaw2e7CQG8qBpIU5ajkaIH7TSbjiWeWBVe16AhmbqN5ygzDsIBuO21RANeE3kH
        hntYaWntVq4YcaxksqwiDP7uq59HXmD8/sesbOX0GJkyeeIqotkjSTyBhC/+Y5fuq4P6zE
        RAfC25kkZocEI3FWWZv5AB2pP57apm5+XvG9AQvwQBBW0BUFJOaTAegc4qCbARjlOxoRbI
        eTX9VfIKVtLm/f/BiLhFeuclDvdcszt2kg67M18SCnSV/hlpqt8OePaZFXoa9S8umsLEpq
        LW16MwV7FhczcSVoOZm3rsEUnYsykVbPwTZ7ppqNpNYWJblB6NvPNKt320tS8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597944460;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EneEtsyJ/gl6AXrGRnO0QcF3H1K2WoJHKidgfUg0wQM=;
        b=kaDmGAGYnIJwVEYgwYd4NkSIeiGxZJoIR7LazPueHUMVkgLa6qxFq6ES2Fhm1O20EtgEvu
        Xz8YDVq3EWEXjrDg==
From:   "tip-bot2 for Brendan Shanks" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/umip: Add emulation/spoofing for SLDT and STR instructions
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Andreas Rammhold <andi@notmuch.email>,
        Brendan Shanks <bshanks@codeweavers.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200710224525.21966-1-bshanks@codeweavers.com>
References: <20200710224525.21966-1-bshanks@codeweavers.com>
MIME-Version: 1.0
Message-ID: <159794445764.3192.12431631641611015648.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     b91e7089ae70d2f7c81a4456e5b78fef498663d9
Gitweb:        https://git.kernel.org/tip/b91e7089ae70d2f7c81a4456e5b78fef498663d9
Author:        Brendan Shanks <bshanks@codeweavers.com>
AuthorDate:    Fri, 10 Jul 2020 15:45:25 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 20 Aug 2020 19:10:26 +02:00

x86/umip: Add emulation/spoofing for SLDT and STR instructions

Add emulation/spoofing of SLDT and STR for both 32- and 64-bit
processes.

Wine users have found a small number of Windows apps using SLDT that
were crashing when run on UMIP-enabled systems.

Originally-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Reported-by: Andreas Rammhold <andi@notmuch.email>
Signed-off-by: Brendan Shanks <bshanks@codeweavers.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Link: https://lkml.kernel.org/r/20200710224525.21966-1-bshanks@codeweavers.com
---
 arch/x86/kernel/umip.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 8d5cbe1..2c304fd 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -45,11 +45,12 @@
  * value that, lies close to the top of the kernel memory. The limit for the GDT
  * and the IDT are set to zero.
  *
- * Given that SLDT and STR are not commonly used in programs that run on WineHQ
- * or DOSEMU2, they are not emulated.
- *
- * The instruction smsw is emulated to return the value that the register CR0
+ * The instruction SMSW is emulated to return the value that the register CR0
  * has at boot time as set in the head_32.
+ * SLDT and STR are emulated to return the values that the kernel programmatically
+ * assigns:
+ * - SLDT returns (GDT_ENTRY_LDT * 8) if an LDT has been set, 0 if not.
+ * - STR returns (GDT_ENTRY_TSS * 8).
  *
  * Emulation is provided for both 32-bit and 64-bit processes.
  *
@@ -244,16 +245,34 @@ static int emulate_umip_insn(struct insn *insn, int umip_inst,
 		*data_size += UMIP_GDT_IDT_LIMIT_SIZE;
 		memcpy(data, &dummy_limit, UMIP_GDT_IDT_LIMIT_SIZE);
 
-	} else if (umip_inst == UMIP_INST_SMSW) {
-		unsigned long dummy_value = CR0_STATE;
+	} else if (umip_inst == UMIP_INST_SMSW || umip_inst == UMIP_INST_SLDT ||
+		   umip_inst == UMIP_INST_STR) {
+		unsigned long dummy_value;
+
+		if (umip_inst == UMIP_INST_SMSW) {
+			dummy_value = CR0_STATE;
+		} else if (umip_inst == UMIP_INST_STR) {
+			dummy_value = GDT_ENTRY_TSS * 8;
+		} else if (umip_inst == UMIP_INST_SLDT) {
+#ifdef CONFIG_MODIFY_LDT_SYSCALL
+			down_read(&current->mm->context.ldt_usr_sem);
+			if (current->mm->context.ldt)
+				dummy_value = GDT_ENTRY_LDT * 8;
+			else
+				dummy_value = 0;
+			up_read(&current->mm->context.ldt_usr_sem);
+#else
+			dummy_value = 0;
+#endif
+		}
 
 		/*
-		 * Even though the CR0 register has 4 bytes, the number
+		 * For these 3 instructions, the number
 		 * of bytes to be copied in the result buffer is determined
 		 * by whether the operand is a register or a memory location.
 		 * If operand is a register, return as many bytes as the operand
 		 * size. If operand is memory, return only the two least
-		 * siginificant bytes of CR0.
+		 * siginificant bytes.
 		 */
 		if (X86_MODRM_MOD(insn->modrm.value) == 3)
 			*data_size = insn->opnd_bytes;
@@ -261,7 +280,6 @@ static int emulate_umip_insn(struct insn *insn, int umip_inst,
 			*data_size = 2;
 
 		memcpy(data, &dummy_value, *data_size);
-	/* STR and SLDT  are not emulated */
 	} else {
 		return -EINVAL;
 	}
@@ -383,10 +401,6 @@ bool fixup_umip_exception(struct pt_regs *regs)
 	umip_pr_warn(regs, "%s instruction cannot be used by applications.\n",
 			umip_insns[umip_inst]);
 
-	/* Do not emulate (spoof) SLDT or STR. */
-	if (umip_inst == UMIP_INST_STR || umip_inst == UMIP_INST_SLDT)
-		return false;
-
 	umip_pr_warn(regs, "For now, expensive software emulation returns the result.\n");
 
 	if (emulate_umip_insn(&insn, umip_inst, dummy_data, &dummy_data_size,
