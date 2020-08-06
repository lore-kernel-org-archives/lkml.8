Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7BEC43619
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43CB722D71
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gOvhi5v7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgHFKcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 06:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729279AbgHFKci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 06:32:38 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC24FC0617A4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 03:31:50 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 93so25615984otx.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 03:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ypy/qALQFzmq+pA0XvKiGAPjinMvR6vyLxRwEn3AJFI=;
        b=gOvhi5v7BbQFQoXJcbV51yRSVcKrTP34twEImtq5+qWngIgzldbxjrxCgTSeJBcVhP
         618+tmwcLdKMfEJq5jbujOgUXAU90c0yN3Z2HHwNANalPBjJJKs0/OmkNsA4X4jC+DwO
         tY5S0ZeRPlwAkbX9ZzjlXSAO1SyCaVB+dqT6CsKr8lvUyIGHKquAap6l48keHVwHs9iy
         qJZdMO0bo2jBQmsa44AulU7Pjg+9lZN4XMcM2rFcOUQTwhUb71hZr7FeyxRFyFG9O+3A
         yLb8SAJlrVxYmQwwGY+EJl4lg3zxMnktNggdEbtcaqA0YTwlFFJ3rE9u9vew1hMn0oht
         nD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ypy/qALQFzmq+pA0XvKiGAPjinMvR6vyLxRwEn3AJFI=;
        b=JPV50fphlNMrgFLs/nw8Y1MV/mUwPkmi55k4P/0NGuXz6fcL+ECxkCc3oTsY0Rsz1h
         feDgudJzNNZLujXJ85jiTf+ibGYEiLJU1DwHuP8cJexYdHJ5Qe2shRratG8qe1CTvnBl
         9dhVW3elBDiLkgDRR+Qov8t+ld2hsdVtaI2bZ9IHJxhUSdVYtYu5J89G5QoThRzM+7S8
         gHFBU2EDB3R29rPLD17Xvm1aGOmiNUWRUfUl3NLjpAq9YHwzvPl0tSYM1sgJtSPrd/4Y
         oKW80qISZWBVHHqu7z8C4pCX8MeQ0a3AN4i4oxij7RzlAHZtQD3L6M5BAFw3tkFFVUPB
         MTfA==
X-Gm-Message-State: AOAM532hqfvtggWMi3Zn0zgN6DtEZiqsj5YpK3EYtC/GhCxD58N9VG9o
        FfJ4Ysqmq1kDOYcHmHCTUqfhVvY4iU/Gjr1WsOj6eA==
X-Google-Smtp-Source: ABdhPJwGxfFTOMnCB+7bQVHYWAbL/9U5CLzSy4zlUHOTah/Hy8phgbFCvlGhsR1zgrKyUQro3jZbKMd4mKlz0TYmk9A=
X-Received: by 2002:a9d:739a:: with SMTP id j26mr6861992otk.17.1596709908446;
 Thu, 06 Aug 2020 03:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200805230852.GA28727@paulmck-ThinkPad-P72>
In-Reply-To: <20200805230852.GA28727@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Thu, 6 Aug 2020 12:31:36 +0200
Message-ID: <CANpmjNPxzOFC+VQujipFaPmAV8evU2LnB4X-iXuHah45o-7pfw@mail.gmail.com>
Subject: Re: Finally starting on short RCU grace periods, but...
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc kasan-dev

On Thu, 6 Aug 2020 at 01:08, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Hello!
>
> If I remember correctly, one of you asked for a way to shorten RCU
> grace periods so that KASAN would have a better chance of detecting bugs
> such as pointers being leaked out of RCU read-side critical sections.
> I am finally starting entering and testing code for this, but realized
> that I had forgotten a couple of things:
>
> 1.      I don't remember exactly who asked, but I suspect that it was
>         Kostya.  I am using his Reported-by as a placeholder for the
>         moment, but please let me know if this should be adjusted.

It certainly was not me.

> 2.      Although this work is necessary to detect situtions where
>         call_rcu() is used to initiate a grace period, there already
>         exists a way to make short grace periods that are initiated by
>         synchronize_rcu(), namely, the rcupdate.rcu_expedited kernel
>         boot parameter.  This will cause all calls to synchronize_rcu()
>         to act like synchronize_rcu_expedited(), resulting in about 2-3
>         orders of magnitude reduction in grace-period latency on small
>         systems (say 16 CPUs).
>
> In addition, I plan to make a few other adjustments that will
> increase the probability of KASAN spotting a pointer leak even in the
> rcupdate.rcu_expedited case.

Thank you, that'll be useful I think.

> But if you would like to start this sort of testing on current mainline,
> rcupdate.rcu_expedited is your friend!

Do any of you remember some bugs we missed due to this? Can we find
them if we add this option?

Thanks,
-- Marco
