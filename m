Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94F1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAA5C2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgFJWJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 18:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgFJWJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 18:09:11 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F672C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 15:09:11 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jj8tt-0004e0-G2; Thu, 11 Jun 2020 00:08:49 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id C6DEC100F18; Thu, 11 Jun 2020 00:08:48 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     "David P. Reed" <dpreed@deepplum.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Martin Molnar <martin.molnar.programming@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix undefined operation VMXOFF during reboot and crash
In-Reply-To: <20200610214231.GH18790@linux.intel.com>
References: <20200610181254.2142-1-dpreed@deepplum.com> <878sgufvvm.fsf@nanos.tec.linutronix.de> <20200610214231.GH18790@linux.intel.com>
Date:   Thu, 11 Jun 2020 00:08:48 +0200
Message-ID: <87wo4evaj3.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:
> Gah, I typed too slow :-)

Haha. I had the same thought.

> On Wed, Jun 10, 2020 at 11:34:21PM +0200, Thomas Gleixner wrote:
>> We have exception fixups to avoid exactly that kind of horrible
>> workarounds all over the place.
>> 
>> static inline int cpu_vmxoff_safe(void)
>> {
>>         int err;
>>  
>> 	asm volatile("2: vmxoff; xor %[err],%[err]\n"
>> 		     "1:\n\t"
>> 		     ".section .fixup,\"ax\"\n\t"
>> 		     "3:  mov %[fault],%[err] ; jmp 1b\n\t"
>> 		     ".previous\n\t"
>> 		     _ASM_EXTABLE(2b, 3b)
>> 		     : [err] "=a" (err)
>> 		     : [fault] "i" (-EFAULT)
>> 		     : "memory");
>>         return err;
>> }
>> 
>> static inline void __cpu_emergency_vmxoff(void)
>> {
>>         if (!cpu_vmx_enabled())
>>         	return;
>>         if (!cpu_vmxoff_safe())
>>         	cr4_clear_bits(X86_CR4_VMXE);
>
> This bit is wrong, CR4.VMXE should be cleared even if VMXOFF faults, e.g.
> if this is called in NMI context and the NMI arrived in KVM code between
> VMXOFF and clearing CR4.VMXE.

Oh, right.

> All other VMXOFF faults are mode related, i.e. any fault is guaranteed to
> be due to the !post-VMXON check unless we're magically in RM, VM86, compat
> mode, or at CPL>0.

Your patch is simpler indeed.

Thanks,

        tglx
