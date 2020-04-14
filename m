Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5A0C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18E372064A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390903AbgDNO3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:29:25 -0400
Received: from foss.arm.com ([217.140.110.172]:56948 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390563AbgDNO3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:29:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31C7731B;
        Tue, 14 Apr 2020 07:29:04 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 349573F73D;
        Tue, 14 Apr 2020 07:29:02 -0700 (PDT)
References: <20200408095012.3819-1-dietmar.eggemann@arm.com> <20200408095012.3819-3-dietmar.eggemann@arm.com> <jhjeesyw96u.mognet@arm.com> <20200408153032.447e098d@nowhere> <jhjblo2vx60.mognet@arm.com> <31620965-e1e7-6854-ad46-8192ee4b41af@arm.com> <20200414114032.wigdlnegism6qqns@e107158-lin.cambridge.arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        luca abeni <luca.abeni@santannapisa.it>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] sched/deadline: Improve admission control for asymmetric CPU capacities
In-reply-to: <20200414114032.wigdlnegism6qqns@e107158-lin.cambridge.arm.com>
Date:   Tue, 14 Apr 2020 15:29:00 +0100
Message-ID: <jhjy2qyrvir.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/04/20 12:40, Qais Yousef wrote:
>
> I haven't followed this discussion closely, so I could be missing something
> here.
>
> In sched_cpu_dying() we call set_rq_offline() which clears the cpu in
> rq->rd->online.
>
> So the way I read the code
>
>       rd->online = cpumask_and(rd->span, cpu_active_mask)
>
> But I could have easily missed some detail.
>

sched_cpu_dying() is wayyyy below sched_cpu_deactivate(). This doesn't help
at all for the dl_cpu_busy() check in sched_cpu_deactivate().

> Regardless, it seems to me that DL is working around something not right in the
> definition of rd->span or using the wrong variable.
>

What DL is doing now is fine, it only needs to be aligned with the active
mask (which it is). We're making things a bit trickier by adding capacity
values into the mix.

> My 2p :-). I have to go back and read the discussion in more detail.
>
> Thanks
