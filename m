Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788BEC47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58E5F20A8B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgEHK6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 06:58:42 -0400
Received: from foss.arm.com ([217.140.110.172]:46518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbgEHK6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 06:58:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6C3A30E;
        Fri,  8 May 2020 03:58:40 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D040A3F71F;
        Fri,  8 May 2020 03:58:37 -0700 (PDT)
Subject: Re: [RFC PATCH v3 2/3] docs: scheduler: Add scheduler overview
 documentation
To:     Valentin Schneider <valentin.schneider@arm.com>,
        John Mathew <john.mathew@unikie.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, tsbogend@alpha.franken.de,
        lukas.bulwahn@gmail.com, x86@kernel.org,
        linux-mips@vger.kernel.org, tglx@linutronix.de,
        mostafa.chamanara@basemark.com, rdunlap@infradead.org,
        Oleg Tsymbal <oleg.tsymbal@unikie.com>
References: <20200507180553.9993-1-john.mathew@unikie.com>
 <20200507180553.9993-3-john.mathew@unikie.com> <jhjh7wrtpjk.mognet@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <b974b959-7b9a-2874-dca6-674b74ad5b42@arm.com>
Date:   Fri, 8 May 2020 12:58:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <jhjh7wrtpjk.mognet@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2020 23:15, Valentin Schneider wrote:
> 
> On 07/05/20 19:05, John Mathew wrote:

[...]

> It would also be an opportunity to have one place to (at least briefly)
> describe what the different sched classes do wrt capacity asymmetry - CFS
> does one thing, RT now does one thing (see Qais' work), and DL will
> hopefully soon follow (see Dietmar's work).
> 
> I'd be happy to contribute (some of) that, if it can be deemed useful (I
> personally think it might).

I like the idea.

Essentially all the code which is guarded by the 'if
(static_branch_unlikely(&sched_asym_cpucapacity)' condition or which
sets it during bring-up.

* 'Cpu capacity < SCHED_LOAD_SCALE for non-big' CPUs setting during
   bringup (necessary dt binding, CPUfreq influence)

* CFS capacity awareness:

  * wakeup - select_idle_capacity() (replaced wake_cap() & slow path to
             cover DynamIQ and classical big.LITTLE)

  * load_balance - misfit handling

* RT & DL capacity awareness

* ... & the relation to EAS (Documentation/scheduler/sched-energy.rst)

This is what we referred to (at least internally) as CAS (Capacity-Aware
Scheduling).
