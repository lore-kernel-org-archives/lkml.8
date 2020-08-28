Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5318FC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 17:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28D7020776
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 17:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgH1RKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 13:10:54 -0400
Received: from foss.arm.com ([217.140.110.172]:53716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbgH1RKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 13:10:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62E161FB;
        Fri, 28 Aug 2020 10:10:51 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF9CE3F71F;
        Fri, 28 Aug 2020 10:10:43 -0700 (PDT)
Subject: Re: [PATCH v2] sched/debug: Add new tracepoint to track cpu_capacity
To:     Qais Yousef <qais.yousef@arm.com>, vincent.donnefort@arm.com
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com
References: <1598605249-72651-1-git-send-email-vincent.donnefort@arm.com>
 <20200828102724.wmng7p6je2pkc33n@e107158-lin.cambridge.arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <1e806d48-fd54-fd86-5b3a-372d9876f360@arm.com>
Date:   Fri, 28 Aug 2020 19:10:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828102724.wmng7p6je2pkc33n@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2020 12:27, Qais Yousef wrote:
> On 08/28/20 10:00, vincent.donnefort@arm.com wrote:
>> From: Vincent Donnefort <vincent.donnefort@arm.com>
>>
>> rq->cpu_capacity is a key element in several scheduler parts, such as EAS
>> task placement and load balancing. Tracking this value enables testing
>> and/or debugging by a toolkit.
>>
>> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
> 
> [...]
> 
>> +int sched_trace_rq_cpu_capacity(struct rq *rq)
>> +{
>> +	return rq ?
>> +#ifdef CONFIG_SMP
>> +		rq->cpu_capacity
>> +#else
>> +		SCHED_CAPACITY_SCALE
>> +#endif
>> +		: -1;
>> +}
>> +EXPORT_SYMBOL_GPL(sched_trace_rq_cpu_capacity);
>> +
> 
> The placement of this #ifdef looks odd to me. But FWIW
> 
> Reviewed-by: Qais Yousef <qais.yousef@arm.com>

Returning -1 for cpu_capacity? It makes sense for sched_trace_rq_cpu()
but for cpu_capacity?

Can you remind me why we have all these helper functions like
sched_trace_rq_cpu_capacity?

In case we would let the extra code (which transforms trace points into
trace events) know the internals of struct rq we could handle those
things in the TRACE_EVENT and/or the register_trace_##name(void
(*probe)(data_proto), void *data) thing.
We always said when the internal things will change this extra code will
break. So that's not an issue.
