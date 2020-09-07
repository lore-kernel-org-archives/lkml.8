Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0BCC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5036220768
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgIGKsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:48:52 -0400
Received: from foss.arm.com ([217.140.110.172]:60746 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728395AbgIGKst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:48:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07318106F;
        Mon,  7 Sep 2020 03:48:49 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E146D3F66E;
        Mon,  7 Sep 2020 03:48:47 -0700 (PDT)
Date:   Mon, 7 Sep 2020 11:48:45 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     vincent.donnefort@arm.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2] sched/debug: Add new tracepoint to track cpu_capacity
Message-ID: <20200907104845.6rust2lf2o3d5gmq@e107158-lin.cambridge.arm.com>
References: <1598605249-72651-1-git-send-email-vincent.donnefort@arm.com>
 <20200828102724.wmng7p6je2pkc33n@e107158-lin.cambridge.arm.com>
 <1e806d48-fd54-fd86-5b3a-372d9876f360@arm.com>
 <20200828172658.dxygk7j672gho4ax@e107158-lin.cambridge.arm.com>
 <58f5d2e8-493b-7ce1-6abd-57705e5ab437@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58f5d2e8-493b-7ce1-6abd-57705e5ab437@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar

On 09/02/20 12:44, Dietmar Eggemann wrote:
> + Phil Auld <pauld@redhat.com>
> 
> On 28/08/2020 19:26, Qais Yousef wrote:
> > On 08/28/20 19:10, Dietmar Eggemann wrote:
> >> On 28/08/2020 12:27, Qais Yousef wrote:
> >>> On 08/28/20 10:00, vincent.donnefort@arm.com wrote:
> >>>> From: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> [...]
> 
> >> Can you remind me why we have all these helper functions like
> >> sched_trace_rq_cpu_capacity?
> > 
> > struct rq is defined in kernel/sched/sched.h. It's not exported. Exporting
> > these helper functions was the agreement to help modules trace internal info.
> > By passing generic info you decouple the tracepoint from giving specific info
> > and allow the modules to extract all the info they need from the same
> > tracepoint. IE: if you need more than just cpu_capacity from this tracepoint,
> > you can get that without having to continuously add extra arguments everytime
> > you need an extra piece of info. Unless this info is not in the rq of course.
> 
> I think this decoupling is not necessary. The natural place for those
> scheduler trace_event based on trace_points extension files is
> kernel/sched/ and here the internal sched.h can just be included.
> 
> If someone really wants to build this as an out-of-tree module there is
> an easy way to make kernel/sched/sched.h visible.
> 
> CFLAGS_sched_tp.o := -I$KERNEL_SRC/kernel/sched
> 
> all:
>     make -C $KERNEL_SRC M=$(PWD) modules

Sorry for the late response. Was on holiday.

IMHO the above is a hack. Out-of-tree modules should rely on public headers and
exported functions only. What you propose means that people who want to use
these tracepoints in meaningful way must have a prebuilt kernel handy. Which is
maybe true for us who work in the embedded world. But users who run normal
distro kernels (desktop/servers) will fail to build against
`/lib/modules/$(uname -r)/build` where that internal header file is not
exported. IOW, we're putting extra hoops for a large class of users here to be
able to access these internal data. They have to maintain their out-of-tree
definition of these structures.

FWIW, I did raise this concern with Peter in 2019 OSPM and he was okay with the
exports as it's still not a contract and they can disappear anytime we want.
Migrating to using BTF is the right way forward IMO. I don't think what we have
here is out-of-control yet. Though I agree they're annoying.

Cheers

--
Qais Yousef
