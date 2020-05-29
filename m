Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAF9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52999207D4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590779972;
	bh=wI+/kMrA9GhjxeBwubeLYcKLqzRSiFv0lgXwmLa3XuY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=neB+Ta+EgLWGN3UJ6ooznrnvaOAyADIYo/P1AGzo+c2oQlGknrrcwhLRwJyTDfZO8
	 +9slS0zh/1H2aMEBmIsePv6rJ6Fo1fvT32GmU9G8vhecQAwegc+4kJm0uqVUbEBuoS
	 cC0GZd7/JuSpo3UPLEY//DPEvQI+m1/3xsf4vH/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgE2TTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 15:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgE2TTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:19:25 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B16C08C5C9
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:19:23 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id r125so320292lff.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vo9kcqH3+r49rRyfr5F53x5hhASyTdSUh1QFspC2AyA=;
        b=NLTb+v6BJYCqO+v7twCPV6ZmPrFD83aAxXEWTUdawlUiCz2SyXVz4O/AOpY8YEuVP6
         9YhQkmR2+9ilOO6XVHF+SolA9uT3QoTV7VuPoTF/1gB1t6wb7vZZm9UpNYYZuiTecknY
         S3TZuhMi7aCqd/4zIdlB499SzVqQ4Eyuj6l7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vo9kcqH3+r49rRyfr5F53x5hhASyTdSUh1QFspC2AyA=;
        b=Bg1qmmjikZjby6/OfFSFeEhfd2a5aVtrwEUXUbI1Q/o66YqZqNU9i+6v1wOkQJ00ff
         FH9oUw7BFVaukhodAs6CzmxXDKS5Y0UPb/BPOw+LiPL8bN3obcWD7dDZHwC9j5s1UE5F
         ClnUQrrWAdhohAq59Z/n/bOyUtzdeppC8bYDNOtf90Nt7LKKIpMBqVLND4xqbh5BvI0e
         X3NX4kzWdLdQ1uNOnHjuuRho0fWUn2PHJu4+Nipg0tSdx3gN7IWVc9NEwOZPzOZ80tN5
         HYp8CIFP4ksP7pB42A5gIBKN85tT2UtvvGfoDalvHFc10UnQ4EZZ5O7bcPnL70c8qF3M
         I1/A==
X-Gm-Message-State: AOAM533OBVAP2/e3VV2Wq9daw9uPx6N3hZDUqJbTuY5cQyg5aHRQmJdl
        MSFmGeOtz3sE+ZG+vXPPDMnVUMT9iCM=
X-Google-Smtp-Source: ABdhPJxZ+Bk3+WtpgPF1u6M+w/1PkG5+P1t+oqrWpIMG7O/bhanWgGjrQ/wXHWc3ePTwyMuIUJ4sZA==
X-Received: by 2002:a19:4895:: with SMTP id v143mr5013213lfa.193.1590779961037;
        Fri, 29 May 2020 12:19:21 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id y11sm2179310lji.52.2020.05.29.12.19.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 12:19:19 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id v16so584577ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:19:19 -0700 (PDT)
X-Received: by 2002:a2e:b16e:: with SMTP id a14mr4488600ljm.70.1590779959015;
 Fri, 29 May 2020 12:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wj3iGQqjpvc+gf6+C29Jo4COj6OQQFzdY0h5qvYKTdCow@mail.gmail.com>
 <20200528054043.621510-1-hch@lst.de> <22778.1590697055@warthog.procyon.org.uk>
 <f89f0f7f-83b4-72c6-7d08-cb6eaeccd443@schaufler-ca.com> <3aea7a1c10e94ea2964fa837ae7d8fe2@AcuMS.aculab.com>
In-Reply-To: <3aea7a1c10e94ea2964fa837ae7d8fe2@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 May 2020 12:19:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjR0H3+2ba0UUWwoYzYBH0GX9yTf5dj2MZyo0xvyzvJnA@mail.gmail.com>
Message-ID: <CAHk-=wjR0H3+2ba0UUWwoYzYBH0GX9yTf5dj2MZyo0xvyzvJnA@mail.gmail.com>
Subject: Re: clean up kernel_{read,write} & friends v2
To:     David Laight <David.Laight@aculab.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 6:08 AM David Laight <David.Laight@aculab.com> wrote:
>
> A wide monitor is for looking at lots of files.

Not necessarily.

Excessive line breaks are BAD. They cause real and every-day problems.

They cause problems for things like "grep" both in the patterns and in
the output, since grep (and a lot of other very basic unix utilities)
is fundamentally line-based.

So the fact is, many of us have long long since skipped the whole
"80-column terminal" model, for the same reason that we have many more
lines than 25 lines visible at a time.

And honestly, I don't want to see patches that make the kernel reading
experience worse for me and likely for the vast majority of people,
based on the argument that some odd people have small terminal
windows.

If you or Christoph have 80 character lines, you'll get possibly ugly
wrapped output. Tough. That's _your_ choice. Your hardware limitations
shouldn't be a pain for the rest of us.

Longer lines are fundamentally useful. My monitor is not only a lot
wider than it is tall, my fonts are universally narrower than they are
tall. Long lines are natural.

When I tile my terminal windows on my display, I can have 6 terminals
visible at one time, and that's because I have them three wide. And I
could still fit 80% of a fourth one side-by-side.

And guess what? That's with my default "100x50" terminal window (go to
your gnome terminal settings, you'll find that the 80x25 thing is just
an initial default that you can change), not with some 80x25 one. And
that's with a font that has anti-aliasing and isn't some pixelated
mess.

And most of my terminals actually end up being dragged wider and
taller than that. I checked, and my main one is 142x76 characters
right now, because it turns out that wider (and taller) terminals are
useful not just for source code.

Have you looked at "ps ax" output lately? Or used "top"? Or done "git
diff --stat" or any number of things where it turns out that 80x25 is
really really limiting, and is simply NO LONGER RELEVANT to most of
us.

So no. I do not care about somebody with a 80x25 terminal window
getting line wrapping.

For exactly the same reason I find it completely irrelevant if
somebody says that their kernel compile takes 10 hours because they
are doing kernel development on a Raspberry PI with 4GB of RAM.

People with restrictive hardware shouldn't make it more inconvenient
for people who have better resources. Yes, we'll accommodate things to
within reasonable limits. But no, 80-column terminals in 2020 isn't
"reasonable" any more as far as I'm concerned. People commonly used
132-column terminals even back in the 80's, for chrissake, don't try
to make 80 columns some immovable standard.

If you choose to use a 80-column terminal, you can live with the line
wrapping. It's just that simple.

And longer lines are simply useful. Part of that is that we aren't
programming in the 80's any more, and our source code is fundamentally
wider as a result.

Yes, local iteration variables are still called 'i', because more
context just isn't helpful for some anonymous counter. Being concise
is still a good thing, and overly verbose names are not inherently
better.

But still - it's entirely reasonable to have variable names that are
10-15 characters and it makes the code more legible. Writing things
out instead of using abbreviations etc.

And yes, we do use wide tabs, because that makes indentation something
you can visually see in the structure at a glance and on a
whole-function basis, rather than something you have to try to
visually "line up" things for or count spaces.

So we have lots of fairly fundamental issues that fairly easily make
for longer lines in many circumstances.

And yes, we do line breaks at some point. But there really isn't any
reason to make that point be 80 columns any more.

                  Linus
