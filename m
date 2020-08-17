Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BECC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F4EE2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oAGoWeFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390573AbgHQSNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390540AbgHQSM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 14:12:57 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC354C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 11:12:56 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 185so18496074ljj.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 11:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7yoDJoEA7vgq3GWujkt1bvWEISuJc569oCDBRXcp0LQ=;
        b=oAGoWeFyEp4ErQovLfIwgMmnPbn1pu/GKGb5fxo9wsdh6qi3jOnvmY7V7dCP/mg9iE
         moTJN0CTldA0hDCarFbJ/df/D7OvJwcbx82pBySGh4bZNxWQY9cQ9HB8EzFfDa3dl2Gg
         nNLfgkjKkmoYH/ircXshAHufiIAffsPkshYfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7yoDJoEA7vgq3GWujkt1bvWEISuJc569oCDBRXcp0LQ=;
        b=rrqbjIlzisD+hloS3yjBI1wfvwstOAB+wPQT3evufswzaHXzHczqXmlsG2i2C7Nn1t
         LMy7tutf6TJaNP69UMMxxtdrk7w9u2P54xbUDePVMs8dndr+P3ZjMS1AH5mEDUXncn3p
         04Sjeyhigfc2Sz37p9SVTYIegdmjcVb1ezCW5b6PgAh2+ghqUSowK634Rxau7sBNgiD0
         zqj3zi/K+izny9ar2mjWDBs1exrL95xjT+mbOBRzkdsnmFl0GBsQ84PviUAHzllpG7Lz
         AhX2Bz+A+G8k7UhMQYwF7XEW55ywZ2bU3GtR/iTiPkS1gOS9lHzTiuWIVaVSmlMt06qk
         tXdA==
X-Gm-Message-State: AOAM530ENf2XLXOWzVtQJR4gjxH+4JfCKwpBVQcRkXwQRMB9KU1L1yeY
        RBemSJ1cuzQ7jp/mA1Re1ZX0tagmBkbjKg==
X-Google-Smtp-Source: ABdhPJxmP/nQb4ErcmLSJR1C6LmnByt+ED89nTvKE3nEp/fTsJwT1RftH7yVmBEkRw8AZwF80RrjlA==
X-Received: by 2002:a2e:8689:: with SMTP id l9mr8556546lji.467.1597687974875;
        Mon, 17 Aug 2020 11:12:54 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id i16sm5150470ljn.100.2020.08.17.11.12.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 11:12:54 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id f26so18510990ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 11:12:54 -0700 (PDT)
X-Received: by 2002:a05:651c:1b4:: with SMTP id c20mr7906945ljn.432.1597687973528;
 Mon, 17 Aug 2020 11:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200814213842.31151-1-ashok.raj@intel.com>
In-Reply-To: <20200814213842.31151-1-ashok.raj@intel.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 17 Aug 2020 11:12:17 -0700
X-Gmail-Original-Message-ID: <CAE=gft6fQ7cLQO025TDYNF-d6xxMeGkOHVieMZDq6wAZ84NsGQ@mail.gmail.com>
Message-ID: <CAE=gft6fQ7cLQO025TDYNF-d6xxMeGkOHVieMZDq6wAZ84NsGQ@mail.gmail.com>
Subject: Re: [PATCH] x86/hotplug: Silence APIC only after all irq's are migrated
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sukumar Ghorai <sukumar.ghorai@intel.com>,
        Srikanth Nandamuri <srikanth.nandamuri@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ashok,
Thank you, Srikanth, and Sukumar for some very impressive debugging here.

On Fri, Aug 14, 2020 at 2:38 PM Ashok Raj <ashok.raj@intel.com> wrote:
>
> When offlining CPU's, fixup_irqs() migrates all interrupts away from the
> outgoing CPU to an online CPU. Its always possible the device sent an
> interrupt to the previous CPU destination. Pending interrupt bit in IRR in
> lapic identifies such interrupts. apic_soft_disable() will not capture any
> new interrupts in IRR. This causes interrupts from device to be lost during
> cpu offline. The issue was found when explicitly setting MSI affinity to a
> CPU and immediately offlining it. It was simple to recreate with a USB
> ethernet device and doing I/O to it while the CPU is offlined. Lost
> interrupts happen even when Interrupt Remapping is enabled.
>
> Current code does apic_soft_disable() before migrating interrupts.
>
> native_cpu_disable()
> {
>         ...
>         apic_soft_disable();
>         cpu_disable_common();
>           --> fixup_irqs(); // Too late to capture anything in IRR.
> }
>
> Just fliping the above call sequence seems to hit the IRR checks
> and the lost interrupt is fixed for both legacy MSI and when
> interrupt remapping is enabled.
>
>
> Fixes: 60dcaad5736f ("x86/hotplug: Silence APIC and NMI when CPU is dead")
> Link: https://lore.kernel.org/lkml/875zdarr4h.fsf@nanos.tec.linutronix.de/
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
>
> To: linux-kernel@vger.kernel.org
> To: Thomas Gleixner <tglx@linutronix.de>
> Cc: Sukumar Ghorai <sukumar.ghorai@intel.com>
> Cc: Srikanth Nandamuri <srikanth.nandamuri@intel.com>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/kernel/smpboot.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index ffbd9a3d78d8..278cc9f92f2f 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1603,13 +1603,20 @@ int native_cpu_disable(void)
>         if (ret)
>                 return ret;
>
> +       cpu_disable_common();
>         /*
>          * Disable the local APIC. Otherwise IPI broadcasts will reach
>          * it. It still responds normally to INIT, NMI, SMI, and SIPI
> -        * messages.

I'm slightly unclear about whether interrupts are disabled at the core
by this point or not. I followed native_cpu_disable() up to
__cpu_disable(), up to take_cpu_down(). This is passed into a call to
stop_machine_cpuslocked(), where interrupts get disabled at the core.
So unless there's another path, it seems like interrupts are always
disabled at the core by this point.

If interrupts are always disabled, then the comment above is a little
obsolete, since we're not expecting to receive broadcast IPIs from
here on out anyway. We could clean up that comment in this change.

If there is a path to here where interrupts are still enabled at the
core, then we'd need to watch out, because this change now allows
broadcast IPIs to come in during cpu_disable_common(). That could be
bad. But I think that's not this case, so this should be ok.

> +        * messages. Its important to do apic_soft_disable() after
> +        * fixup_irqs(), because fixup_irqs() called from cpu_disable_common()
> +        * depends on IRR being set. After apic_soft_disable() CPU preserves
> +        * currently set IRR/ISR but new interrupts will not set IRR.
> +        * This causes interrupts sent to outgoing cpu before completion
> +        * of irq migration to be lost. Check SDM Vol 3 "10.4.7.2 Local
> +        * APIC State after It Has been Software Disabled" section for more
> +        * details.
>          */
>         apic_soft_disable();
> -       cpu_disable_common();
>
>         return 0;
>  }
> --
> 2.13.6
>
