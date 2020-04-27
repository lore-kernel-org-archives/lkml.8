Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122FBC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA30D206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgD0ORf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:17:35 -0400
Received: from mail.sssup.it ([193.205.80.98]:21733 "EHLO mail.santannapisa.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgD0ORe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:17:34 -0400
Received: from [151.41.75.232] (account l.abeni@santannapisa.it HELO nowhere)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 147663101; Mon, 27 Apr 2020 16:17:31 +0200
Date:   Mon, 27 Apr 2020 16:17:15 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] sched/deadline: Implement fallback mechanism for
 !fit case
Message-ID: <20200427161715.3dd3a148@nowhere>
In-Reply-To: <20200427133438.GA6469@localhost.localdomain>
References: <20200427083709.30262-1-dietmar.eggemann@arm.com>
        <20200427083709.30262-7-dietmar.eggemann@arm.com>
        <20200427133438.GA6469@localhost.localdomain>
Organization: Scuola Superiore S.Anna
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juri,

On Mon, 27 Apr 2020 15:34:38 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:

> Hi,
> 
> On 27/04/20 10:37, Dietmar Eggemann wrote:
> > From: Luca Abeni <luca.abeni@santannapisa.it>
> > 
> > When a task has a runtime that cannot be served within the
> > scheduling deadline by any of the idle CPU (later_mask) the task is
> > doomed to miss its deadline.
> > 
> > This can happen since the SCHED_DEADLINE admission control
> > guarantees only bounded tardiness and not the hard respect of all
> > deadlines. In this case try to select the idle CPU with the largest
> > CPU capacity to minimize tardiness.
> > 
> > Signed-off-by: Luca Abeni <luca.abeni@santannapisa.it>
> > Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
[...]
> > -		if (!cpumask_empty(later_mask))
> > -			return 1;
> > +		if (cpumask_empty(later_mask))
> > +			cpumask_set_cpu(max_cpu, later_mask);  
> 
> Think we touched upon this during v1 review, but I'm (still?)
> wondering if we can do a little better, still considering only free
> cpus.
> 
> Can't we get into a situation that some of the (once free) big cpus
> have been occupied by small tasks and now a big task enters the
> system and it only finds small cpus available, were it could have fit
> into bigs if small tasks were put onto small cpus?
> 
> I.e., shouldn't we always try to best fit among free cpus?

Yes; there was an additional patch that tried schedule each task on the
slowest core where it can fit, to address this issue.
But I think it will go in a second round of patches.



			Luca
