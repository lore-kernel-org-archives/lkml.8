Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB69C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6509C2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BpRSOxxD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgERXyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 19:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgERXyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:54:46 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE403C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:54:46 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t40so559001pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M1UcD1yb0aCao1CCRKbW8T4p0FAKHwtEQ3wCZL+1q6I=;
        b=BpRSOxxDqRwpWZjDq+SIvva+dP5WbHEtizqbVUyHI6N1/rh39aILsHMdDAeovHU9LG
         JunPKDosRAC1m537x4MUwxsWUy53AQswNglm4dv3/koFlu9v/i9+ufVH1ZT1NnjIpAkL
         d294wqQjw1I5Jg7g1/MijG7jomKCiDfEZeaDxuMAEkNa6GFK2d9PZ4Xp2A5gEvuSVZqc
         Mm6plllGcJ8C3R1lp+ufjf3nZlURmGh+NRDhtzYZrEGdcLElb6ebSVvPmUqrZTjtlmvE
         68TtIzC2qTQ/xGrRWIoek9XHMicD54NQPMP/xYkOQJVWwdezUIz/eyM3UgmTz0fEX5Gv
         1ZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M1UcD1yb0aCao1CCRKbW8T4p0FAKHwtEQ3wCZL+1q6I=;
        b=kSfQ71SF3wg0+uzD4z4z05ZZgmaB5BZ1kX1+d7ay8o72k9m4bdDRkivTKWf8n5VX6D
         6aiqjHpohSoLFEzTAtuJCAMmO4EwGucm18gDXXBlhYUqOK3EOLzgV0NkjGiPBh2rHvPz
         4xZc3Wm1o1GJ+IhZdQC4JvS1OSILSQSsSoENw2+p+S+bKmF5GmO11UOihDQRddxbTyRV
         L2yXbfWGsYmXRnV28lWwfYo3PjMKbK95oLS42GDWNrtjdRxEFwrEzmNSOyqKIp3cW2Qf
         4GhGlAm3+h+wCe7l2SJtvnsJeoohHqGsspJXMMIwcDzhYXtzeuBEdy8CfUpDCzbBOQiW
         biug==
X-Gm-Message-State: AOAM531j9mEg0kxEJSaNDuW8GD+c/gmUBzNDQdBwqfcZE1SbUwiMyB00
        wpMfmu1ATIgzEfs+L/BmFS8aYrL8ZCZXWME8m6OoZoyIjUA=
X-Google-Smtp-Source: ABdhPJx7RvnopUpyivO/PQNIfBC2QBD+z1rzGt5RIEjjAvYC1/0s387ccUdD8tW3344AzydOO3gkmaX2n3rr2M+1EKM=
X-Received: by 2002:a17:902:341:: with SMTP id 59mr10290114pld.119.1589846086067;
 Mon, 18 May 2020 16:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200517152916.3146539-1-brgerst@gmail.com> <CAKwvOd=ch9L2n0nCOmH6nQ67zOXW-R9GV5wbWVha3ScGedrgQg@mail.gmail.com>
In-Reply-To: <CAKwvOd=ch9L2n0nCOmH6nQ67zOXW-R9GV5wbWVha3ScGedrgQg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 18 May 2020 16:54:31 -0700
Message-ID: <CAKwvOdmak_L9Rp8FQ+N6-N9vWGH3M-jjP+XJTGUTeYCG9N_dBQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] x86: Clean up percpu operations
To:     Brian Gerst <brgerst@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 12:19 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, May 17, 2020 at 8:29 AM Brian Gerst <brgerst@gmail.com> wrote:
> >
> > The core percpu operations already have a switch on the width of the
> > data type, which resulted in an extra amount of dead code being
>
> Thanks for the series Brian.  The duplication between knowing the size
> at the call site and the switch is exactly what I picked up on, too.
> This past weekend I started a similar cleanup, but only got through 2
> of the 6 functions you cleaned up.  And via quick glance, your series
> looks much better than mine does.  I'll sit down and review+test these
> after lunch.  I appreciate you taking the time to create this series.

Patch set looks good.  I tested:
* i386_defconfig
* defconfig
* allyesconfig
with ToT Clang and GCC 9.2.1.  Booted the first two in QEMU as a smoke
test as well.

Note that for Clang, I also needed to apply this hunk to
arch/x86/include/asm/uaccess.h
(https://github.com/ClangBuiltLinux/continuous-integration/blob/master/patches/llvm-all/linux-next/x86/x86-support-i386-with-Clang.patch)
which will be the final issue for i386_defconfig+clang.

I think other than the 0day report on patch 4/7, and the use of
__same_type, the series is mostly good to go.  You can add my:
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
to any v2 of the whole series.

I generally find the use of named assembly operands and a few of the
simplifications to be a nice touch, which I pointed out per patch.

Thanks again for shaving this yak.

>
> > generated with the x86 operations having another switch.  This patch set
> > rewrites the x86 ops to remove the switch.  Additional cleanups are to
> > use named assembly operands, and to cast variables to the width used in
> > the assembly to make Clang happy.
> >
> > Brian Gerst (7):
> >   x86/percpu: Introduce size abstraction macros
> >   x86/percpu: Clean up percpu_to_op()
> >   x86/percpu: Clean up percpu_from_op()
> >   x86/percpu: Clean up percpu_add_op()
> >   x86/percpu: Clean up percpu_add_return_op()
> >   x86/percpu: Clean up percpu_xchg_op()
> >   x86/percpu: Clean up percpu_cmpxchg_op()
> >
> >  arch/x86/include/asm/percpu.h | 447 ++++++++++++----------------------
> >  1 file changed, 158 insertions(+), 289 deletions(-)
> >
> > --

-- 
Thanks,
~Nick Desaulniers
