Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01032C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC3F720661
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qUdGxncK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgDVPxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgDVPxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:53:09 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AF6C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:53:08 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id f8so2090267lfe.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0udPE9EnePSlFarVuldYTggNRyQNC5Zk7MCG7l+KWZc=;
        b=qUdGxncKjL48ifOV0XDyL0sTKyG/EZjKG5C8HIRjgDIX5h+Sh2a12dWMuHuy9PpLnj
         +MnY47OTG88LNJIydi6UUAUuNCkpqpuz4NTmJf9XPDynqedL3FutsknAGPY0Fi0YRZTM
         KkM+MalPiSWZbFzYonetaNIwfAzWWfxbjgbWnRdrmz+PlL/HvTCo4fmzSkzBOUu5kzfY
         fN9A9QleyEhlQY+wFeHBbKYjzJz+d5+qV40tIiqYUajacYuhMVtnQBeZ6/eXkw23wZAy
         jTV4wSkGt9QIr4PbESLQiOmcWk5zIuaCjZFfFc43kfpLNmtnqrs8SqgTMxifh5F7Rrmc
         cr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0udPE9EnePSlFarVuldYTggNRyQNC5Zk7MCG7l+KWZc=;
        b=Je5inqYFd9ytoXdJSx0GrnvXMk6avAInACIw2gZFxh2O8UOIzPAHxHM/Bx1o+WETU8
         81w0mBB7uHithtefVTPvpohQz1f+k2IfQ8PTJ5TKjpRWbRAJK/uHwKzNDCJGesmDFMnU
         U//pU4YMIT1W+bR2IMb+XCGgSomRLTx8HBmCWgVF4YDpgJ3xh4DwsPGJkhntAD4WQRm8
         3R29/5IzC3BRt3jqvufG4WSQg5cU8O36OFUJpiN57NP36ngEHR9krshCIYHkGRyd7ajX
         AezJt4KalRmO8Jq7sldPQWPPCkdSVdaWLgJmvD9xMYOa8DCDu2Aovn3qVCkal0CFg1S3
         w2/g==
X-Gm-Message-State: AGi0PuaW29peVrkk1Nf15lV+lA0vzPmjI6vofNI0jOXLbqjeP4SBDCCY
        B3KbhJ6GpXKirHpNl96RxiZVrlG/+QYhQkdQ8+bkmQ==
X-Google-Smtp-Source: APiQypIWkemN+mKU8J8xU8e7NjHLXmqNFRLkAUOYPdZIndUBuIhsCmbdsuuurJVWWsy7/9khQfAjp49aoUagFcLxMGU=
X-Received: by 2002:ac2:46f9:: with SMTP id q25mr17725719lfo.149.1587570787276;
 Wed, 22 Apr 2020 08:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200422112719.826676174@infradead.org> <20200422112831.988065598@infradead.org>
 <CAKfTPtB8NiKqggZN3v6u=Rdwj4grzRwn1mW31ov0y5ZhDBcvuw@mail.gmail.com>
 <20200422132923.GK20730@hirez.programming.kicks-ass.net> <CAKfTPtBsFDt8JyxjD39B2YP+kCN9nXWZxnaJys9sz2CjWzd1Zw@mail.gmail.com>
 <20200422135921.GL20730@hirez.programming.kicks-ass.net> <CAKfTPtDa2JPtc2qPSe=d187u8pp7AdvV4wKJiUJsDiAvUTE9hg@mail.gmail.com>
 <20200422153910.GN20730@hirez.programming.kicks-ass.net>
In-Reply-To: <20200422153910.GN20730@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 22 Apr 2020 17:52:55 +0200
Message-ID: <CAKfTPtA=d6pnczmU8LFpV=d-9-KArO0qfQuvzod5xYo1pKjK5g@mail.gmail.com>
Subject: Re: [PATCH 13/23] sched,ion: Convert to sched_set_normal()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020 at 17:39, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Apr 22, 2020 at 05:09:15PM +0200, Vincent Guittot wrote:
> > > It's not unbounded, like a true idle-time scheduler would be, but it can
> > > still be pretty horrible. nice19 has some of that too of course, but
> > > idle has it worse, esp. also because it begs others to preempt it.
> >
> > Yeah... you have to pay the benefit of letting other tasks to preempt
> > faster. But both sched_idle and nice19 have the same weight
>
> #define WEIGHT_IDLEPRIO         3
>
>  /*  15 */        36,        29,        23,        18,        15,
>
> 15 != 3

Good point
Don't know why I thought they had same weight

>
> Also, like said elsewhere, idle is much more eager to let itself be
> preempted.
