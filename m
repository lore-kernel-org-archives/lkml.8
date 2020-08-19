Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B54BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68FE9207DE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597863079;
	bh=fqTv9oQdIeZgjEluImr6yY1b8ndbcKGOqvt/bNfx7D8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ybhoDxLc21bhjHoXttWsOG1po2d+4W05lgMGCIm5jIUGhjUkrThnyiGXw1BOl/n+n
	 HJxF1/yR6wG4N/WBUCJATIWx92ys50jWaoj1OgDmbV7BXEIXU9sRiAPbh0FVOY5yay
	 NblFMsz0ZaXMXgZ8c9/Av5EnkvlTgLAkHxQnGy2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgHSSvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgHSSvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:51:15 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984C7C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:51:15 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t23so26576041ljc.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hGVzfbKpKFG7FgQ+mRgouJYalcSPr/oWhs8I8+UWA04=;
        b=P6TdUNNyLEXtFN3uf+RNMJ6AJnnQDaj2fwlveK85TDnO6kTKE2aWywSdXf0Fd6nMsj
         N/SUAOdz1SI8dkcAwDk6zKkR7ZyE9xH1fT73gwVBVp9KJ89+0V5NKZUUY2Aq1/h18TI6
         /LfluIVBo9DtpjCjw4egKswukidd9I3fMNX4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hGVzfbKpKFG7FgQ+mRgouJYalcSPr/oWhs8I8+UWA04=;
        b=lmN7q6YKs2C9D2S+0XpjCUSZ6fYv2PEKdZv7RqLNsAg7xDnhRADF/Qs4zfVqbNhvbb
         MikKb3cADi8Aq/0J8+SF0u+ePedIQDifKo3VxUirRzvvT+a1CBudbHJMLMgNKnynS4o6
         K+7/NUzTVwtMvRX5K/wnFg+if+YqUuhatj7Agwate5kU9a9l1I8KOpQUCed97TxSJNeb
         BLyaQyvRy8wb1uvdUnYbpPXU4snpvFiNm3ClZ7jltXTs3F6Z5csmpWSFc5+EXzzDCaFw
         ZgxVRFiAlL85hDg9hSl8NDZVF7sxS+q7E/NxRWV5Nc+o+ewunEAJjvY8RXEjJsOUDk3F
         n1OA==
X-Gm-Message-State: AOAM532JT1JtbCGR6AbMKm7bGTnrhAAUokeIw5nce7uIWEZSDGmKk9Dx
        pT5Gp1ZsVrvH+iKJ+HD4ExkmaOMzmzbB5Q==
X-Google-Smtp-Source: ABdhPJz6Gy+KKIckjXXOMee/IIzJEhe/ACWqzs3kmFg+2sosXLN0W+IFTGui/b/dmP8u2egQuz6uVw==
X-Received: by 2002:a2e:3615:: with SMTP id d21mr13228896lja.333.1597863073462;
        Wed, 19 Aug 2020 11:51:13 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id o7sm7456031lfa.88.2020.08.19.11.51.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 11:51:12 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id i80so12582780lfi.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:51:11 -0700 (PDT)
X-Received: by 2002:ac2:58d5:: with SMTP id u21mr12805418lfo.31.1597863071540;
 Wed, 19 Aug 2020 11:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200818105102.926463950@infradead.org> <20200818112418.460474861@infradead.org>
 <20200818162542.GB27196@lst.de> <20200819072209.GU2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200819072209.GU2674@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Aug 2020 11:50:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMATDQQxLSsgmxCoCqApVXVeRnGOf6iWjnYdTJY_R3aw@mail.gmail.com>
Message-ID: <CAHk-=wgMATDQQxLSsgmxCoCqApVXVeRnGOf6iWjnYdTJY_R3aw@mail.gmail.com>
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

On Wed, Aug 19, 2020 at 12:22 AM <peterz@infradead.org> wrote:
>
> That is, the external serialization comes from the non-atomic
> test-and-set they both have. This works nicely when there is external
> state that already serializes things, but totally comes apart (and
> causes trivial list corruption) when you get it wrong.

Quite often, there just isn't any *need* for serialization, because
there is only ever one op active.

That can be either because the csd is fundamentally a single thing ("I
will transfer this object to another CPU"), or it can be because the
CSD is already per-cpu (ie smp_call_function_single).

You seem to make that common situation much worse.

Not only do you add that expensive atomic op, you add that expensive
"use irq_work queues" for something that doesn't _need_ to use them.

I have to say, I'm not a fan. What are the real advantages? Your
listed disadvantages are very very questionable.

IOW, what are the actual examples of "totally comes apart" that justifies this?

If the example is theoretical ("if you use csd's wrong") then I think
they are worthless.

             Linus
