Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC144C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90E74206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="eY7tkpL8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbgFISAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:00:12 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:57876 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733123AbgFIRyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZjbHKgM5r9f86QG3jG78V/vbvHdJO4q+ttgn1p1FemY=; b=eY7tkpL8TJvDhbdXGWtD3jveJJ
        otyAaf+ibuUoGSiY2OrxYeVc46xxzrrkJWK0pIdjrx46eU3KQNdGdH88n+g9PIyNrue+3MUSjXCuE
        WYOdnMp5wUJb3UtwF+pkoxN9V/gWicH1FUX5E0p0lRlSJ0NkWlMfDl4iLwSOke9oKZ7A=;
Received: from cpe-107-184-2-226.socal.res.rr.com ([107.184.2.226] helo=zen.bslabs.net)
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <bshanks@codeweavers.com>)
        id 1jiiSI-0001Ur-4N; Tue, 09 Jun 2020 12:54:35 -0500
From:   Brendan Shanks <bshanks@codeweavers.com>
To:     linux-kernel@vger.kernel.org
Cc:     ricardo.neri-calderon@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        ebiederm@xmission.com, andi@notmuch.email, Babu.Moger@amd.com,
        Brendan Shanks <bshanks@codeweavers.com>
Subject: [PATCH v4] x86/umip: Add emulation/spoofing for SLDT and STR instructions
Date:   Tue,  9 Jun 2020 10:54:23 -0700
Message-Id: <20200609175423.31568-1-bshanks@codeweavers.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add emulation/spoofing of SLDT and STR for both 32- and 64-bit
processes.

Wine users have found a small number of Windows apps using SLDT that
were crashing when run on UMIP-enabled systems.

Reported-by: Andreas Rammhold <andi@notmuch.email>
Originally-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Brendan Shanks <bshanks@codeweavers.com>
---

v4: Use braces for every clause of the conditional. I tried a switch(),
but it takes more lines and looks more cluttered (especially with the
#ifdef).
Also replace out-of-date comment at top of file.

 arch/x86/kernel/umip.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 8d5cbe1bbb3b..62f4f0afb979 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -45,11 +45,12 @@
  * value that, lies close to the top of the kernel memory. The limit for the GDT
  * and the IDT are set to zero.
  *
- * Given that SLDT and STR are not commonly used in programs that run on WineHQ
- * or DOSEMU2, they are not emulated.
- *
  * The instruction smsw is emulated to return the value that the register CR0
  * has at boot time as set in the head_32.
+ * sldt and str are emulated to return the values that the kernel programmatically
+ * assigns:
+ * - sldt returns (GDT_ENTRY_LDT * 8) if an LDT has been set, 0 if not.
+ * - str returns (GDT_ENTRY_TSS * 8).
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
-- 
2.26.2

