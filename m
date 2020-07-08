Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9986C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBDF8205CB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N5awc+9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgGHTgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 15:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgGHTga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 15:36:30 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851D3C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 12:36:30 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p3so22150934pgh.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 12:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UlOQFGlZj5bWzar4eWUzhZTqr0UJgpfAN8IY8nJf+RI=;
        b=N5awc+9vcqKaNfH6/xYgwOeaQfQB0YwP6yIiVn1wsvCaiKySEe1x1zWCE3R+vcjzQ3
         qAk3o+IN/npi3/WeXRGBmgS2V5tE2EjRLEbxeqiEKuP0u5BmsR5t2P8iDuxBKCqVstcK
         MDKJ635HQ9j11wxyRs/vB7hSBbZv1xgNq4nU+hXegCB2RgHfnkqPv4hSR7vgvD+R/ZEw
         yDz6WTUXqM46dIGiFSx7/AqR+F/ppwtWERVa6VLYH/y9VVXML9n76um2BkSUCBQ84CtP
         Yx4TcXwavwr7rle/1JAfOQm3WAtKRTxftUOljH6JF53hMips5c5N7giUvN+vqHh5eHba
         dBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UlOQFGlZj5bWzar4eWUzhZTqr0UJgpfAN8IY8nJf+RI=;
        b=mbk5/9GByEbMDiCtC3fbsNivy8sika9tmL5KN6v6ehaW4FcGqtdw6yGNMiQwvaxq/f
         X0fSQHIOWEigHteu2xm3zZbw2PWRoX3BMVcLpGJPvAEhEN94cfIAlWoOyOyVV+wS2kig
         C5ovp1UPYRIM9PjrLranLpfEKcL5MOF9NHlPjJuVaZOUCjY1QIdAOKDl57ddbfhUFlbv
         qxDS8NR5oFK7GTVjhWjSZ+OcwtJZpoySJzyPLQV92on2qaK/EvFF5R/ubzFMSiVLI2zw
         Xx6eqZsCR8Gl7IR5PGJa+GpPCFdi7CqIy+KoUjgmJct4tH9LKyZq1fhdbeZlWEf88M3n
         MD6w==
X-Gm-Message-State: AOAM533AngccZRObNcZ1Zd2rf4zjyEy3nOtDyWoj9oA3D2CElIdySeBn
        1NuORlEAtwoaYrrUIx2NgWT90rzgnoru1qKhUwO587u9
X-Google-Smtp-Source: ABdhPJzeL6Hgnk5RDvSRSo+5JR09vEJ6Vq0mcOPo4Xa3R4L1j8fff0tIdNST+X8EkC6QT9qV1j8pfYKiWn/CY1twvec=
X-Received: by 2002:a63:a119:: with SMTP id b25mr49682689pgf.10.1594236989911;
 Wed, 08 Jul 2020 12:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200530221127.459704-1-brgerst@gmail.com> <CAKwvOdn7Ugu_687b9CnOnL8RA9hbi+ONCb10gS=3VqtkTsmduw@mail.gmail.com>
In-Reply-To: <CAKwvOdn7Ugu_687b9CnOnL8RA9hbi+ONCb10gS=3VqtkTsmduw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 8 Jul 2020 12:36:18 -0700
Message-ID: <CAKwvOdm4gMe_-DcB_H4mDGm8Yy++_7G20sg9xuZoom-rF2j1Sw@mail.gmail.com>
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
        Alistair Delva <adelva@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 2:00 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Sat, May 30, 2020 at 3:11 PM Brian Gerst <brgerst@gmail.com> wrote:
> >
> > The core percpu operations already have a switch on the width of the
> > data type, which resulted in an extra amount of dead code being
> > generated with the x86 operations having another switch.  This patch set
> > rewrites the x86 ops to remove the switch.  Additional cleanups are to
> > use named assembly operands, and to cast variables to the width used in
> > the assembly to make Clang happy.
>
> Thanks for all of the work that went into this series.  I think I've
> reviewed all of them.
> With this series plus this hunk:
> https://github.com/ClangBuiltLinux/continuous-integration/blob/master/patches/llvm-all/linux-next/x86/x86-support-i386-with-Clang.patch#L219-L237
> I can build and boot i386_defconfig with Clang! So for the series:
>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>

tglx, Ingo, Boris, Linus,
Do you all have thoughts on this series?  I can understand "let
sleeping dogs lie" but some Android folks are really interested in
i386 testing, and randconfigs/allnoconfigs are doing i386 builds which
are currently broken w/ Clang. This series gets us closer to having
test coverage of this ISA with another toolchain, FWIW.

-- 
Thanks,
~Nick Desaulniers
