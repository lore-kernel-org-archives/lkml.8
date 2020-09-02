Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03E3C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF56D2078E
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HrgtsbQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgIBOJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:09:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32937 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727865AbgIBNye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599054872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Zfzufm9G5SFln+XIoQYVsj9Zarn3bzwRdNtLhuoQNc=;
        b=HrgtsbQK3TxVUj5ttS/xxATbvxKq9pcTOUW7i4H6dk1vicUMY/ojfCi6rRY/hHCPWUUEgq
        AtHYAXDh9lo/UY6DMM8cCwBmf7RM2sRTHFXMutoS4Tr+PJFikwwjpaVExUMV0paCVZr2Fv
        mJPaYLzRSF2tFpqTfi3oP7DPHON8fjg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-v4U8S-sVMA24mehEkvg_iA-1; Wed, 02 Sep 2020 09:54:28 -0400
X-MC-Unique: v4U8S-sVMA24mehEkvg_iA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C70DD802B4C;
        Wed,  2 Sep 2020 13:54:26 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-113-219.phx2.redhat.com [10.3.113.219])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D19425DA30;
        Wed,  2 Sep 2020 13:54:25 +0000 (UTC)
Date:   Wed, 2 Sep 2020 09:54:23 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Qais Yousef <qais.yousef@arm.com>, vincent.donnefort@arm.com,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com
Subject: Re: [PATCH v2] sched/debug: Add new tracepoint to track cpu_capacity
Message-ID: <20200902135423.GB93959@lorien.usersys.redhat.com>
References: <1598605249-72651-1-git-send-email-vincent.donnefort@arm.com>
 <20200828102724.wmng7p6je2pkc33n@e107158-lin.cambridge.arm.com>
 <1e806d48-fd54-fd86-5b3a-372d9876f360@arm.com>
 <20200828172658.dxygk7j672gho4ax@e107158-lin.cambridge.arm.com>
 <58f5d2e8-493b-7ce1-6abd-57705e5ab437@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58f5d2e8-493b-7ce1-6abd-57705e5ab437@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 12:44:42PM +0200 Dietmar Eggemann wrote:
> + Phil Auld <pauld@redhat.com>
>

Thanks Dietmar.


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

It's not so much that we really _want_ to do this in an external module.
But we aren't adding more trace events and my (limited) knowledge of
BPF let me to the conclusion that its raw tracepoint functionality
requires full events.  I didn't see any other way to do it.

We could put sched_tp in the tree under a debug CONFIG :)

> CFLAGS_sched_tp.o := -I$KERNEL_SRC/kernel/sched
> 
> all:
>     make -C $KERNEL_SRC M=$(PWD) modules
> 
> This allowed me to build our trace_event extension module (sched_tp.c,
> sched_events.h) out-of-tree and I was able to get rid of all the
> sched_trace_foo() functions (in fair.c, include/linux/sched.h) and code
> there content directly in foo.c
> 
> There are two things we would need exported from the kernel:
> 
> (1) cfs_rq_tg_path() to print the path of a taskgroup cfs_rq or se.
> 
> (2) sched_uclamp_used so uclamp_rq_util_with() can be used in
>     sched_events.h.
> 
> I put Phil Auld on cc because of his trace_point
> sched_update_nr_running_tp. I think Phil was using sched_tp as a base so
> I can't see an issue why we can't also remove sched_trace_rq_nr_running().
>

Our Perf team is now actively using this in downstream, using sched_tp, and
finding it very useful.

But I have no problem if this is all simpler in the kernel tree.

> >> In case we would let the extra code (which transforms trace points into
> >> trace events) know the internals of struct rq we could handle those
> >> things in the TRACE_EVENT and/or the register_trace_##name(void
> >> (*probe)(data_proto), void *data) thing.
> >> We always said when the internal things will change this extra code will
> >> break. So that's not an issue.
> > 
> > The problem is that you need to export struct rq in a public header. Which we
> > don't want to do. I have been trying to find out how to use BTF so we can
> > remove these functions. Haven't gotten far away yet - but it should be doable
> > and it's a question of me finding enough time to understand what was currently
> > done and if I can re-use something or need to come up with extra infrastructure
> > first.
> 
> Let's keep the footprint of these trace points as small as possible in
> the scheduler code.
> 
> I'm putting the changes I described above in our monthly EAS integration
> right now and when this worked out nicely I will share the patches on lkml.
> 

Sounds good, thanks!


Cheers,
Phil

-- 

