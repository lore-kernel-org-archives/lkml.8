Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F65C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD2720714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S2s7zvMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgCQVfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:35:46 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:40062 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgCQVfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:35:45 -0400
Received: by mail-qv1-f65.google.com with SMTP id cy12so5880492qvb.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 14:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ftj10VLsYaiA6T3F2kq6t1b/UKFGKg8xJC5CD9CHAZg=;
        b=S2s7zvMjdQS2YL59qrGpnLepk5Dx85cXsRT8C8oanXXydslCXFue7WW16zAr2sbNWt
         GS0Ow5CjYtZ0ItjiAm9xGPsgxXdFUCAJLI4+BU6pp066EycbGudGs8YJ9oGWz77drJfs
         L5qDqxz/TFwYKR1g0hglZEOej9vrYI3LtRPk6gSO+og/Du5tsULTG1eEzxNiuI57m0te
         B6Q4cTJ+swdm/VASYkZ9awnNV54Y/orFynKe+GXK/Gu5WMJElMCmGcSjBW0kxQ5hEHHh
         7lFSnHZBE7WwssCb/3Qtg++PwYrQe9HkJrDA9mL3+MwrF02zhjMZn8VqA97fPiEtH+IZ
         Gagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ftj10VLsYaiA6T3F2kq6t1b/UKFGKg8xJC5CD9CHAZg=;
        b=XI55/YeXd8MtzBD9o+oMEDN53G2RjV71eS+IR1zqqqjalP1UDzTwqe4s8imzoSrrcV
         TFfkyJ+VhiCUIvAcHfLmosXEmH4ONIeFDhVTEGWqAH4N35goCvlo6zTqEXcbFY3ozKR+
         gYnUGIgkyPlnoSOs+i6/uoEvuhRauMjaWWkQSE6lBoCmHZXqJ7BtruKeI126o54dOXPV
         tbCNsNiCgyuiBkx+JWYW9cMSaAK5JOrLFDVrMqQYgI+FgDWn1Hgo4B8ERGWplAgRKUQQ
         2a+WTKF5g8YbWQl4eLGGDF6e4oHMqHYRYvw5bNFuBCuGKpqcu7FtKpsuByGfWgtB4z2F
         AyAA==
X-Gm-Message-State: ANhLgQ37EYc7Wq0yRlYH64RfiFEjvU2R4wzDzQwoIa2saGAeUUS1hj+q
        DrZVmNjO+Envk/9ugffCmzsXBMMP7+RmWdxgp7kvlg==
X-Google-Smtp-Source: ADFU+vteq0N9A+Ax9G/lHv2IvYDFjANhuTLDBzWS09Z2TaGDN+s13dYsW5dbXbP546/H8CuvFENNy9K6khQE9KFvC28=
X-Received: by 2002:ad4:54d4:: with SMTP id j20mr1205826qvx.75.1584480943367;
 Tue, 17 Mar 2020 14:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200311010113.136465-1-joshdon@google.com> <20200311140533.pclgecwhbpqzyrks@e107158-lin.cambridge.arm.com>
 <20200317192401.GE20713@hirez.programming.kicks-ass.net>
In-Reply-To: <20200317192401.GE20713@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 17 Mar 2020 14:35:32 -0700
Message-ID: <CABk29NuAYvkqNmZZ6cjZBC6=hv--2siPPjZG-BUpNewxm02O6A@mail.gmail.com>
Subject: Re: [PATCH v2] sched/cpuset: distribute tasks within affinity masks
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 7:05 AM Qais Yousef <qais.yousef@arm.com> wrote:
>
> This actually helps me fix a similar problem I faced in RT [1]. If multiple RT
> tasks wakeup at the same time we get a 'thundering herd' issue where they all
> end up going to the same CPU, just to be pushed out again.
>
> Beside this will help fix another problem for RT tasks fitness, which is
> a manifestation of the problem above. If two tasks wake up at the same time and
> they happen to run on a little cpu (but request to run on a big one), one of
> them will end up being migrated because find_lowest_rq() will return the first
> cpu in the mask for both tasks.
>
> I tested the API (not the change in sched/core.c) and it looks good to me.

Nice, glad that the API already has another use case. Thanks for taking a look.

> nit: cpumask_first_and() is better here?

Yea, I would also prefer to use it, but the definition of
cpumask_first_and() follows this section, as it itself uses
cpumask_next_and().

> It might be a good idea to split the API from the user too.

Not sure what you mean by this, could you clarify?

On Tue, Mar 17, 2020 at 12:24 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > Anyway, for the API.
> >
> > Reviewed-by: Qais Yousef <qais.yousef@arm.com>
> > Tested-by: Qais Yousef <qais.yousef@arm.com>
>
> Thanks guys!

Thanks Peter, any other comments or are you happy with merging this patch as-is?
