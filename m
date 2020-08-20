Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5073C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70FBD204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MS1ngaMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgHTSWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 14:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgHTSWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 14:22:05 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1A1C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 11:22:05 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v4so3187708ljd.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 11:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6bpH/rDSoFxQjF9Z+G+y55sWHGzEFzdoVgsBQvNI7v4=;
        b=MS1ngaMH/qq1mDlfneEQX0J3/fOBeD1iB0e+t4YZKZ9mgCOjLIUkL6iCaoR9YMDwAB
         clFSxGt92ljoPzFGrNPh11R1a5/cRMzoNd9Kd6lSAIz/jO3LxlrSWTBy4+sLcIgBVMhj
         rDdmzdByP/J58lYF2ajvQH1ClC/RglRFgs7Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6bpH/rDSoFxQjF9Z+G+y55sWHGzEFzdoVgsBQvNI7v4=;
        b=rYECGnI5MVPQt+igc/F+pzFpJNSQbAEZ9Gy81d2Tkw9RbCmwztBDT/TfG3odYeUXTi
         zaiEH84E3K6twxIzlTLktd2XN+gMcvn3tz1T6MFgA2ryJGABq2wE1gN5Os+HwRuTeCUm
         aTGLmr/jjPzIzYhE0NTDWPc/hiTESUiyKseUl010U28sekZ29Qh6XpuAox1E/UoEM8iu
         /I/zzBTupBlVXDJXNfbG2OallqDTqHO46eMGt63EkQz2+Bu+KQ0dQI+rCbF7psrzTVZn
         mYOFm40D3aIb6GT0R049Bt3Su309xoSuQ67giRcdFdIn7mTq4PWIJj4GTa3HCpbBhcaL
         M14g==
X-Gm-Message-State: AOAM531hCLvJpAh7fYKMuTlOM2JxJbIi044Mf9cS1nBUK1D6IgGnQR0v
        /dhz0IZ3nAZVfX8WR+TwyO1rGgYvG7cf0Q==
X-Google-Smtp-Source: ABdhPJwKIQgh7KokP91xjtOXAA4Yj14TilY5ULBToQVLuWGfahS/5yKLDN7und6VJWMhjCdEgKoWsg==
X-Received: by 2002:a2e:9557:: with SMTP id t23mr2111719ljh.85.1597947722943;
        Thu, 20 Aug 2020 11:22:02 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 185sm585198ljf.82.2020.08.20.11.22.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 11:22:02 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id w25so3131620ljo.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 11:22:02 -0700 (PDT)
X-Received: by 2002:a05:651c:1b4:: with SMTP id c20mr2064657ljn.432.1597947721521;
 Thu, 20 Aug 2020 11:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200814213842.31151-1-ashok.raj@intel.com> <CAE=gft6fQ7cLQO025TDYNF-d6xxMeGkOHVieMZDq6wAZ84NsGQ@mail.gmail.com>
 <20200817183322.GA11486@araj-mobl1.jf.intel.com>
In-Reply-To: <20200817183322.GA11486@araj-mobl1.jf.intel.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 20 Aug 2020 11:21:24 -0700
X-Gmail-Original-Message-ID: <CAE=gft6D_1NWVczfO3JFhwCGeYBKsUUtt03TrtgWVViOVgP=4w@mail.gmail.com>
Message-ID: <CAE=gft6D_1NWVczfO3JFhwCGeYBKsUUtt03TrtgWVViOVgP=4w@mail.gmail.com>
Subject: Re: [PATCH] x86/hotplug: Silence APIC only after all irq's are migrated
To:     "Raj, Ashok" <ashok.raj@intel.com>
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

