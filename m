Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71BCC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EBA92068F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XbPByrKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgDUPKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 11:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgDUPKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:10:13 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158F6C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 08:10:13 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id l11so11429611lfc.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 08:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XNK0e8yf1FrEYvaxfLQv37hJ9f6DqOREqQ/OEs3byWk=;
        b=XbPByrKcv2Fc3cTT2uQvd0lBB1L7Llj1mV8jtJw+7/p5IMdICaAGGf6LShzjU9krmG
         Omu1OxI7UC8sJL3plkMvJNbTh+qzjNjk1drRvt1aoR8yEeNn8ILglA6nJuLrhGaXYqVh
         w8LcASc34gOivyIQKmWmNTudAFpOrC2yJ1SR+p4HItnObTovsoQ3G4UHtyLH7kIv0NEb
         cEuBC1f41k0zwCGAMgVdVoktWIkQcetGDcQn+WU2z90N/6sisbVV6c3bOw+ZFFrg0CGh
         Hq72d5fBJfOLSovcq2+I5wMfnDhmr5rhT4jLCY/tCbF6uBxIj5G+LYrF+pcJKN3HAOK6
         WA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XNK0e8yf1FrEYvaxfLQv37hJ9f6DqOREqQ/OEs3byWk=;
        b=S5aaxienO4wKaqmiqV/IYfy4ZEytLxFMNiXaf5Uej1SIrytmmdvEMPvTonXQAzrG6N
         +ehosQ4MKHEjWM1VYBnFC8CQ25kE/M/E08XYDEItNALI/RGmGMaUKhGD9zE/PY8LAmbE
         aNI8MX4nHMm8ffiKOWMQcuYDh1x90Vg+7EXp/D4cc6QDMnseaEo2ntxWgMXzzg4Dryky
         cLd5sH/rPGDHlg6t8jKsDWVm3a8sIP2nRrjMizjWmudKPXcS86QJBBUg1Esc2zCh5g5q
         e6crlFzOQPC0md+f7QB5dec12rYWwVeYCOvH+oEXfeBy91C5xBaJ+9Z43o35TgM28pDK
         UmGQ==
X-Gm-Message-State: AGi0PuYMpl3vi9UwaE8Owmgr6I173Y4RKE+DQGQqdeH9Vd31mVX76QQg
        lmQol/a7uW18Vpy17H1Zvu0/6vKX/kwJ5vh9YwBG5w==
X-Google-Smtp-Source: APiQypKLNs/ylG/NH1TDF/1f7YloULLpvIqw0pPPlG6htHD8PvjqTjdNwtVQe7RGogQhs34Lny2XgnJhaBx8k+q+/Sg=
X-Received: by 2002:a19:c850:: with SMTP id y77mr13991308lff.45.1587481811207;
 Tue, 21 Apr 2020 08:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200419100848.63472-1-glider@google.com> <20200420153352.6682533e794f591dae7aafbc@linux-foundation.org>
 <202004201540.01C8F82B@keescook> <20200421034249.GB23230@ZenIV.linux.org.uk> <CAG_fn=X_eQ4G-0+oAO_q+_zRnkfMf4uhfMcnoYt4i1N_noKgdA@mail.gmail.com>
In-Reply-To: <CAG_fn=X_eQ4G-0+oAO_q+_zRnkfMf4uhfMcnoYt4i1N_noKgdA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 21 Apr 2020 17:09:44 +0200
Message-ID: <CAG48ez1u9=Uqcx2dH=7xea1R+WpnL239DSoVHLwV09=FxZUevQ@mail.gmail.com>
Subject: Re: [PATCH] fs/binfmt_elf.c: allocate initialized memory in fill_thread_core_info()
To:     Alexander Potapenko <glider@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, sunhaoyl@outlook.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+x86 folks

(rest of thread is on lore
<https://lore.kernel.org/lkml/20200419100848.63472-1-glider@google.com/>,
with original bug report on github
<https://github.com/google/kmsan/issues/76>)

On Tue, Apr 21, 2020 at 2:54 PM Alexander Potapenko <glider@google.com> wrote:
> On Tue, Apr 21, 2020 at 5:42 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Mon, Apr 20, 2020 at 03:41:40PM -0700, Kees Cook wrote:
> > > On Mon, Apr 20, 2020 at 03:33:52PM -0700, Andrew Morton wrote:
> > > > On Sun, 19 Apr 2020 12:08:48 +0200 glider@google.com wrote:
> > > >
> > > > > KMSAN reported uninitialized data being written to disk when dumping
> > > > > core. As a result, several kilobytes of kmalloc memory may be written to
> > > > > the core file and then read by a non-privileged user.
> > >
> > > Ewww. That's been there for 12 years. Did something change in
> > > regset_size() or regset->get()? Do you know what leaves the hole?
> >
> > Not lately and I would also like to hear the details; which regset it is?
> > Should be reasonably easy to find - just memset() the damn thing to something
> > recognizable, do whatever triggers that KMSAN report and look at that
> > resulting coredump.
> >
>
> Seems to be REGSET_XSTATE filled by xstateregs_get().
> Is there a ptrace interface also using that function?

It looks to me like the problem KMSAN found is that
copy_xstate_to_kernel() will not fill out memory for unused xstates? I
think this may have been introduced by commit 91c3dba7dbc1
("x86/fpu/xstate: Fix PTRACE frames for XSAVES", introduced in v4.8).

There seem to be no other functions that reach that path other than
coredumping; I think the correct fix would be to change
copy_xstate_to_kernel() to always fully initialize the output buffer.

The ptrace path uses copy_xstate_to_user(); there, instead of leaking
kernel memory to userspace, parts of the userspace buffer are simply
not written to at all.
