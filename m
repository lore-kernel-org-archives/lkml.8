Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664B2C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441442073B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgCEPqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:46:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:48544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgCEPqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:46:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9B018AC37;
        Thu,  5 Mar 2020 15:46:48 +0000 (UTC)
Date:   Thu, 5 Mar 2020 07:34:34 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] perf bench futex-wake: Restore thread count default
 to online CPU count
Message-ID: <20200305153434.5r2jqsfxyrusrgwc@linux-p48b>
References: <20200305083714.9381-1-tommi.t.rantala@nokia.com>
 <20200305083714.9381-3-tommi.t.rantala@nokia.com>
 <20200305145149.GB7895@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200305145149.GB7895@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Mar 2020, Arnaldo Carvalho de Melo wrote:

>Em Thu, Mar 05, 2020 at 10:37:13AM +0200, Tommi Rantala escreveu:
>> Since commit 3b2323c2c1c4 ("perf bench futex: Use cpumaps") the default
>> number of threads the benchmark uses got changed from number of online
>> CPUs to zero:
>>
>>   $ perf bench futex wake
>>   # Running 'futex/wake' benchmark:
>>   Run summary [PID 15930]: blocking on 0 threads (at [private] futex 0x558b8ee4bfac), waking up 1 at a time.
>>   [Run 1]: Wokeup 0 of 0 threads in 0.0000 ms
>>   [...]
>>   [Run 10]: Wokeup 0 of 0 threads in 0.0000 ms
>>   Wokeup 0 of 0 threads in 0.0004 ms (+-40.82%)
>>
>> Restore the old behavior by grabbing the number of online CPUs via
>> cpu->nr:
>>
>>   $ perf bench futex wake
>>   # Running 'futex/wake' benchmark:
>>   Run summary [PID 18356]: blocking on 8 threads (at [private] futex 0xb3e62c), waking up 1 at a time.
>>   [Run 1]: Wokeup 8 of 8 threads in 0.0260 ms
>>   [...]
>>   [Run 10]: Wokeup 8 of 8 threads in 0.0270 ms
>>   Wokeup 8 of 8 threads in 0.0419 ms (+-24.35%)
>>
>> Fixes: 3b2323c2c1c4 ("perf bench futex: Use cpumaps")
>
>Thanks, tested and applied.

Thanks!
