Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD97C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 20:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEC2E2100A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 20:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="sV+GXz01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgGDUqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 16:46:54 -0400
Received: from smtp90.iad3b.emailsrvr.com ([146.20.161.90]:53526 "EHLO
        smtp90.iad3b.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727908AbgGDUqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 16:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1593895106;
        bh=lr75QF2in2wcP8L+bTcON/4LbYMnulpodkBOzczEdWI=;
        h=From:To:Subject:Date:From;
        b=sV+GXz01AXRsv3bM23s4w+JNvMnJwCXp0Zh0tTR5g6YGa9RA7m7qTssJfOe3+kBBw
         i19fA0dJmmEyJqDbxSysbjeSF1TZtjJ8X638cQEGvXadj1YzkLhp26C/39+Ycv0flg
         rUdl6ZhfgvWX/1wqqwsld9po2hUPquhsoT9KCCoM=
X-Auth-ID: dpreed@deepplum.com
Received: by smtp20.relay.iad3b.emailsrvr.com (Authenticated sender: dpreed-AT-deepplum.com) with ESMTPSA id 7D7C5A00D3;
        Sat,  4 Jul 2020 16:38:25 -0400 (EDT)
From:   "David P. Reed" <dpreed@deepplum.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     "David P. Reed" <dpreed@deepplum.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Martin Molnar <martin.molnar.programming@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/3] Correct asm VMXOFF side effects
Date:   Sat,  4 Jul 2020 16:38:07 -0400
Message-Id: <20200704203809.76391-2-dpreed@deepplum.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704203809.76391-1-dpreed@deepplum.com>
References: <20200629214956.GA12962@linux.intel.com>
 <20200704203809.76391-1-dpreed@deepplum.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 64370b40-6b65-46c7-a817-521193c95a46-2-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tell gcc that VMXOFF instruction clobbers condition codes
and memory when executed.
Also, correct original comments to remove kernel-doc syntax
per Randy Dunlap's request.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: David P. Reed <dpreed@deepplum.com>
---
 arch/x86/include/asm/virtext.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index 9aad0e0876fb..0ede8d04535a 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -30,7 +30,7 @@ static inline int cpu_has_vmx(void)
 }
 
 
-/** Disable VMX on the current CPU
+/* Disable VMX on the current CPU
  *
  * vmxoff causes a undefined-opcode exception if vmxon was not run
  * on the CPU previously. Only call this function if you know VMX
@@ -38,7 +38,7 @@ static inline int cpu_has_vmx(void)
  */
 static inline void cpu_vmxoff(void)
 {
-	asm volatile ("vmxoff");
+	asm volatile ("vmxoff" ::: "cc", "memory");
 	cr4_clear_bits(X86_CR4_VMXE);
 }
 
@@ -47,7 +47,7 @@ static inline int cpu_vmx_enabled(void)
 	return __read_cr4() & X86_CR4_VMXE;
 }
 
-/** Disable VMX if it is enabled on the current CPU
+/* Disable VMX if it is enabled on the current CPU
  *
  * You shouldn't call this if cpu_has_vmx() returns 0.
  */
@@ -57,7 +57,7 @@ static inline void __cpu_emergency_vmxoff(void)
 		cpu_vmxoff();
 }
 
-/** Disable VMX if it is supported and enabled on the current CPU
+/* Disable VMX if it is supported and enabled on the current CPU
  */
 static inline void cpu_emergency_vmxoff(void)
 {
-- 
2.26.2

