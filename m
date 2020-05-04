Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DA3C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7835B2087E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rpULkMOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731604AbgEDSD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731596AbgEDSDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:03:54 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1F2C061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 11:03:54 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u15so10666518ljd.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 11:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rcDmJIg6XQDOa3chgWWWTIDoYfHpXCrYezz5o9UsioM=;
        b=rpULkMOhQ4XZU3gawsHD+pAOZ/hs2S8hKO6veZt59CSRwuHnSJXAiuoI75zoy7R9Ll
         uf4UZP+VqLBAvTEWV5yIfVLut+GowlNGk+3EGPjaOP5qKHnnI3l48fex3cTWR4l44GLH
         8wd5MdAVyv692TTfAXe+O3MU9ndQq3PxjqaW6TxHBflien/xVKeDzY6auFfoNRYH/B/2
         fC6JEADleGtaKfIPrip+5m6sMwyC2n6uWKxRL5+H+CJ0cW58eC7MD2VZjb96sOpTG+7G
         Ae7Y3Et/iIuTjbwxhdpZH3qq7AeT35TAmNFcQPrZptvKZd4RSfnQClAONC3cth5/dvFR
         Wvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rcDmJIg6XQDOa3chgWWWTIDoYfHpXCrYezz5o9UsioM=;
        b=BjbbUVYL8aZmR4UlDAnFdEjl7vDS3LuU4Wz9htmRLCIW8UjHdddYw/uXP/+rhA1J1L
         SO0KeY+ez09xD5FkzNQZDJeTHwmnaUsmCKExxmAd1w/6asoeir8TJuHOd5yN335l5yw+
         ozmfaXheBtZF85sbZyhh1ylSqOXr7z7vMkqJ+keHHvElyzdamSEit/ZtFLa8rboeXZfg
         ZyKHePWWl+c9c/GOylOjlbMJh/XfAbP0PqAcO6EnhQwvnBFq/6l3wRy9ZulLgXUTKHdC
         1Xk0WTYNDpeihzSH0mxQ8aUNHwImZrT3B6jtWxlIqIM8Fxhft29kFUnJVyCKrxK+JL5y
         B+JQ==
X-Gm-Message-State: AGi0PuYhCJwrayab0E/hLGNO3ukSLQvDWBcnINpR/SuRHBcU4SgAdH3j
        A9jpkD3oWrVxJuN4mTm0jzW6RF5a7k+HpyntqsAVfQ==
X-Google-Smtp-Source: APiQypIHcgbbdXmVy3vl3ztP5eNJSATUT2t97dtLpQSHGN3q+TF5z+bWNiX9e7gWwtb8yO4Jkfo2dPzDOiP5vUAhK0c=
X-Received: by 2002:a2e:b249:: with SMTP id n9mr11270265ljm.221.1588615432462;
 Mon, 04 May 2020 11:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200416161245.148813-1-samitolvanen@google.com> <20200416161245.148813-2-samitolvanen@google.com>
 <20200420171727.GB24386@willie-the-truck> <20200420211830.GA5081@google.com>
 <20200422173938.GA3069@willie-the-truck> <20200422235134.GA211149@google.com>
 <202004231121.A13FDA100@keescook> <20200424112113.GC21141@willie-the-truck>
 <20200427204546.GA80713@google.com> <20200504165227.GB1833@willie-the-truck>
In-Reply-To: <20200504165227.GB1833@willie-the-truck>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 4 May 2020 20:03:25 +0200
Message-ID: <CAG48ez0OjQpCvO1EqUqtHX+zVj27p3yWd5riY_r7+rNWwec_OQ@mail.gmail.com>
Subject: Re: [PATCH v11 01/12] add support for Clang's Shadow Call Stack (SCS)
To:     Will Deacon <will@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 4, 2020 at 6:52 PM Will Deacon <will@kernel.org> wrote:
> On Mon, Apr 27, 2020 at 01:45:46PM -0700, Sami Tolvanen wrote:
> > On Fri, Apr 24, 2020 at 12:21:14PM +0100, Will Deacon wrote:
> > > Also, since you mentioned the lack of redzoning, isn't it a bit dodgy
> > > allocating blindly out of the kmem_cache? It means we don't have a redzone
> > > or a guard page, so if you can trigger something like a recursion bug then
> > > could you scribble past the SCS before the main stack overflows? Would this
> > > clobber somebody else's SCS?
> >
> > I agree that allocating from a kmem_cache isn't ideal for safety. It's a
> > compromise to reduce memory overhead.
>
> Do you think it would be a problem if we always allocated a page for the
> SCS?

I guess doing this safely and without wasting a page per task would
only be possible in an elegant way once MTE lands on devices?

I wonder how bad context switch latency would be if the actual SCS was
percpu and vmapped (starting at an offset inside the page such that
the SCS can only grow up to something like 0x400 bytes before
panicking the CPU) and the context switch path saved/restored the used
part of the vmapped SCS into a smaller allocation from the slab
allocator... presumably the SCS will usually just be something like
one cacheline big? That probably only costs a moderate amount of time
to copy...
Or as an extension of that, if the SCS copying turns out to be too
costly, there could be a percpu LRU cache consisting of vmapped SCS
pages, and whenever a task gets scheduled that doesn't have a vmapped
SCS, it "swaps out" the contents of the least recently used vmapped
SCS into the corresponding task's slab SCS, and "swaps in" from its
own slab SCS into the vmapped SCS. And task migration would force
"swapping out".

Not sure if this is a good idea, or if I'm just making things worse by
suggesting extra complexity...
