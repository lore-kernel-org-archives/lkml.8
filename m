Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C93AC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 23:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70807217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 23:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgDPXcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 19:32:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:7585 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbgDPXcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 19:32:31 -0400
IronPort-SDR: s3b+Xo8wUZoXGfmDMWg5SLrPRUk0HortSzvbDo2dN6S5TWHV31zPcejR56PC+H4iKKd2fEpCL7
 pfd0l67G7Ytg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 16:32:30 -0700
IronPort-SDR: ym/zxMEgyXps61iGw/Ee6+UbniY5VWtuxaq2HPRAa8AHaB6gEZbO7MxoKsnjFsGQEm+IB0OaFg
 DC3YfjR3ed3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,392,1580803200"; 
   d="scan'208";a="246138657"
Received: from schen9-mobl.amr.corp.intel.com ([10.212.43.163])
  by fmsmga008.fm.intel.com with ESMTP; 16 Apr 2020 16:32:29 -0700
Subject: Re: [RFC PATCH 07/13] sched: Add core wide task selection and
 scheduling.
To:     Peter Zijlstra <peterz@infradead.org>,
        vpillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org,
        Aaron Lu <aaron.lu@linux.alibaba.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <e942da7fd881977923463f19648085c1bfaa37f8.1583332765.git.vpillai@digitalocean.com>
 <20200414133559.GT20730@hirez.programming.kicks-ass.net>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <1e587d48-2e61-e425-81cf-d304e13c91d4@linux.intel.com>
Date:   Thu, 16 Apr 2020 16:32:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200414133559.GT20730@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/20 6:35 AM, Peter Zijlstra wrote:
> On Wed, Mar 04, 2020 at 04:59:57PM +0000, vpillai wrote:
>> +static struct task_struct *
>> +pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>> +{
>> +	struct task_struct *next, *max = NULL;
>> +	const struct sched_class *class;
>> +	const struct cpumask *smt_mask;
>> +	int i, j, cpu;
>> +	bool need_sync = false;
> 
> AFAICT that assignment is superfluous. Also, you violated the inverse
> x-mas tree.
> 
>> +
>> +	cpu = cpu_of(rq);
>> +	if (cpu_is_offline(cpu))
>> +		return idle_sched_class.pick_next_task(rq);
> 
> Are we actually hitting this one?
> 

I did hit this race when I was testing taking cpu offline and online,
which prompted the check of cpu being offline.

Tim

