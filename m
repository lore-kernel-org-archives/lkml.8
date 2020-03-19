Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E574C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 22:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C573206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 22:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K35Xul1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgCSWqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 18:46:00 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34158 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgCSWp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 18:45:59 -0400
Received: by mail-qt1-f194.google.com with SMTP id 10so3436593qtp.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 15:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hg6/XErwieCbKEfwaK23H7KvFdhoOokx+O1ndfHjdpU=;
        b=K35Xul1BPwATBVYVGK1BzNwg1AfbzIoEMcMIYFIqZpTfU1JbG3He3l99NhGYwgWPbs
         u+xfPnUrH81APCqnVXY50nhKQe+ibkMS6ecDck1xrFL/vkqdoUZAXjGM5K5s03HW0Aoa
         AV5WoC6OrOCmXVwZewxhhuhbjcgCsDJIrX+EQ2xk5snNqTolW+uP+GRkYkobmARhQsUa
         MX6rxQVC9wEFCyXiEKPNjK2a/ofXMo0ny2KPnalzfVm81aV/W8CND2olyxDgGBeJd/jw
         dD3iSNij3AxA+/LNEFdtOU91evmTLVH+cdGxvLXoCkeAy4wDv4TFfwKjhecSF6aMb0Wb
         kvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hg6/XErwieCbKEfwaK23H7KvFdhoOokx+O1ndfHjdpU=;
        b=RoPBqqobYWbjbsavaLj//dda5dY3Env5JXYjz+UBjzxIR8KTIOOVejk2foMGdM3NfB
         dDDpnpHwWK+blBSJRHsLA6bgP+8aanlZi1fUjiUbWE7adSb52D67/IKaKoO8bFH7LLIe
         KlmA49vQM4KFzDWHVG3RFfba8VzhlxbwB1fbPLrambnYXts+e0GmcO2dbstU60DHT3oP
         BRj/jG/twoh9bJJ2plhcsNwPkG0MGZKaFq1L+Qncpmtr19YraLTC2LJADOQEDpuiJWVr
         IbY4o6lHoA8YJfL2TM/RqTlIHbapcsa8Uv7YCpTVSQ39o8iWd4QibvfwauYqzLe1gvgc
         GMzQ==
X-Gm-Message-State: ANhLgQ1Binp19lGmVdfqFC3UAk9UtjMQGmaEypzulnalOYLKtjmPJfTU
        RLUM3IVn53IuafzN5pTX5RN4SBRaDGDI3KCwb4OWgg==
X-Google-Smtp-Source: ADFU+vuXEDkZdqwcA6ixqZ1MJr03UDx5UVIrRa+dLF75K2KQgFf3jrcjivNnTNOHve786HRh0iyHi2Aa1IvSOWXmc3U=
X-Received: by 2002:ac8:47cc:: with SMTP id d12mr5510636qtr.234.1584657958214;
 Thu, 19 Mar 2020 15:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200311010113.136465-1-joshdon@google.com> <20200311140533.pclgecwhbpqzyrks@e107158-lin.cambridge.arm.com>
 <20200317192401.GE20713@hirez.programming.kicks-ass.net> <CABk29NuAYvkqNmZZ6cjZBC6=hv--2siPPjZG-BUpNewxm02O6A@mail.gmail.com>
 <20200318113456.3h64jpyb6xiczhcj@e107158-lin.cambridge.arm.com>
In-Reply-To: <20200318113456.3h64jpyb6xiczhcj@e107158-lin.cambridge.arm.com>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 19 Mar 2020 15:45:47 -0700
Message-ID: <CABk29NvvJCYyEnEkDt4JgZacf6XLd+0wxx_BNGnX8oZcrBp4EA@mail.gmail.com>
Subject: Re: [PATCH v2] sched/cpuset: distribute tasks within affinity masks
To:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
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

On Wed, Mar 18, 2020 at 4:35 AM Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 03/17/20 14:35, Josh Don wrote:
> > On Wed, Mar 11, 2020 at 7:05 AM Qais Yousef <qais.yousef@arm.com> wrote:
> > >
> > > It might be a good idea to split the API from the user too.
> >
> > Not sure what you mean by this, could you clarify?
>
> I meant it'd be a good idea to split the cpumask API into its own patch and
> have a separate patch for the user in sched/core.c. But that was a small nit.
> If the user (in sched/core.c) somehow introduces a regression, reverting it
> separately should be trivial.
>
> Thanks

Ah, yes I agree that sounds like a good idea, I can do that.

Peter, any other nit before I re-send?
