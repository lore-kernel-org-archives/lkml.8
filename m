Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3903C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9EEA2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgFKRAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 13:00:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:30885 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbgFKRAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 13:00:33 -0400
IronPort-SDR: vQsW/a2zXTC3uRWFkCVe7bmtLK6GKNDOLpaiYS08SOKwm8UbUMXb5iYA5sdgA7t2CuPQi8Y0m/
 yWjGSNhfCJhw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 10:00:32 -0700
IronPort-SDR: qnQcBwzlmUxjMQi/E0uufUB7EUSDfe2x3cB9GmlKby6yZ5Zfhbr0VYDnT6rBMp7/nTnxlh452b
 YxuN1U493QGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,500,1583222400"; 
   d="scan'208";a="473764807"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by fmsmga006.fm.intel.com with ESMTP; 11 Jun 2020 10:00:31 -0700
Date:   Thu, 11 Jun 2020 10:00:31 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     "David P. Reed" <dpreed@deepplum.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
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
Subject: Re: [PATCH] Fix undefined operation VMXOFF during reboot and crash
Message-ID: <20200611170031.GI29918@linux.intel.com>
References: <20200610181254.2142-1-dpreed@deepplum.com>
 <3F5CEF02-0561-4E28-851B-8E993F76DC9B@amacapital.net>
 <20200611000032.GI18790@linux.intel.com>
 <CALCETrWxBW-f_YcRyO8jH-LNnot-4GjEFAFoqzY87M04EZTBzA@mail.gmail.com>
 <1591893200.58634165@apps.rackspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591893200.58634165@apps.rackspace.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 12:33:20PM -0400, David P. Reed wrote:
> To respond to Thomas Gleixner's suggestion about exception masking mechanism
> - it may well be a better fix, but a) I used "BUG" as a model, and b) the
> exception masking is undocumented anywhere I can find. These are "static
> inline" routines, and only the "emergency" version needs protection, because
> you'd want a random VMXOFF to actually trap.

The only in-kernel usage of cpu_vmxoff() are for emergencies.  And, the only
reasonable source of faults on VMXOFF is that VMX is already off, i.e. for
the kernel's usage, the goal is purely to ensure VMX is disabled, how we get
there doesn't truly matter.
 
> In at least one of the calls to emergency, it is stated that no locks may be
> taken at all because of where it was.
>  
> Further, I have a different patch that requires a scratch page per processor
> to exist, but which never takes a UD fault. (basically, it attempts VMXON
> first, and then does VMXOFF after VMXON, which ensures exit from VMX root
> mode, but VMXON needs a blank page to either succeed or fail without GP
> fault). If someone prefers that, it's local to the routine, but requires a
> new scratch page per processor be allocated. So after testing it, I decided
> in the interest of memory reduction that the masking of UD was preferable.

Please no, doing VMXON, even temporarily, could cause breakage.  The CPU's
VMCS cache isn't cleared on VMXOFF.  Doing VMXON after kdump_nmi_callback()
invokes cpu_crash_vmclear_loaded_vmcss() would create a window where VMPTRLD
could succeed in a hypervisor and lead to memory corruption in the new
kernel when the VMCS is evicted from the non-coherent VMCS cache.

> I'm happy to resubmit the masking exception patch as version 2, if it works
> in my test case.
>  
> Advice?

Please test the below, which simply eats any exception on VMXOFF. 

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index 9aad0e0876fb..54bc84d7028d 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -32,13 +32,15 @@ static inline int cpu_has_vmx(void)

 /** Disable VMX on the current CPU
  *
- * vmxoff causes a undefined-opcode exception if vmxon was not run
- * on the CPU previously. Only call this function if you know VMX
- * is enabled.
+ * VMXOFF causes a #UD if the CPU is not post-VMXON, eat any #UDs to handle
+ * races with a hypervisor doing VMXOFF, e.g. if an NMI arrived between VMXOFF
+ * and clearing CR4.VMXE.
  */
 static inline void cpu_vmxoff(void)
 {
-       asm volatile ("vmxoff");
+       asm volatile("1: vmxoff\n\t"
+                    "2:\n\t"
+                    _ASM_EXTABLE(1b, 2b));
        cr4_clear_bits(X86_CR4_VMXE);
 }
