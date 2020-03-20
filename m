Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BE2C43332
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 04:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A554520773
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 04:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584678212;
	bh=RwUpts3my+2j4S9FwhIam1+GYrL1NFcEKY29ijsR0f0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OUjWQH9FGVqcPt3PflZIrnUUqjctFqQDSIi5xLsLLELyJxEwNcG1PhrR+wAqQMcbF
	 AIRrYLZSdCtSttJe69gXxaojGy/xLRRJgJK4vbN9MkRR2AzzjCtovbP9elFj2qmSAs
	 38Eprn5I9Bbwe22TtYz52fwkt2bv0oQvR22tpxmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgCTEXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 00:23:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbgCTEX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 00:23:29 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC26E20777
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 04:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584678209;
        bh=RwUpts3my+2j4S9FwhIam1+GYrL1NFcEKY29ijsR0f0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SQ5BRfBdjGnHWHEOv22TTrCx+hiIZnXlTkt0193blhy5p+OqMwsX6LuafM4HxXK3v
         nGVfo+rQRRQspZEs8dtCKCugi1IFzKNAm7KeMLAlcex9N1PEWrGstL9Ah9SUilM3sG
         4WT0MqPoSywO8k8Llp8+4lZkW6k++GNv34pdaVAQ=
Received: by mail-wm1-f47.google.com with SMTP id 6so5105087wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 21:23:28 -0700 (PDT)
X-Gm-Message-State: ANhLgQ39qMUANDoRk0kj2Cu4Dsz8ExJBBUvAmVRjnOJSXa9fqYoXT0jf
        6/f32wTfWWxOwIz40O3hB40a4KZ/jq74arwyVGUjBA==
X-Google-Smtp-Source: ADFU+vviOlsxvS4AUIk2v1iVSa2KGfsgjhwZ1Heqpb+fLRxDpiVTVL5HVvW7Efg92V/1OteNG76Qp5TrjAzat6QdDd4=
X-Received: by 2002:a7b:c8ce:: with SMTP id f14mr7663108wml.138.1584678206958;
 Thu, 19 Mar 2020 21:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <1584677604-32707-1-git-send-email-kyung.min.park@intel.com> <1584677604-32707-3-git-send-email-kyung.min.park@intel.com>
In-Reply-To: <1584677604-32707-3-git-send-email-kyung.min.park@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 19 Mar 2020 21:23:15 -0700
X-Gmail-Original-Message-ID: <CALCETrWJ88CaGmij_NNysRjUQ6LPwwbPnMy1YPdKnM-cFDueSw@mail.gmail.com>
Message-ID: <CALCETrWJ88CaGmij_NNysRjUQ6LPwwbPnMy1YPdKnM-cFDueSw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/delay: Introduce TPAUSE delay
To:     Kyung Min Park <kyung.min.park@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 9:13 PM Kyung Min Park <kyung.min.park@intel.com> wrote:
>
> TPAUSE instructs the processor to enter an implementation-dependent
> optimized state. The instruction execution wakes up when the time-stamp
> counter reaches or exceeds the implicit EDX:EAX 64-bit input value.
> The instruction execution also wakes up due to the expiration of
> the operating system time-limit or by an external interrupt
> or exceptions such as a debug exception or a machine check exception.
>
> TPAUSE offers a choice of two lower power states:
>  1. Light-weight power/performance optimized state C0.1
>  2. Improved power/performance optimized state C0.2
> This way, it can save power with low wake-up latency in comparison to
> spinloop based delay. The selection between the two is governed by the
> input register.
>
> TPAUSE is available on processors with X86_FEATURE_WAITPKG.
>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
> ---
>  arch/x86/include/asm/mwait.h | 17 +++++++++++++++++
>  arch/x86/lib/delay.c         | 27 ++++++++++++++++++++++++++-
>  2 files changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
> index aaf6643..fd59db0 100644
> --- a/arch/x86/include/asm/mwait.h
> +++ b/arch/x86/include/asm/mwait.h
> @@ -22,6 +22,8 @@
>  #define MWAITX_ECX_TIMER_ENABLE                BIT(1)
>  #define MWAITX_MAX_WAIT_CYCLES         UINT_MAX
>  #define MWAITX_DISABLE_CSTATES         0xf0
> +#define TPAUSE_C01_STATE               1
> +#define TPAUSE_C02_STATE               0
>
>  static inline void __monitor(const void *eax, unsigned long ecx,
>                              unsigned long edx)
> @@ -120,4 +122,19 @@ static inline void mwait_idle_with_hints(unsigned long eax, unsigned long ecx)
>         current_clr_polling();
>  }
>
> +/*
> + * Caller can specify whether to enter C0.1 (low latency, less
> + * power saving) or C0.2 state (saves more power, but longer wakeup
> + * latency). This may be overridden by the IA32_UMWAIT_CONTROL MSR
> + * which can force requests for C0.2 to be downgraded to C0.1.
> + */
> +static inline void __tpause(unsigned int ecx, unsigned int edx,
> +                           unsigned int eax)
> +{
> +       /* "tpause %ecx, %edx, %eax;" */
> +       asm volatile(".byte 0x66, 0x0f, 0xae, 0xf1\t\n"
> +                    :
> +                    : "c"(ecx), "d"(edx), "a"(eax));
> +}
> +
>  #endif /* _ASM_X86_MWAIT_H */
> diff --git a/arch/x86/lib/delay.c b/arch/x86/lib/delay.c
> index e6db855..5f11f0a 100644
> --- a/arch/x86/lib/delay.c
> +++ b/arch/x86/lib/delay.c
> @@ -97,6 +97,27 @@ static void delay_tsc(u64 cycles)
>  }
>
>  /*
> + * On Intel the TPAUSE instruction waits until any of:
> + * 1) the TSC counter exceeds the value provided in EAX:EDX
> + * 2) global timeout in IA32_UMWAIT_CONTROL is exceeded
> + * 3) an external interrupt occurs
> + */
> +static void delay_halt_tpause(u64 start, u64 cycles)
> +{
> +       u64 until = start + cycles;
> +       unsigned int eax, edx;
> +
> +       eax = (unsigned int)(until & 0xffffffff);
> +       edx = (unsigned int)(until >> 32);
> +
> +       /*
> +        * Hard code the deeper (C0.2) sleep state because exit latency is
> +        * small compared to the "microseconds" that usleep() will delay.
> +        */
> +       __tpause(TPAUSE_C02_STATE, edx, eax);
> +}
> +
> +/*
>   * On some AMD platforms, MWAITX has a configurable 32-bit timer, that
>   * counts with TSC frequency. The input value is the number of TSC cycles
>   * to wait. MWAITX will also exit when the timer expires.
> @@ -152,8 +173,12 @@ static void delay_halt(u64 __cycles)
>
>  void use_tsc_delay(void)
>  {
> -       if (delay_fn == delay_loop)
> +       if (static_cpu_has(X86_FEATURE_WAITPKG)) {
> +               delay_halt_fn = delay_halt_tpause;
> +               delay_fn = delay_halt;
> +       } else if (delay_fn == delay_loop) {
>                 delay_fn = delay_tsc;
> +       }
>  }

This is an odd way to dispatch: you're using static_cpu_has(), but
you're using it once to populate a function pointer.  Why not just put
the static_cpu_has() directly into delay_halt() and open-code the
three variants?  That will also make it a lot easier to understand the
oddity with start and cycles.

--Andy

> --
> 2.7.4
>
