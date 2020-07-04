Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1639C433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 20:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D3AD20CC7
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 20:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="LjxrK19h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgGDUqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 16:46:49 -0400
Received: from smtp91.iad3b.emailsrvr.com ([146.20.161.91]:46828 "EHLO
        smtp91.iad3b.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726669AbgGDUqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 16:46:46 -0400
X-Greylist: delayed 500 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Jul 2020 16:46:45 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1593895107;
        bh=w0ZgXkMgv8LAI8TjR+1AD+5/TefFnaxCjkf2/Gvaz9k=;
        h=From:To:Subject:Date:From;
        b=LjxrK19hBZgLIh960XXcZdvSvzhIh/B44QczL05d+/kDeG4VpGpsKwWSPQI9KfyPv
         +ZcYixyFMXA8KSLhrAfrb+FsFAulPawrJjr/kNxcghPoTjn2lgtvK/KBhg+sk+OeW9
         apBJtXAAn/z/5vWNVhAb3NQYleZlYNJNAvn16rCo=
X-Auth-ID: dpreed@deepplum.com
Received: by smtp20.relay.iad3b.emailsrvr.com (Authenticated sender: dpreed-AT-deepplum.com) with ESMTPSA id 65743A00ED;
        Sat,  4 Jul 2020 16:38:26 -0400 (EDT)
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
Subject: [PATCH v3 2/3] Fix undefined operation fault that can hang a cpu on crash or panic
Date:   Sat,  4 Jul 2020 16:38:08 -0400
Message-Id: <20200704203809.76391-3-dpreed@deepplum.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704203809.76391-1-dpreed@deepplum.com>
References: <20200629214956.GA12962@linux.intel.com>
 <20200704203809.76391-1-dpreed@deepplum.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 64370b40-6b65-46c7-a817-521193c95a46-3-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix: Mask undefined operation fault during emergency VMXOFF that must be
attempted to force cpu exit from VMX root operation.
Explanation: When a cpu may be in VMX root operation (only possible when
CR4.VMXE is set), crash or panic reboot tries to exit VMX root operation
using VMXOFF. This is necessary, because any INIT will be masked while cpu
is in VMX root operation, but that state cannot be reliably
discerned by the state of the cpu.
VMXOFF faults if the cpu is not actually in VMX root operation, signalling
undefined operation.
Discovered while debugging an out-of-tree x-visor with a race. Can happen
due to certain kinds of bugs in KVM.

Fixes: 208067 <https://bugzilla.kernel.org/show_bug.cgi?id=208067>
Reported-by: David P. Reed <dpreed@deepplum.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: David P. Reed <dpreed@deepplum.com>
---
 arch/x86/include/asm/virtext.h | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index 0ede8d04535a..0e0900eacb9c 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -30,11 +30,11 @@ static inline int cpu_has_vmx(void)
 }
 
 
-/* Disable VMX on the current CPU
+/* Exit VMX root mode and isable VMX on the current CPU.
  *
  * vmxoff causes a undefined-opcode exception if vmxon was not run
- * on the CPU previously. Only call this function if you know VMX
- * is enabled.
+ * on the CPU previously. Only call this function if you know cpu
+ * is in VMX root mode.
  */
 static inline void cpu_vmxoff(void)
 {
@@ -47,14 +47,22 @@ static inline int cpu_vmx_enabled(void)
 	return __read_cr4() & X86_CR4_VMXE;
 }
 
-/* Disable VMX if it is enabled on the current CPU
+/* Safely exit VMX root mode and disable VMX if VMX enabled
+ * on the current CPU. Handle undefined-opcode fault
+ * that can occur if cpu is not in VMX root mode, due
+ * to a race.
  *
  * You shouldn't call this if cpu_has_vmx() returns 0.
  */
 static inline void __cpu_emergency_vmxoff(void)
 {
-	if (cpu_vmx_enabled())
-		cpu_vmxoff();
+	if (!cpu_vmx_enabled())
+		return;
+	asm volatile ("1:vmxoff\n\t"
+		      "2:\n\t"
+		      _ASM_EXTABLE(1b, 2b)
+		      ::: "cc", "memory");
+	cr4_clear_bits(X86_CR4_VMXE);
 }
 
 /* Disable VMX if it is supported and enabled on the current CPU
-- 
2.26.2

