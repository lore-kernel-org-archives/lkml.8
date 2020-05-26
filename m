Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D2BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 790FD208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590529285;
	bh=ASAei/5aZNDnv/88Q5SmQvIFeh8mFiG+YRHwqw3qnyM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=13xKX2WsypKuEioaNJ+nAvNREhaACxI5tUceG+8l42QYKDcYD9/0YJoMwqErSazXZ
	 qGmzvd1LCi8BSfhMfW14C13LLFRhEMJH4hHsMEBwZ9GzROYvwLScIVEwKIPkJyy/47
	 OoQXipwWPawMcuBZPcUa11sffsmRw7PIba+ybWl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390163AbgEZVlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 17:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390013AbgEZVlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 17:41:24 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40FDC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:41:22 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m12so24007851ljc.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J9WojUurYp8M0OM1iDJ84mIbxKRRao8G7FiCxj1qq60=;
        b=Y78s/sN6OraGMsElR7XZ+ekhJAgzfJhfu08R4ev2QjfZIZj0BuVsU2xQJx+zFWTf/b
         o6gAs0lr5+i/v2jP4nGhV0VVzPZ8U6P2tL1tC5SwjdF/U7FCNt2TQ6dKXib4T3WjDMhc
         MMbZZuAhCZ9ONzhx9Vlhz23Yc+mcMKRpMp2LY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J9WojUurYp8M0OM1iDJ84mIbxKRRao8G7FiCxj1qq60=;
        b=bbsblL9OoZU2vVFE0rZRVOfNR3PDFiGdPyVygE0MQMbTJXn5gwV2+B4LZDJI01dLGy
         etjdiO9e6er+1AF34pBIZoD5dbh2lMeHweeCYLRr/craUYLE2ODuorCyPIOA5ghJg8U7
         /KbNmQqDlEBwfok1MWW89XySiJQbqgN+Gy1G4WxT6IDzmTKoALfXa58GNENfMvJEilQF
         As+LFRjoway5KSKr0pYUvkb13+axRQC3baqr42Z2ESF8U6ry64oJkR6CFValZ0apfMSB
         2+wXmVAPlrCw6NLc996Trfi7dV1Qw0t0u+lUPcOet8/IDHHTws60D3JEdArV0Sh90Xe+
         3oYQ==
X-Gm-Message-State: AOAM531O5lnPh5vlt+egn4faeNfMhEovytyTHkkL+ADSLDkom32xbvy6
        EQRf3/8RkK6FyaXJ+MjoyaPBSUlxsL4=
X-Google-Smtp-Source: ABdhPJzAetx/m1xmh7FFa7BkK/rrtEfKCD4vhaueqWfCDG9Rw01kO2HvM+7kbQQiENFtXyVbOQi49A==
X-Received: by 2002:a2e:7610:: with SMTP id r16mr1590760ljc.88.1590529280613;
        Tue, 26 May 2020 14:41:20 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id p19sm256871lfc.91.2020.05.26.14.41.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 14:41:19 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id b6so26436799ljj.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:41:19 -0700 (PDT)
X-Received: by 2002:a05:651c:2c6:: with SMTP id f6mr1428221ljo.371.1590529279312;
 Tue, 26 May 2020 14:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200513162732.977489-1-bigeasy@linutronix.de> <20200526194641.GF83516@mtj.thefacebook.com>
In-Reply-To: <20200526194641.GF83516@mtj.thefacebook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 May 2020 14:41:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjHgkama3SYOcYCYt_F-sxV8h4+kQ5aQSMgK7PtiQ=Nkw@mail.gmail.com>
Message-ID: <CAHk-=wjHgkama3SYOcYCYt_F-sxV8h4+kQ5aQSMgK7PtiQ=Nkw@mail.gmail.com>
Subject: Re: [PATCH 0/3] workqueue: Make the workqueue code PREEMPT_RT safe
To:     Tejun Heo <tj@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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

On Tue, May 26, 2020 at 12:46 PM Tejun Heo <tj@kernel.org> wrote:
>
> No objection from workqueue side but the comment in swait.h doesn't look too
> encouraging. Kinda difficult to make a call from my side. Linus, does this
> qualify as the RT use case you had on mind?

I still find swait to be very questionable, but at least it has gotten
better over time.

Almost all users of swait have historically been buggy and/or
pointless. At least the naming disaster has been fixed, and the
outright bugs have hopefully been handled in the process. The
"pointless" part has been that people have used these swait lists for
single-entry queues, for absolutely no reason when just a task pointer
would have been the better model.

Honestly, that seems to be the case even for the workqueue code. Why
the h*ll do people insist on using wait queues - and then converting
them to swait queues - when there is only a single waiter (the pool
manager in this case).

I really don't understand this fundamental disconnect with reality.
You have a waitqueue with locking issues, and a _single_ waiter, and
what you do is convert this to swait.

WHY?

And no, the answer is not "swait is just so great". swait has
traditionally been a buggy misnamed disaster, and the fact that at
least now it's no longer using actively misleading naming any more
doesn't make it magically better than just "wake_up_process()".

             Linus
