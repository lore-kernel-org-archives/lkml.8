Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B86C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 17:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3460E20872
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 17:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgH1R1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 13:27:03 -0400
Received: from foss.arm.com ([217.140.110.172]:54000 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgH1R1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 13:27:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD1011FB;
        Fri, 28 Aug 2020 10:27:01 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDBFF3F71F;
        Fri, 28 Aug 2020 10:27:00 -0700 (PDT)
Date:   Fri, 28 Aug 2020 18:26:58 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     vincent.donnefort@arm.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com
Subject: Re: [PATCH v2] sched/debug: Add new tracepoint to track cpu_capacity
Message-ID: <20200828172658.dxygk7j672gho4ax@e107158-lin.cambridge.arm.com>
References: <1598605249-72651-1-git-send-email-vincent.donnefort@arm.com>
 <20200828102724.wmng7p6je2pkc33n@e107158-lin.cambridge.arm.com>
 <1e806d48-fd54-fd86-5b3a-372d9876f360@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1e806d48-fd54-fd86-5b3a-372d9876f360@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/20 19:10, Dietmar Eggemann wrote:
> On 28/08/2020 12:27, Qais Yousef wrote:
> > On 08/28/20 10:00, vincent.donnefort@arm.com wrote:
> >> From: Vincent Donnefort <vincent.donnefort@arm.com>
> >>
> >> rq->cpu_capacity is a key element in several scheduler parts, such as EAS
> >> task placement and load balancing. Tracking this value enables testing
> >> and/or debugging by a toolkit.
> >>
> >> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> >>
> >> diff --git a/include/linux/sched.h b/include/linux/sched.h
> > 
> > [...]
> > 
> >> +int sched_trace_rq_cpu_capacity(struct rq *rq)
> >> +{
> >> +	return rq ?
> >> +#ifdef CONFIG_SMP
> >> +		rq->cpu_capacity
> >> +#else
> >> +		SCHED_CAPACITY_SCALE
> >> +#endif
> >> +		: -1;
> >> +}
> >> +EXPORT_SYMBOL_GPL(sched_trace_rq_cpu_capacity);
> >> +
> > 
> > The placement of this #ifdef looks odd to me. But FWIW
> > 
> > Reviewed-by: Qais Yousef <qais.yousef@arm.com>
> 
> Returning -1 for cpu_capacity? It makes sense for sched_trace_rq_cpu()
> but for cpu_capacity?

If rq is NULL you return -1, an error the way I read it. rq is passed as an
argument, so better ensure we handle NULL and not blindly dereference rq and
crash.

> 
> Can you remind me why we have all these helper functions like
> sched_trace_rq_cpu_capacity?

struct rq is defined in kernel/sched/sched.h. It's not exported. Exporting
these helper functions was the agreement to help modules trace internal info.
By passing generic info you decouple the tracepoint from giving specific info
and allow the modules to extract all the info they need from the same
tracepoint. IE: if you need more than just cpu_capacity from this tracepoint,
you can get that without having to continuously add extra arguments everytime
you need an extra piece of info. Unless this info is not in the rq of course.

> 
> In case we would let the extra code (which transforms trace points into
> trace events) know the internals of struct rq we could handle those
> things in the TRACE_EVENT and/or the register_trace_##name(void
> (*probe)(data_proto), void *data) thing.
> We always said when the internal things will change this extra code will
> break. So that's not an issue.

The problem is that you need to export struct rq in a public header. Which we
don't want to do. I have been trying to find out how to use BTF so we can
remove these functions. Haven't gotten far away yet - but it should be doable
and it's a question of me finding enough time to understand what was currently
done and if I can re-use something or need to come up with extra infrastructure
first.

Thanks

--
Qais Yousef
