Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA4AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03E3E2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgGTJBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:01:11 -0400
Received: from foss.arm.com ([217.140.110.172]:53910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgGTJBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:01:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D41F101E;
        Mon, 20 Jul 2020 02:01:10 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1044B3F66E;
        Mon, 20 Jul 2020 02:01:07 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [SchedulerWakeupLatency] Skipping Idle Cores and CPU Search
To:     chris hyser <chris.hyser@oracle.com>,
        Parth Shah <parth@linux.ibm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Josef Bacik <jbacik@fb.com>
References: <87v9kv2545.derkling@matbug.com> <87h7wd15v2.derkling@matbug.net>
 <87imgrlrqi.derkling@matbug.net> <87mu5sqwkt.derkling@matbug.net>
 <87eer42clt.derkling@matbug.net> <87imfi2qbk.derkling@matbug.net>
 <39cc4666-6355-fb9f-654d-e85e1852bc6f@linux.ibm.com>
 <ffcff197-122f-c5bd-91f4-0ff8600be04d@oracle.com>
Message-ID: <c1b24dd5-dce9-61ed-baba-a70f08276bf5@arm.com>
Date:   Mon, 20 Jul 2020 10:47:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ffcff197-122f-c5bd-91f4-0ff8600be04d@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2020 01:08, chris hyser wrote:

[...]

>> D) Desired behavior:
> 
> Reduce the maximum wake-up latency of designated CFS tasks by skipping
> some or all of the idle CPU and core searches by setting a maximum idle
> CPU search value (maximum loop iterations).
> 
> Searching 'ALL' as the maximum would be the default and implies the
> current code path which may or may not search up to ALL. Searching 0
> would result in the least latency (shown with experimental results to be
> included if/when patchset goes up). One of the considerations is that
> the maximum length of the search is a function of the size of the LLC
> scheduling domain and this is platform dependent. Whether 'some', i.e. a
> numerical value limiting the search can be used to "normalize" this
> latency across differing scheduling domain sizes is under investigation.
> Clearly differing hardware will have many other significant differences,
> but in different sized and dynamically sized VMs running on fleets of
> common HW this may be interesting.

I assume that this task-specific feature could coexists in
select_idle_core() and select_idle_cpu() with the already existing
runtime heuristics (test_idle_cores() and the two sched features
mentioned under E/F) to reduce the idle CPU search space on a busy system.

>> E/F) Existing knobs (and limitations):
> 
> There are existing sched_feat: SIS_AVG_CPU, SIS_PROP that attempt to
> short circuit the idle cpu search path in select_idle_cpu() based on
> estimations of the current costs of searching. Neither provides a means

[...]

>> H) Range Analysis:
> 
> The knob is a positive integer representing "max number of CPUs to
> search". The default would be 'ALL' which could be translated as
> INT_MAX. '0 searches' translates to 0. Other values represent a max
> limit on the search, in this case iterations of a for loop.

IMHO the opposite use case for this feature (favour high throughput over
short wakeup latency (Facebook) is already cured by the changes
introduced by commit 10e2f1acd010 ("sched/core: Rewrite and improve
select_idle_siblings()"), i.e. with the current implementation of sis().

It seems that they don't need an additional per-task feature on top of
the default system-wide runtime heuristics.

[...]
