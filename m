Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78B2C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3E0C206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MlI4a+Q0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgDUUVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgDUUVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 16:21:02 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0131EC0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 13:21:01 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x15so2853320pfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 13:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Evw1V4uqZUGpDYDYCxbYGse6+dosIR0q5W80NJbevCQ=;
        b=MlI4a+Q0NL3nf6rN90gBE+yFxugJvCBMyDx99QqzvyXaExEif85YkmaaUBmq99vnpw
         qny0gaf4mSIgnaaHkG5mWXZUB+uJPUTT326Q1ePJE5ECq8FT7v3H0nZEkDYh7qSTn+Br
         uK7+C9tz+P4YnkhMosnBcye0RtX4xKniCA208=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Evw1V4uqZUGpDYDYCxbYGse6+dosIR0q5W80NJbevCQ=;
        b=uDMsOLD22rQnlIrLdlIJW8Ud/3sHuT6VQRsbfusqu00sX4vlClOO0fkzW6e1WK5FL9
         xcWEvNVQq0xN0ir6wHILBhTBGGGG6O5HtNtsxpzUeePjsEcG+qkU0+EHeQZkGvmKBwv/
         XwLafPYTc7NxHE76JQpAJfSKBJ13iosfhZWu1yoAyviF2E1kO97sLCJZqZ/qmvlwYAMW
         iK8ojacq0Y+/PPquzI7lfjiRh5Z9DUiz1NBZDCrOYsqaz/xskHwP8JS+wTTm/D4BWqhk
         VhCttiXS4yDuBm4TziaJfB7y67KTmW2WLsXDn/s7rhQLZ8ZLmUCBQ5kaL5QOyTg01Fiv
         uyzw==
X-Gm-Message-State: AGi0PuY2vknqMPwUVQa65nM/H5DOx2n1hMdKQ3o86HBaeEhUJgP05muw
        g5IVsJDazZVtf9n2nlhTRt5GQQ==
X-Google-Smtp-Source: APiQypK5zjoBsN5dAMVf3TlGO0rGxrwa5QoCwpIE9oZ/RcEcy64db6eJcMf+zLkUx5GnhRZdLICS+A==
X-Received: by 2002:a63:e94f:: with SMTP id q15mr23344386pgj.339.1587500460548;
        Tue, 21 Apr 2020 13:21:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a138sm3244383pfd.32.2020.04.21.13.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 13:20:59 -0700 (PDT)
Date:   Tue, 21 Apr 2020 13:20:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, sunhaoyl@outlook.com
Subject: Re: [PATCH] fs/binfmt_elf.c: allocate initialized memory in
 fill_thread_core_info()
Message-ID: <202004211320.C2B3840@keescook>
References: <20200419100848.63472-1-glider@google.com>
 <20200420153352.6682533e794f591dae7aafbc@linux-foundation.org>
 <202004201540.01C8F82B@keescook>
 <20200421034249.GB23230@ZenIV.linux.org.uk>
 <CAG_fn=X_eQ4G-0+oAO_q+_zRnkfMf4uhfMcnoYt4i1N_noKgdA@mail.gmail.com>
 <CAG48ez1u9=Uqcx2dH=7xea1R+WpnL239DSoVHLwV09=FxZUevQ@mail.gmail.com>
 <6eb0a398097d16f7247accdfa9c21c1da90e0461.camel@intel.com>
 <CAG48ez0rWH+kQVFVwwrZHqbL5G5H7CEJ-_xYsF15Wo2RzrqDfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0rWH+kQVFVwwrZHqbL5G5H7CEJ-_xYsF15Wo2RzrqDfg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 06:16:25PM +0200, Jann Horn wrote:
> On Tue, Apr 21, 2020 at 6:05 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> > On Tue, 2020-04-21 at 17:09 +0200, Jann Horn wrote:
> > > +x86 folks
> > >
> > > (rest of thread is on lore
> > > <https://lore.kernel.org/lkml/20200419100848.63472-1-glider@google.com/>;,
> > > with original bug report on github
> > > <https://github.com/google/kmsan/issues/76>;)
> > >
> > > On Tue, Apr 21, 2020 at 2:54 PM Alexander Potapenko <glider@google.com> wrote:
> > > > On Tue, Apr 21, 2020 at 5:42 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > > > On Mon, Apr 20, 2020 at 03:41:40PM -0700, Kees Cook wrote:
> > > > > > On Mon, Apr 20, 2020 at 03:33:52PM -0700, Andrew Morton wrote:
> > > > > > > On Sun, 19 Apr 2020 12:08:48 +0200 glider@google.com wrote:
> > > > > > >
> > > > > > > > KMSAN reported uninitialized data being written to disk when dumping
> > > > > > > > core. As a result, several kilobytes of kmalloc memory may be written to
> > > > > > > > the core file and then read by a non-privileged user.
> > > > > >
> > > > > > Ewww. That's been there for 12 years. Did something change in
> > > > > > regset_size() or regset->get()? Do you know what leaves the hole?
> > > > >
> > > > > Not lately and I would also like to hear the details; which regset it is?
> > > > > Should be reasonably easy to find - just memset() the damn thing to something
> > > > > recognizable, do whatever triggers that KMSAN report and look at that
> > > > > resulting coredump.
> > > > >
> > > >
> > > > Seems to be REGSET_XSTATE filled by xstateregs_get().
> > > > Is there a ptrace interface also using that function?
> > >
> > > It looks to me like the problem KMSAN found is that
> > > copy_xstate_to_kernel() will not fill out memory for unused xstates? I
> > > think this may have been introduced by commit 91c3dba7dbc1
> > > ("x86/fpu/xstate: Fix PTRACE frames for XSAVES", introduced in v4.8).
> > >
> > > There seem to be no other functions that reach that path other than
> > > coredumping; I think the correct fix would be to change
> > > copy_xstate_to_kernel() to always fully initialize the output buffer.
> >
> > Yes, that makes sense.  On the other hand, the kzalloc() fix prevents potential
> > similar problems for other regsets.
> 
> I don't really have anything against using kzalloc() there; but in my
> opinion that's not a fix, that's hardening. The real problem, in my
> opinion, is that regset->get() claims to have filled out a buffer
> without actually having done so; and if someone happens to add another
> caller to that thing in the future, I don't want them to run into
> exactly the same problem again.

Right -- we should fix both.

-- 
Kees Cook
