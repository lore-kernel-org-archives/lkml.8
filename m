Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A78C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8D5320739
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593973579;
	bh=9Y2dAgEVUZNawhiry+/FDAV6jSDC2JPLURF27eusN2o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Itw9JSaFrHcLqUdjfyUu+rXmOJA/SJUrMEAkkMMqyDg+IQR1BICFEULbx2DNrwp65
	 QRjzBChJIrt02LuC+KVGsH/xB58WWiRbM/HmWsfQqKrmjV9LeXMJ3mI7fvYdEyPEfy
	 mPNjc71ph06MrNBsHLdiHE58+0gijVeksJ8C8D2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgGES0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 14:26:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbgGES0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 14:26:17 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9718820CC7
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 18:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593973576;
        bh=9Y2dAgEVUZNawhiry+/FDAV6jSDC2JPLURF27eusN2o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bh/WEhEeg3fvfU8ctQ3Y++4KK3G+KanSoTTILlXnT5CmdM1T2IpZAn/R3wvnceLo3
         i/ENZVy1c8+j5t1PfgPllDgTueQEYciZAxAcD/B+GRM/SAZLpwpcQhCX1Pl0e+sHhb
         rwBnlfRRCNVX81K4/BeYGA6+srfoWgmrIJZuU3Zw=
Received: by mail-wm1-f43.google.com with SMTP id j18so36819879wmi.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 11:26:16 -0700 (PDT)
X-Gm-Message-State: AOAM530jJhcIr4/7Jnjqi6G5Kq8RhoQibFHpBMXC/or7N/lGeaD4DKNf
        mp2XvkCuU16j3x7u9vhIqorJp4yQ9PONAKm8NtXH0Q==
X-Google-Smtp-Source: ABdhPJyFKWdJhjEdznHVBnyaF0gBEethlygSuTswNDuDcbBl4xVknlUwLf6XfQTaiqN9ib+hF5+Mx3nZLUdnESwdxvE=
X-Received: by 2002:a1c:e4d4:: with SMTP id b203mr16971530wmh.49.1593973575062;
 Sun, 05 Jul 2020 11:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200629214956.GA12962@linux.intel.com> <20200704203809.76391-1-dpreed@deepplum.com>
 <20200704203809.76391-4-dpreed@deepplum.com>
In-Reply-To: <20200704203809.76391-4-dpreed@deepplum.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 5 Jul 2020 11:26:03 -0700
X-Gmail-Original-Message-ID: <CALCETrWzh03fefGuSTM9hr9QY9_=xqbHg3hQ-_vo2PLUXuZ4wg@mail.gmail.com>
Message-ID: <CALCETrWzh03fefGuSTM9hr9QY9_=xqbHg3hQ-_vo2PLUXuZ4wg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] Force all cpus to exit VMX root operation on
 crash/panic reliably
To:     "David P. Reed" <dpreed@deepplum.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
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

On Sat, Jul 4, 2020 at 1:38 PM David P. Reed <dpreed@deepplum.com> wrote:
>
> Fix the logic during crash/panic reboot on Intel processors that
> can support VMX operation to ensure that all processors are not
> in VMX root operation. Prior code made optimistic assumptions
> about other cpus that would leave other cpus in VMX root operation
> depending on timing of crash/panic reboot.
> Builds on cpu_ermergency_vmxoff() and __cpu_emergency_vmxoff() created
> in a prior patch.
>
> Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: David P. Reed <dpreed@deepplum.com>
> ---
>  arch/x86/kernel/reboot.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> index 0ec7ced727fe..c8e96ba78efc 100644
> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -543,24 +543,18 @@ static void emergency_vmx_disable_all(void)
>          * signals when VMX is enabled.
>          *
>          * We can't take any locks and we may be on an inconsistent
> -        * state, so we use NMIs as IPIs to tell the other CPUs to disable
> -        * VMX and halt.
> +        * state, so we use NMIs as IPIs to tell the other CPUs to exit
> +        * VMX root operation and halt.
>          *
>          * For safety, we will avoid running the nmi_shootdown_cpus()
>          * stuff unnecessarily, but we don't have a way to check
> -        * if other CPUs have VMX enabled. So we will call it only if the
> -        * CPU we are running on has VMX enabled.
> -        *
> -        * We will miss cases where VMX is not enabled on all CPUs. This
> -        * shouldn't do much harm because KVM always enable VMX on all
> -        * CPUs anyway. But we can miss it on the small window where KVM
> -        * is still enabling VMX.
> +        * if other CPUs might be in VMX root operation.
>          */
> -       if (cpu_has_vmx() && cpu_vmx_enabled()) {
> -               /* Disable VMX on this CPU. */
> -               cpu_vmxoff();
> +       if (cpu_has_vmx()) {
> +               /* Safely force out of VMX root operation on this CPU. */
> +               __cpu_emergency_vmxoff();
>
> -               /* Halt and disable VMX on the other CPUs */
> +               /* Halt and exit VMX root operation on the other CPUs */
>                 nmi_shootdown_cpus(vmxoff_nmi);
>
>         }

Seems reasonable to me.

As a minor caveat, doing cr4_clear_bits() in NMI context is not really
okay, but we're about to reboot, so nothing too awful should happen.
And this has very little to do with your patch.

Reviewed-by: Andy Lutomirski <luto@kernel.org>
