Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868D0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EBD20702
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387486AbgAXPZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 10:25:40 -0500
Received: from foss.arm.com ([217.140.110.172]:53854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgAXPZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 10:25:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D3901FB;
        Fri, 24 Jan 2020 07:25:39 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C7D83F6C4;
        Fri, 24 Jan 2020 07:25:38 -0800 (PST)
Subject: Re: [PATCH v2 1/3] sched/fair: Add asymmetric CPU capacity wakeup
 scan
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        adharmap@codeaurora.org
References: <20200124130213.24886-1-valentin.schneider@arm.com>
 <20200124130213.24886-2-valentin.schneider@arm.com>
 <00aa64e8-5e75-181e-a4f4-72c2ac64081c@arm.com>
 <20200124151134.GB221730@google.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <9c825e43-304a-a216-c57d-8ae6b3f7a1d9@arm.com>
Date:   Fri, 24 Jan 2020 15:25:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200124151134.GB221730@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2020 15:11, Quentin Perret wrote:
>> I think what we were trying to go with here is to not entirely hijack
>> select_idle_sibling(). If we go with the above alternative, topologies
>> with sched_asym_cpucapacity enabled would only ever see
>> select_idle_capacity() and not the rest of select_idle_sibling(). Not sure
>> if it's a bad thing or not, but it's something to ponder over.
> 
> Right, I would think your suggestion above is a pretty sensible policy
> for asymmetric systems, and I don't think the rest of
> select_idle_sibling() will do a much better job on such systems at
> finding an idle CPU than select_idle_capacity() would do, but I see
> your point.
> 
> Now, not having to re-iterate over the CPUs again might keep the wakeup
> latency a bit lower -- perhaps something noticeable with hackbench ?
> Worth a try.
> 

Agreed. Removing SD_BALANCE_WAKE causes most of the perf delta here,
I'll try to get some statistics on the same versions but with and without
the extra select_idle_capacity() policy and see how noticeable it is.

I might still do it if the delta is lost in the noise, just gotta put my
brain cells to work. One thing I'm thinking is maybe we're not guaranteed
to have sd_asym_cpucapacity being a superset of sd_llc, so we would need
to go through select_idle_sibling() to cover for the rest, although I think
this falls in the category of topologies we highly recommend *not* to build
(or expose, in case of people playing games with cpu-map).

> In any case, no strong opinion. With that missing call to
> sync_entity_load_avg() fixed, the patch looks pretty decent to me.
> 

Thanks for having a look!

> Thanks,
> Quentin
> 
