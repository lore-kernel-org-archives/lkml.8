Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C605FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CBEE2075B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593982435;
	bh=9RDRMuJ1yhkI0FV1AmxTqXQufZf4YIfBZSX0VGAC754=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=j2XrsHmSVlPLvP08G4LsmdMioY6ZkmL1c88mo2pKmlFBcKEoWeDNuwWy9auOq4psc
	 Nwu5sqhWSQFVxFjxQuy4pvEsqw2Mu19GbtmVX4VaXpwgAq4HwJsZS7xhjEdS3mHXYj
	 o9r3Yuf4oKcsn1tncOl1/HHsjUgTyjmj+parcAOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgGEUxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 16:53:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728056AbgGEUxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 16:53:53 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99627207CD
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 20:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593982432;
        bh=9RDRMuJ1yhkI0FV1AmxTqXQufZf4YIfBZSX0VGAC754=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rjex7168IsEZxqMOEM89tSwWdcgHFTWxfIRRE6y7r0PeX4xBRtBGkx1vXnvWpK9F7
         Fqb5MhXysKX4gdE+s8diN/OPTo3b9QSUBAkE/yjw7vx104ny8usrQNdNkoxNS+/aOe
         A3RJVwzDf18eBEefVapZU7SAB9/bwf0B4FioEftM=
Received: by mail-wm1-f44.google.com with SMTP id j18so37087154wmi.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 13:53:52 -0700 (PDT)
X-Gm-Message-State: AOAM531yom3Q8MSqwCOzhULOUJIgy9WLDJmGHTmBrdjKEI85TgG9xVtT
        4OpLzbe/L7akpOOR633HALS3BD7HmWUSmRrTVMyZ/Q==
X-Google-Smtp-Source: ABdhPJzuQ6plxy80tbtbQd+NzybOqhoLg+qifCKUvr+VlsnymWmGHkQPGcN3oDo470m0y41UYsYiJOi2qOdoiH5QwT0=
X-Received: by 2002:a7b:c09a:: with SMTP id r26mr45511123wmh.176.1593982431130;
 Sun, 05 Jul 2020 13:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200629214956.GA12962@linux.intel.com> <20200704203809.76391-1-dpreed@deepplum.com>
 <20200704203809.76391-4-dpreed@deepplum.com> <CALCETrWzh03fefGuSTM9hr9QY9_=xqbHg3hQ-_vo2PLUXuZ4wg@mail.gmail.com>
 <1593979233.22877148@apps.rackspace.com>
In-Reply-To: <1593979233.22877148@apps.rackspace.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 5 Jul 2020 13:53:39 -0700
X-Gmail-Original-Message-ID: <CALCETrWnef+Q=Pyrf1h5tcPSrp7tW6eSVozjfONC+OsqbGcj-Q@mail.gmail.com>
Message-ID: <CALCETrWnef+Q=Pyrf1h5tcPSrp7tW6eSVozjfONC+OsqbGcj-Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] Force all cpus to exit VMX root operation on
 crash/panic reliably
To:     "David P. Reed" <dpreed@deepplum.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
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
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 5, 2020 at 1:00 PM David P. Reed <dpreed@deepplum.com> wrote:
>
>
>
> On Sunday, July 5, 2020 2:26pm, "Andy Lutomirski" <luto@kernel.org> said:
>
> > On Sat, Jul 4, 2020 at 1:38 PM David P. Reed <dpreed@deepplum.com> wrot=
e:
> >>
> >> Fix the logic during crash/panic reboot on Intel processors that
> >> can support VMX operation to ensure that all processors are not
> >> in VMX root operation. Prior code made optimistic assumptions
> >> about other cpus that would leave other cpus in VMX root operation
> >> depending on timing of crash/panic reboot.
> >> Builds on cpu_ermergency_vmxoff() and __cpu_emergency_vmxoff() created
> >> in a prior patch.
> >>
> >> Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
> >> Signed-off-by: David P. Reed <dpreed@deepplum.com>
> >> ---
> >>  arch/x86/kernel/reboot.c | 20 +++++++-------------
> >>  1 file changed, 7 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> >> index 0ec7ced727fe..c8e96ba78efc 100644
> >> --- a/arch/x86/kernel/reboot.c
> >> +++ b/arch/x86/kernel/reboot.c
> >> @@ -543,24 +543,18 @@ static void emergency_vmx_disable_all(void)
> >>          * signals when VMX is enabled.
> >>          *
> >>          * We can't take any locks and we may be on an inconsistent
> >> -        * state, so we use NMIs as IPIs to tell the other CPUs to dis=
able
> >> -        * VMX and halt.
> >> +        * state, so we use NMIs as IPIs to tell the other CPUs to exi=
t
> >> +        * VMX root operation and halt.
> >>          *
> >>          * For safety, we will avoid running the nmi_shootdown_cpus()
> >>          * stuff unnecessarily, but we don't have a way to check
> >> -        * if other CPUs have VMX enabled. So we will call it only if =
the
> >> -        * CPU we are running on has VMX enabled.
> >> -        *
> >> -        * We will miss cases where VMX is not enabled on all CPUs. Th=
is
> >> -        * shouldn't do much harm because KVM always enable VMX on all
> >> -        * CPUs anyway. But we can miss it on the small window where K=
VM
> >> -        * is still enabling VMX.
> >> +        * if other CPUs might be in VMX root operation.
> >>          */
> >> -       if (cpu_has_vmx() && cpu_vmx_enabled()) {
> >> -               /* Disable VMX on this CPU. */
> >> -               cpu_vmxoff();
> >> +       if (cpu_has_vmx()) {
> >> +               /* Safely force out of VMX root operation on this CPU.=
 */
> >> +               __cpu_emergency_vmxoff();
> >>
> >> -               /* Halt and disable VMX on the other CPUs */
> >> +               /* Halt and exit VMX root operation on the other CPUs =
*/
> >>                 nmi_shootdown_cpus(vmxoff_nmi);
> >>
> >>         }
> >
> > Seems reasonable to me.
> >
> > As a minor caveat, doing cr4_clear_bits() in NMI context is not really
> > okay, but we're about to reboot, so nothing too awful should happen.
> > And this has very little to do with your patch.
>
> I had wondered why the bit is cleared, too. (I assumed it was OK or desir=
able, because it was being cleared in NMI context before). Happy to submit =
a separate patch to eliminate that issue as well, since the point of emerge=
ncy vmxoff is only to get out of VMX root mode - CR4.VMXE's state is irrele=
vant. Of course, clearing it prevents any future emergency vmxoff attempts.=
 (there seemed to be some confusion about "enabling" VMX vs. "in VMX operat=
ion" in the comments)  Should I?

I have a vague recollection of some firmwares that got upset if
rebooted with CR4.VMXE set.  Sean?

The real issue here is that the percpu CR4 machinery uses IRQ-offness
as a lock, and NMI breaks this.

--Andy
