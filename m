Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EB1C33CB7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 02:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF39224686
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 02:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J1rUlN9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgA1C2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 21:28:13 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43178 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbgA1C2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 21:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580178491; x=1611714491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Aa/KOay4NXW/kCM7QuDcS3Px0MPY5o5nqFvm1/cPYf4=;
  b=J1rUlN9O1guWRkt4S0mZpknl/pvuE7UGQ7IHS3yVtutfmi0JDhsfi7M2
   J3eFJVpGOHK4sAH5MEpWw6X0VfVX9Vs/rhiKSp2EguA63Z3qgS0lGjE9V
   xIRLMwdb0oHqgCynNoe9AITPNqRxp0NyDmg53ZXawQPy959IvkTXtolvZ
   NWLFk3mPYW4Cyc5TFoA0cEUnBOueaxqSl2DelnQhMjF+SNcBhPyEBuBvy
   dm3fCDluD3DRTI95GNIfLiac+przGGRo4YKpow+TR3EPeN1DZ0o1cU1y5
   xCZzYpiTxIuux49X8l2slz/rEnoPgFa0gWnjkIVVc6/mSCrWDCPVLsaqe
   w==;
IronPort-SDR: Z4vslOSjeBGqeXXS2eDylp9QcZTjSXLS9meWH1V4q6uOWUZwP8JlL4u9qP29cITQpkWKIsW0wX
 pn0KQN6RT9Df83MW56e4OqOwmO0QsQBX+/tf24zqzWEP0ix/G1Dd843kHNdMLDzx+d6z6LgU3b
 FLBBkbeJz0LuwkODPXkI2xzg+Aj2o7fTkrXknoZZb7RsGmVLsU1SUth05yK7kwFtoYSoTMN47i
 +C5id4NbzFB5XcZXsVerOIRdc7KkLslcANJOaY/lpk/lWXgCvIPallSbKAAOWAxgxHd7CCHyMg
 G9w=
X-IronPort-AV: E=Sophos;i="5.70,372,1574092800"; 
   d="scan'208";a="132899422"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2020 10:28:10 +0800
IronPort-SDR: V1Mkqq2q0qebWbF2TgBg/CA+WcqdFMU4lUVTY8ysTnXbEQxnOr7lJ9wPHvYXJudcYWrUs7Sgg4
 GOw2d2afMaPkpZJbN6Dkzrd/HGNk7MvYZqn/kD+/Cs4Fn/txCkKrFIfXXe8tWKczRnwahEmUBE
 iv/+mlnita1tQmuqa1cUMiog/MZy6yuHeC/cZeRbPTBd3o3mLCaNbqYmp7WzFjSIq5BZKzZui2
 E/fVegU6eS27rnX+WFNjRNbaZRSS0Q7c6URLQXHUY9SOXrDpCA2g8G8aoeFA1Wfpw1F2h16Ekp
 pM/MGh4GqzLs6VSBkAidh8SF
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 18:21:25 -0800
IronPort-SDR: xjtXdnYD68EmEyMnqmzrTVMrZxbCZwVJb/v6gC9WAN9oAsky/IKHwA201FTIcsJTdBvH1w0Qhr
 h5n/SIRg6lE+KJmdIsn2eTQdholBnvKykXfZQpvQwMDn1XTQq0sJ8qd6vfqd/DpaEBZBfaomta
 0lsfxNW3l/pvmf+SvH8dcg5zesILijyXiPdhFWxBNBMdV9sZnv37bVD9E1liae5PtlgHid56Ua
 LdVuMPclvkT+UIiv1DIUJaUzIfHltfLqrLfMEiNs3SP0kXegVKVw2H54lsbbYhV9jGFdptTJI9
 CZg=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Jan 2020 18:28:10 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>, Borislav Petkov <bp@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>, abner.chang@hpe.com,
        clin@suse.com, nickhu@andestech.com,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v7 07/10] RISC-V: Move relocate and few other functions out of __init
Date:   Mon, 27 Jan 2020 18:27:34 -0800
Message-Id: <20200128022737.15371-8-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200128022737.15371-1-atish.patra@wdc.com>
References: <20200128022737.15371-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The secondary hart booting and relocation code are under .init section.
As a result, it will be freed once kernel booting is done. However,
ordered booting protocol and CPU hotplug always requires these sections
to be present to bringup harts after initial kernel boot.

Move the required sections to a different section and make sure that
they are in memory within first 2MB offset as trampoline page directory
only maps first 2MB.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/head.S        | 73 +++++++++++++++++++--------------
 arch/riscv/kernel/vmlinux.lds.S |  9 +++-
 2 files changed, 50 insertions(+), 32 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index a4242be66966..9d7f084a50cc 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -14,7 +14,7 @@
 #include <asm/hwcap.h>
 #include <asm/image.h>
 
