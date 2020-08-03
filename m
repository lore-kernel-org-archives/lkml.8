Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8336BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 23:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90E43206F6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 23:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596498564;
	bh=p3Kfoa7BlpBd4ELjwfPBib2hICPgGs3wlnc9pR6jPlY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rhs4qyw8K8TsJPQEezuVuLW6f/uv3ieNN0k0h7BvzSrZs5nRNYYE/dDPrls84ybC9
	 JPb8YL2d9q94vxT8ddMY97bCffojk6FEkRLMqnBn+TVLTTFZs5JQBZjtgENvjps1Bp
	 xHoY8jS10wJuUTPxOnckUtKhNuCUGCX7C1xXLgEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgHCXtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 19:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgHCXtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 19:49:22 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62978C061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 16:49:22 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id x9so41591864ljc.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 16:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rjFfxbNIZeER3lRkzTq/8A/E4palbhToV4FcRoDFDQU=;
        b=LNPbu/JBr7LgWvqrpga5bSNfG5kG5Dh4SimAjNbTedFwlm+C/trvigNb3I6cdGQ882
         Fbm0TrpGSScd8f4TgWHJHzAeG+mCgZcpSLPb2IVy7HUG5YLlb4X7yAOjFcKUNet8QOy2
         qCeVQZwqcCRne91hfASqgpVkhmO1QTjnKHD04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rjFfxbNIZeER3lRkzTq/8A/E4palbhToV4FcRoDFDQU=;
        b=lwuWVsKl0L97dG0g9wEzConbntNI9WJ8lc91wbp35Ni64I5c2k0sWammfnE7mW8LgW
         NDbi6vcGRniY85s1lVC6um+Xy82ILWeuLcKs4D4229GlYNZHJaErwt0D0Aqk+aHt9nZV
         VH7ROdN9qS4s91gvQ+P7KLswwTelJzZfFEZC9Tfq04cKaiIKOAyWEI0SgjjAZeg1EErH
         bqjtsPrCIR1hpvQERgQ1vCW/2pCHCMEn2BbAiSgFjWoKWezK45K/9N8jg45epZtyaqCs
         NshRtvBWPeOQEEDX2moMj2rfBRKwRMl/jRe64COLaBLo+MsDYG4PJ5GckqXr6lC3DYMU
         7uVA==
X-Gm-Message-State: AOAM532vfQXK5aJ25u3YCL6g14uUA5iJzLqduvrfQs7ttlxKOz/Mx5J9
        ZeYJFodHch6A1iIcAPTIgTBNlt6SA3c=
X-Google-Smtp-Source: ABdhPJxCrMZueVG32kn3OfD5V/S+3tSMerRZt8+1Afe4sFThISz5K61gnUn7J7PKb+lIjU55ykVC2w==
X-Received: by 2002:a2e:8ecc:: with SMTP id e12mr8113279ljl.33.1596498560353;
        Mon, 03 Aug 2020 16:49:20 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id w19sm4767065ljh.106.2020.08.03.16.49.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 16:49:19 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id h8so21357604lfp.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 16:49:19 -0700 (PDT)
X-Received: by 2002:a05:6512:241:: with SMTP id b1mr9664740lfo.125.1596498559171;
 Mon, 03 Aug 2020 16:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <50466810-9148-e245-7c1e-e7435b753582@kernel.dk>
 <CAHk-=wgaxWMA7DVTQq+KxqaWHPDrXDuScX9orzRgxdi7SBfmoA@mail.gmail.com>
 <cd478521-e6ec-a1aa-5f93-29ad13d2a8bb@kernel.dk> <56cb11b1-7943-086e-fb31-6564f4d4d089@kernel.dk>
 <025dcd45-46df-b3fa-6b4a-a8c6a73787b0@kernel.dk>
In-Reply-To: <025dcd45-46df-b3fa-6b4a-a8c6a73787b0@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Aug 2020 16:49:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZYCK2eNEcTvKWgBvoSL8YLT6G0dexVkFbDiVCLN3zBQ@mail.gmail.com>
Message-ID: <CAHk-=whZYCK2eNEcTvKWgBvoSL8YLT6G0dexVkFbDiVCLN3zBQ@mail.gmail.com>
Subject: Re: [GIT PULL] io_uring changes for 5.9-rc1
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 4:31 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> Updated to honor exclusive return value as well:

See my previous email, You're just adding code that makes no sense,
because your wait entry fundamentally isn't an exclusive one.

So all that code is a no-op and only makes it more confusing to read.

Your wakeup handler has _nothing_ to do with the generic
wake_page_function(). There is _zero_ overlap. Your wakeup handler
gets called only for the wait entries _you_ created.

Trying to use the wakeup logic from wake_page_function() makes no
sense, because the rules for wake_page_function() are entirely
different. Yes, they are called for the same thing (somebody unlocked
a page and is waking up waiters), but it's using a completely
different sleeping logic.

See? When wake_page_function() does that

        wait->flags |= WQ_FLAG_WOKEN;

and does something different (and returns different values) depending
on whether WQ_FLAG_EXCLUSIVE was set, that is all because
wait_on_page_bit_common() entry set yo that wait entry (on its stack)
with those exact rules in mind.

So the wakeup function is 1:1 tied to the code that registers the wait
entry. wait_on_page_bit_common() has one set of rules, that are then
honored by the wakeup function it uses. But those rules have _zero_
impact on your use. You can have - and you *do* have - different sets
of rules.

For example, none of your wakeups are ever exclusive. All you do is
make a work runnable - that doesn't mean that other people shouldn't
do other things when they get a "page was unlocked" wakeup
notification.

Also, for you "list_del_init()" is fine, because you never do the
unlocked "list_empty_careful()" on that wait entry.  All the waitqueue
operations run under the queue head lock.

So what I think you _should_ do is just something like this:

    diff --git a/fs/io_uring.c b/fs/io_uring.c
    index 2a3af95be4ca..1e243f99643b 100644
    --- a/fs/io_uring.c
    +++ b/fs/io_uring.c
    @@ -2965,10 +2965,10 @@ static int io_async_buf_func(struct
wait_queue_entry *wait, unsigned mode,
            if (!wake_page_match(wpq, key))
                    return 0;

    -       /* Stop waking things up if the page is locked again */
    -       if (test_bit(key->bit_nr, &key->page->flags))
    -              return -1;
    -
    +       /*
    +        * Somebody unlocked the page. Unqueue the wait entry
    +        * and run the task_work
    +        */
             list_del_init(&wait->entry);

             init_task_work(&req->task_work, io_req_task_submit);

because that matches what you're actually doing.

There's no reason to stop waking up others because the page is locked,
because you don't know what others want.

And there's never any reason for the exclusive thing, b3ecause none of
what you do guarantees that you take exclusive ownership of the page
lock. Running the work *may* end up doing a "lock_page()", but you
don't actually guarantee that.

                Linus
