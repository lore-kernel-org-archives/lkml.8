Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A727CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2C82065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgG1Txc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:53:32 -0400
Received: from foss.arm.com ([217.140.110.172]:40494 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbgG1Txc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:53:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 459F731B;
        Tue, 28 Jul 2020 12:53:31 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13BEC3F66E;
        Tue, 28 Jul 2020 12:53:29 -0700 (PDT)
Date:   Tue, 28 Jul 2020 20:53:21 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        lukasz.luba@arm.com, valentin.schneider@arm.com
Subject: Re: [PATCH] sched/fair: provide u64 read for 32-bits arch helper
Message-ID: <20200728195320.GA426859@e120877-lin.cambridge.arm.com>
References: <1595847564-239957-1-git-send-email-vincent.donnefort@arm.com>
 <20200727123801.GJ119549@hirez.programming.kicks-ass.net>
 <20200727152303.GA301827@e120877-lin.cambridge.arm.com>
 <20200728111302.GV119549@hirez.programming.kicks-ass.net>
 <20200728120027.GN43129@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728120027.GN43129@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 28, 2020 at 02:00:27PM +0200, peterz@infradead.org wrote:
> On Tue, Jul 28, 2020 at 01:13:02PM +0200, peterz@infradead.org wrote:
> > On Mon, Jul 27, 2020 at 04:23:03PM +0100, Vincent Donnefort wrote:
> > 
> > > For 32-bit architectures, both min_vruntime and last_update_time are using
> > > similar access. This patch is simply an attempt to unify their usage by
> > > introducing two macros to rely on when accessing those. At the same time, it
> > > brings a comment regarding the barriers usage, as per the kernel policy. So
> > > overall this is just a clean-up without any functional changes.
> > 
> > Ah, I though there was perhaps the idea to make use of armv7-lpae
> > instructions.
> > 
> > Aside of that, I think we need to spend a little time bike-shedding the
> > API/naming here:
> > 
> > > +# define u64_32read(val, copy) (val)
> > > +# define u64_32read_set_copy(val, copy) do { } while (0)
> > 
> > How about something like:
> > 
> > #ifdef CONFIG_64BIT
> > 
> > #define DEFINE_U64_U32(name)	u64 name
> > #define u64_u32_load(name)	name
> > #define u64_u32_store(name, val)name = val
> > 
> > #else
> > 
> > #define DEFINE_U64_U32(name)			\
> > 	struct {				\
> > 		u64 name;			\
> > 		u64 name##_copy;		\
> > 	}
> > 
> > #define u64_u32_load(name)			\
> > 	({					\
> > 		u64 val, copy;			\
> > 		do {				\
> > 			val = name;		\
> > 			smb_rmb();		\
> > 			copy = name##_copy;	\
> > 		} while (val != copy);		\
> 
> wrong order there; we should first read _copy and then the regular one
> of course.
> 
> > 		val;
> > 	})
> > 
> > #define u64_u32_store(name, val)		\
> > 	do {					\
> > 		typeof(val) __val = (val);	\
> > 		name = __val;			\
> > 		smp_wmb();			\
> > 		name##_copy = __val;		\
> > 	} while (0)
> > 
> > #endif
> 
> The other approach is making it a full type and inline functions I
> suppose.

I didn't pick this approach originally, as I thought it would be way too
invasive. If the API looks way cleaner, it nonetheless doesn't match
last_update_time usage. The variable is declared in sched_avg while its copy
is in struct cfs_rq.

Moving the copy in sched_avg would mean:

 * Setting the copy for all struct sched_avg in ___update_load_sum(), instead
   of just the cfs_rq.avg in update_cfs_rq_load_avg().

 * Having the DEFINE_U64_U32 declaration in include/linux/sched.h to cover
   struct sched_avg.

-- 
Vincent
