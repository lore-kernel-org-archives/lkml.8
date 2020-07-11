Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7C4C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 21:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2B0420725
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 21:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="mIy6enJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgGKVut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 17:50:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41157 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgGKVus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 17:50:48 -0400
Received: from [IPv6:2601:646:8600:3281:c18:10c2:6ab:e372] ([IPv6:2601:646:8600:3281:c18:10c2:6ab:e372])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 06BLo3oH498128
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sat, 11 Jul 2020 14:50:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 06BLo3oH498128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020062301; t=1594504208;
        bh=EA8udCNpy5G5eYmIzoirtKji/V5xe5L2j6nxS48n0As=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=mIy6enJbioLt/w3C72Y46pABshKkyJNAX0NHgUgfY2pqfp5cVAVS8qxO9BCuI2+DA
         2nlYdmJG7dSxHR3TmO3MlAVJx8Hzw5VXk3n0eYtqm7v6FGKfvW0etIGRtp9YfrLiGm
         FjTfW4wtLLOi3C8mP/znVwQBR7ccN5PHcYrP51SzJTDH3tO23HzNmIoaZEziP9Vyji
         5HjIRkGsB+6CuyErvnVJt3t5IClXGDkpnfub5dKtBmjNkm0tQE/YCe/f2RRNoZR/PU
         xBRhAEA2mzKwa1zAX/ZBGGfQ7L8cw9OTKjkQ/PEs9782N3Isn3m9DkVxHqraBfAfTN
         +PedychKLjTLA==
Date:   Sat, 11 Jul 2020 14:49:54 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20200710224525.21966-1-bshanks@codeweavers.com>
References: <20200710224525.21966-1-bshanks@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5] x86/umip: Add emulation/spoofing for SLDT and STR instructions
To:     Brendan Shanks <bshanks@codeweavers.com>,
        linux-kernel@vger.kernel.org
CC:     ricardo.neri-calderon@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        ebiederm@xmission.com, andi@notmuch.email, Babu.Moger@amd.com
From:   hpa@zytor.com
Message-ID: <85F5E233-6C81-419F-8FE2-D9B93169E4DA@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 10, 2020 3:45:25 PM PDT, Brendan Shanks <bshanks@codeweavers=2Ecom>=
 wrote:
>Add emulation/spoofing of SLDT and STR for both 32- and 64-bit
>processes=2E
>
>Wine users have found a small number of Windows apps using SLDT that
>were crashing when run on UMIP-enabled systems=2E
>
>Reported-by: Andreas Rammhold <andi@notmuch=2Eemail>
>Originally-by: Ricardo Neri <ricardo=2Eneri-calderon@linux=2Eintel=2Ecom>
>Signed-off-by: Brendan Shanks <bshanks@codeweavers=2Ecom>
>---
>
>v5: Capitalize instruction names in comments=2E
>
> arch/x86/kernel/umip=2Ec | 40 +++++++++++++++++++++++++++-------------
> 1 file changed, 27 insertions(+), 13 deletions(-)
>
>diff --git a/arch/x86/kernel/umip=2Ec b/arch/x86/kernel/umip=2Ec
>index 8d5cbe1bbb3b=2E=2E2c304fd0bb1a 100644
>--- a/arch/x86/kernel/umip=2Ec
>+++ b/arch/x86/kernel/umip=2Ec
>@@ -45,11 +45,12 @@
>* value that, lies close to the top of the kernel memory=2E The limit for
>the GDT
>  * and the IDT are set to zero=2E
>  *
>- * Given that SLDT and STR are not commonly used in programs that run
>on WineHQ
>- * or DOSEMU2, they are not emulated=2E
>- *
>- * The instruction smsw is emulated to return the value that the
>register CR0
>+ * The instruction SMSW is emulated to return the value that the
>register CR0
>  * has at boot time as set in the head_32=2E
>+ * SLDT and STR are emulated to return the values that the kernel
>programmatically
>+ * assigns:
>+ * - SLDT returns (GDT_ENTRY_LDT * 8) if an LDT has been set, 0 if
>not=2E
>+ * - STR returns (GDT_ENTRY_TSS * 8)=2E
>  *
>  * Emulation is provided for both 32-bit and 64-bit processes=2E
>  *
>@@ -244,16 +245,34 @@ static int emulate_umip_insn(struct insn *insn,
>int umip_inst,
> 		*data_size +=3D UMIP_GDT_IDT_LIMIT_SIZE;
> 		memcpy(data, &dummy_limit, UMIP_GDT_IDT_LIMIT_SIZE);
>=20
>-	} else if (umip_inst =3D=3D UMIP_INST_SMSW) {
>-		unsigned long dummy_value =3D CR0_STATE;
>+	} else if (umip_inst =3D=3D UMIP_INST_SMSW || umip_inst =3D=3D UMIP_INS=
T_SLDT
>||
>+		   umip_inst =3D=3D UMIP_INST_STR) {
>+		unsigned long dummy_value;
>+
>+		if (umip_inst =3D=3D UMIP_INST_SMSW) {
>+			dummy_value =3D CR0_STATE;
>+		} else if (umip_inst =3D=3D UMIP_INST_STR) {
>+			dummy_value =3D GDT_ENTRY_TSS * 8;
>+		} else if (umip_inst =3D=3D UMIP_INST_SLDT) {
>+#ifdef CONFIG_MODIFY_LDT_SYSCALL
>+			down_read(&current->mm->context=2Eldt_usr_sem);
>+			if (current->mm->context=2Eldt)
>+				dummy_value =3D GDT_ENTRY_LDT * 8;
>+			else
>+				dummy_value =3D 0;
>+			up_read(&current->mm->context=2Eldt_usr_sem);
>+#else
>+			dummy_value =3D 0;
>+#endif
>+		}
>=20
> 		/*
>-		 * Even though the CR0 register has 4 bytes, the number
>+		 * For these 3 instructions, the number
> 		 * of bytes to be copied in the result buffer is determined
> 		 * by whether the operand is a register or a memory location=2E
> 		 * If operand is a register, return as many bytes as the operand
> 		 * size=2E If operand is memory, return only the two least
>-		 * siginificant bytes of CR0=2E
>+		 * siginificant bytes=2E
> 		 */
> 		if (X86_MODRM_MOD(insn->modrm=2Evalue) =3D=3D 3)
> 			*data_size =3D insn->opnd_bytes;
>@@ -261,7 +280,6 @@ static int emulate_umip_insn(struct insn *insn, int
>umip_inst,
> 			*data_size =3D 2;
>=20
> 		memcpy(data, &dummy_value, *data_size);
>-	/* STR and SLDT  are not emulated */
> 	} else {
> 		return -EINVAL;
> 	}
>@@ -383,10 +401,6 @@ bool fixup_umip_exception(struct pt_regs *regs)
>	umip_pr_warn(regs, "%s instruction cannot be used by applications=2E\n",
> 			umip_insns[umip_inst]);
>=20
>-	/* Do not emulate (spoof) SLDT or STR=2E */
>-	if (umip_inst =3D=3D UMIP_INST_STR || umip_inst =3D=3D UMIP_INST_SLDT)
>-		return false;
>-
>	umip_pr_warn(regs, "For now, expensive software emulation returns the
>result=2E\n");
>=20
> 	if (emulate_umip_insn(&insn, umip_inst, dummy_data, &dummy_data_size,

It's there any reason for SLDT to not *always* return a fixed value? "An L=
DT has been assigned" is formally a kernel internal property, separate from=
 the property of whenever there are user space enteies in the LDT=2E

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
