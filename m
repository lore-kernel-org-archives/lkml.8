Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38D9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CFCA20899
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iAFVfplI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgGMWY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgGMWY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 18:24:28 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17BDC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:24:28 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ch3so591726pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VTtkH3MGYL+kpdst+fFlW3U8UfnKxPxTFUgVE1D6ZEY=;
        b=iAFVfplIK2+wAu/OomucjOsTbnZuYA67YGKTgwYn+qbg5vYX9QCLJXafJ4TvxpIivJ
         eU1635K7cglWpc8uRvkND6lI2cvX8j3a7XI4/+gDGj5ykhrR07bKBmm3/s1wKRpO514w
         lXb0orYT16Iu2Gjnkyy3ivQZekDoVa5OH4XoEr3Ox19DgGh/wXrB86bTohUtYeVUlJsq
         HQOjNVpK+8PN28dHVv3xpg/yMpwI9wS/xPZU7C5vazOM0PcZaXinvyzGEFRbLN8N0i9Y
         lY8okoCQi4YMHmKwFoG8+C5z5cm5OwucWbv9XXz7u+BXaeeawtbCu+9s5Sa64Q4PbPhb
         Gywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VTtkH3MGYL+kpdst+fFlW3U8UfnKxPxTFUgVE1D6ZEY=;
        b=LAa87NMoOqls8DeSJNckqA7eOEQVfcsFIyqhNaZPAD9vDJZTubF7SOpTPNBNPXzu2o
         34DRHv8AVhPX16yNbbQGl1KLACOtsydz3hG8z08C+7bY+PCgyknI2X7pMiMlu2GDE7CH
         mekZ+rCgS/+RQe/8q1qZ8xAb6+4Hbk2W06YcQsbfYHkzHSkACcCjaqXY1H5ZaTF7vR+z
         qo8o0d+nIiW2azzwC2YXZvZQuPq6Rf5AdnUuLPbxe7qHlsPY+KRK/dCQYQjhx/3m57M3
         Y/r/oWdCnqDW8B/xIUJs1KmbPho8SW8w2trCIfP7DnkhLsMe9f2YtOmgvW5LMQb4nD2Y
         aMfA==
X-Gm-Message-State: AOAM531HKMFBPtf8XTQuRyymKoX+FsJsJxOvO0pDRVul7nyGE74YJkD1
        vL6D+b/o5kaQiKBoYeqvlO69Wff32tn/6bF6ySnPOw==
X-Google-Smtp-Source: ABdhPJzZIQDm121xN3wRxyEptFl4bzQHqgsmaNn/Bk73TzwN9a7cXEVkIAMdBmPJAt8Xw0WF2dTkqyqSywU+VaPn1xs=
X-Received: by 2002:a17:902:a50c:: with SMTP id s12mr1371343plq.119.1594679068150;
 Mon, 13 Jul 2020 15:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200530221127.459704-1-brgerst@gmail.com> <CAKwvOdn7Ugu_687b9CnOnL8RA9hbi+ONCb10gS=3VqtkTsmduw@mail.gmail.com>
 <CAKwvOdm4gMe_-DcB_H4mDGm8Yy++_7G20sg9xuZoom-rF2j1Sw@mail.gmail.com>
In-Reply-To: <CAKwvOdm4gMe_-DcB_H4mDGm8Yy++_7G20sg9xuZoom-rF2j1Sw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 13 Jul 2020 15:24:16 -0700
Message-ID: <CAKwvOdmGtZtqF5f-5x0n4GNCWLOnrk2r6e3X2XHGmoOL7f7u0g@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] x86: Clean up percpu operations
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        Dmitry Golovin <dima@golovin.in>,
        Alistair Delva <adelva@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 12:36 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Jun 1, 2020 at 2:00 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Sat, May 30, 2020 at 3:11 PM Brian Gerst <brgerst@gmail.com> wrote:
> > >
> > > The core percpu operations already have a switch on the width of the
> > > data type, which resulted in an extra amount of dead code being
> > > generated with the x86 operations having another switch.  This patch set
> > > rewrites the x86 ops to remove the switch.  Additional cleanups are to
> > > use named assembly operands, and to cast variables to the width used in
> > > the assembly to make Clang happy.
> >
> > Thanks for all of the work that went into this series.  I think I've
> > reviewed all of them.
> > With this series plus this hunk:
> > https://github.com/ClangBuiltLinux/continuous-integration/blob/master/patches/llvm-all/linux-next/x86/x86-support-i386-with-Clang.patch#L219-L237
> > I can build and boot i386_defconfig with Clang! So for the series:
> >
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
>
> tglx, Ingo, Boris, Linus,
> Do you all have thoughts on this series?  I can understand "let
> sleeping dogs lie" but some Android folks are really interested in
> i386 testing, and randconfigs/allnoconfigs are doing i386 builds which
> are currently broken w/ Clang. This series gets us closer to having
> test coverage of this ISA with another toolchain, FWIW.

I'm trying to organize an LLVM micro conference at plumbers.  I think
a session on "clang and remaining i386 blockers" might be of interest,
which would cover why the existing code pattern is problematic for
compiler portability.  This series in particular would be brought up.

Are you all planning on attending plumbers this year?  Might such a
session be of interest?

Otherwise, is there any additional feedback on this series or is it good to go?
-- 
Thanks,
~Nick Desaulniers
