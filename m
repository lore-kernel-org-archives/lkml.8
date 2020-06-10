Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAB0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0E0D206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgFJVmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:42:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:57876 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgFJVmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:42:33 -0400
IronPort-SDR: 21ohFHxs3cuTxfb8nNFa8tRH1WuWX4xZLWzqvwQEi/3kDCo3QS9PmGKKgmEhMyZ7ITcEJ2u5fr
 MbIMnoEn6w7g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 14:42:32 -0700
IronPort-SDR: +V0QIYpPLZKdKGrCFZmSwGosMNWEVNmio3RcOy+ukMeFOklxh3hugwgCGopqwSi3z7ZIDg/poL
 seBJteskvaMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,497,1583222400"; 
   d="scan'208";a="473487394"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jun 2020 14:42:32 -0700
Date:   Wed, 10 Jun 2020 14:42:31 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "David P. Reed" <dpreed@deepplum.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix undefined operation VMXOFF during reboot and crash
Message-ID: <20200610214231.GH18790@linux.intel.com>
References: <20200610181254.2142-1-dpreed@deepplum.com>
 <878sgufvvm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878sgufvvm.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gah, I typed too slow :-)

On Wed, Jun 10, 2020 at 11:34:21PM +0200, Thomas Gleixner wrote:
> We have exception fixups to avoid exactly that kind of horrible
> workarounds all over the place.
> 
> static inline int cpu_vmxoff_safe(void)
> {
>         int err;
>  
> 	asm volatile("2: vmxoff; xor %[err],%[err]\n"
> 		     "1:\n\t"
> 		     ".section .fixup,\"ax\"\n\t"
> 		     "3:  mov %[fault],%[err] ; jmp 1b\n\t"
> 		     ".previous\n\t"
> 		     _ASM_EXTABLE(2b, 3b)
> 		     : [err] "=a" (err)
> 		     : [fault] "i" (-EFAULT)
> 		     : "memory");
>         return err;
> }
> 
> static inline void __cpu_emergency_vmxoff(void)
> {
>         if (!cpu_vmx_enabled())
>         	return;
>         if (!cpu_vmxoff_safe())
>         	cr4_clear_bits(X86_CR4_VMXE);

This bit is wrong, CR4.VMXE should be cleared even if VMXOFF faults, e.g.
if this is called in NMI context and the NMI arrived in KVM code between
VMXOFF and clearing CR4.VMXE.

All other VMXOFF faults are mode related, i.e. any fault is guaranteed to
be due to the !post-VMXON check unless we're magically in RM, VM86, compat
mode, or at CPL>0.

> }
> 
> Problem solved.
> 
> Thanks,
> 
>         tglx
