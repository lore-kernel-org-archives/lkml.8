Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35031C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D1320787
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgCZLkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 07:40:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50457 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbgCZLkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 07:40:16 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jHQrp-0006UF-Vp; Thu, 26 Mar 2020 12:40:10 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 830511C0470;
        Thu, 26 Mar 2020 12:40:09 +0100 (CET)
Date:   Thu, 26 Mar 2020 11:40:09 -0000
From:   "tip-bot2 for Yu-cheng Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/insn: Add Control-flow Enforcement (CET)
 instructions to the opcode map
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200204171425.28073-2-yu-cheng.yu@intel.com>
References: <20200204171425.28073-2-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Message-ID: <158522280919.28353.13352431577449123346.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     5790921bc18b1eb5c0c61371e31114fd4c4b0154
Gitweb:        https://git.kernel.org/tip/5790921bc18b1eb5c0c61371e31114fd4c4b0154
Author:        Yu-cheng Yu <yu-cheng.yu@intel.com>
AuthorDate:    Tue, 04 Feb 2020 09:14:24 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 26 Mar 2020 12:21:40 +01:00

x86/insn: Add Control-flow Enforcement (CET) instructions to the opcode map

Add the following CET instructions to the opcode map:

INCSSP:
    Increment Shadow Stack pointer (SSP).

RDSSP:
    Read SSP into a GPR.

SAVEPREVSSP:
    Use "previous ssp" token at top of current Shadow Stack (SHSTK) to
    create a "restore token" on the previous (outgoing) SHSTK.

RSTORSSP:
    Restore from a "restore token" to SSP.

WRSS:
    Write to kernel-mode SHSTK (kernel-mode instruction).

WRUSS:
    Write to user-mode SHSTK (kernel-mode instruction).

SETSSBSY:
    Verify the "supervisor token" pointed by MSR_IA32_PL0_SSP, set the
    token busy, and set then Shadow Stack pointer(SSP) to the value of
    MSR_IA32_PL0_SSP.

CLRSSBSY:
    Verify the "supervisor token" and clear its busy bit.

ENDBR64/ENDBR32:
    Mark a valid 64/32 bit control transfer endpoint.

Detailed information of CET instructions can be found in Intel Software
Developer's Manual.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lkml.kernel.org/r/20200204171425.28073-2-yu-cheng.yu@intel.com
---
 arch/x86/lib/x86-opcode-map.txt       | 17 +++++++++++------
 tools/arch/x86/lib/x86-opcode-map.txt | 17 +++++++++++------
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index 53adc17..ec31f5b 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -366,7 +366,7 @@ AVXcode: 1
 1b: BNDCN Gv,Ev (F2) | BNDMOV Ev,Gv (66) | BNDMK Gv,Ev (F3) | BNDSTX Ev,Gv
 1c: Grp20 (1A),(1C)
 1d:
-1e:
+1e: Grp21 (1A)
 1f: NOP Ev
 # 0x0f 0x20-0x2f
 20: MOV Rd,Cd
@@ -803,8 +803,8 @@ f0: MOVBE Gy,My | MOVBE Gw,Mw (66) | CRC32 Gd,Eb (F2) | CRC32 Gd,Eb (66&F2)
 f1: MOVBE My,Gy | MOVBE Mw,Gw (66) | CRC32 Gd,Ey (F2) | CRC32 Gd,Ew (66&F2)
 f2: ANDN Gy,By,Ey (v)
 f3: Grp17 (1A)
-f5: BZHI Gy,Ey,By (v) | PEXT Gy,By,Ey (F3),(v) | PDEP Gy,By,Ey (F2),(v)
-f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v)
+f5: BZHI Gy,Ey,By (v) | PEXT Gy,By,Ey (F3),(v) | PDEP Gy,By,Ey (F2),(v) | WRUSSD/Q My,Gy (66)
+f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v) | WRSSD/Q My,Gy
 f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By (F3),(v) | SHRX Gy,Ey,By (F2),(v)
 f8: MOVDIR64B Gv,Mdqq (66) | ENQCMD Gv,Mdqq (F2) | ENQCMDS Gv,Mdqq (F3)
 f9: MOVDIRI My,Gy
@@ -970,7 +970,7 @@ GrpTable: Grp7
 2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B) | ENCLU (111),(11B)
 3: LIDT Ms
 4: SMSW Mw/Rv
-5: rdpkru (110),(11B) | wrpkru (111),(11B)
+5: rdpkru (110),(11B) | wrpkru (111),(11B) | SAVEPREVSSP (F3),(010),(11B) | RSTORSSP Mq (F3) | SETSSBSY (F3),(000),(11B)
 6: LMSW Ew
 7: INVLPG Mb | SWAPGS (o64),(000),(11B) | RDTSCP (001),(11B)
 EndTable
