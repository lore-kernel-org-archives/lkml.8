Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E4DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B429220724
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jql/0Rqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgGFInn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 04:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbgGFInm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 04:43:42 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19CDC061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 01:43:42 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id a12so38496858ion.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 01:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=1+XYTZTGMy2T7rPgNMQ47wtlVTSbHNHcU8v4DWvxfc8=;
        b=jql/0RqxAGkEiQywO37aBi5NjrOHbHDl8I2QToJEEDpKtnvClHE83Ej0AvmQELoFbh
         sLtbEK5UiI2fPyT5jlyT3ZHbW5CvjmZ80vi9E57IL9rreGMoOvhw+3ERDVFHd020I+dL
         53C4vz+Y322gA5mB9KamC3nTE24oRAm1Bx5OTKXAs/YSdW/+QHujwJK7txwkRPlW+/4M
         Xs0nZotRoffU4Q50jzdxcrrhN9vfPI1kVrvQClb9E1Mb4BbiQi2kiOXgSTgQT1kxts+z
         cQj93WGG5A6AYe8X7LwtiM4UyQ+GN81Q03dkAaoAuU0JmdSyrHIO3471iEOMIM4aYCFA
         CkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=1+XYTZTGMy2T7rPgNMQ47wtlVTSbHNHcU8v4DWvxfc8=;
        b=pU1yRR32ptGIcGN3TXsLKJsJox7iUj7GvpuCnSvRjCAI+Sr7bC8CY7pJ7/LSVWG5v2
         Jc/7pS2ReOpONQ9dM3HAg+ml7UPIhDXnVvp6cqP2qkWSkKkOlmxO73srlETGha7fqcsW
         5DrkpPvcFQLFOIe26E62vpe1+9vmMUYdyFrTtLKM6YjG/ivvk1GPrlJHiyyHhwI8mvnH
         uCjzDmpp9s6meMEGDf87X0dPluJhsJgk4jwmn5Ty/CxeUnKdO1sSwW6ZeJ7mH+byY57F
         yccUVJDzVKFDzKVXk5JilWR+nVwlNWGVbbWYv5kClT7axKLc7SgVIA16tGNo3eQ6VgSq
         D4Kg==
X-Gm-Message-State: AOAM530x2QknjkXVZLp1GpvqLZFJH3k51Ds038ntsCy272MADHu3rYqC
        Ygd0Q9jhheP1hu17lZypg9z6GcQmwfkfj9sb3ys=
X-Google-Smtp-Source: ABdhPJwHNt2n85yxEtWNig9tU+enDrwChyzgXPNB71R7j9T5TcAxuyNS5oQXqrfRjjyzD0vPZYN2HG0ZJmdhFqbKEY0=
X-Received: by 2002:a5e:9309:: with SMTP id k9mr23944381iom.135.1594025022121;
 Mon, 06 Jul 2020 01:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUVgJFXJ3C_iYK8HrsuhAy3R9U1RDB6mPkOS52JcnU4mDQ@mail.gmail.com>
 <20200706083900.GC4800@hirez.programming.kicks-ass.net>
In-Reply-To: <20200706083900.GC4800@hirez.programming.kicks-ass.net>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 6 Jul 2020 10:43:30 +0200
Message-ID: <CA+icZUV=VVpy=R5_bq0N4TvPg+SfzyCXuWW9-QCnKk8-WnZLLg@mail.gmail.com>
Subject: Re: [Linux v5.8-rc4] objtool warnings with gcc-10
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mbenes@suse.cz
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 10:39 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jul 06, 2020 at 09:09:55AM +0200, Sedat Dilek wrote:
> > [ Please CC me I am not subscribed to this mailing-list ]
> >
> > Hi Josh and Peter,
> >
> > today I switched over from Linux v5.7.y to Linux v5.8-rc4 and built
> > the first time with GCC version 10 on Debian/testing AMD64.
> >
> > $ cat /proc/version
> > Linux version 5.8.0-rc4-1-amd64-gcc10 (sedat.dilek@gmail.com@iniza)
> > (gcc-10 (Debian 10.1.0-4) 10.1.0, GNU ld (GNU Binutils for Debian)
> > 2.34) #1~bullseye+dileks1 SMP 2020-07-06
> >
> > I see these objtool warnings (which are new to me):
> >
> > $ grep warning: build-log_5.8.0-rc4-1-amd64-gcc10.txt | sort
> > arch/x86/kernel/cpu/mce/core.o: warning: objtool: mce_panic()+0x118: unreachable instruction
> > drivers/atm/horizon.o: warning: objtool: interrupt_handler()+0x19f: unreachable instruction
> > drivers/message/fusion/mptbase.o: warning: objtool: mpt_Soft_Hard_ResetHandler()+0x33a: unreachable instruction
> > drivers/scsi/aic7xxx/aic79xx_core.o: warning: objtool: ahd_intr.part.0()+0x10f: unreachable instruction
> > drivers/scsi/pcmcia/aha152x_core.o: warning: objtool: run()+0x4c0: unreachable instruction
> > fs/btrfs/backref.o: warning: objtool: btrfs_backref_finish_upper_links()+0x309: unreachable instruction
> > fs/btrfs/extent_io.o: warning: objtool: __set_extent_bit.cold()+0xc: unreachable instruction
> > fs/btrfs/relocation.o: warning: objtool: update_backref_cache.part.0()+0x1de: unreachable instruction
> > kernel/exit.o: warning: objtool: __x64_sys_exit_group()+0x14: unreachable instruction
> > net/core/skbuff.o: warning: objtool: skb_push.cold()+0x15: unreachable instruction
>
> That's more CONFIG_LIVEPATCH=y wreckage I expect. The problem is that
> GCC -flive-patching= thing wreck the propagation of the noreturn.
>
> This really is a compiler issue and we've not managed a sensible
> work-around in objtool.

Thanks for the quick response.

I have...

CONFIG_LIVEPATCH=y

...and see in my build-log:

-flive-patching=inline-clone

- Sedat -
