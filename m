Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7C4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D636C207F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ks95EGnG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgERTUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 15:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgERTUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 15:20:12 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC50C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 12:20:12 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id o26so6298922vsr.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 12:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VYS01OjV1B1pDC2qLVF5XfomrtGwxD3ytYuCh/dfTzY=;
        b=Ks95EGnG9KKdVC+Ep/9VkmIS5FtzjDj70JpeLlQ3TtrwydvRG23Dy6xF0j1hiQt3Sy
         tEjDfjvTnUglUqvlru+5Dfq57HTRBMOujnWkuNxe9xx5mZYx3S11hCuiXQ6lgz469Fsh
         XuIw5W2dEx9FaF+6P9WecvJ4a62OOr7BmfBNgVTiFy5IZAdpT33icyPxNGc0oSOqFbv8
         fJjDqzRSoUSZ5SkpNWdeJuUwSYtfottzzYzUSyeCmbFXGBnEtGOe2VtfdyYP+p9kQ9oZ
         MDEGT5Gk8raAta2BfZVJAGSgqXah9d0Kh0j1aK8nBKVjFYn+T++QaoDPt+siHqcpuv9H
         5NEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VYS01OjV1B1pDC2qLVF5XfomrtGwxD3ytYuCh/dfTzY=;
        b=Sw3uyozpZMFk4alcmLPFPprUlH9MD62zh55P3K8yp948zYVorGrSRICUSHDsmn0Hhs
         bruIAoxFozl+tDnGxg7dIN7ZHQykiAlSAfRl95jInH7dYip4xKlWpYsTfS3r2rGo1PB4
         e4AA8g1oxihIDLVv6LDKTno6VP7EVFLYVTSUSWiVnfvaENbfnNntWWZt9IvRX7Qg6blB
         ODaJkn9K1FkMdRNkR6apacCXJIXiDrwPx3oRdWlkUSjNw7CPazfR1JCC0DdDupgwTfN1
         RRU3u3516M7EFmwsu+sXQf8zX6fMQuPmjwLbue/Brp+6LEysPuwWiTz56PtrkkBikJNg
         Nj7Q==
X-Gm-Message-State: AOAM530KTgUsfdyJKw28Bf8lbAiSimyiYC6uAtf4chUtgO//sXC4jZ9d
        bvnDhPkWwrh7ektGX56bbwwrtsO3biHhcwAAqUDrKw==
X-Google-Smtp-Source: ABdhPJwzReX4yG//pXbNia8GuPbOPHA1oxLIJWUfyzVyUHCGcWXXgjV+QK1g9LTdSfkl6MIJg4a7nbIbc+fb246PI7g=
X-Received: by 2002:a67:d60b:: with SMTP id n11mr2312109vsj.143.1589829611381;
 Mon, 18 May 2020 12:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200517152916.3146539-1-brgerst@gmail.com>
In-Reply-To: <20200517152916.3146539-1-brgerst@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 18 May 2020 12:19:59 -0700
Message-ID: <CAKwvOd=ch9L2n0nCOmH6nQ67zOXW-R9GV5wbWVha3ScGedrgQg@mail.gmail.com>
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

On Sun, May 17, 2020 at 8:29 AM Brian Gerst <brgerst@gmail.com> wrote:
>
> The core percpu operations already have a switch on the width of the
> data type, which resulted in an extra amount of dead code being

Thanks for the series Brian.  The duplication between knowing the size
at the call site and the switch is exactly what I picked up on, too.
This past weekend I started a similar cleanup, but only got through 2
of the 6 functions you cleaned up.  And via quick glance, your series
looks much better than mine does.  I'll sit down and review+test these
after lunch.  I appreciate you taking the time to create this series.

> generated with the x86 operations having another switch.  This patch set
> rewrites the x86 ops to remove the switch.  Additional cleanups are to
> use named assembly operands, and to cast variables to the width used in
> the assembly to make Clang happy.
>
> Brian Gerst (7):
>   x86/percpu: Introduce size abstraction macros
>   x86/percpu: Clean up percpu_to_op()
>   x86/percpu: Clean up percpu_from_op()
>   x86/percpu: Clean up percpu_add_op()
>   x86/percpu: Clean up percpu_add_return_op()
>   x86/percpu: Clean up percpu_xchg_op()
>   x86/percpu: Clean up percpu_cmpxchg_op()
>
>  arch/x86/include/asm/percpu.h | 447 ++++++++++++----------------------
>  1 file changed, 158 insertions(+), 289 deletions(-)
>
> --
> 2.25.4
>


-- 
Thanks,
~Nick Desaulniers
