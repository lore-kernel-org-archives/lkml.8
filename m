Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20155C38A29
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00A02206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440405AbgDNP2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:28:05 -0400
Received: from foss.arm.com ([217.140.110.172]:58326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439713AbgDNP1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:27:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8D8630E;
        Tue, 14 Apr 2020 08:27:30 -0700 (PDT)
Received: from [192.168.1.19] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B49353F73D;
        Tue, 14 Apr 2020 08:27:27 -0700 (PDT)
Subject: Re: [PATCH 1/4] sched/topology: Store root domain CPU capacity sum
To:     Quentin Perret <qperret@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200408095012.3819-1-dietmar.eggemann@arm.com>
 <20200408095012.3819-2-dietmar.eggemann@arm.com>
 <CAKfTPtC4_+dTddLdoFMdzUvsXwWyi3bUOXcg9kstC8RzZS_a+A@mail.gmail.com>
 <42cc3878-4c57-96ba-3ebd-1b4d4ef87fae@arm.com>
 <CAKfTPtDS_qwPH+TwoFWPz6QRzG1N=t46ZvGN=w6zbOtnGAdOeQ@mail.gmail.com>
 <20200414124503.GA236568@google.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <7adf893b-769d-ffa4-71da-d9a93646a88c@arm.com>
Date:   Tue, 14 Apr 2020 17:27:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414124503.GA236568@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.04.20 14:45, Quentin Perret wrote:
> On Wednesday 08 Apr 2020 at 19:03:57 (+0200), Vincent Guittot wrote:
>> Or we can do the opposite and only use capacity_orig_of()/rq->cpu_capacity_orig.
>>
>> Is there a case where the max cpu capacity changes over time ? So I
>> would prefer to use cpu_capacity_orig which is a field of scheduler
>> instead of always calling an external arch specific function
> 
> Note however that using arch_scale_cpu_capacity() would be more
> efficient, especially on non-arm/arm64 systems where it is a
> compile-time constant.

or essentially all ARCHs not defining it.

> 
> It's probably a matter of personal taste, but I find rq->cpu_capacity_orig
> superfluous. It wastes space without actually giving you anything no?
> Anybody remembers why it was introduced in the first place?

v3.18 arm providing arch_scale_cpu_capacity()
v4.1  introduction of rq->cpu_capacity_orig
v4.10 arm64 providing arch_scale_cpu_capacity()
...

So it's down to the question of 'minimizing the scheduler calls to an
external arch function' vs 'efficiency'.
