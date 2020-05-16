Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FDAC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 05:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83FF620767
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 05:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tOOAgCP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgEPFDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 01:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725803AbgEPFDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 01:03:18 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F42C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 22:03:17 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id x15so2247199ybr.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 22:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x/5cYDQ1oZIZVQJWwS41SSv1uW/pl/h7TUy4jDkcR/I=;
        b=tOOAgCP7ujM0mY6Thl9bA4ltUOmdCjhcf895cOi67X26MFq1jrIqbudnJfQDOf1fbP
         WF9/pgAErK1zcaE1xM/eA8UsXWeKW5XuZO3XRelY242zmQOtNUDIqrfgg5dr4uy3YynQ
         f0wajwNuGOo9OnlFqZd6DnpgZ4mWBt5pJX/vicF80E7W24GtCCGjdNSirNep+QMKch5h
         ZvkwluFVLH3GRV4anQzzLTj4K77uulWbgIcccrTuTMywOL8M3E93vnTtnI3hMrWpEzVK
         eAIDW+awYwpFzZGIlmQC+JfCLUj3CDCdoH2vbvWXFSDdcyzEh/1khgqOknV+wD4iZlWk
         JArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/5cYDQ1oZIZVQJWwS41SSv1uW/pl/h7TUy4jDkcR/I=;
        b=Q6wAl6+uTPnvp5CRfCkfki0Ftrv5oa1Rg8232UzKraIz6J9NlBZpEQ772hKggZRntN
         OLiEJoujSuJ1AhW2C/kwwVjYATgq/IbnnaeKZxkf+P4RtmObML/BydV+UU4y6EP5s6T5
         g0a2SIWe5ZTN3JPj2MR/DqbgMwzOI67pElNN8uo/G0YzxP5bJg8L4UGKgPG5mSrHbAw4
         Wv3xKDCxCLxQ+8xxgAY0tq+OhG30wTgTCDAitkaBaEcSPEVPYy5hc1pcNw6NyM9xg3NQ
         Jh+TBDHa3oXVvgGQdrVQTf4kqQ21TUZf8gCmeV2HF2MDl40dCzZX+RNnG+o+g2ynhWCn
         0bYw==
X-Gm-Message-State: AOAM530Sz8F8VTqTHi9ETrFE6yqBRgCoWl9VspMCstY19jcOEvdcBDgT
        7nG75z47sJC3Tq3l3ZcVeIRlvxWnZpBA0Y1x2J/pmA==
X-Google-Smtp-Source: ABdhPJyqQul6ryq00cd3+/+P9stZaAiOuTSG4KnwBEfd+CY0+2l8zlOhTM+7LotgWKbkRZ12GQ1yVXyxvwXDz1Dlwy4=
X-Received: by 2002:a25:7044:: with SMTP id l65mr11413708ybc.7.1589605396743;
 Fri, 15 May 2020 22:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200515150122.GY2957@hirez.programming.kicks-ass.net>
 <20200515155912.1713-1-laijs@linux.alibaba.com> <20200515155912.1713-2-laijs@linux.alibaba.com>
 <20200516042705.GA82414@google.com> <CAJhGHyB5BAR2k8OALutExW-Z1iOqjA1s5_vtsU2p2QNa2tE9eg@mail.gmail.com>
In-Reply-To: <CAJhGHyB5BAR2k8OALutExW-Z1iOqjA1s5_vtsU2p2QNa2tE9eg@mail.gmail.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Fri, 15 May 2020 22:03:02 -0700
Message-ID: <CANN689Hw7Z4ScsdXcnhAZTqePb8bx6UP-XAtQRcVKv79aKjXtw@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] rbtree_latch: don't need to check seq when it
 found a node
To:     Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 9:52 PM Lai Jiangshan
<jiangshanlai+lkml@gmail.com> wrote:
>
> On Sat, May 16, 2020 at 12:28 PM Michel Lespinasse <walken@google.com> wrote:
> >
> > On Fri, May 15, 2020 at 03:59:09PM +0000, Lai Jiangshan wrote:
> > > latch_tree_find() should be protected by caller via RCU or so.
> > > When it find a node in an attempt, the node must be a valid one
> > > in RCU's point's of view even the tree is (being) updated with a
> > > new node with the same key which is entirely subject to timing
> > > anyway.
> >
> > I'm not sure I buy this. Even if we get a valid node, is it the one we
> > were searching for ? I don't see how this could be guaranteed if the
> > read raced with a tree rebalancing.
>
> It is valid because ops->comp() returns 0 and it should be
> the one we were searching for unless ops->comp() is wrong.
> The searched one could be possible just deleted, but it is still
> a legitimate searched result in RCU's point's of view.
>
> A tree rebalancing can cause a searching fails to find
> an existing target. This is the job of read_seqcount_retry()
> to tell you to retry.

Ah, yes, this is correct. It wouldn't work if we wanted to return the
next higher key for example, but it does work for exact matches. Nice!

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
