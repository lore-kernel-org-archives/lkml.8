Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E870C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E94AB206B9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vlnaxe6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894698AbgDPNAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2894531AbgDPNA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:00:26 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5243BC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 06:00:25 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q22so7760999ljg.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 06:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AeHBEnFZl+NhqzR7wy4wT03tgSkivqbCYEDT2pt/LpM=;
        b=Vlnaxe6qX46DWb/BlxfTeRcY1RfKgPd4fVHtCo1BUdk2xf8cJQLT9s9H0zQjV+qM/X
         zxr12p6j8NiKKVxcLIhQBuehVsQaqlu6qvlhrERADHgSp/ByVSUsBkz27nSFJLN90g9o
         p6qvP5YQ+F3A3XNKOQBAKlkPO+hCc/yFiBZEHrZa+/4BlcT4ZDzql13/neJ40Xr89cql
         L9hFAv1RkFhHuOQQtD06H01CvkA+dZTYnpdJZ7Vw+bwPWWdMDeJulf+uRGlfSYlYwBX6
         hpimNkbTXOrb6Tf3hISoslFzBiC0vAsACYMiAMaa9iCW8Lb36jwVKJSKfoIrkNlmDi8H
         EdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AeHBEnFZl+NhqzR7wy4wT03tgSkivqbCYEDT2pt/LpM=;
        b=rUMQ0E4zDfjHs87namLss0Lkd/ePWBwjRPTrF+ErDjS0oezNuAtXTcHSCd4mBSgggY
         +jLCJI/HnoRlAgp7ernEd6Y4diteR7q+hjr9zSkLOlhl8oI+uCgpdvQM003KCUPLJT9S
         nZHy81tVsmFJLeRTCQyIyFX8P4nI98WdG3ETFYkTSCoKpN5RcKn9xTZVZzT0QEngmGZW
         ekdNALkBEfoFLm0UPYz0qnhDCkxdy4R4Ytz6nKiJxllK/RuEZQIJmYlgzFYJhn61I497
         gOoVislLs0CxsBO4y7J3vtVYM3goMGhauXVfFCKhcOBHJ6y9NGMJpvcKRRh4WlIbDfJ6
         c+WQ==
X-Gm-Message-State: AGi0PuY+tWA0K9lYYBeHyACXJgKQn1T9XXKyD4bhGvZg35+jvi4bcBdN
        SPhEmBi5nSZ6Sp6EUzpUPy2e/67qoVFEt31IqRqJkw==
X-Google-Smtp-Source: APiQypITgGoC5uuQ/8MnWQvY44uoOclkk8R7KZ9pL5IBd8IKcD5V7eaxCdyozjE7KD6zKsfsYbX6eyVPGBv+/Lq3PRU=
X-Received: by 2002:a2e:7c1a:: with SMTP id x26mr5955613ljc.209.1587042023468;
 Thu, 16 Apr 2020 06:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200415210512.805-1-valentin.schneider@arm.com>
 <20200416105828.GN20730@hirez.programming.kicks-ass.net> <20200416110056.GT20760@hirez.programming.kicks-ass.net>
In-Reply-To: <20200416110056.GT20760@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 16 Apr 2020 15:00:12 +0200
Message-ID: <CAKfTPtB=Jr2XXjdUokRneNWNCNt6k6yYvhTuWxgAF4qs_wS2sg@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] sched: Streamline select_task_rq() & select_task_rq_fair()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020 at 13:01, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Apr 16, 2020 at 12:58:28PM +0200, Peter Zijlstra wrote:
> > On Wed, Apr 15, 2020 at 10:05:03PM +0100, Valentin Schneider wrote:
> > > Valentin Schneider (9):
> > >   sched/fair: find_idlest_group(): Remove unused sd_flag parameter
> > >   sched/debug: Make sd->flags sysctl read-only
> > >   sched: Remove checks against SD_LOAD_BALANCE
> > >   sched/topology: Kill SD_LOAD_BALANCE
> > >   sched: Add WF_TTWU, WF_EXEC wakeup flags
> >
> > How about I queue two first 5, and you rework these last few?
>
> Argh, 4 ofcourse, that 5th patch doesn't make much sense if we have to
> rework those flags like I proposed.

Looks good to me too

>
> > >   sched: Kill select_task_rq()'s sd_flag parameter
> > >   sched/fair: Dissociate wakeup decisions from SD flag value
> > >   sched/fair: Split select_task_rq_fair want_affine logic
> > >   sched/topology: Define and use shortcut pointers for wakeup sd_flag scan
> >
> >