-__INIT
+__HEAD
 ENTRY(_start)
 	/*
 	 * Image header expected by Linux boot-loaders. The image header data
@@ -44,9 +44,10 @@ ENTRY(_start)
 	.balign 4
 	.ascii RISCV_IMAGE_MAGIC2
 	.word 0
+END(_start)
 
-.global _start_kernel
-_start_kernel:
+	__INIT
+ENTRY(_start_kernel)
 	/* Mask all interrupts */
 	csrw CSR_IE, zero
 	csrw CSR_IP, zero
@@ -125,6 +126,37 @@ clear_bss_done:
 	call parse_dtb
 	tail start_kernel
 
+.Lsecondary_start:
+#ifdef CONFIG_SMP
+	/* Set trap vector to spin forever to help debug */
+	la a3, .Lsecondary_park
+	csrw CSR_TVEC, a3
+
+	slli a3, a0, LGREG
+	la a1, __cpu_up_stack_pointer
+	la a2, __cpu_up_task_pointer
+	add a1, a3, a1
+	add a2, a3, a2
+
+	/*
+	 * This hart didn't win the lottery, so we wait for the winning hart to
+	 * get far enough along the boot process that it should continue.
+	 */
+.Lwait_for_cpu_up:
+	/* FIXME: We should WFI to save some energy here. */
+	REG_L sp, (a1)
+	REG_L tp, (a2)
+	beqz sp, .Lwait_for_cpu_up
+	beqz tp, .Lwait_for_cpu_up
+	fence
+
+	tail secondary_start_common
+#endif
+
+END(_start_kernel)
+
+.section ".noinit.text","ax",@progbits
+.align 2
 #ifdef CONFIG_MMU
 relocate:
 	/* Relocate return address */
@@ -177,41 +209,27 @@ relocate:
 
 	ret
 #endif /* CONFIG_MMU */
-
-.Lsecondary_start:
 #ifdef CONFIG_SMP
 	/* Set trap vector to spin forever to help debug */
 	la a3, .Lsecondary_park
 	csrw CSR_TVEC, a3
 
 	slli a3, a0, LGREG
-	la a1, __cpu_up_stack_pointer
-	la a2, __cpu_up_task_pointer
-	add a1, a3, a1
-	add a2, a3, a2
-
-	/*
-	 * This hart didn't win the lottery, so we wait for the winning hart to
-	 * get far enough along the boot process that it should continue.
-	 */
-.Lwait_for_cpu_up:
-	/* FIXME: We should WFI to save some energy here. */
-	REG_L sp, (a1)
-	REG_L tp, (a2)
-	beqz sp, .Lwait_for_cpu_up
-	beqz tp, .Lwait_for_cpu_up
-	fence
+	.global secondary_start_common
+secondary_start_common:
 
 #ifdef CONFIG_MMU
 	/* Enable virtual memory and relocate to virtual address */
 	la a0, swapper_pg_dir
 	call relocate
 #endif
-
 	tail smp_callin
-#endif
+#endif /* CONFIG_SMP */
 
-END(_start)
+.Lsecondary_park:
+	/* We lack SMP support or have too many harts, so park this hart */
+	wfi
+	j .Lsecondary_park
 
 #ifdef CONFIG_RISCV_M_MODE
 ENTRY(reset_regs)
@@ -292,13 +310,6 @@ ENTRY(reset_regs)
 END(reset_regs)
 #endif /* CONFIG_RISCV_M_MODE */
 
-.section ".text", "ax",@progbits
-.align 2
-.Lsecondary_park:
-	/* We lack SMP support or have too many harts, so park this hart */
-	wfi
-	j .Lsecondary_park
-
 __PAGE_ALIGNED_BSS
 	/* Empty zero page */
 	.balign PAGE_SIZE
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 12f42f96d46e..c8a88326df9e 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -10,6 +10,7 @@
 #include <asm/cache.h>
 #include <asm/thread_info.h>
 
+#include <linux/sizes.h>
 OUTPUT_ARCH(riscv)
 ENTRY(_start)
 
@@ -20,8 +21,14 @@ SECTIONS
 	/* Beginning of code and text segment */
 	. = LOAD_OFFSET;
 	_start = .;
-	__init_begin = .;
 	HEAD_TEXT_SECTION
+	.noinit.text :
+	{
+		*(.noinit.text)
+	}
+	. = ALIGN(SZ_4K);
+
+	__init_begin = .;
 	INIT_TEXT_SECTION(PAGE_SIZE)
 	INIT_DATA_SECTION(16)
 	/* we have to discard exit text and such at runtime, not link time */
-- 
2.24.0

