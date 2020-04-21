Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB13C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 263BB2073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fn8cEQff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgDUHmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 03:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgDUHmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 03:42:39 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528A7C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 00:42:39 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id t11so10285977lfe.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 00:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GLQ+sk9cCZhcpZOfw48+Y/fUPQs2C5qNPqE3L4F8118=;
        b=Fn8cEQffMu1E7ovpSMbZlPgqOt4u8eB6bf3ej8FcjW5br6dQ3ZEM9nRDdwbhKoj7Rr
         MbIKmyiyoLj1jUxa+tDiS9wdomR8wKhGKg82ka+yrL51CCMLPobJ9ZkkT8WaYXj/kIUu
         XOJpiZJchJauJAmjPJWbzCWD7kuPTkZZwVBPYhxK5Ri4sEP8cswuXxh04R/4MMO6Z7tv
         vwlz4eCTVb7DIZaw9SlkvjLBcw2fZW3zwkwOFQLlzOesxLJPCOJZHTINpi/I+jJbxq8C
         EwkSm/K13x0HL7DOuVZVXNTnIh+RBUrxADTAMOJU7BFYLxUD5y/OvElbugjieOduQxQ+
         j9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GLQ+sk9cCZhcpZOfw48+Y/fUPQs2C5qNPqE3L4F8118=;
        b=fT/xZ2sKukS5FwK+EnbxeCivdt9HrzTZ35/bpMke0K8pHheNKmbI6l+IMrFsCkXxa0
         xNF7mQL0qt18u3L2x1tio5uJ+LE5H97xF0gXqZP8ughnuoTbYI6FFPuotEVh4m4f80Bi
         37avb2YK5qM8hgJxvH40LRhGiUuuOx5gL7rQccuAKgTN1j/N7Jr7TseargfFjvNr7m35
         L/RzoNR8RFqeLis4f87hahFlSzQFiOy9rZC7yu9VqgK99Q91m11UL5HGh3sn4ieoFyR6
         I7V4M07vI+Yxw8ZSA5Lly7+C/O7kGKfzdKeFA7nMZ8XqCzyTQi5DTy+HajeINBr4Re8A
         hM9Q==
X-Gm-Message-State: AGi0PuZq9ZI7TvjX69+XD1T7wzgVmUi6QzmiVT+LFg7olAdlxx+cCFqz
        G94xnKJ2Ve/B+uCjTBsU5iZq5P0arb47j6qINmCCTA==
X-Google-Smtp-Source: APiQypKU71scoLFoepiM/BkasDCix/M9OxfMrzo4Ml6ggiseg2MKksXsH5mlBh1Nv9qN8Voscmz5dRwLDqMdmHjlgxk=
X-Received: by 2002:a19:c7d8:: with SMTP id x207mr12689538lff.190.1587454957831;
 Tue, 21 Apr 2020 00:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587309963.git.yu.c.chen@intel.com> <7c1eab789cb4b53ec5f54644c089ce27ea14088a.1587309963.git.yu.c.chen@intel.com>
 <20200420183232.16b83374@gandalf.local.home> <jhjwo69lqcm.mognet@arm.com>
 <20200420231355.GU2483@worktop.programming.kicks-ass.net> <20200420222319.34f9f646@oasis.local.home>
In-Reply-To: <20200420222319.34f9f646@oasis.local.home>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 21 Apr 2020 09:42:26 +0200
Message-ID: <CAKfTPtBG=Nu+76NywfD0rk-BmT=2egTd_9FaPU4oCP1D_eyuBQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched: Extract the task putting code from pick_next_task()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Chen Yu <yu.c.chen@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Apr 2020 at 04:23, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 21 Apr 2020 01:13:55 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > The 'finish' thing isn't too far from the truth; it's the last thing we
> > > need to do with the prev task (in terms of sched bookkeeping, I mean) -
> > > and in Chen's defence ISTR Peter suggested that name.
> > >
> > > Seeing as it's a "supercharged" put_prev_task(), I could live with the
> > > marginally shorter "put_prev_task_balance()".
> >
> > What Valentin said; it's the last put we do before picking a new task.
> > Also, I don't like long names. That said, I'm open to short and
> > appropriate suggestions.
>
> I wont bikeshed this too much.
>
> Is the "finish" more appropriate with the other use cases that are
> coming. I do like that "put_prev_task_balance()" too.

This name looks reasonnable

>
> -- Steve
