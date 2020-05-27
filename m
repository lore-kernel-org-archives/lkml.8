Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531A2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C70320899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590594813;
	bh=vOSAJJq49HbOLGio+0l4NiccIrOfRgQ/jsz7vpCdGRc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Hy+jEGkRzcUieqijxuXdAHJiU4m5doCP9jNofvQTf8NDBJIYALk+h3TuUOcS4FydS
	 SUnywy4emusOXwwXKGjlyqRXMlJ3TYyCalXndQWAudtKY9d720Ff342K7PFasrUZKV
	 /1lJh5dbEP5VdEkWTIGo9b+AKGGVysEp+Bno61cc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390451AbgE0Pxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730737AbgE0Pwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:52:30 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9648C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 08:52:29 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id w15so14711208lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 08:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EWGiPDc5EJAFSwyh6mf4UfMOzoMXHwdkrtIM/R13868=;
        b=gDXpeDLoPstoCJiUV4fa4zp7o5+6F4nL2AYKI3EllVnQukro51FkKHy0duOrha7M8B
         cSgK5nh7B+In1ge/TpCu10+BQpIV7a8WKMyvDnDfqw3lM33QHAwflVBuOXAiDu9IkuDX
         VRjKHBFQlIUYMX+raBl6c68XIc8p3esCh8jZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EWGiPDc5EJAFSwyh6mf4UfMOzoMXHwdkrtIM/R13868=;
        b=Hlg46KipLvAuwKe1fFedhvYzC9oNiF3zi4NeNnLNBcFRv8RfIyY5DDY9GOeZvjTrQV
         DgHCLSw2O4Eek1FTw7CnNGq6q1bLB5IDBPPfY7jiRZOFUdkFshD5MbnQxm9GuBVJqjZa
         ray9dh3EJb8wEeHPt3S7BLm9kYyxEtZKyR7Xk26BILENKoUogsibaciKbaVOgK+Jw7er
         qN2b93Vb7F2jN6/DlwDL95/asBO8/va6TGTC91Xq9wAxsgQzRfHdg/FjxBhwUEaD/dz+
         jNQYThs4rRDfDt/35eir3sJ7NT815p9ZYQbmYIl6X16GpbcflZ7GdUXMdBG58tF7JZI9
         w8DQ==
X-Gm-Message-State: AOAM532TllbjIT8FDQurDsorn5c1E+tTCiVDnsB4oM/Ca44xfz2xBLlB
        tS/itEGxFF00CCXtEU6tdipetbFPObI=
X-Google-Smtp-Source: ABdhPJy6jDrnGS516ajw9tx0/GMJFd3VhOg2oOQIR18RhB7JcTu5yNZs4Qvw3HRU92Knzl3lJQ0YhA==
X-Received: by 2002:a05:6512:488:: with SMTP id v8mr2682259lfq.205.1590594747348;
        Wed, 27 May 2020 08:52:27 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id c78sm999870lfd.63.2020.05.27.08.52.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 08:52:26 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id q2so29499211ljm.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 08:52:26 -0700 (PDT)
X-Received: by 2002:a2e:8090:: with SMTP id i16mr2943836ljg.421.1590594745691;
 Wed, 27 May 2020 08:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200513162732.977489-1-bigeasy@linutronix.de>
 <20200526194641.GF83516@mtj.thefacebook.com> <CAHk-=wjHgkama3SYOcYCYt_F-sxV8h4+kQ5aQSMgK7PtiQ=Nkw@mail.gmail.com>
 <CAHk-=wgrG--AdCUBF9jR=zMm=cUn+6VaeOmmbbRFxx1YOx3RiA@mail.gmail.com> <20200527152004.z3n5ccajp6stdcno@linutronix.de>
In-Reply-To: <20200527152004.z3n5ccajp6stdcno@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 May 2020 08:52:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whp9hADY4f+9hB+-xd_bEF1Nbgt_TdbzuO=mCXFejTJuA@mail.gmail.com>
Message-ID: <CAHk-=whp9hADY4f+9hB+-xd_bEF1Nbgt_TdbzuO=mCXFejTJuA@mail.gmail.com>
Subject: Re: [PATCH 0/3] workqueue: Make the workqueue code PREEMPT_RT safe
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Tejun Heo <tj@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 8:20 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2020-05-26 14:46:59 [-0700], Linus Torvalds wrote:
> >
> > We have better models. We have "rcuwait", and we have
> > "wake_up_process()". Either of which is simpler and more efficient
> > than swait, and are actually useful. rcuwait isn't exactly widely
> > used, but it has very nice semantics for when that is what you want.
> > And wake_up_process() is both simple and straightforward, particularly
> > when you already have a spinlock for protecting whatever state it is
> > you're waking up on or waiting for.
>
> rcuwait would be this:

Hmm. That patch certainly looks fairly simple and straightforward to me.

That said, I think you're missing a rcuwait_init() to initialize the
thing (or probably better - a __RCUWAIT_INITIALIZER(name)
initializer).

Not that it's actually needed in the current implementation (a NULL
initializer is fine, and you get it from the variable being static),
but it would be a good thing for future-proofing in case people add
debugging or whatever to it.

> +static bool wq_manager_inactive(struct worker_pool *pool)
> +{
> +       spin_lock_irq(&pool->lock);
> +
> +       if (pool->flags & POOL_MANAGER_ACTIVE) {
> +               spin_unlock_irq(&pool->lock);
> +               return false;
> +       }
> +       return true;
> +}

Heh. Ok, I see what and why you're doing it this way, and it's even clever.

But it's clever enough to want a comment both here and in the
rcuwait_wait_event() use. Just something simple like "this returns
with the lock held on success" here, and then at the wait-event
something like "because of how wq_manager_inactive() works, we will
hold the spinlock after a successful wait".

But yes, it looks quite simple and straightforward other than this.

Famous last words. Maybe I'm missing something, but I like this a lot
more than the swait thing.

                 Linus
