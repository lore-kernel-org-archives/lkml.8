Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897C9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60D4920780
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgGBQtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:49:42 -0400
Received: from foss.arm.com ([217.140.110.172]:42966 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbgGBQtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:49:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4ED211FB;
        Thu,  2 Jul 2020 09:49:41 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DCAF3F71E;
        Thu,  2 Jul 2020 09:49:40 -0700 (PDT)
References: <20200701190656.10126-1-valentin.schneider@arm.com> <20200701190656.10126-3-valentin.schneider@arm.com> <20200702121536.GA765585@google.com> <jhjk0zm7zv8.mognet@arm.com> <20200702154514.GA1072702@google.com> <jhjfta9994q.mognet@arm.com> <20200702163748.GA1125675@google.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com
Subject: Re: [PATCH v3 2/7] sched/topology: Define and assign sched_domain flag metadata
In-reply-to: <20200702163748.GA1125675@google.com>
Date:   Thu, 02 Jul 2020 17:49:38 +0100
Message-ID: <jhjeept980t.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/07/20 17:37, Quentin Perret wrote:
> On Thursday 02 Jul 2020 at 17:25:41 (+0100), Valentin Schneider wrote:
>> It's actually pretty close to what happens with the LLC domain on SMP -
>> select_idle_sibling() doesn't look outside of it. The wake_affine() stuff
>> might steer the task towards a different LLC, but that's about it for
>> wakeups. We rely on load balancing (fork/exec, newidle, nohz and periodic)
>> to spread this further - and we would here too.
>
> Sure, but on SMP the search space in select_idle_sibling is always
> consistent -- you search within the LLC. With the fix you suggested,
> CPUs 0-3 will search within their LLCs, while CPU4 searches the entire
> system, which creates an imbalanced mess IMO.
>

Yeah, it is a mess.

> For affine wake-ups, you could migrate from CPU4 -> CPU0-3, but CPU0-3
> to CPU4 is not possible

AIU the wake_affine bits, you get to steer the wakeup towards the waking
CPU. So if the task previously ran on CPU0-3, wake_affine can make the
target CPU4 (waking CPU), so it would become a possible candidate.

But as you say, this thing is still an ugly asymmetric mess.

> so this asymmetry is almost guaranteed to
> actively create imbalance. And sure, the periodic load balancer ought to
> fix it, but really wake-up balance and periodic load balance should be
> pushing in the same direction and not fighting against each other.
>
> Anyways, enough bikeshedding for today, I'll try and have look at the
> rest of the series :)
>

Thanks!

> Cheers,
> Quentin