@@ -1041,8 +1041,8 @@ GrpTable: Grp15
 2: vldmxcsr Md (v1) | WRFSBASE Ry (F3),(11B)
 3: vstmxcsr Md (v1) | WRGSBASE Ry (F3),(11B)
 4: XSAVE | ptwrite Ey (F3),(11B)
-5: XRSTOR | lfence (11B)
-6: XSAVEOPT | clwb (66) | mfence (11B) | TPAUSE Rd (66),(11B) | UMONITOR Rv (F3),(11B) | UMWAIT Rd (F2),(11B)
+5: XRSTOR | lfence (11B) | INCSSPD/Q Ry (F3),(11B)
+6: XSAVEOPT | clwb (66) | mfence (11B) | TPAUSE Rd (66),(11B) | UMONITOR Rv (F3),(11B) | UMWAIT Rd (F2),(11B) | CLRSSBSY Mq (F3)
 7: clflush | clflushopt (66) | sfence (11B)
 EndTable
 
@@ -1077,6 +1077,11 @@ GrpTable: Grp20
 0: cldemote Mb
 EndTable
 
+GrpTable: Grp21
+1: RDSSPD/Q Ry (F3),(11B)
+7: ENDBR64 (F3),(010),(11B) | ENDBR32 (F3),(011),(11B)
+EndTable
+
 # AMD's Prefetch Group
 GrpTable: GrpP
 0: PREFETCH
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index 53adc17..ec31f5b 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -366,7 +366,7 @@ AVXcode: 1
 1b: BNDCN Gv,Ev (F2) | BNDMOV Ev,Gv (66) | BNDMK Gv,Ev (F3) | BNDSTX Ev,Gv
 1c: Grp20 (1A),(1C)
 1d:
-1e:
+1e: Grp21 (1A)
 1f: NOP Ev
 # 0x0f 0x20-0x2f
 20: MOV Rd,Cd
@@ -803,8 +803,8 @@ f0: MOVBE Gy,My | MOVBE Gw,Mw (66) | CRC32 Gd,Eb (F2) | CRC32 Gd,Eb (66&F2)
 f1: MOVBE My,Gy | MOVBE Mw,Gw (66) | CRC32 Gd,Ey (F2) | CRC32 Gd,Ew (66&F2)
 f2: ANDN Gy,By,Ey (v)
 f3: Grp17 (1A)
-f5: BZHI Gy,Ey,By (v) | PEXT Gy,By,Ey (F3),(v) | PDEP Gy,By,Ey (F2),(v)
-f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v)
+f5: BZHI Gy,Ey,By (v) | PEXT Gy,By,Ey (F3),(v) | PDEP Gy,By,Ey (F2),(v) | WRUSSD/Q My,Gy (66)
+f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v) | WRSSD/Q My,Gy
 f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By (F3),(v) | SHRX Gy,Ey,By (F2),(v)
 f8: MOVDIR64B Gv,Mdqq (66) | ENQCMD Gv,Mdqq (F2) | ENQCMDS Gv,Mdqq (F3)
 f9: MOVDIRI My,Gy
@@ -970,7 +970,7 @@ GrpTable: Grp7
 2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B) | ENCLU (111),(11B)
 3: LIDT Ms
 4: SMSW Mw/Rv
-5: rdpkru (110),(11B) | wrpkru (111),(11B)
+5: rdpkru (110),(11B) | wrpkru (111),(11B) | SAVEPREVSSP (F3),(010),(11B) | RSTORSSP Mq (F3) | SETSSBSY (F3),(000),(11B)
 6: LMSW Ew
 7: INVLPG Mb | SWAPGS (o64),(000),(11B) | RDTSCP (001),(11B)
 EndTable
@@ -1041,8 +1041,8 @@ GrpTable: Grp15
 2: vldmxcsr Md (v1) | WRFSBASE Ry (F3),(11B)
 3: vstmxcsr Md (v1) | WRGSBASE Ry (F3),(11B)
 4: XSAVE | ptwrite Ey (F3),(11B)
-5: XRSTOR | lfence (11B)
-6: XSAVEOPT | clwb (66) | mfence (11B) | TPAUSE Rd (66),(11B) | UMONITOR Rv (F3),(11B) | UMWAIT Rd (F2),(11B)
+5: XRSTOR | lfence (11B) | INCSSPD/Q Ry (F3),(11B)
+6: XSAVEOPT | clwb (66) | mfence (11B) | TPAUSE Rd (66),(11B) | UMONITOR Rv (F3),(11B) | UMWAIT Rd (F2),(11B) | CLRSSBSY Mq (F3)
 7: clflush | clflushopt (66) | sfence (11B)
 EndTable
 
@@ -1077,6 +1077,11 @@ GrpTable: Grp20
 0: cldemote Mb
 EndTable
 
+GrpTable: Grp21
+1: RDSSPD/Q Ry (F3),(11B)
+7: ENDBR64 (F3),(010),(11B) | ENDBR32 (F3),(011),(11B)
+EndTable
+
 # AMD's Prefetch Group
 GrpTable: GrpP
 0: PREFETCH
