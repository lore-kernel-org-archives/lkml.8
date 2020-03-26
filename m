Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14C9C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E6020714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585263166;
	bh=OKaOV10aSv+w7aRtKdmajPo4mtiQ/GKB05g0taL9xZQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TemsnFBHtWPiDbzylCEjhrejVNxlvSeFouZOHg6wSMYdAduM+M/zNw9iKDsieiKWf
	 NdqDNc0Xu/6tIjJZIYlNKEE/BprybLlQVPLgUl/vYgpqSeWrRZ5lhG+7c/HrbefH1o
	 XXnNUHa+ajRvEvM0zrXq0bzowT06VHfkEEnDX/cw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgCZWwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 18:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgCZWwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 18:52:45 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91F632073E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 22:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585263163;
        bh=OKaOV10aSv+w7aRtKdmajPo4mtiQ/GKB05g0taL9xZQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uAXqPazjzsK5XyPxG0TkTaiKhFnIiNrk0ODtgaRGwwMAhbMlnyGqhcf/o5SBqhcYV
         rTn89uuNAmaUC41Q+FLf7vgcwyQSta0L2NmNLxj9fTWoN0o69/uYz4xtHruJVObmuS
         0W9B6bjeBMfVUvyO/qufNjBAeYZWEa+rGk7Mfe/0=
Received: by mail-wm1-f48.google.com with SMTP id g62so10137192wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 15:52:43 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3o5Pp5BN9eKgYrJFhEe+kxn9dKdBE4ZHMBkq6hWKb22bPv5SO9
        4+6U1eiw8KQxZeyWtBt5O+U4YupvzNOn9yfjabjLfA==
X-Google-Smtp-Source: ADFU+vtGhOoSeBlioPgd1l6MFQhubTaMcq6Rizuo6hpVyiypUEOuobjEzsegMH8u2w1tqgD+WpgwPdvlKoV1nYFfoqs=
X-Received: by 2002:adf:f2c7:: with SMTP id d7mr11468528wrp.184.1585263162026;
 Thu, 26 Mar 2020 15:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <CACdnJusd7m-c0zLmAjSq9Sb9HxyCkhyyp5W=4FMdysgu7_g=Sw@mail.gmail.com>
 <BB670F86-9362-4A8C-8BE6-64A5AF9537A7@amacapital.net> <CACdnJus6H3LQww8hkTMpPKN7u_sb1PXmgPwQOCSVZR_fi7GMrA@mail.gmail.com>
In-Reply-To: <CACdnJus6H3LQww8hkTMpPKN7u_sb1PXmgPwQOCSVZR_fi7GMrA@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 26 Mar 2020 15:52:30 -0700
X-Gmail-Original-Message-ID: <CALCETrU4W7q=QyTX_iq_kN4nVK58WoOD0F_NBt7z8p7xiE7hfA@mail.gmail.com>
Message-ID: <CALCETrU4W7q=QyTX_iq_kN4nVK58WoOD0F_NBt7z8p7xiE7hfA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/12] x86: Trenchboot secure late launch Linux kernel support
To:     Matthew Garrett <mjg59@google.com>
Cc:     Daniel Kiper <daniel.kiper@oracle.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "Daniel P. Smith" <dpsmith@apertussolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        trenchboot-devel@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>, leif@nuviainc.com,
        eric.snowberg@oracle.com, piotr.krol@3mdeb.com,
        krystian.hebel@3mdeb.com, michal.zygowski@3mdeb.com,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 2:28 PM Matthew Garrett <mjg59@google.com> wrote:
>
> On Thu, Mar 26, 2020 at 2:07 PM Andy Lutomirski <luto@amacapital.net> wro=
te:
> > > On Mar 26, 2020, at 1:40 PM, Matthew Garrett <mjg59@google.com> wrote=
:
> > >
> > > =EF=BB=BFOn Thu, Mar 26, 2020 at 1:33 PM Andy Lutomirski <luto@amacap=
ital.net> wrote:
> > >> As a straw-man approach: make the rule that we never call EFI after =
secure launch. Instead we write out any firmware variables that we want to =
change on disk somewhere.  When we want to commit those changes, we reboot,=
 commit the changes, and re-launch. Or we deactivate the kernel kexec-style=
, seal the image against PCRs, blow away PCRs, call EFI, relaunch, unseal t=
he PCRs, and continue on our merry way.
> > >
> > > That breaks the memory overwrite protection code, where a variable is
> > > set at boot and cleared on a controlled reboot.
> >
> > Can you elaborate?  I=E2=80=99m not familiar with this.
>
> https://trustedcomputinggroup.org/wp-content/uploads/TCG_PlatformResetAtt=
ackMitigationSpecification_1.10_published.pdf
> - you want to protect in-memory secrets from a physically present
> attacker hitting the reset button, booting something else and just
> dumping RAM. This is avoided by setting a variable at boot time (in
> the boot stub), and then clearing it on reboot once the secrets have
> been cleared from RAM. If the variable isn't cleared, the firmware
> overwrites all RAM contents before booting anything else.

I admit my information is rather dated, but I'm pretty sure that at
least some and possibly all TXT implementations solve this more
directly.  In particular, as I understand it, when you TXT-launch
anything, a nonvolatile flag in the chipset is set.  On reboot, the
chipset will not allow access to memory *at all* until an
authenticated code module wipes memory and clears that flag.

If your computer advertises TXT support but is missing that ACM, you
are SOL.  I learned about this when I bricked my old Lenovo laptop. As
far as I can tell, the flag was set, but the Lenovo BIOS didn't know
how to wipe memory.  Whoops!

>
> > > As for the second approach - how would we
> > > verify that the EFI code hadn't modified any user pages? Those
> > > wouldn't be measured during the second secure launch. If we're callin=
g
> > > the code at runtime then I think we need to assert that it's trusted.
> >
> > Maybe you=E2=80=99re misunderstanding my suggestion.  I=E2=80=99m sugge=
sting that we hibernate the whole running system to memory (more like kexec=
 jump than hibernate) and authenticated-encrypt the whole thing (including =
user memory) with a PCR-sealed key. We jump to a stub that zaps PCRs does E=
FI calls. Then we re-launch and decrypt memory.
>
> When you say "re-launch", you mean perform a second secure launch? I
> think that would work, as long as we could reconstruct an identical
> state to ensure that the PCR17 values matched - and that seems like a
> hard problem.

Exactly.  I would hope that performing a second secure launch would
reproduce the same post-launch PCRs as the first launch.  If the
kernel were wise enough to record all PCR extensions, it could replay
them.

(I can imagine an alternate universe in which the PCR extension used a
more clever algorithm that allowed log-time fast forwarding.  As far
as I know, this is not currently the case.)

In any case, I'm kind of with Daniel here.  We survived for quite a
long time without EFI variables at all.  The ability to write them is
nice, and we certainly need some way, however awkward, to write them
on rare occasions, but I don't think we really need painless runtime
writes to EFI variables.
