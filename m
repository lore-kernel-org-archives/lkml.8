Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2643C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A442469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbgB0QnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:43:00 -0500
Received: from foss.arm.com ([217.140.110.172]:54616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729146AbgB0QnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:43:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D4391FB;
        Thu, 27 Feb 2020 08:42:59 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 079423F7B4;
        Thu, 27 Feb 2020 08:42:57 -0800 (PST)
References: <20200226164118.6405-1-valentin.schneider@arm.com> <20200226164118.6405-2-valentin.schneider@arm.com> <20200227130001.GA107011@google.com> <7ce12aa2-1925-f991-a85f-5bd81ba668fb@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Quentin Perret <qperret@google.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        morten.rasmussen@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel-team@android.com
Subject: Re: [PATCH 1/2] sched/topology: Don't enable EAS on SMT systems
In-reply-to: <7ce12aa2-1925-f991-a85f-5bd81ba668fb@arm.com>
Date:   Thu, 27 Feb 2020 16:42:55 +0000
Message-ID: <jhjftewvv5c.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27 2020, Dietmar Eggemann wrote:
>>> +	/* EAS definitely does *not* handle SMT */
>>> +	if (sched_smt_active())
>
> Can you add a pr_warn() and use the current comment as the warning
> message? Since we have one for !Asym CPU capacity and !schedutil.
>
>>> +		goto free;
>>> +
>
> [...]
>
> There is this 'EAS can be used ...' list of currently 4 items in the
> build_perf_domains() function header. You could include 'X. No SMT
> support' there.
>  ;-)

Right, the rst doc says "EAS on SMT is not supported" but I think that can
be interpreted as "EAS on !asym SMT". I'll add the warning and update the
comment.
