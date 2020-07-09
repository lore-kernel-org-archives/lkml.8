Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8257C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4A9D207DA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mIyW8zZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgGIUCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 16:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgGIUCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 16:02:47 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D096DC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 13:02:47 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f2so1257204plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 13:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2VF7eJrZIbjXtY34qIPtFXhMtxmmt28w7rrxhSng8oY=;
        b=mIyW8zZOWOY1pVXYX/2zNQFllS1xgMrpixZbYUPUyWHOZ6IlW8z95tLUpzi8JiW48R
         7wlKto0aIRL/lggyxOGdZuOWJpSvH5vRS0WbAz1cvUNNAMP4TgDSp7aLxVIuBL0zUnyR
         QiF6K9DF2QwoRsxqwDlvXq+eh1l1djghBCJjMwcogQ6HwLreSqgMFv8POKDy18zyR4Gb
         751DZz4Bhjg0wAaRs2YK1ZjBly1oTt0N2PNdTfAYzIxn2HXpXkHZHESHOHcbJP9VUdp4
         mc6uUFW7KPrMhLj9H4BwJ3/v2QN5OoaFfEmTfZ8r5lyGRjEYD7mBb2LGrMGVizRqRpdG
         bkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2VF7eJrZIbjXtY34qIPtFXhMtxmmt28w7rrxhSng8oY=;
        b=HSO63fA4nGzeJXyPMqwXP9mSrj1vpA2yOp4sBXejOZh++N4Z2OYXrf1pY/nA+UmTdH
         MWofEPEZJjzfiaW7EG3Yf0qP16QbJZYtNfiygCSJK+06DVlqlQWE7c0K7BVoHRwQqc/h
         RZc8SbA0R/Yk4EOiq32L9CSbu5TUxwxV4JrCSf37y4iKtbiT4bboQ8maohlnr/bg9LYY
         ii6cHFRLGUlrsuSPBVZa/IYaehh72Wczqj9UWyg1Ct6x5xfDmI0Yehx0pJn3bstAdlqd
         B1+jeTIQKoNja/cBsznPOVorTnGOqQTzql1VOtxTSZ33dzWZ52S4fNpYHSZpC2yKielG
         X5HA==
X-Gm-Message-State: AOAM5312W3QOleuIXdeuAZf9eZyB3/13L/UlwzC3YiQ91dx6PPwFtCU2
        SbomEv5EIFVCqJPQCagtSfk6vUTvE2OG1crqjkCUeA==
X-Google-Smtp-Source: ABdhPJwaZaJ+u5RMaS3HRspVE6liBbxnKyRa6B6ssKDIkoaASfmGaGbdWDCMdFhzpm1ErlOjqfFKvkpfi9hhufy+8YE=
X-Received: by 2002:a17:90a:21ef:: with SMTP id q102mr1866229pjc.101.1594324967094;
 Thu, 09 Jul 2020 13:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200530221127.459704-1-brgerst@gmail.com> <CAKwvOdn7Ugu_687b9CnOnL8RA9hbi+ONCb10gS=3VqtkTsmduw@mail.gmail.com>
 <CAKwvOdm4gMe_-DcB_H4mDGm8Yy++_7G20sg9xuZoom-rF2j1Sw@mail.gmail.com>
In-Reply-To: <CAKwvOdm4gMe_-DcB_H4mDGm8Yy++_7G20sg9xuZoom-rF2j1Sw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 9 Jul 2020 13:02:35 -0700
Message-ID: <CAKwvOd=0pD2-h_777SjG8dPqw3HYGkmS3UJ2tCWVqmsCL1cZ=w@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] x86: Clean up percpu operations
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        Dmitry Golovin <dima@golovin.in>,
        Alistair Delva <adelva@google.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
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

Oh, was https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6ec4476ac825
alluding to this, perchance?

-- 
Thanks,
~Nick Desaulniers
