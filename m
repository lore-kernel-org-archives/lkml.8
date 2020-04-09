Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF42C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 05:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C96620B1F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 05:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586408443;
	bh=ybAemVinDOrFkWGU4pR0kABPQkU2CYgYUAJ3d024/hg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=t86RJ6pXGSrfYrRfJupuxhh0+VU5elCHcNVxP1qZNjJie7DX2hnNQzpGsPtbtdlu5
	 ySPi9mbboSLId1ldd14T6kSqEoM5tRscu+nDjPhmwIapdpm5D7mvJj79C4Gcauwevy
	 +1+pBDIc1YpFg1qSwcp1Qtb4jBeL0nWqunnCy3lM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgDIFAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 01:00:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgDIFAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 01:00:41 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8591C2084D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Apr 2020 05:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586408440;
        bh=ybAemVinDOrFkWGU4pR0kABPQkU2CYgYUAJ3d024/hg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=naYoU8128r/t5DBcg5YON2seFf+Pgvb+D3pHFg1EjnLsLSo30WFo2p+B7VGmAEae2
         x9hZFMicI3wqBHlV4v0c94LujKhWuyhBI+DeJcmQLJUrMBp90yGwmcjfiptlttdVbU
         lMA0A5DMjV7VkJNDdl0zF019oKwvEQOMzypx+ITo=
Received: by mail-wm1-f51.google.com with SMTP id v8so1620143wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 22:00:40 -0700 (PDT)
X-Gm-Message-State: AGi0PubIoV4E4ZPPDF5ux68qLCAvA/Dc7uq08ASA8ZYCod3LaRdnp0y6
        JrMhBcgIO2rnGO3DxMje7RmWeA/7INluSxA52dEcjA==
X-Google-Smtp-Source: APiQypIRJj7f30eROzcVUMIqGh0ifT2Cl8xvUp1wurfEe/Fdj9DuHrhVpqsSMHno4+Uy9AvpjV+ZRXUkSPNiYTbW66I=
X-Received: by 2002:a7b:c8cd:: with SMTP id f13mr8047341wml.138.1586408438909;
 Wed, 08 Apr 2020 22:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2004081607050.27197@tglase.lan.tarent.de>
In-Reply-To: <alpine.DEB.2.22.394.2004081607050.27197@tglase.lan.tarent.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 8 Apr 2020 22:00:27 -0700
X-Gmail-Original-Message-ID: <CALCETrUkC0mfbo44+Jb7p6f19S+nH5VAEZAwTaYApbNqy9Fj-w@mail.gmail.com>
Message-ID: <CALCETrUkC0mfbo44+Jb7p6f19S+nH5VAEZAwTaYApbNqy9Fj-w@mail.gmail.com>
Subject: Re: __X32_SYSCALL_BIT being defined as UL constant breaks userspace
To:     Thorsten Glaser <t.glaser@tarent.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, 954294@bugs.debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 8, 2020 at 7:34 AM Thorsten Glaser <t.glaser@tarent.de> wrote:
>
> Hello,
>
> I=E2=80=99m writing to you because your name shows up on this:
>
> commit 45e29d119e9923ff14dfb840e3482bef1667bbfb
> Author: Andy Lutomirski <luto@kernel.org>
> Date:   Wed Jul 3 13:34:05 2019 -0700
>
>     x86/syscalls: Make __X32_SYSCALL_BIT be unsigned long
>
>     Currently, it's an int.  This is bizarre.  Fortunately, the code usin=
g it
>     still works: ~__X32_SYSCALL_BIT is also int, so, if nr is unsigned lo=
ng,
>     then C kindly sign-extends the ~__X32_SYSCALL_BIT part, and it actual=
ly
>     results in the desired value.
>
>     This is far more subtle than it deserves to be.  Syscall numbers are,=
 for
>     all practical purposes, unsigned long, so make __X32_SYSCALL_BIT be
>     unsigned long.
>
>     Signed-off-by: Andy Lutomirski <luto@kernel.org>
>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>     Link: https://lkml.kernel.org/r/99b0d83ad891c67105470a1a6b63243fd63a5=
061.1562185330.git.luto@kernel.org
>
> This commit changed an uapi header, breaking userspace. Long debugging
> story (https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D954294 if you
> are interested) short, it goes like this:
>
> libseccomp exposes an interface SCMP_SYS() which is designed to expand
> to an int and be usable in cpp context. It redirects to the __NR_*
> constants from <asm/unistd.h>.
>
> Example: SCMP_SYS(mmap) becomes __NR_mmap or __NR_mmap2 (depending on
> the architecture).
>
> Now, most architectures define __NR_mmap as a mere integer number:
>
> asm/unistd_32.h:#define __NR_mmap 90
> asm/unistd_64.h:#define __NR_mmap 9
>
> x32 differs:
>
> asm/unistd_x32.h:#define __NR_mmap (__X32_SYSCALL_BIT + 9)
>
> This construct is, thankfully, still usable in something like
>         #if (__NR_mmap > __NR_somethingelse)
> but as __X32_SYSCALL_BIT is no longer int its type also isn=E2=80=99t.
>
> Therefore I ask you to revert this change, bringing x32 closer
> to all other architectures.
>

One might reasonably ask whether it makes sense for syscall nrs to be
signed at all.

But regardless, this breaks userspace and we should fix it.  I can
whip up a patch to split it into X32_SYSCALL_BIT (unsigned long) and
__X32_SYSCALL_BIT (uapi, int).  Thomas, etc, does this seem
reasonable?  (For those not following all the machinations, this
change caused some userspace build failures in libseccomp and/or
systemd for reasons that are vaguely silly.)

> > Syscall numbers are, for
> > all practical purposes, unsigned long
>
> Yes, except for the one purpose of the C data type of the
> syscall constants exposed to userspace, they are.
>
> Feel free to handle __X32_SYSCALL_BIT differently in the
> kernel (although even there it *will* introduce subtle
> differences from other architectures), but please keep it
> as int as visible from userspace.
>
> Thanks in advance,
> //mirabilos
>
> PS: Please keep both me *and* the Debian bug in Cc, but
>     feel free to forward to relevant lists and persons;
>     I=E2=80=99m unsure where exactly to write to about this.
>
> @bwh: commit 45e29d119e9923ff14dfb840e3482bef1667bbfb is
>     literally just this=E2=80=A6
>         -#define __X32_SYSCALL_BIT      0x40000000
>         +#define __X32_SYSCALL_BIT      0x40000000UL
>     =E2=80=A6 so can you please revert it in Debian in the meantime,
>     even if you said you won=E2=80=99t spend time on this?
> --
> tarent solutions GmbH
> Rochusstra=C3=9Fe 2-4, D-53123 Bonn =E2=80=A2 http://www.tarent.de/
> Tel: +49 228 54881-393 =E2=80=A2 Fax: +49 228 54881-235
> HRB 5168 (AG Bonn) =E2=80=A2 USt-ID (VAT): DE122264941
> Gesch=C3=A4ftsf=C3=BChrer: Dr. Stefan Barth, Kai Ebenrett, Boris Esser, A=
lexander Steeg
>
> **********
>
> Mit der tarent Academy bieten wir auch Trainings und Schulungen in den
> Bereichen Softwareentwicklung, Agiles Arbeiten und Zukunftstechnologien a=
n.
>
> Besuchen Sie uns auf www.tarent.de/academy. Wir freuen uns auf Ihren Kont=
akt.
>
> **********
