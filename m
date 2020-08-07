Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91875C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B18B2086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596827295;
	bh=7oH8HHWjv0Fqtx6NnYKfhdNyUutqPCCLEgh+b5hHjMk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wMhWwn8L0eTTeyUCeev9j4K3Sb6pN+mwlSkulHkmm9hkQui/j5A5M1iGqdunAekzy
	 xoH7UtbzHS7GvmGSGeSZRW38fvUP82wgThV6z5WxEoalxCeNZJIco9zv5N2aXtiP0L
	 KsdlRtv2zIV4YW2R9HOVl9r5XNMoxaiMwY7QwTpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgHGTIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGTIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:08:13 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EA6C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 12:08:13 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w14so3318035ljj.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 12:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c8tGfyphxRtiXyEdcvoYman9XgjfDP3kct92h+829I4=;
        b=IgxCxB4uub7VQqj+eQvlcRIhDoXI2u63xnHa6xhV72pL6k6VdF2Riprov2SytE5Be5
         PCTWDk4SeGRy98Ba2QdQ8bI/ekpBd9OazBCyPQGu8VFQp11MxKlxQX1S3uRYaNw0+dMs
         Sa2DcnatE4QSVfijxi+fBGnSJF78tPUoiZFBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c8tGfyphxRtiXyEdcvoYman9XgjfDP3kct92h+829I4=;
        b=XMMyvPLeAxxTmqCgi9oR6ftbEKDlHqAO3Agj8dwybszd3wFluNaOZtUzMZ9JqQcfGD
         9vEOrQAavSFoVdWHaoTPj61zC/Mfabe+fr6E/pz5yg/iDNYm9C0246ydsXtd3OuSG+/W
         9jiAtl3nvYMjqZSnpMsb66f6P7tpv7cgwBtlfxPOt2PZzbOftQSdIoumTggXG455+ZMy
         9QZ8lEZ9dDXkEsr/VWydF6e9G0tBtAwaqjLtvTP2oloO1dEdXu0PPP4kSu8fOAaFjg/w
         IErzQ4dvbHjGQxYPwKzFv5/lzB5i2KutDiOPrnZug1coQdc2L9e/jgVDsEYRqrNe5HXl
         e22A==
X-Gm-Message-State: AOAM533TEM2l+vMH/mCDJYwiE9FmBba0K5WOjmXMJL/TxIkBilQm/tVm
        tyaZ3JR2aftpKTYzEokce1Vgc5AF0mM=
X-Google-Smtp-Source: ABdhPJyRrrbXgs91V4ribX+omqiBP0fEr2sqO6iRlMXHSttQrtyMSEFJHtFsh8AySF+SqEPzzCjoQQ==
X-Received: by 2002:a2e:9ce:: with SMTP id 197mr7229455ljj.369.1596827290633;
        Fri, 07 Aug 2020 12:08:10 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id w11sm4567223lff.62.2020.08.07.12.08.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 12:08:05 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id i10so3326378ljn.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 12:08:04 -0700 (PDT)
X-Received: by 2002:a05:651c:503:: with SMTP id o3mr4808734ljp.312.1596827284312;
 Fri, 07 Aug 2020 12:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200724152424.GC17209@redhat.com> <CAHk-=whuG+5pUeUqdiW4gk0prvqu7GZSMo-6oWv5PdDC5dBr=A@mail.gmail.com>
 <CAHk-=wjYHvbOs9i39EnUsC6VEJiuJ2e_5gZB5-J5CRKxq80B_Q@mail.gmail.com>
 <20200725101445.GB3870@redhat.com> <CAHk-=whSJbODMVmxxDs64f7BaESKWuMqOxWGpjUSDn6Jzqa71g@mail.gmail.com>
 <alpine.LSU.2.11.2007251343370.3804@eggly.anvils> <alpine.LSU.2.11.2007252100230.5376@eggly.anvils>
 <alpine.LSU.2.11.2007261246530.6812@eggly.anvils> <alpine.LSU.2.11.2008052105040.8716@eggly.anvils>
 <CAHk-=whf7wCUV2oTDUg0eeNafhhk_OhJBT2SbHZXwgtmAzNeTg@mail.gmail.com>
 <20200806180024.GB17456@casper.infradead.org> <CAHk-=wihTRHMm1LC4AfidZptT9ZuT-wBjE2VhYzKBy66e4iwQw@mail.gmail.com>
 <alpine.LSU.2.11.2008071047510.1239@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2008071047510.1239@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Aug 2020 12:07:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjHdwaz9aU1NMcucr+kK3BdZkM7FYVxpBLOo1H0NHPynw@mail.gmail.com>
Message-ID: <CAHk-=wjHdwaz9aU1NMcucr+kK3BdZkM7FYVxpBLOo1H0NHPynw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
To:     Hugh Dickins <hughd@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 7, 2020 at 11:41 AM Hugh Dickins <hughd@google.com> wrote:
>
> +
> +       /*
> +        * If we hoped to pass PG_locked on to the next locker, but found
> +        * no exclusive taker, then we must clear it before dropping q->lock.
> +        * Otherwise unlock_page() can race trylock_page_bit_common(), and if
> +        * PageWaiters was already set from before, then cmpxchg sees no
> +        * difference to send it back to wake_up_page_bit().
> +        *
> +        * We may have already dropped and retaken q->lock on the way here, but
> +        * I think this works out because new entries are always added at tail.
> +        */
> +       if (exclude && !exclusive)
> +               clear_bit(bit_nr, &page->flags);
> +
>         spin_unlock_irqrestore(&q->lock, flags);

Yeah, I started thinking about this, and that's when I decided to just
throw away the patch.

Because now it clears the bit *after* it has woken people up, and that
just made me go "Eww".

You did add a comment about the whole "always added to the tail"
thing, and the spinlock should serialize everything, so I guess it's
ok (because the spinlock should serialize things that care), but it
just feels wrong.

I also started worrying about other people waiting on the page lock
(ie we now have that whole io_uring case), and interaction with the
PG_writeback case etc, and it just ended up feeling very messy.

I think it was all fine - other cases won't hit that exclusive case at
all - but I had a hard time wrapping my little mind around the exact
handoff rules, and the cmpxchg behavior when other bits changed (eg
PG_waiters), so I gave up.

> My home testing was, effectively, on top of c6fe44d96fc1 (v5.8 plus
> your two patches): I did not have in the io_uring changes from the
> current tree. In glancing there, I noticed one new and one previous
> instance of SetPageWaiters() *after* __add_wait_queue_entry_tail():
> are those correct?

I don't think SetPageWaiters() has any ordering constraints with the
wait queue. Nobody looks at the waitqueue unless they already got to
the slowpath.

The only ordering constraint is with the testing of the bit we're
going to wait on. Because doing

     if (test_and_set_bit())
          SetPageWaiters(page);

is wrong - there's a race in there when somebody can clear the bit,
and not see that there are waiters.

And obviously that needs to be done inside the spinlock, but once you
do that, the ordering of the actual wait-queue is entirely irrelevant.
The spinlock will order _that_ part. The only thing the spinlock won't
order and serialize is the PG_lock bit and making sure we get to the
slowpath in the first place.

So if you're talking about __wait_on_page_locked_async(), then I think
that part is ok.

Or am I missing something?

                Linus
