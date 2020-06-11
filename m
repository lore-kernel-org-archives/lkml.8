Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012CFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CADB5207ED
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591894976;
	bh=yaEGrcbi8onX817gqhpCJ8mgmuSBARdm2p0oTRW4L5I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xlMrajzyDRR05Nd0JXfAhSyhA6aW1UhOQH6paqvNWxnBrEIgWlj68B8v2l5yUD+6b
	 UbhEvHRWsDCh3sQKK434qUVn5lJyLZglxBhbqpJ+JfE3qodTKi+dsiNll1vdMaWe33
	 4f7K7WFcDkMcoMKeb69mO5FEiFyomupiZtz/++zw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgFKRCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 13:02:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgFKRCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 13:02:54 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F374207ED
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 17:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591894973;
        bh=yaEGrcbi8onX817gqhpCJ8mgmuSBARdm2p0oTRW4L5I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FPvjh8jEQyRCCNqYIZY0ZShyLJzqO0a91f6nIIl/FSjXQ6VofZNF29BkdJWueo2vR
         wEp4NSytg27J35/9+Ee9csn4XSEBUjZzEg1T8XEdhdG5IEJbT+4XGf1zhP5rp1+Gb3
         Uz0hKRio7seWaO+EfGJdENRUTyGetB3/gTLwbqMo=
Received: by mail-wr1-f48.google.com with SMTP id l11so6953968wru.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 10:02:53 -0700 (PDT)
X-Gm-Message-State: AOAM532VQvla86ronF+dmgl/OoNPORiBVxrgcXeCHUxuBNg8xMFcqSjE
        V9TPUDUgh+xOXn73xL550vtphrre2wWM1CbkmIBmcA==
X-Google-Smtp-Source: ABdhPJw5brtpVI9xF55pOBYqyZHxzmLqPz/RtoXwJSjdsdENYAQ2Kw2kYhTGNowaGcD/R2zIGLXWmbgUcCzWcYFrd4U=
X-Received: by 2002:adf:ea11:: with SMTP id q17mr10269625wrm.75.1591894972048;
 Thu, 11 Jun 2020 10:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200610181254.2142-1-dpreed@deepplum.com> <3F5CEF02-0561-4E28-851B-8E993F76DC9B@amacapital.net>
 <20200611000032.GI18790@linux.intel.com> <CALCETrWxBW-f_YcRyO8jH-LNnot-4GjEFAFoqzY87M04EZTBzA@mail.gmail.com>
 <1591893200.58634165@apps.rackspace.com> <20200611170031.GI29918@linux.intel.com>
In-Reply-To: <20200611170031.GI29918@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 11 Jun 2020 10:02:39 -0700
X-Gmail-Original-Message-ID: <CALCETrWw3WKLx1k94NfH1jJm-XLid_G-zy8jz_Afdf3KkWjquw@mail.gmail.com>
Message-ID: <CALCETrWw3WKLx1k94NfH1jJm-XLid_G-zy8jz_Afdf3KkWjquw@mail.gmail.com>
Subject: Re: [PATCH] Fix undefined operation VMXOFF during reboot and crash
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     "David P. Reed" <dpreed@deepplum.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 10:00 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Thu, Jun 11, 2020 at 12:33:20PM -0400, David P. Reed wrote:
> > To respond to Thomas Gleixner's suggestion about exception masking mechanism
> > - it may well be a better fix, but a) I used "BUG" as a model, and b) the
> > exception masking is undocumented anywhere I can find. These are "static
> > inline" routines, and only the "emergency" version needs protection, because
> > you'd want a random VMXOFF to actually trap.
>
> The only in-kernel usage of cpu_vmxoff() are for emergencies.  And, the only
> reasonable source of faults on VMXOFF is that VMX is already off, i.e. for
> the kernel's usage, the goal is purely to ensure VMX is disabled, how we get
> there doesn't truly matter.
>
> > In at least one of the calls to emergency, it is stated that no locks may be
> > taken at all because of where it was.
> >
> > Further, I have a different patch that requires a scratch page per processor
> > to exist, but which never takes a UD fault. (basically, it attempts VMXON
> > first, and then does VMXOFF after VMXON, which ensures exit from VMX root
> > mode, but VMXON needs a blank page to either succeed or fail without GP
> > fault). If someone prefers that, it's local to the routine, but requires a
> > new scratch page per processor be allocated. So after testing it, I decided
> > in the interest of memory reduction that the masking of UD was preferable.
>
> Please no, doing VMXON, even temporarily, could cause breakage.  The CPU's
> VMCS cache isn't cleared on VMXOFF.  Doing VMXON after kdump_nmi_callback()
> invokes cpu_crash_vmclear_loaded_vmcss() would create a window where VMPTRLD
> could succeed in a hypervisor and lead to memory corruption in the new
> kernel when the VMCS is evicted from the non-coherent VMCS cache.
>
> > I'm happy to resubmit the masking exception patch as version 2, if it works
> > in my test case.
> >
> > Advice?
>
> Please test the below, which simply eats any exception on VMXOFF.
>
> diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
> index 9aad0e0876fb..54bc84d7028d 100644
> --- a/arch/x86/include/asm/virtext.h
> +++ b/arch/x86/include/asm/virtext.h
> @@ -32,13 +32,15 @@ static inline int cpu_has_vmx(void)
>
>  /** Disable VMX on the current CPU
>   *
> - * vmxoff causes a undefined-opcode exception if vmxon was not run
> - * on the CPU previously. Only call this function if you know VMX
> - * is enabled.
> + * VMXOFF causes a #UD if the CPU is not post-VMXON, eat any #UDs to handle
> + * races with a hypervisor doing VMXOFF, e.g. if an NMI arrived between VMXOFF
> + * and clearing CR4.VMXE.
>   */
>  static inline void cpu_vmxoff(void)
>  {
> -       asm volatile ("vmxoff");
> +       asm volatile("1: vmxoff\n\t"
> +                    "2:\n\t"
> +                    _ASM_EXTABLE(1b, 2b));
>         cr4_clear_bits(X86_CR4_VMXE);
>  }

I think that just eating exceptions like this is asking for trouble.
How about having a separate cpu_emergency_vmxoff() that eats
exceptions and leaving cpu_vmxoff() alone?  Or make cpu_vmxoff()
return an error on failure and have the normal caller WARN if there's
an error.

Silently eating exceptions in the non-emergency path makes it too easy
to regress something without noticing.