On Mon, Aug 17, 2020 at 11:33 AM Raj, Ashok <ashok.raj@intel.com> wrote:
>
> Hi Evan
>
> Some details below,
>
> On Mon, Aug 17, 2020 at 11:12:17AM -0700, Evan Green wrote:
> > Hi Ashok,
> > Thank you, Srikanth, and Sukumar for some very impressive debugging here.
> >
> > On Fri, Aug 14, 2020 at 2:38 PM Ashok Raj <ashok.raj@intel.com> wrote:
> > >
> > > When offlining CPU's, fixup_irqs() migrates all interrupts away from the
> > > outgoing CPU to an online CPU. Its always possible the device sent an
> > > interrupt to the previous CPU destination. Pending interrupt bit in IRR in
> > > lapic identifies such interrupts. apic_soft_disable() will not capture any
> > > new interrupts in IRR. This causes interrupts from device to be lost during
> > > cpu offline. The issue was found when explicitly setting MSI affinity to a
> > > CPU and immediately offlining it. It was simple to recreate with a USB
> > > ethernet device and doing I/O to it while the CPU is offlined. Lost
> > > interrupts happen even when Interrupt Remapping is enabled.
> > >
> > > Current code does apic_soft_disable() before migrating interrupts.
> > >
> > > native_cpu_disable()
> > > {
> > >         ...
> > >         apic_soft_disable();
> > >         cpu_disable_common();
> > >           --> fixup_irqs(); // Too late to capture anything in IRR.
> > > }
> > >
> > > Just fliping the above call sequence seems to hit the IRR checks
> > > and the lost interrupt is fixed for both legacy MSI and when
> > > interrupt remapping is enabled.
> > >
> > >
> > > Fixes: 60dcaad5736f ("x86/hotplug: Silence APIC and NMI when CPU is dead")
> > > Link: https://lore.kernel.org/lkml/875zdarr4h.fsf@nanos.tec.linutronix.de/
> > > Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> > >
> > > To: linux-kernel@vger.kernel.org
> > > To: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Sukumar Ghorai <sukumar.ghorai@intel.com>
> > > Cc: Srikanth Nandamuri <srikanth.nandamuri@intel.com>
> > > Cc: Evan Green <evgreen@chromium.org>
> > > Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: stable@vger.kernel.org
> > > ---
> > >  arch/x86/kernel/smpboot.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> > > index ffbd9a3d78d8..278cc9f92f2f 100644
> > > --- a/arch/x86/kernel/smpboot.c
> > > +++ b/arch/x86/kernel/smpboot.c
> > > @@ -1603,13 +1603,20 @@ int native_cpu_disable(void)
> > >         if (ret)
> > >                 return ret;
> > >
> > > +       cpu_disable_common();
> > >         /*
> > >          * Disable the local APIC. Otherwise IPI broadcasts will reach
> > >          * it. It still responds normally to INIT, NMI, SMI, and SIPI
> > > -        * messages.
> >
> > I'm slightly unclear about whether interrupts are disabled at the core
> > by this point or not. I followed native_cpu_disable() up to
> > __cpu_disable(), up to take_cpu_down(). This is passed into a call to
> > stop_machine_cpuslocked(), where interrupts get disabled at the core.
> > So unless there's another path, it seems like interrupts are always
> > disabled at the core by this point.
>
> local_irq_disable() just does cli() which allows interrupts to trickle
> in to the IRR bits, and once you do sti() things would flow back for
> normal interrupt processing.
>
>
> >
> > If interrupts are always disabled, then the comment above is a little
>
> Disable interrupts is different from disabling LAPIC. Once you do the
> apic_soft_disable(), there is nothing flowing into the LAPIC except
> for INIT, NMI, SMI and SIPI messages.
>
> This turns off the pipe for all other interrupts to enter LAPIC. Which
> is different from doing a cli().

I understand the distinction. I was mostly musing on the difference in
behavior your change causes if this function is entered with
interrupts enabled at the core (ie sti()). But I think it never is, so
that thought is moot.

I could never repro the issue reliably on comet lake after Thomas'
original fix. But I can still repro it easily on jasper lake. And this
patch fixes the issue for me on that platform. Thanks for the fix.

Reviewed-by: Evan Green <evgreen@chromium.org>
Tested-by: Evan Green <evgreen@chromium.org>
