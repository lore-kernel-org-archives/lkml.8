Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EBEC2D0E7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30CC920719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585264453;
	bh=pBpYKCYnqkY69V5IhWZ/DJiK6T7TRaVaD2ZvmGOEuS4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=os4/et8oEdIRR6Cx/sMPTmmNDaw1E00c7Z/nOtyjrxcVNGRhsaO3sjCQh1UNH4Bsc
	 3lUIQPXt3+mDdCi2p9d7fEVduYxPRbQOPg7GFy9Z+knuBMslRNhC6erAjHPKgTAqZ9
	 9/ta4EozYsxCDX9rNboCIGsaECPg2lHFIje4+bOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgCZXOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 19:14:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbgCZXOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 19:14:11 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 530F020787
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 23:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585264450;
        bh=pBpYKCYnqkY69V5IhWZ/DJiK6T7TRaVaD2ZvmGOEuS4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nNx+mI6ABRCHDoPFwj94WyC7rJi0CnjZZMRGH1IMgdPUiiYaDdczR2RYxzmj5F3VY
         gMHKe5fl7h5UDsvgBHpIe3+tNvgdkfhOdN/0Ivu7iqYlvZwEpbUs1auWaN3fyfFyxn
         SPwdX0Y64sOV1ufFqHPBZrTcIrsIY5kN69kTiAsc=
Received: by mail-wm1-f44.google.com with SMTP id f6so3660054wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 16:14:10 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1grtehqdXJ0sPiJ2uJOkdwLC+iUEakTtJIcbGsWZjT0H2IWxy0
        Pc6sZWLTCk2ZtTUwXYksG0JChG0Mz2DuMyxDry1Fdw==
X-Google-Smtp-Source: ADFU+vuwoO/FGdbYD7WuoSUeoCQPV6aJnU4Jo48Ndl/Q19AIohripXx7VFMXL5Ej+zBmJfVFYrfJhZMXOGODzbtI3yA=
X-Received: by 2002:adf:b641:: with SMTP id i1mr11924938wre.18.1585264448743;
 Thu, 26 Mar 2020 16:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200325194317.526492-1-ross.philipson@oracle.com>
 <CACdnJut56WuqO=uLff0qy1Jp=C6f_sRxLpRBsrzb6byBsFYdCg@mail.gmail.com>
 <CALCETrUshiLMHyf4DShgDRtCvnzUVyRQgmgCiudvhuhw05cDxg@mail.gmail.com> <6bb09673-292e-b056-3755-ffc51a1d6b59@apertussolutions.com>
In-Reply-To: <6bb09673-292e-b056-3755-ffc51a1d6b59@apertussolutions.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 26 Mar 2020 16:13:56 -0700
X-Gmail-Original-Message-ID: <CALCETrUnyTbihpqjZ-rwKDsyS=1yMg1KGTD60PJMj7R1-5PbhA@mail.gmail.com>
Message-ID: <CALCETrUnyTbihpqjZ-rwKDsyS=1yMg1KGTD60PJMj7R1-5PbhA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/12] x86: Trenchboot secure late launch Linux kernel support
To:     "Daniel P. Smith" <dpsmith@apertussolutions.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 1:51 PM Daniel P. Smith
<dpsmith@apertussolutions.com> wrote:
>
> On 3/25/20 6:51 PM, Andy Lutomirski wrote:
> > On Wed, Mar 25, 2020 at 1:29 PM Matthew Garrett <mjg59@google.com> wrote:
> >>
> >> On Wed, Mar 25, 2020 at 12:43 PM Ross Philipson
> >> <ross.philipson@oracle.com> wrote:
> >>> To enable the kernel to be launched by GETSEC or SKINIT, a stub must be
> >>> built into the setup section of the compressed kernel to handle the
> >>> specific state that the late launch process leaves the BSP. This is a
> >>> lot like the EFI stub that is found in the same area. Also this stub
> >>> must measure everything that is going to be used as early as possible.
> >>> This stub code and subsequent code must also deal with the specific
> >>> state that the late launch leaves the APs in.
> >>
> >> How does this integrate with the EFI entry point? That's the expected
> >> entry point on most modern x86. What's calling ExitBootServices() in
> >> this flow, and does the secure launch have to occur after it? It'd be
> >> a lot easier if you could still use the firmware's TPM code rather
> >> than carrying yet another copy.
> >
> > I was wondering why the bootloader was involved at all.  In other
> > words, could you instead hand off control to the kernel just like
> > normal and have the kernel itself (in normal code, the EFI stub, or
> > wherever it makes sense) do the DRTM launch all by itself?  This would
> > avoid needing to patch bootloaders, to implement this specially for
> > QEMU -kernel, to get the exact right buy-in from all the cloud
> > vendors, etc.  It would also give you more flexibility to evolve
> > exactly what configuration maps to exactly what PCRs in the future.
> >
>
> Partly this is driven by the fact that one of the goals for the
> TrenchBoot project is about more universal/unified, cross open source
> project adoption of Dynamic Launch. Another aspect is that initiating a
> Dynamic Launch requires additional file(s) to be loaded, the platform to
> be put into a quiescent state, and the invocation of the SENTER/SKINIT
> instruction can be thought of as a soft reset of the CPU that on Intel
> even results in the CPU being in a different mode (SMX) which has a
> subtle change to its behavior. In the TCG Dynamic Launch design, the
> component responsible for this loading, preparing, and Dynamic Launch
> Instruction invocation is referred to as the Preamble and IMHO the best
> time for dealing with such a disruptive behavior caused by invoking the
> instruction is at the boot boundary. It also makes for a good transition
> point to enable switching between kernels in control of the system
> whereby the integrity will be establish by the hardware instead of the
> kernel (UEFI, GRUB, Linux, etc.) that loaded it. I think what helps
> address your concern is that one of the next items on the roadmap is to
> extend kexec to be able to perform the Preamble. As I just mentioned,
> this provides a clean way to transition for one Linux kernel that may or
> may not have been started via a Dynamic Launch could relaunch itself,
> launch a new Linux kernel, or even launch a non-Linux kernel that is
> Dynamic Launch aware.
>

Hmm.  I don't have any real objection to the kernel supporting this
type of secure launch, but I do have some more questions first.

One of the problems with the old tboot code and the general state of
dynamic-root-of-trust is that it's an incredible pain in the neck to
even test.  I think it would be helpful if I could build a kernel that
supported secure launch (Intel or AMD) and just run the thing.  I
realize that you're planning to integrate this into GRUB, etc, but it
might be nice if even existing GRUB and EFI shell can do this.  How
hard would it be to make the kernel support a mode where whatever
blobs are required are in the initrd or built in like firmware and
where I could set a command line argument like secure_launch=on and
have the kernel secure launch itself?

Are you planning on supporting a mode where kernel A kexecs to kernel
B, kernel B is secure launched, and then kernel B resumes kernel A and
re-launches it?  If so, would it work better if the measured state of
the kernel were the *uncompressed* text or even the uncompressed and
alternative-ified text?  Or is the idea that the secure launch entry
will figure out that it's actually a resume and not a fresh boot and
behave accordingly?

What's the situation like in a VM?  Can I run the secure launch entry
in a VM somehow?  Can I actually initiate the dynamic launch from the
VM?
