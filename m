Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F6EC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4383C2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgBRQbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 11:31:32 -0500
Received: from foss.arm.com ([217.140.110.172]:55334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbgBRQbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 11:31:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 169C130E;
        Tue, 18 Feb 2020 08:31:32 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35C673F68F;
        Tue, 18 Feb 2020 08:31:30 -0800 (PST)
Subject: Re: [PATCH v2 4/5] sched/pelt: Add a new runnable average signal
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Hillf Danton <hdanton@sina.com>
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
 <20200214152729.6059-5-vincent.guittot@linaro.org>
 <5ea96f6e-433e-1520-56dc-a10e9a8e63c7@arm.com>
 <CAKfTPtBn+OG6HDN6prWk+7BNH4Grpc67Mex41-=DumKMogvxpw@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <ab73c47d-daad-a4e8-1a92-98f743b18635@arm.com>
Date:   Tue, 18 Feb 2020 16:30:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBn+OG6HDN6prWk+7BNH4Grpc67Mex41-=DumKMogvxpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2020 15:28, Vincent Guittot wrote:
>>> @@ -532,8 +535,8 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
>>>                       cfs_rq->removed.load_avg);
>>>       SEQ_printf(m, "  .%-30s: %ld\n", "removed.util_avg",
>>>                       cfs_rq->removed.util_avg);
>>> -     SEQ_printf(m, "  .%-30s: %ld\n", "removed.runnable_sum",
>>> -                     cfs_rq->removed.runnable_sum);
>>
>> Shouldn't that have been part of patch 3?
> 
> No this was used to propagate load_avg
> 

Right, sorry about that.

>> <fugly here>
>> +DECLARE_UPDATE_TG_CFS_SIGNAL(util);
>> +DECLARE_UPDATE_TG_CFS_SIGNAL(runnable);
> 
> TBH, I prefer keeping the current version which is easier to read IMO
> 

I did call it an eldritch horror :-) I agree with you here, it's a shame we
don't really have better ways to factorize this (I don't think splitting the
inputs is really an alternative).
