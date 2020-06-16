Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61120C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 01:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4053020776
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 01:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5LNBkn/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgFPB4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 21:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgFPB4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 21:56:13 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7288EC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 18:56:12 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id j19so13169336ilk.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 18:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KsyypAzFsnAyMtkg0SUHRWIDqrfnrJOwHkv8H23gAlQ=;
        b=Y5LNBkn/0ZUI0zOHp2QPPEoJFu4XhUtCiFSn3fgmwYLKkwlwDxJgEZaQ+MzGbxq1EA
         X1MlTnpebD+YhI0iV3HJly1sGndQgXkdae8NNJUt/l1hDZSqeHq2CVy9w3PnImy4rH4j
         IeSKzH7QdFTv9jS3JAtAidJYDD7uSayV/CNeTcimaJMV47DGfZKQQ3GCo0gCj8O5P/5M
         +iR0QtxsXkVn8CP+IPH3m2y/+zowI1pmw13AfjUPg1qXz4qSg1GpNzSZCAkMDRcoHf08
         Fz6W3TZCeKxZhvLlHJWwSAJZMrbDBIZyI5NCob8NU0O98/tBj7hBO40rqLvfkXZWKUOh
         bUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KsyypAzFsnAyMtkg0SUHRWIDqrfnrJOwHkv8H23gAlQ=;
        b=JiiNtrxFuBztDabRL9XwuuUIvXhfsTYugycY3BXFQ29YTTNYaMB/lC5MDhKr5M6One
         UF6RVPNI0LgWHm9KW/R9+HN7/3cddWrmLXuKscw9BTX7ViZ/NASfg4X0zWTk3q52/LgY
         uHgbfIo08SiYtsFHEAY4og6ozFOHTwVEsvs0Q2aCrzFYqnd0hpY4Kg90N0ltFO1hlv6s
         SC2ksCSTyBYgjUXXhO//BIn+FGbwdyRw8uoeYWgni0eIgVrbLullopze2TeHd0auju/G
         mqPa9SIMJWHm7t0c8Y0RJ0ugeAS/VSlZ02n8XtleStFPf9F/8h5+RTpEv2bV6SWZL20L
         JufA==
X-Gm-Message-State: AOAM5324aGpxT0Uuf6rWU0bX5W88Qef7K0pll1gr703/pG5g0cMUHM2n
        sq2yJnyco/yzkd6uEv+SOBO7WZOJQt9DeAVk7BtZXVkGoNA=
X-Google-Smtp-Source: ABdhPJw6VA5k+cRU2/nkIAO33YsBJwJAj5Jatw06VO/EOC4dSqGxNPVRLaeYlTIoc2TvtUrgTUlVQBlSIbzF/uAMhgQ=
X-Received: by 2002:a92:a1d1:: with SMTP id b78mr898263ill.164.1592272571875;
 Mon, 15 Jun 2020 18:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <87mu5roov6.fsf@nanos.tec.linutronix.de> <20200529082618.1697-1-laijs@linux.alibaba.com>
 <CALCETrXKdh=nBWz96pow5roLmh0ez2YeQ9P+H5gxdor5TfrqUQ@mail.gmail.com>
In-Reply-To: <CALCETrXKdh=nBWz96pow5roLmh0ez2YeQ9P+H5gxdor5TfrqUQ@mail.gmail.com>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Tue, 16 Jun 2020 09:56:00 +0800
Message-ID: <CAJhGHyBSzhm7h5dROAKSzdSD3czmUNG+80rS9tpaau_U23p4Ug@mail.gmail.com>
Subject: Re: [PATCH V2 0/4] x86/entry: simply stack switching when exception
 on userspace
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 2:33 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Fri, May 29, 2020 at 1:26 AM Lai Jiangshan <laijs@linux.alibaba.com> wrote:
> >
> > 7f2590a110b8("x86/entry/64: Use a per-CPU trampoline stack for IDT entries")
> > has resulted that when exception on userspace, the kernel (error_entry)
> > always push the pt_regs to entry stack(sp0), and then copy them to the
> > kernel stack.
> >
> > And recent x86/entry work makes interrupt also use idtentry
> > and makes all the interrupt code save the pt_regs on the sp0 stack
> > and then copy it to the thread stack like exception.
> >
> > This is hot path (page fault, ipi), such overhead should be avoided.
> > And the original interrupt_entry directly switches to kernel stack
> > and pushes pt_regs to kernel stack. We should do it for error_entry.
> > This is the job of patch1.
> >
> > Patch 2-4 simply stack switching for .Lerror_bad_iret by just doing
> > all the work in one function (fixup_bad_iret()).
> >
> > The patch set is based on tip/x86/entry (28447ea41542) (May 20).
>
> There are definitely good cleanups in here, but I think it would be
> nice rebased to whatever lands in 5.8-rc1 settles.
>

Hello, All

This patchset can be smoothly applicable to the newest tip/x86/entry
which has 5.8-rc1 merged. Which means I don't have to respin/resend it
until any update is needed.

Could you have a review on it please.

Thanks
Lai
