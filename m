Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23293C433E5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 18:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F19D5206E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 18:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595702964;
	bh=EDs51vTJkRsZEC0fa6aEk+jLDIy7zWVKNLWyDTVOVKU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=POXNxvGP6kimzNJDIVMg/Ni5ivf0l4UZkmC+6Jc2GKubrhq7/UV+bJaG9n5yvOfCX
	 bUbi0VeLNuZgiEO+Rz8pg/R45uyrG5iCtekI+AmA0uV3VKMTQwUsfaXSW8FUfPFnfp
	 2+PfHF1YpkhiuF6RYTmMo3E12zTfAAP7KNxSvPD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgGYStC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 14:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgGYStB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 14:49:01 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954A1C08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 11:49:01 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id i80so6891036lfi.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 11:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uhV82Ck0bx4IRzuHTa923nInRUJDUpSkjAmZsyGi/28=;
        b=FCzTzzUO9rdyNK8BUOPugYbX8pHQozqQlW7Ecn0OjkAgGqfLj/Coy/X2BTx5SH5knk
         +MMR+CWJRUV0zBDa9c80ewMvbe2qMmu/o7KRSlENLysMqA1GvXHs+1s0arsxysoAS9Dl
         Nws4jWhAWi19kHoajgY3XM48Cg5ZxCy/7KiJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uhV82Ck0bx4IRzuHTa923nInRUJDUpSkjAmZsyGi/28=;
        b=ni1Dt6zuqwuY6kFXwqGYwIgdaDUjesl8dFpGwNriQ/vEHm7ikIYk85aJnE+Qlwe39t
         sJxs6VWwOdKN6Tjx8DEblvFtI+FG2X35FhJrWlvgUWa0YRTc8X2BOVow35zoI2FCP0IX
         Ba8koA5j5gvODWYUFwefk2mmq8ppoQdhvmwcOtbW3uJ/kyCWeo+Yf9vgJ1DrlMizsNZe
         FhFELwgJiMSZTajbxNx+ceG3e0iBQYHMQrlnr91GiSv8vEwe1yc2eeXMU3uqpxn3JGbb
         QpIx42kgtdXqTEOQnN558OZjGhlVYgSpZ0/yO3TyZ/AeEJuXMsrfpAKBas77igt0gJax
         Ym8g==
X-Gm-Message-State: AOAM533zU76Oxxp5MR1BIvVhcELH8Y69ebu8Adu7Hijx0mkcXNrsxV5y
        B8Kz6/NC0yhZS0IikqW4FEhNRGK7nj0=
X-Google-Smtp-Source: ABdhPJwCS8X5wAJcv7a4xcQDRElDq5smyXWwMBANutDS5jNio3v71E9CzPjvZFAU8+8xG0riH5aQbw==
X-Received: by 2002:ac2:530e:: with SMTP id c14mr7902358lfh.127.1595702939368;
        Sat, 25 Jul 2020 11:48:59 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id a19sm1572480lff.25.2020.07.25.11.48.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2020 11:48:58 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id s9so6920563lfs.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 11:48:57 -0700 (PDT)
X-Received: by 2002:a19:c206:: with SMTP id l6mr7873933lfc.152.1595702937396;
 Sat, 25 Jul 2020 11:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com>
 <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com>
 <20200723124749.GA7428@redhat.com> <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com>
 <CAHk-=whQK3OGwExTzCrwwvuuVaQAgs8KsR-Yv8m1BmXoNZZ=jQ@mail.gmail.com>
 <alpine.LSU.2.11.2007231549540.1016@eggly.anvils> <CAHk-=wgvGOnMF0ePU4xS236bOsP8jouj3rps+ysCaGXvCjh2Dg@mail.gmail.com>
 <20200724152424.GC17209@redhat.com> <CAHk-=whuG+5pUeUqdiW4gk0prvqu7GZSMo-6oWv5PdDC5dBr=A@mail.gmail.com>
 <CAHk-=wjYHvbOs9i39EnUsC6VEJiuJ2e_5gZB5-J5CRKxq80B_Q@mail.gmail.com> <20200725101445.GB3870@redhat.com>
In-Reply-To: <20200725101445.GB3870@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 Jul 2020 11:48:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whSJbODMVmxxDs64f7BaESKWuMqOxWGpjUSDn6Jzqa71g@mail.gmail.com>
Message-ID: <CAHk-=whSJbODMVmxxDs64f7BaESKWuMqOxWGpjUSDn6Jzqa71g@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 3:14 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> Heh. I too thought about this. And just in case, your patch looks correct
> to me. But I can't really comment this behavioural change. Perhaps it
> should come in a separate patch?

We could do that. At the same time, I think both parts change how the
waitqueue works that it might as well just be one "fix page_bit_wait
waitqueue usage".

But let's wait to see what Hugh's numbers say.

> In essense, this partly reverts your commit 3510ca20ece0150
> ("Minor page waitqueue cleanups"). I mean this part:

Well, no. I mean, it keeps the "always add to the fail" behavior.

But some of the reasons for it have gone away. Now we could just make
it go back to always doing non-exclusive waits at the head.

The non-exclusive waiters _used_ to re-insert themselves on the queue
until they saw the bit clear, so waking them up if the bit was just
going to be set again was just going to make for unnecessary
scheduling and waitlist noise.

That reason is gone.

But I think the fundamental fairness issue might still be there. So
I'll keep the simpler "always add at the end".

But you're right - we could expedite the non-exclusive waiters even more.

             Linus
