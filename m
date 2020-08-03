Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCD4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42975208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596487714;
	bh=C8XE4B4NxnarADCSkBTtGHBUAvzbx/8SNofWNBYy8zE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=c/fTBTDO04D/xOL+pgcnvdFEU+kG4Ct1NbmYCBP+UJLeJFIU264WK/4esWkT3CzTR
	 CgLR+wKTkAN5tqqtchFumIGXluNADwToEu9Zv1gdJYWCeu2eCD7CNJas+kC37Ypql5
	 b37h5mumRBWmc1ixDMJuRps3Pb36y0g/jHpZqN2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbgHCUsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbgHCUsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:48:32 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC12C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 13:48:31 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v4so31482851ljd.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 13:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jM5UnR5hZjLl1157SoQFWnfhWDoj7HV2zdSk/8vex4c=;
        b=h/1hcZc8H6kswFNHbGzElDpPVhs+UwWLspQ4s/1kYc+JOfKTih1pDum7QlRbD1M/yD
         lGIcKVqsoPuVM4T/MMgCTsXA+/DYsvUAcGM7UdlugTXO5Un6YTzb0AOoLe6IxKsoHF7C
         m62JSgM6Kws1LLaSVZxcC2bK6TewTRu2vCjws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jM5UnR5hZjLl1157SoQFWnfhWDoj7HV2zdSk/8vex4c=;
        b=e0pnNLeLE7Nvg6PoeiGa9DbgqJCwrO+PRzgIUh5fBhggOosCm5+uEznJzDttHAxF3T
         hwaNVbKyRft3lHf/IOZ+C4yM2QJLelW0FjWtwrwFFlNk32OJCiZhQOjbyUF3+9et/DOH
         xkDJjtukuMSb+7c0EHinDWv9YvCbxmbxjBg2qC9AW9AM0A+0sdoHPIJaNgB1ZUbuY21R
         /7iaCkx2WkfMf5jT5g8kI+3WReM1tgT9yvQerrLkRcKPMZXV6ggWx+fmpzaoHxs8SeTN
         7kHSZxmRAyYwTFdS2kHOhoCoZcPhVU+i6YnIGLHycP7iQZiHzC+RHnnPTmJ9vQaPAj+K
         R01Q==
X-Gm-Message-State: AOAM533VP5ndjoKbeFFeHXYDSm4TZVM5+KzWmPMkp+aJCKvFMzMGH6M8
        UxQ6wJ1NweF6QmO6iiSeOtZXS8331K0=
X-Google-Smtp-Source: ABdhPJxxylqyhvmJK2xtQaFCkI2Y+8WULidtAWw2+3bBwlQymivdUhTmOMyfHHo6GNv4oiGRns2WzQ==
X-Received: by 2002:a2e:85a:: with SMTP id g26mr8887154ljd.319.1596487709762;
        Mon, 03 Aug 2020 13:48:29 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id d22sm5285517lfs.26.2020.08.03.13.48.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 13:48:28 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id t6so28224742ljk.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 13:48:28 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr8970245ljf.285.1596487708229;
 Mon, 03 Aug 2020 13:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <50466810-9148-e245-7c1e-e7435b753582@kernel.dk>
In-Reply-To: <50466810-9148-e245-7c1e-e7435b753582@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Aug 2020 13:48:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgaxWMA7DVTQq+KxqaWHPDrXDuScX9orzRgxdi7SBfmoA@mail.gmail.com>
Message-ID: <CAHk-=wgaxWMA7DVTQq+KxqaWHPDrXDuScX9orzRgxdi7SBfmoA@mail.gmail.com>
Subject: Re: [GIT PULL] io_uring changes for 5.9-rc1
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 2, 2020 at 2:41 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> Lots of cleanups in here, hardening the code and/or making it easier to
> read and fixing buts, but a core feature/change too adding support for
> real async buffered reads. With the latter in place, we just need
> buffered write async support and we're done relying on kthreads for the
> fast path. In detail:

That async buffered reads handling the the page locking flag is a
mess, and I'm really happy I committed my page locking scalability
change early, so that the conflicts there caught it.

Re-using the page bit waitqueue types and exporting them?

That part is fine, I guess, particularly since it came from the
wait_bit_key thing and have a smell of being generic.

Taking a random part of wake_page_function(), and calling it
"wake_page_match()" even though that's not at all that it does?

Not ok.

Adding random kiocb helper functions to a core header file, when they
are only used in one place, and when they only make sense in that one
place?

Not ok.

When the function is called "wake_page_match()", you'd expect it
matches the wake page information, wouldn't it?

Yeah, it did that. And then it also checked whether the bit we're
waiting had been set again, because everybody ostensibly wanted that.
Except they don't any more, and that's not what the name really
implied anyway.

And kiocb_wait_page_queue_init() has absolutely zero business being in
<linux/filemap.h>. There are absolutely no valid uses of that thing
outside of the one place that calls it.

I tried to fix up the things I could.

That said, like a lot of io_uring code, this is some seriously opaque
code. You say you've done a lot of cleanups, but I'm not convinced
those cleanups are in any way offsetting adding yet another union (how
many bugs did the last one add?) and a magic flag of "use this part of
the union" now.

And I don't know what loads you use for testing that thing, or what
happens when the "lock_page_async()" case actually fails to lock, and
just calls back the io_async_buf_func() wakeup function when the page
has unlocked...

That function doesn't actually lock the page either, but does the task
work. I hope that work then knows to do the right thing, but it's
really opaque and hard to follow.

Anyway, I'm not entirely happy with doing these kinds of changes in
the merge resolution, but the alternative was to not do the pull at
all, and require you to do a lot of cleanups before I would pull it.
Maybe I should have done that.

So this is a slightly grumpy email about how io_uring is (a) still
making me very nervous about a very lackadaisical approach to things,
and having the codepaths so obscure that I'm not convinced it's not
horribly buggy. And (b) I fixed things up without really being able to
test them. I tested that the _normal_ paths still seem to work fine,
but..

I really think that whole thing needs a lot of comments, particularly
around the whole io_rw_should_retry() area.

A bit and legible comment about how it will be caught by the
generic_file_buffered_read() page locking code, how the two cases
differ (it might get caught by the "I'm just waiting for it to be
unlocked", but it could *also* get caught by the "lock page now"
case), and how it continues the request.

As it is, it bounces between the generic code and very io_uring
specific code in strange and not easy to follow ways.

I've pushed out my merge of this thing, but you might also want to
take a look at commit 2a9127fcf229 ("mm: rewrite
wait_on_page_bit_common() logic"). I particular, the comment about how
there's no point in even testing the page bit any more when you get
woken up.

I left that

        if (test_bit(key->bit_nr, &key->page->flags))
                return -1;

logic in io_async_buf_func() (but it's not in "wake_page_match()" any
more), but I suspect it's bogus and pointless, for the same reason
that it isn't done for normal page waits now. Maybe it's better to
just queue the actual work regardless, it will then be caught in the
_real_ lock_page() or whatever it ends up doing - and if it only
really wants to see the "uptodate" bit being set, and was just waiting
for IO to finish, then it never really cared about the page lock bit
at all, it just wanted to be notified about IO being done.

So this was a really long email to tell you - again - that I'm not
happy  with how fragile io_uring is, and how the code seems to be
almost intentionally written to *be* fragile. Complex and hard to
understand, and as a result it has had a fairly high rate of fairly
nasty bugs.

I'm hoping this isn't going to be yet another case of "nasty bugs
because of complexity and a total disregard for explaining what is
going on".

              Linus
