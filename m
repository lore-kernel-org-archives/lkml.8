Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD3CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 22:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8C63207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 22:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597874722;
	bh=jukmfwd6a428b66rXMBYmKn97W9jM93Aja1s6wo2850=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LYQ4qzzsJmhSivw2OWNr7XXkbKVRngwl6X61J1+9kGqJaYBfTKMDZYC62200bnpl0
	 ErRdq8pyh83PXtDfQjxGB+L3/5LeFYafVSeuKKS94n9a3W93ICq5TIFGrQ8m6/Pb9j
	 Mu2OTNzur/y8GSnaPgY3kZiPmi3eUKLKG0yhD3s4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHSWFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 18:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgHSWFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 18:05:20 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D46CC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 15:05:19 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h19so27093665ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 15:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3CY9SyyyNDsLuFPD7br1LJ2x1XbKvP0/ZmH+CIHwRnU=;
        b=e9BbwpAddXS6JsYm5LejIENcNeNfoAbUQhjb6ebUPiytUG3ICMd046xXR/rpS5fezi
         qE0FzaDpmUmz3rBr6NQAvCq4leTJ68j/VzYwNdbP/GW04ze3xqdHGg6FLbrAqWf1Cg6J
         TonKflUyZAxNmBf4cX6hkEN5tLYCDXlxMh96s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3CY9SyyyNDsLuFPD7br1LJ2x1XbKvP0/ZmH+CIHwRnU=;
        b=nNwBfZADsIJr6DwsL3SzF0WzNR6DEXFNUDkgzArmeNw5b3jBJ8N5C8cNwtjYigiXxs
         RVVbPZE9lMKr98hc3UftJgk9P2zwtMqu3eYYtrVzh0IrdCFRL9SrgAGZskZ/4EyOyj0L
         l9mCMTb3bHNJCcNHptVFCPvZz3Gdj115KAi++KMJJgTgol3BLLTGGWf3mBIXqcWUVlGi
         SzaBJcC0rqDNHL4uHWMCwXAAlbpLpsQ7MPTEZfIuC4r54lAYxKaewY+Ds44DmI7lHgqI
         sUeh5F+mAyIQpdyflCOKtpygYuczSSg+NKbAFHydJQGHQFhaSqiDg/RsPcOb1nlXrkid
         ly0w==
X-Gm-Message-State: AOAM533ru8lIpngz2No246XX3cjxPfw97qf6xtIOltxBO1bZGw2rWtSr
        WBGxeg72uviKuNrHyAhOFU8xr3H275BdWg==
X-Google-Smtp-Source: ABdhPJz6ZPHKtwzfh00mD1iGY4533LnZUmhf0deKXmkXLZjvCFzi13ecNoPx/pxirmttnLFng1ayvw==
X-Received: by 2002:a2e:80d8:: with SMTP id r24mr118680ljg.305.1597874716713;
        Wed, 19 Aug 2020 15:05:16 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id y9sm49430ljm.89.2020.08.19.15.05.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 15:05:14 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id m22so27071932ljj.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 15:05:12 -0700 (PDT)
X-Received: by 2002:a2e:b008:: with SMTP id y8mr106478ljk.421.1597874711996;
 Wed, 19 Aug 2020 15:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200818105102.926463950@infradead.org> <20200818112418.460474861@infradead.org>
 <20200818162542.GB27196@lst.de> <20200819072209.GU2674@hirez.programming.kicks-ass.net>
 <CAHk-=wgMATDQQxLSsgmxCoCqApVXVeRnGOf6iWjnYdTJY_R3aw@mail.gmail.com> <20200819194116.GJ2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200819194116.GJ2674@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Aug 2020 15:04:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh2_pAFxa8FN95KoOseqMYPD0iX-d6ORbXxX22ixVZwBQ@mail.gmail.com>
Message-ID: <CAHk-=wh2_pAFxa8FN95KoOseqMYPD0iX-d6ORbXxX22ixVZwBQ@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 08/10] smp,irq_work: Use the new irq_work API
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 12:41 PM <peterz@infradead.org> wrote:
>
> I'm not sure I get the "expensive irq_work queues" argument, I fully
> agree with you that adding the atomic op is fairly crap.

There's an atomic op on the actual runing side too, because of the
whole IRQ_WORK_PENDING thing.

So you get that double hit.

Maybe it doesn't matter. I just remember us being very careful to
avoid any unnecessary atomics in the smp_call_function area, but
admittedly I haven't worked on that code for a few years, so ..

                Linus
