Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FC3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6119C20721
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590708233;
	bh=xBVgQog88CfnvTMVQZBY41JFpVOvLBlcLa++r9c7jlE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qezRSSN0IzhfGpmSsa2IUepgioOYIyQAHFORFPORo57MOP5HXpQP/BO5Bo9MDdFFT
	 DwlIGj/SKGFS2N8TaplMtUaqO4RIsUGvqmWFctMvqBldRKGcsjq9qz1zZDqhGfpilk
	 cBT3E3syzXSTsm+1dhGWPjKRWcvVbwLJYxCD8akc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437596AbgE1XXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 19:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437490AbgE1XXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 19:23:48 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71249C08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 16:23:47 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id r125so147472lff.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 16:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lvntbN5poYtMfSoKiCXpDz0H9PHNUtXkgX3txl3QBqg=;
        b=Owg3ySC84uxhuGKf6i2dNH2q/RD4VDxW4n+bdjTUEA6SmcwJChlGAG9o1ZFxzpK1Nh
         nY6SPtEKeisN9g2MeJWXi6V8e9llGjbJu5nh52W1rAF6P824ju3OUk4J4RBFThk0Muul
         r/SE9uKEOWNO53I3VkXf8ZjvR0cIpy6y6Gck4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lvntbN5poYtMfSoKiCXpDz0H9PHNUtXkgX3txl3QBqg=;
        b=aIilD3Ry34MTQqcay0WJ+idSUQtjkqnSiD3rF/JCw6ncbzO7qOCU6wjDvaESguukEM
         xGx1NFQudjhCGgHyHS1OBrvD/54SoVVGhIkKxGLHfJly+sKyLEDrB3stM6+MtO26dst1
         1iKTCqtckGPerZC85ogrcpqlB0ak72YXqTiYGcRLiIxwRAcCO9+kihZBZ/b6zdtls60C
         y8AaeZpMRxnffqvEnRPf28brCAarBS5PDZ7W2qa0+I77ONuM0WtSV1kw4q12nL9h/SmO
         /3uLZa6qD1RJlXlg0MI0OCygIOmCgnW/7SXhYIoq8YPWctT9A4qnYjrI4FJqE3iXoBqg
         mOmw==
X-Gm-Message-State: AOAM530QyPod/vVyZ69sKf9PUIe+HeM7aj2S617EOW2rT6TS6aKxPwV+
        jBrIuZUVRsnpXIFGLblm1ogmWyKG0bc=
X-Google-Smtp-Source: ABdhPJwKPKlM41DnaB8VMqpn/jQJF5rJq6DEo7a11iHhFKTJRli4i1bFfWXf0q0H/+bC52puCNt3jQ==
X-Received: by 2002:a19:6e0e:: with SMTP id j14mr2883386lfc.155.1590708224501;
        Thu, 28 May 2020 16:23:44 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id v7sm1687787ljv.40.2020.05.28.16.23.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 16:23:43 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id z13so275627ljn.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 16:23:42 -0700 (PDT)
X-Received: by 2002:a2e:b16e:: with SMTP id a14mr2499699ljm.70.1590708222167;
 Thu, 28 May 2020 16:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200528135552.GA87103@google.com> <CAHk-=wjgtD6drydXP5h_r90v0sCSQe7BMk7AiYADhJ-x9HGgkg@mail.gmail.com>
 <20200528230859.GB225299@google.com>
In-Reply-To: <20200528230859.GB225299@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 16:23:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=whf6b=OijDL=+PUTBsrhURzLZQ5xAq5tWDqOQpTmePFDA@mail.gmail.com>
Message-ID: <CAHk-=whf6b=OijDL=+PUTBsrhURzLZQ5xAq5tWDqOQpTmePFDA@mail.gmail.com>
Subject: Re: [PATCH] sched/headers: Fix sched_setattr userspace compilation breakage
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Blecker <matthewb@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Mike Frysinger <vapier@google.com>,
        Christian Brauner <christian@brauner.io>,
        vpillai <vpillai@digitalocean.com>, vineethrp@gmail.com,
        Peter Zijlstra <peterz@infradead.org>,
        stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 4:09 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> > So no, this patch is fundamentally wrong. It negates the whole point
> > of having a uapi header at all.
>
> Sorry, I naively assumed that headers in 'include/uapi/' are safe to include
> from userspace. I feel terrible.

Well, they "kind of" are safe to include.

It's just that normally they are meant for system integrators to
include as part of the system header files. So they are designed not
to be safe for normal programs, but for library writers.

And to make things more confusing, sometimes people _do_ include
kernel header files directly, just because they want to get features
that either haven't been exposed by the system libraries, or because
the system libraries copied the uapi header files for an older version
of the kernel, and you want the shiny new feature, so...

And some of those header files are easier to do that with than others...

> The problem is <sched.h> still does not get us 'struct sched_attr' even
> though the manpage of sched_setattr(2) says including <sched.h> is all that's
> needed.

Ouch. But clearly you get it from -somewhere- since it then complains
about the double declaration.

Strange.

> Also, even if glibc included 'include/uapi/linux/sched/types.h' to get struct
> sched_attr's definition, we would run into the same issue I reported right?
> The 'struct sched_param' is already defined by glibc, and this header
> redefines it.

That's kind of the point: glibc sets up whatever system headers it
wants. The uapi ones are there to _help_ it, but it's not like glibc
_has_ to use them.

In fact, traditionally we didn't have any uapi header files at all,
and we just expected the system libraries to scrape them and make
their own private copies.

The uapi headers are _meant_ to make that easier, and to allow system
headers to then co-exists with the inevitable "I need to get newer
headers because I'm using a bleeding edge feature that glibc isn't
exposing" crowd.

Put another way: a very non-portable programs _could_ include the uapi
headers directly, if the system library headers were set up that way.

More commonly, what bleeding edge people do when the system header
files don't play nice, is to just build their very own libraries and
copy the bleeding-edge features directly from the kernel. So you'll
find things like

  #ifndef __NR_clone3
  #define __NR_clone3 435
  #endif

                syscall(__NR_clone3, ...);

in user space that wants to use the clone3 system call, but knows that
it hasn't made it into the glibc headers yet, so the program just
forced the local knowledge of it.

That's obviously generally easier to do with macro defines like the
above, exactly because you can trivially _test_ whether they've been
exposed or not.

So yes, this is a horrid mess.

But the *intent* is that the uapi header files should be things that
system library implementations can just use directly, and then the
"special" users could mix-and-match if everything is wonderful.

Which it seldom is.

But that's why putting those interface declarations inside a #ifdef
__KERNEL__ would completely destroy the whole point.

              Linus
