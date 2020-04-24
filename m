Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441DBC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 18:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 212A020774
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 18:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587751377;
	bh=GjSvgTiUfJoQDX5RWLfMxG6G8m1V2jsRyg5MYZ+OrpY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=g/fQxzm5XJ2w5x5U/ifzeA59NJh2CYTtFhGe1pl0mC4NJ17vFM4tpdF+fiJagl7kf
	 P7KAl4IG6GAloj2teLuheg5G7QzGOHDJEU+vq20UwWDqQQ2RWOl0j88AnlDmf9Eobb
	 HvTqXnkmyFX2EcchSWSYqPlrSNe0zRoivDXF7mmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgDXSC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 14:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726908AbgDXSCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 14:02:55 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61029C09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 11:02:55 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id t11so8426616lfe.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 11:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z13IEYz83XdBeUibWdG7wclkW3og2+VosmLRfwAtAdA=;
        b=WsMshc2mIdVUt3yh9Dd3vA9NAUPuyxr+K526tt3N6H9SWCUwoLVukf7frGTwCg48QE
         DZUzz3sWj1a8QHzrAGEPyboToxOGmPzCgGA1IDa8Ud0ufbf5qTjMtiFJwutkwG32h2SQ
         ovIx45Wunn4iKR1DL6i7Xis6NIaAz1s2wwEGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z13IEYz83XdBeUibWdG7wclkW3og2+VosmLRfwAtAdA=;
        b=NDM4rN3PPsouS04AUS0Y0eBDXqElkm3KgZT9h9VKlw76XJqx8DhH8hc68+oeT0wQ6j
         iFyMLj7aU+wT4xA9nKUTrX/MUwA25ZHX52A+8GEcYscAe/RF2Kw8mvN7n4Xjo2Z68Mw5
         EO1IL8e2r3OzB9Cx+h1DWMJ/rLSRrOJpk4jRTQfcugliLjUNSSevYpM/JzIN1mpbwh8A
         JZ8wm89izCKAGmLOsFTSBkuj4ialGAgO1vmJ5QtIVHQX3NPTXbQLQAThyVxya1w9y6rn
         cNaQ80G/NKa27RAcVXSbVpFnprWGmFBpRhto7+zrvk3T7lrB1VkqVKo9vw6Oj21TJPLh
         F2aw==
X-Gm-Message-State: AGi0PuavMH1UDy68lWVMB4vTNG8HXAGG19PLpbYhWpkIbxaO0Sh5Ov2o
        4PtFrev1Rer+MZ+q/Y7fira3SMmZQ0Q=
X-Google-Smtp-Source: APiQypKWZ0iuNPf0j5A7orzHCHJRna2flN4ReDkgspbg4ILBN/qceU/WaCXzkLZq/03CIxGXeb0Tcw==
X-Received: by 2002:ac2:57cb:: with SMTP id k11mr7094272lfo.19.1587751373239;
        Fri, 24 Apr 2020 11:02:53 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id j22sm5157528lfg.96.2020.04.24.11.02.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 11:02:52 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id n6so10853811ljg.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 11:02:52 -0700 (PDT)
X-Received: by 2002:a2e:814e:: with SMTP id t14mr6506692ljg.204.1587751371830;
 Fri, 24 Apr 2020 11:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
 <87ftcv1nqe.fsf@x220.int.ebiederm.org> <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
 <CAHk-=wgXEJdkgGzZQzBDGk7ijjVdAVXe=G-mkFSVng_Hpwd4tQ@mail.gmail.com> <87tv19tv65.fsf@x220.int.ebiederm.org>
In-Reply-To: <87tv19tv65.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Apr 2020 11:02:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-K3fqdMr-r8WgS8RKPuZOuFbPXCEUe9APrdShn99xsA@mail.gmail.com>
Message-ID: <CAHk-=wj-K3fqdMr-r8WgS8RKPuZOuFbPXCEUe9APrdShn99xsA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] proc: Ensure we see the exit of each process tid exactly
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 8:36 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> At one point my brain I had forgetten that xchg can not take two memory
> arguments and had hoped to be able to provide stronger guarnatees than I
> can.  Which is where I think the structure of exchange_pids came from.

Note that even if we were to have a "exchange two memory locations
atomically" instruction (and we don't - even a "double cmpxchg" is
actually just a double-_sized_ one, not a two different locations
one), I'm not convinced it makes sense.

There's no way to _walk_ two lists atomically. Any user will only ever
walk one or the other, so it's not sensible to try to make the two
list updates be atomic.

And if a user for some reason walks both, the walking itself will
obviously then be racy - it does one or the other first, and can see
either the old state, or the new state - or see _neither_ (ie if you
walk it twice, you might see neither task, or you might see both, just
depending on order or walk).

> I do agree the clearer we can write things, the easier it is for
> someone else to come along and follow.

Your alternate write of the function seems a bit more readable to me,
even if the main effect might be just that it was split up a bit and
added a few comments and whitespace.

So I'm more happier with that one. That said:

> We can not use a remove and reinser model because that does break rcu
> accesses, and complicates everything else.  With a swap model we have
> the struct pids pointer at either of the tasks that are swapped but
> never at nothing.

I'm not suggesting removing the pid entirely - like making task->pid
be NULL. I'm literally suggesting just doing the RCU list operations
as "remove and re-insert".

And that shouldn't break anything, for the same reason that an atomic
exchange doesn't make sense: you can only ever walk one of the lists
at a time. And regardless of how you walk it, you might not see the
new state (or the old state) reliably.

Put another way:

>         void hlist_swap_before_rcu(struct hlist_node *left, struct hlist_node *right)
>         {
>                 struct hlist_node **lpprev = left->pprev;
>                 struct hlist_node **rpprev = right->pprev;
>
>                 rcu_assign_pointer(*lpprev, right);
>                 rcu_assign_pointer(*rpprev, left);

These are the only two assignments that matter for anything that walks
the list (the pprev ones are for things that change the list, and they
have to have exclusions in place).

And those two writes cannot be atomic anyway, so you fundamentally
will always be in the situation that a walker can miss one of the
tasks.

Which is why I think it would be ok to just do the RCU list swap as a
"remove left, remove right, add left, add right" operation. It doesn't
seem fundamentally different to a walker than the "switch left/right"
operation, and it seems much simpler.

Is there something I'm missing?

But I'm *not* suggesting that we change these simple parts to be
"remove thread_pid or pid pointer, and then insert a new one":

>                 /* Swap thread_pid */
>                 rpid = left->thread_pid;
>                 lpid = right->thread_pid;
>                 rcu_assign_pointer(left->thread_pid, lpid);
>                 rcu_assign_pointer(right->thread_pid, rpid);
>
>                 /* Swap the cached pid value */
>                 WRITE_ONCE(left->pid, pid_nr(lpid));
>                 WRITE_ONCE(right->pid, pid_nr(rpid));
>         }

because I agree that for things that don't _walk_ the list, but just
look up "thread_pid" vs "pid" atomically but asynchronously, we
obviously need to get one or the other, not some kind of "empty"
state.

> Does that look a little more readable?

Regardless, I find your new version at least a lot more readable, so
I'm ok with it.

It looks like Oleg found an independent issue, though.

                  Linus
