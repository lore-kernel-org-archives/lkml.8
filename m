Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBFCC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C73032070B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NXEelkyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgDUQQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726245AbgDUQQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:16:54 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2639BC061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:16:53 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id l19so12069512lje.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sZb/G+BPZCnKqNsOXZmWC5vghAcQlH+ouaFUjXK/3AQ=;
        b=NXEelkyDEgdRL1G6FH5p2bLty3HGgMXhS0omaT+tore+VnjnCscaeRkZIkG0FdUEZ5
         nKYoGvT1giT0+uB+hMl+Pm2c3/21ZLx+MS+mRYgvqVdokvuVAAV1LclnPMMl/PygRBMK
         6MtBvJTPS+WVdN2pI09XNbg2guoLV2q3qgyybxloiX4Mmrw092X2L1nNZspfO7UJgTsp
         fcIlZX7uV5/7/2YznW0FpGYRbo+pwucTQaSvYrZEtTtrjqrUMdI22zhsSAGQtWkS5upo
         Zm4XjUPNb/JZ1ZWiFx+bUac7Hug/bhh3A48FbervaNkkjFnD+FzUygLkmnP+DMYYzUMO
         jr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sZb/G+BPZCnKqNsOXZmWC5vghAcQlH+ouaFUjXK/3AQ=;
        b=dc/stbc73j/TtfQf8vhswexQA5I41tpEHw+FaE2WHAP0aBPlrAAdskxIgMdvWDqndC
         qyC0EHNht50jHmhTbKIHFcQEq5U1OuKdGXNE0gMK9UGQmd7vVjf7vG1B+mk7I2bNnK8w
         Vte9pHSbJD6iZ3hASKrjEE+aDNg9JCAJmg2jKMApsbEp0AeZoN5tVdBZmxQk+x+R6Lx9
         WNP8IoYQM5sSqsCSZ8VIMJVXG6FeJYwBfH76podPRwwx+iPzyNXsifnHuFBca+S8o8ad
         ftNh6VcOomNDD80bHGA2ZVA1KGtsh30yeMHQIu57OsBOuxL0ka8SNC23sd4cxCLEcM+3
         3+kQ==
X-Gm-Message-State: AGi0PuZ3fdIItesWyG4aLlRsJNqMoZNtuLF0xp3fgGVNCHt6HLNKxaq0
        5q0naYsVO2fpWoLorI7JMuEhGbbhywI5pgksfx1EnA==
X-Google-Smtp-Source: APiQypL1Spb7veDXsbQKHPlWDL1mJhlHyH2D2suMl7FZvElj6bCXd/LGRfmT1nvoCOgL6r3oimIYlQH43FpnAe/uJbs=
X-Received: by 2002:a2e:87d3:: with SMTP id v19mr4440555ljj.176.1587485811325;
 Tue, 21 Apr 2020 09:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200419100848.63472-1-glider@google.com> <20200420153352.6682533e794f591dae7aafbc@linux-foundation.org>
 <202004201540.01C8F82B@keescook> <20200421034249.GB23230@ZenIV.linux.org.uk>
 <CAG_fn=X_eQ4G-0+oAO_q+_zRnkfMf4uhfMcnoYt4i1N_noKgdA@mail.gmail.com>
 <CAG48ez1u9=Uqcx2dH=7xea1R+WpnL239DSoVHLwV09=FxZUevQ@mail.gmail.com> <6eb0a398097d16f7247accdfa9c21c1da90e0461.camel@intel.com>
In-Reply-To: <6eb0a398097d16f7247accdfa9c21c1da90e0461.camel@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 21 Apr 2020 18:16:25 +0200
Message-ID: <CAG48ez0rWH+kQVFVwwrZHqbL5G5H7CEJ-_xYsF15Wo2RzrqDfg@mail.gmail.com>
Subject: Re: [PATCH] fs/binfmt_elf.c: allocate initialized memory in fill_thread_core_info()
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, sunhaoyl@outlook.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 6:05 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> On Tue, 2020-04-21 at 17:09 +0200, Jann Horn wrote:
> > +x86 folks
> >
> > (rest of thread is on lore
> > <https://lore.kernel.org/lkml/20200419100848.63472-1-glider@google.com/>;,
> > with original bug report on github
> > <https://github.com/google/kmsan/issues/76>;)
> >
> > On Tue, Apr 21, 2020 at 2:54 PM Alexander Potapenko <glider@google.com> wrote:
> > > On Tue, Apr 21, 2020 at 5:42 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > > On Mon, Apr 20, 2020 at 03:41:40PM -0700, Kees Cook wrote:
> > > > > On Mon, Apr 20, 2020 at 03:33:52PM -0700, Andrew Morton wrote:
> > > > > > On Sun, 19 Apr 2020 12:08:48 +0200 glider@google.com wrote:
> > > > > >
> > > > > > > KMSAN reported uninitialized data being written to disk when dumping
> > > > > > > core. As a result, several kilobytes of kmalloc memory may be written to
> > > > > > > the core file and then read by a non-privileged user.
> > > > >
> > > > > Ewww. That's been there for 12 years. Did something change in
> > > > > regset_size() or regset->get()? Do you know what leaves the hole?
> > > >
> > > > Not lately and I would also like to hear the details; which regset it is?
> > > > Should be reasonably easy to find - just memset() the damn thing to something
> > > > recognizable, do whatever triggers that KMSAN report and look at that
> > > > resulting coredump.
> > > >
> > >
> > > Seems to be REGSET_XSTATE filled by xstateregs_get().
> > > Is there a ptrace interface also using that function?
> >
> > It looks to me like the problem KMSAN found is that
> > copy_xstate_to_kernel() will not fill out memory for unused xstates? I
> > think this may have been introduced by commit 91c3dba7dbc1
> > ("x86/fpu/xstate: Fix PTRACE frames for XSAVES", introduced in v4.8).
> >
> > There seem to be no other functions that reach that path other than
> > coredumping; I think the correct fix would be to change
> > copy_xstate_to_kernel() to always fully initialize the output buffer.
>
> Yes, that makes sense.  On the other hand, the kzalloc() fix prevents potential
> similar problems for other regsets.

I don't really have anything against using kzalloc() there; but in my
opinion that's not a fix, that's hardening. The real problem, in my
opinion, is that regset->get() claims to have filled out a buffer
without actually having done so; and if someone happens to add another
caller to that thing in the future, I don't want them to run into
exactly the same problem again.
