Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D9FC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4CA2074F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgDIJ7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 05:59:54 -0400
Received: from foss.arm.com ([217.140.110.172]:47848 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbgDIJ7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:59:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A868B31B;
        Thu,  9 Apr 2020 02:59:53 -0700 (PDT)
Received: from bogus (unknown [10.37.12.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4C9A3F73D;
        Thu,  9 Apr 2020 02:59:47 -0700 (PDT)
Date:   Thu, 9 Apr 2020 10:59:41 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Cheng Jian <cj.chengjian@huawei.com>, vpillai@digitalocean.com,
        aaron.lwe@gmail.com, aubrey.intel@gmail.com,
        aubrey.li@linux.intel.com, fweisbec@gmail.com,
        jdesfossez@digitalocean.com, joel@joelfernandes.org,
        joelaf@google.com, keescook@chromium.org, kerrnel@google.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        mingo@kernel.org, naravamudan@digitalocean.com, pauld@redhat.com,
        pawan.kumar.gupta@linux.intel.com, pbonzini@redhat.com,
        peterz@infradead.org, pjt@google.com, tglx@linutronix.de,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org,
        xiexiuqi@huawei.com, huawei.libin@huawei.com, w.f@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] sched/arm64: store cpu topology before
 notify_cpu_starting
Message-ID: <20200409095941.GA25948@bogus>
References: <855831b59e1b3774b11c3e33050eac4cc4639f06.1583332765.git.vpillai@digitalocean.com>
 <20200401114215.36640-1-cj.chengjian@huawei.com>
 <jhjwo6zjq5m.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjwo6zjq5m.mognet@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 02:23:33PM +0100, Valentin Schneider wrote:
>
> (+LAKML, +Sudeep)
>

Thanks Valentin.

> On Wed, Apr 01 2020, Cheng Jian wrote:
> > when SCHED_CORE enabled, sched_cpu_starting() uses thread_sibling as
> > SMT_MASK to initialize rq->core, but only after store_cpu_topology(),
> > the thread_sibling is ready for use.
> >
> >       notify_cpu_starting()
> >           -> sched_cpu_starting()	# use thread_sibling
> >
> >       store_cpu_topology(cpu)
> >           -> update_siblings_masks	# set thread_sibling
> >
> > Fix this by doing notify_cpu_starting later, just like x86 do.
> >
>
> I haven't been following the sched core stuff closely; can't this
> rq->core assignment be done in sched_cpu_activate() instead? We already
> look at the cpu_smt_mask() in there, and it is valid (we go through the
> entirety of secondary_start_kernel() before getting anywhere near
> CPUHP_AP_ACTIVE).
>

I too came to same conclusion. Did you see any issues ? Or is it
just code inspection in parity with x86 ?

> I don't think this breaks anything, but without this dependency in
> sched_cpu_starting() then there isn't really a reason for this move.
>

Based on the commit message, had a quick look at x86 code and I agree
this shouldn't break anything. However the commit message does make
complete sense to me, especially reference to sched_cpu_starting
while smt_masks are accessed in sched_cpu_activate. Or am I missing
to understand something here ?

--
Regards,
Sudeep
