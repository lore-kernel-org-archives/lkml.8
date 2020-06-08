Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABD1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 18:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FA682078D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 18:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="PZ4/HvdN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgFHSPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 14:15:11 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:36646 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFHSPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 14:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AtJTdkGcem0MKnYBuQj5wimwQb7HemSYIZc6Qs/sz9M=; b=PZ4/HvdNcrXomQXlNjDnLLTMX2
        HBjaJwIZQR+PnDcl0yzvjbLVA06OV6eVEsqQ1cPsP+eRpO6KwRDy2UoGq0wazcWt8dPLtFrc/AZE+
        3iDouVc0OXi71NheLG3CdywARXlAUBmMbI5rlogVlZtqoM13FmRl8bpIZkCCsvgV7/Zc=;
Received: from cpe-107-184-2-226.socal.res.rr.com ([107.184.2.226] helo=zen.bslabs.net)
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <bshanks@codeweavers.com>)
        id 1jiMId-0008GB-2z; Mon, 08 Jun 2020 13:15:09 -0500
From:   Brendan Shanks <bshanks@codeweavers.com>
To:     linux-kernel@vger.kernel.org
Cc:     ricardo.neri-calderon@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        ebiederm@xmission.com, andi@notmuch.email, Babu.Moger@amd.com,
        Brendan Shanks <bshanks@codeweavers.com>
Subject: [PATCH v2] x86/umip: Add emulation/spoofing for SLDT and STR instructions
Date:   Mon,  8 Jun 2020 11:14:54 -0700
Message-Id: <20200608181454.14210-1-bshanks@codeweavers.com>
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

v2: Return (GDT_ENTRY_LDT * 8) for SLDT when an LDT is set.

 arch/x86/kernel/umip.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 8d5cbe1bbb3b..a85f0b0ec2b9 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -64,6 +64,8 @@
 #define UMIP_DUMMY_GDT_BASE 0xfffffffffffe0000ULL
 #define UMIP_DUMMY_IDT_BASE 0xffffffffffff0000ULL
 
+#define UMIP_DUMMY_TASK_REGISTER_SELECTOR 0x40
+
 /*
  * The SGDT and SIDT instructions store the contents of the global descriptor
  * table and interrupt table registers, respectively. The destination is a
@@ -244,16 +246,35 @@ static int emulate_umip_insn(struct insn *insn, int umip_inst,
 		*data_size += UMIP_GDT_IDT_LIMIT_SIZE;
 		memcpy(data, &dummy_limit, UMIP_GDT_IDT_LIMIT_SIZE);
 
-	} else if (umip_inst == UMIP_INST_SMSW) {
-		unsigned long dummy_value = CR0_STATE;
+	} else if (umip_inst == UMIP_INST_SMSW || umip_inst == UMIP_INST_SLDT ||
+		   umip_inst == UMIP_INST_STR) {
+		unsigned long dummy_value;
+
+		if (umip_inst == UMIP_INST_SMSW)
+			dummy_value = CR0_STATE;
+		else if (umip_inst == UMIP_INST_STR)
+			dummy_value = UMIP_DUMMY_TASK_REGISTER_SELECTOR;
+		else if (umip_inst == UMIP_INST_SLDT)
+		{
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
@@ -261,7 +282,6 @@ static int emulate_umip_insn(struct insn *insn, int umip_inst,
 			*data_size = 2;
 
 		memcpy(data, &dummy_value, *data_size);
-	/* STR and SLDT  are not emulated */
 	} else {
 		return -EINVAL;
 	}
@@ -383,10 +403,6 @@ bool fixup_umip_exception(struct pt_regs *regs)
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

