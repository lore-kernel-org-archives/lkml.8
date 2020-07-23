Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD64C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 00:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A813522B43
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 00:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595463804;
	bh=hs7tEy5tXx54fszU9AlXUJKGpDkU87uOSZ8zsgw/WLk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HomjFkBOTjg22ppY1pEiyTijl6sjIv++d2GbLVkdP83U7XvIrvOhP8lW8px0tH/sE
	 PAuUPvipnuvRPz1SQznL5hpxOp+kf/mfGzVygdPKjx2BiM+T/rB4JGEgVia+2Os/aA
	 IQc8RKRIG54rMx/NqIRzySh/6UFpllzzgRwdCK/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731300AbgGWAXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 20:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgGWAXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 20:23:23 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AC7C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 17:23:22 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id i19so2338196lfj.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 17:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MLLzW+27c7XskPvxXHpuyTEdYRgvVTLDhxahIBegs8U=;
        b=faikLq+G0vsoBxFYA9T/K3S7QiQTxZoo+WHfXFKRntEclWn6SyFd0s8e5ihC2YGfEC
         xwEvgtLDOzsUvG+mLwzkpkw5BWy4EaMb85BSL5WQahdJG+1+X8n95u66NxFu9yT0IBOw
         4tNBH4IclDxdU2pXAz9akDwoOAVeAIioMO1QA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MLLzW+27c7XskPvxXHpuyTEdYRgvVTLDhxahIBegs8U=;
        b=ETBQP9TZ0ZrrDCOC8AC+RLRQDlRARhsWWcGGUhK75RDcUW0Zh8qFkuq3TH5DaRfs7Q
         nQTXdJXT5bdIYedBEYoeC9pg1DctP2735aC1VRVfM3lWO4O1xeBYx6tujvxZhanNzfvK
         YT7UfonvCcxQvCCWTEKqs/ADHoI5IbxQz2dQ+nJkwOnNevUkV8flDAsuIthMJPsbgSA3
         uWzbTk6FaFVSNBu+dQmCa7Up8vR4sA6bID7F4NuOEZCl0pDFY8Ynm1irJKSLx18iBrwj
         R5R2EO0t32XyaUqy6bajfi18IsMGv+yZXrhcquxAo6vEzJc2fvuuftfhvQWfQXIohS4y
         0jeA==
X-Gm-Message-State: AOAM5339C6m2ITVnaM7wac/li4brvQh0cZ0zFlbL50hvzVnZwSWA8+e+
        8HFWJNh284mqc87M8m7ZAUxgXh77g38=
X-Google-Smtp-Source: ABdhPJyF0JaN4VGKkCtDJrW0wVee3hC+NytPRFHHVxoZl07YnVC1QAIwBpE0GjhR6BDnyfX22W0cwg==
X-Received: by 2002:ac2:5991:: with SMTP id w17mr873525lfn.153.1595463800460;
        Wed, 22 Jul 2020 17:23:20 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id g19sm294270lfd.28.2020.07.22.17.23.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 17:23:19 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id e8so4505399ljb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 17:23:19 -0700 (PDT)
X-Received: by 2002:a2e:9c92:: with SMTP id x18mr706723lji.70.1595463798932;
 Wed, 22 Jul 2020 17:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200721063258.17140-1-mhocko@kernel.org> <CAHk-=whewL14RgwLZTXcNAnrDPt0H+sRJS6iDq0oGb6zwaBMxg@mail.gmail.com>
 <CAHk-=whb0=rjc1WR+F_r_syw5Ld4=ebuNJmmpaPEzfjZRD5Y-w@mail.gmail.com>
 <alpine.LSU.2.11.2007221359450.1017@eggly.anvils> <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com>
 <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com>
In-Reply-To: <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Jul 2020 17:23:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiqzsK_c_jUXFnSXeumsRQpYEwv0Xbi3MiGKLcVxS2_kg@mail.gmail.com>
Message-ID: <CAHk-=wiqzsK_c_jUXFnSXeumsRQpYEwv0Xbi3MiGKLcVxS2_kg@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
To:     Hugh Dickins <hughd@google.com>, Oleg Nesterov <oleg@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 4:42 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> NOTE NOTE NOTE! This is both somewhat subtle code, and ENTIRELY
> UNTESTED.

It seems to boot.

It adds more lines than it removes, but a lot of it is comments, and
while it's somewhat subtle, I think it's actually conceptually simpler
than what we had before.

The actual waiting loop itself, for example, is now entirely and
utterly trivial.

The DROP behavior is also a lot more straightforward and logical, imnsho.

The biggest annoyance I have with it is how it open-codes
"finish_wait()", and honestly, the "proper" fix for that would likely
be to simply instead make "finish_wait()" return the "did I need to
remove it from the list or not" value. That's the only reason that
patch open-codes it right now.

It _feels_ like the right solution to this thing.

But maybe that's just the "pee in the snow" effect, where I like it
only because I've put my mark on it.

So it would be good to get more opinions, and perhaps more testing
than my limited "it boots and works for me, and I can still build
kernels and run a browser".

                Linus
