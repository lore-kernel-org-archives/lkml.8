Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A971C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3947C20825
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598114554;
	bh=4mV79t1nyNS6DI3ftmSBBylHHzDQoo7iQ88XRvUd9G0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2DpVWJIPPzxqHH9OVQBasxyjTrirxvMUwWjewi2XyuM7LIxZxmlqWTo0lVAhmC4E6
	 00XWyuIKQRaZ/oh4EJxmDt2iKLOcXu2oy6k+7jV39mgip/C/tjR/pnJgrX99CSY41X
	 rzH/W8sv4U+nD2X9dXLydqb9OdjU6CvHHsOZz/oE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgHVQmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 12:42:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbgHVQmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 12:42:31 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2508C214F1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 16:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598114551;
        bh=4mV79t1nyNS6DI3ftmSBBylHHzDQoo7iQ88XRvUd9G0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1U5piPjSZhvq5FmJgwthshH6cvV/BZwqr7eGrOikfQkwqWjcJSAHZh/RVScvclL4t
         wnEr/ph6+73siXM638f8pASfEhZtwJqicj6DM1w2ZJINdSNkAo81irDEg0Mkt/VtuJ
         MCvI/IUgphKBCe9PB7JCmSaCNVDt2gSHKqNPct5E=
Received: by mail-wm1-f54.google.com with SMTP id p14so4587033wmg.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 09:42:31 -0700 (PDT)
X-Gm-Message-State: AOAM532bdxPmwDnFebjrDGRG0G1AzQRgwzKAHl1SFxe6FknacHmEliDg
        YPdElK6vO4lSPbEPvlXEa0sgZlkkEiaGetf2h06Nkw==
X-Google-Smtp-Source: ABdhPJyZWyaVpff/IXxOtMiqXF/Quc/aqaeKxDgDzeOMC13s+HrDYLr1eB1fwbBh3Dn08Aaft6SfL6WnLVzKwBYTi34=
X-Received: by 2002:a1c:7e02:: with SMTP id z2mr8313834wmc.138.1598114549600;
 Sat, 22 Aug 2020 09:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200821025050.32573-1-sean.j.christopherson@intel.com>
 <20200821074743.GB12181@zn.tnic> <3eb94913-662d-5423-21b1-eaf75635142a@redhat.com>
 <20200821081633.GD12181@zn.tnic> <3b4ba9e9-dbf6-a094-0684-e68248050758@redhat.com>
 <20200821092237.GF12181@zn.tnic> <1442e559-dde4-70f6-85ac-58109cf81c16@redhat.com>
 <20200821094802.GG12181@zn.tnic> <81985f69-190d-eea6-f1ff-206a43b06851@redhat.com>
In-Reply-To: <81985f69-190d-eea6-f1ff-206a43b06851@redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 22 Aug 2020 09:42:16 -0700
X-Gmail-Original-Message-ID: <CALCETrXn5DHzySo3JGfAn=Ckhn4UG48L-UjauG8_L0D9Sd=WXg@mail.gmail.com>
Message-ID: <CALCETrXn5DHzySo3JGfAn=Ckhn4UG48L-UjauG8_L0D9Sd=WXg@mail.gmail.com>
Subject: Re: [PATCH] x86/entry/64: Disallow RDPID in paranoid entry if KVM is enabled
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Chang Seok Bae <chang.seok.bae@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 3:07 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 21/08/20 11:48, Borislav Petkov wrote:
> >> It's not like we grab MSRs every day.  The user-return notifier restores
> >> 6 MSRs (7 on very old processors).  The last two that were added were
> >> MSR_TSC_AUX itself in 2009 (!) and MSR_IA32_TSX_CTRL last year.
> > What about "If it is a shared resource, there better be an agreement
> > about sharing it." is not clear?
> >
> > It doesn't matter how many or which resources - there needs to be a
> > contract for shared use so that shared use is possible. It is that
> > simple.
>
> Sure, and I'll make sure to have that discussion the next time we add a
> shared MSR in 2029.
>
> In the meanwhile:
>
> * for the syscall MSRs, patches to share them were reviewed by hpa and
> peterz so I guess there's no problem.
>
> * for MSR_TSC_AUX, which is the one that is causing problems, everybody
> seems to agree with just using LSL (in the lack specific numbers on
> performance improvements from RDPID).
>
> * for MSR_IA32_TSX_CTRL.RTM_DISABLE, which is the only one that was
> added in the last 10 years, I'm pretty sure there are no plans for using
> the Trusty Sidechannel eXtension in the kernel.  So that should be fine
> too.  (The CPUID_CLEAR bit of the MSR is not shared).
>

Regardless of how anyone feels about who owns what in arch/x86 vs
arch/x86/kvm, the x86 architecture is a mess that comes from Intel and
AMD, and we have to deal with it.  On VMX, when a VM exits, the VM's
value of MSR_TSC_AUX is live, and we can take an NMI, MCE, or
abominable new #SX, #VE, #VC, etc on the next instruction boundary.
And unless we use the atomic MSR switch mechanism, the result is that
we're going through the entry path with guest-controlled MSRs.

So I think we can chalk this one up to obnoxious hardware.
