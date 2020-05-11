Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABA8C54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3CFB206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Qmt0davu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbgEKOzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 10:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726410AbgEKOzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 10:55:07 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55209C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 07:55:06 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id b18so641054ilf.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 07:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j4cTbhBEuzkRPdUYgvhBb3SOKxTd9Blhp/EM3p/3NNE=;
        b=Qmt0davupjiYVu1SLiWVLBR6s9BkOUUSUU1ayEVcBxGlaHKqe1IuuQlwsuzy4pfFuq
         ++A89cYwrQ/2pnyDtD0k0BqyJVtnGB/2wt2gMmBOTNY2AvOUcStPtOYycJjIva9Fnq0i
         npqwYDfquFOENdPpKawKn8ZhSQ4udZKqLkQeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j4cTbhBEuzkRPdUYgvhBb3SOKxTd9Blhp/EM3p/3NNE=;
        b=j09w3ENmyoaPkrNvC8SJN7wdXrdI2C2GkyBRFuomVgbvMBN3q1n217aIxtF7zQGTwG
         bv2cp+yEkPNvzsb9AwGFr2dox0CTo7bRjH68X0bzgtGniTjxAa1mhpnjRD0Iu++127G/
         +1V51uCKoNyfuTI1YpNqgzOxQoopQf/2N4PYXfM2FDNQy6vkktj5O7DwNVP5rBfyN32G
         clHB1P+uN0uLhANe0/l2tCQicydlP6EfgZltLfMeGVaN1OkV7sKhyu5NhKDblBTGuHMj
         tp5LLEV17NDIQf2ZqFHO0QlszwjjoO1L2Jj8wCfN7bNDIsc0787V4L1/c8/9+Nr3lXwj
         Lj4A==
X-Gm-Message-State: AGi0PubTH5zI8d8OeSLJgaPdPIpIlNTPxa3g2oTd3J032jQ/3JmuNfhw
        BAKV0dO4TbNs4Dv07iNcfISOzUozw2IaGtYQCkEIzw==
X-Google-Smtp-Source: APiQypI7SLb+js7Li3zB6H/D2jeISjXKOrnBDGxv6XSkD/EuSL7YGUQj7huzsPFv+2U6Gp8ctThXn5cQTzNHjAwBa7U=
X-Received: by 2002:a05:6e02:80e:: with SMTP id u14mr17777271ilm.176.1589208905586;
 Mon, 11 May 2020 07:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <20200510234652.249917-1-joel@joelfernandes.org> <20200511134921.GC2940@hirez.programming.kicks-ass.net>
In-Reply-To: <20200511134921.GC2940@hirez.programming.kicks-ass.net>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 11 May 2020 10:54:54 -0400
Message-ID: <CAEXW_YQvVvNS5e89YQX7GALxPUXoymuZ_pDN+5iaAj_yiN3abg@mail.gmail.com>
Subject: Re: [PATCH RFC] Add support for core-wide protection of IRQ and softirq
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vineeth Pillai <vpillai@digitalocean.com>,
        Allison Randal <allison@lohutok.net>,
        Armijn Hemel <armijn@tjaldur.nl>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Muchun Song <smuchun@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 9:49 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sun, May 10, 2020 at 07:46:52PM -0400, Joel Fernandes (Google) wrote:
> > With current core scheduling patchset, non-threaded IRQ and softirq
> > victims can leak data from its hyperthread to a sibling hyperthread
> > running an attacker.
> >
> > For MDS, it is possible for the IRQ and softirq handlers to leak data to
> > either host or guest attackers. For L1TF, it is possible to leak to
> > guest attackers. There is no possible mitigation involving flushing of
> > buffers to avoid this since the execution of attacker and victims happen
> > concurrently on 2 or more HTs.
> >
> > The solution in this patch is to monitor the outer-most core-wide
> > irq_enter() and irq_exit() executed by any sibling. In between these
> > two, we mark the core to be in a special core-wide IRQ state.
>
> Another possible option is force_irqthreads :-) That would cure it
> nicely.

Yes true, it was definitely my "plan B" at one point if this patch
showed any regression. Lastly, people not doing force_irqthreads would
still leave a hole open and it'd be nice to solve it by "default" than
depending on user/sysadmin configuration (same argument against
interrupt affinities, it is another knob for the sysadmin/designer to
configure correctly, Another argument being not all interrupts can be
threaded / affinitized).

Thanks in advance for reviewing the patch,

 - Joel
