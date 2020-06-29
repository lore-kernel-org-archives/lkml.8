Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0470C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 879A020702
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593457663;
	bh=qq7ZcimKgcvZGSbhjx5SCcEVvBKM4tarWe+r5yLEdX4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oxarPXGP3xtdT+KYOXwknWiwV9nx8/BNqGQqq0YSAoMIxFzBwtgKaJeh+UWQm3bcG
	 /YSz/zO7N49W8A9eMLZeVQwolg3+lN2YrmeS2jwnJB/OQrfy8w6+MNO33RWxm7xcih
	 VboceOvHMcvxki/dzuajKttRgmqtjjyXoEx5xiHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbgF2TG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730523AbgF2TCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:02:43 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40136C030F23
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:36:52 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h19so18712789ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tI71Ydu+pOwgXlMgU1oRf0sUNNr5tt035+vZPAuuAlc=;
        b=aUdFRUhudS+xPjPDQJSELxYOf4pJLDIm4+/ROEP7p1wsB51Uh2J9psit34O0WmSaxJ
         OYVP5cGLT9NFbqYH97fpKyzYqtetDtgEQMyQ95b1c8KZXih8pZxMfCuFO6cesNCcfyUh
         MZ+KwA8V96MowogGQxiP9Tmg7PvYg8Xa4kdsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tI71Ydu+pOwgXlMgU1oRf0sUNNr5tt035+vZPAuuAlc=;
        b=kh0Vcv1FifW2nMOWChn+SO/tdMR6fD35t4jqa9lTxydmEtNzaKLGkp/WVx5D2N7Cgb
         lbPxGCqWVbz0jo3HGFKqMqKiH0itzRcrhlnF3rkBnRDr4RrzObTfOSs7cngY6a23orkX
         gnEid/7eSrEts3hk8dXWqOmucl2lbweVUxpz5MnhA+gVcEditBTXJtMLfjjv4LHPXXQY
         tG6ySvOLteprJ1zT8KT2oiGCP48EzrKZruqQy2PSHOIGFry/Ndvlgcf6wyad/xSa3Wsg
         PKvJ48QgPUK74J98thEZPoyUgxSjA3X98YlWMfwWvI+hREGXgT1L58VzHS/R19l3WiYu
         oK8Q==
X-Gm-Message-State: AOAM533ojN0Pn37p54TSWuXd23xxu7lktKVmHfdAsy3xj4I7upf5z+Wb
        GwQUaXqgu6MdtbagjveUD7dZ1GgbZkQ=
X-Google-Smtp-Source: ABdhPJxgB18vHifK/fLWhdVGFdE+3JqppPYalnPYumYqYevAlih/Og2IBuVHZgf4eYqIbN5uQuaxjg==
X-Received: by 2002:a2e:99c6:: with SMTP id l6mr1064609ljj.220.1593448610367;
        Mon, 29 Jun 2020 09:36:50 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id w24sm42617lfl.17.2020.06.29.09.36.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 09:36:49 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id n23so18773020ljh.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:36:49 -0700 (PDT)
X-Received: by 2002:a2e:991:: with SMTP id 139mr8131159ljj.314.1593448608820;
 Mon, 29 Jun 2020 09:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200624161142.GA12184@redhat.com> <20200624162042.GA12238@redhat.com>
 <CAHk-=wjJA2Z3kUFb-5s=6+n0qbTs8ELqKFt9B3pH85a8fGD73w@mail.gmail.com>
 <20200626154313.GI4817@hirez.programming.kicks-ass.net> <CAHk-=whvVWNXPJq1k566zn4SfXAifXtiA7T+7JFweR3rQ0nc9A@mail.gmail.com>
 <1593396958.ydiznwsuu8.astroid@bobo.none> <1593436373.x8otyji40u.astroid@bobo.none>
In-Reply-To: <1593436373.x8otyji40u.astroid@bobo.none>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Jun 2020 09:36:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjJKicPgmvf7atx=h6Li7ez9nFrpJdgTSRm5aUEnuVH6w@mail.gmail.com>
Message-ID: <CAHk-=wjJKicPgmvf7atx=h6Li7ez9nFrpJdgTSRm5aUEnuVH6w@mail.gmail.com>
Subject: Re: wait_on_page_bit_common(TASK_KILLABLE, EXCLUSIVE) can miss wakeup?
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>, Jan Kara <jack@suse.cz>,
        Lukas Czerner <lczerner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 6:16 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> No, ignore this part (which you explained well it was just a thinko,
> and your patch of course would not have worked if this was the case):
> the exclusive wake up doesn't get lost if schedule() was called because
> state goes back to running regardless of what woke it.

Right.

The normal pattern for a wait-loop is

 - add yourself to the wait-queue and set yourself "sleeping" with a
memory barrier.

 - test for the condition, exit if ok

 - go to sleep

and that pattern doesn't have the race.

The other common pattern is to check for the "do I need to sleep at
all" at the *top* of the function, long before you bother with any
wait-queues at all. This code does that odd "let's check in the middle
if we need to sleep" instead, which then caused the bug.

So we had an odd setup because of three different wait conditions that
had different rules for what they could/should do before sleeping, and
then not sleeping reliably at all.

We could also fix it by just splitting out the three cases into their
own wait routines that match the normal pattern. The bug really
happened because that wait-loop is doing things such an odd way due to
all the different cases..

I actually think it would be a lot more readable if it was three
different cases instead of trying to be one "common" routine.

The *common* parts is the special PG_locked logic at the top, and the
thrashing/delayacct code at the bottom.

And *that* could be a true common helper, but the wait loop (which
isn't even a loop for the DROP case) are fundamentally different and
probably should be separate functions.

So I think my "one-liner" fixes the problem, but I'd certainly be open
to somebody cleaning this up properly.

Anybody?

             Linus
