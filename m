Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B196C38BFA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C26E20CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R6ZspJE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgBXWBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:01:51 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33393 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgBXWBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 17:01:50 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay11so4608246plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 14:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IWLJOFGxvVMno0/8se2X6awifOIRIcp17izGUYTA88c=;
        b=R6ZspJE6BKeyLBYb3uDCGB6uHR5kSBAGhpFj+YA6ggUG2ZOClQsLxq2H5hDhWdv1++
         zxhxpdFAAlnEW7lBsiHuxygxgE/tAJxDARzipH13NUvi18Qgtl1uliBn6eO72WI7eu32
         2BW6jv64X8G+aHxSlFoUZY3/QYui6aQ1eo6HyU7UkveWV2VFSF5xEGjAqrEoqISa7MVl
         tZozoWXHvvVIoiz5YkdSHqDxhS99/qqMbqeG7rq3jDocLmHr/cMl5k1TgSxhgKzol/XV
         pfZXXq7U8/9NZp7ctavoZ95mCuAmoTFZ2s9t0lQ18rUr4beSKmILAAnxxlGt4W1fA3Wl
         cHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IWLJOFGxvVMno0/8se2X6awifOIRIcp17izGUYTA88c=;
        b=CGiviftn2hw4qhqVs9F6P/EyPtI42Ikc23aII5/WNSvf5MXfohttZyZPBRA8fI4kAS
         6zd82LRZ8LeERnTvmKBZ2azUqb0pymE+vbELcHhY03plvq23IsNqjNdVgC1kuafbbiQE
         82yfyGA2p6ldTn4EHFRegRmpSq40+PqYmRgNLfpPMVXwz0wLw3/GvT6wkHLV3HhmiFvB
         fqGogbFeATpZK4qi4Ccqt7lqxplTtLGWn8nEDwXCHvB9+iYux9lj1qf9n5UYUNEHrNDg
         rSFuMfSfRda1lEgBolBb26/+1rlit7yDGGNwiSQ2WqTPrP8B+mwotveme8EE/ekHgw5S
         YzqA==
X-Gm-Message-State: APjAAAU1ufkUEUbXF+DR3DHK6IeUi6g2aYlDk0gjxKG1WEoV7P0iajRd
        8G3w+9fnBMRoFyzBfPsFesI1Oo8ye/aIKlldb/Lrnw==
X-Google-Smtp-Source: APXvYqxKzg/oBaNl//6NNxQfT+omS7C/oZWisYiab6zxk3PPHgMQSrnjUUqPCUpzYK0+BMtWF+YBjdZj7kMWAboOC9E=
X-Received: by 2002:a17:90a:7784:: with SMTP id v4mr1372238pjk.134.1582581709602;
 Mon, 24 Feb 2020 14:01:49 -0800 (PST)
MIME-Version: 1.0
References: <20200222235709.GA3786197@rani.riverdale.lan> <20200223193715.83729-1-nivedita@alum.mit.edu>
 <CAKwvOd=qVmb7UEzUSQ5-MUhpRA9Jpu3fMmmMLGdmydLoJV-kkQ@mail.gmail.com> <20200224215330.GA560533@rani.riverdale.lan>
In-Reply-To: <20200224215330.GA560533@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Feb 2020 14:01:38 -0800
Message-ID: <CAKwvOd=wGYRPY32P3xA-WGG5FiNYk-S6BrjLw3nRqcQ3X0oPFg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Stop generating .eh_frame sections
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>, Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 1:53 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Mon, Feb 24, 2020 at 12:49:03PM -0800, Nick Desaulniers wrote:
> > On Sun, Feb 23, 2020 at 11:37 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > In three places in the x86 kernel we are currently generating .eh_frame
> > > sections only to discard them later via linker script. This is in the
> > > boot code (setup.elf), the realmode trampoline (realmode.elf) and the
> > > compressed kernel.
> > >
> > > Implement Fangrui and Nick's suggestion [1] to fix KBUILD_CFLAGS by
> > > adding -fno-asynchronous-unwind-tables to avoid generating .eh_frame
> > > sections in the first place, rather than discarding it in the linker
> > > script.
> > >
> > > Arvind Sankar (2):
> > >   arch/x86: Use -fno-asynchronous-unwind-tables to suppress .eh_frame sections
> > >   arch/x86: Drop unneeded linker script discard of .eh_frame
> >
> > Thanks for the series! I've left some feedback for a v2. Would you
> > mind please including a revert of ("x86/boot/compressed: Remove
> > unnecessary sections from bzImage") in a v2 series?  Our CI being red
> > through the weekend is no bueno.
>
> Sorry about that. Boris already updated tip:x86/boot to only discard
> eh_frame, so your CI should be ok at least now.

Yep: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/boot&id=0eea39a234dc52063d14541fabcb2c64516a2328
Looks like our daily CI ran 6 hours ago just missed it:
https://travis-ci.com/ClangBuiltLinux/continuous-integration/jobs/290435629
Thanks for the fix!

-- 
Thanks,
~Nick Desaulniers
