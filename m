Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB56C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A00A24688
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgB0PRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:17:24 -0500
Received: from foss.arm.com ([217.140.110.172]:53530 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729279AbgB0PRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 10:17:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1966B30E;
        Thu, 27 Feb 2020 07:17:23 -0800 (PST)
Received: from [10.0.8.126] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F7CB3F7B4;
        Thu, 27 Feb 2020 07:17:21 -0800 (PST)
Subject: Re: [PATCH] sched/fair: fix runnable_avg for throttled cfs
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ben Segall <bsegall@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>, zhout@vivaldi.net
References: <20200226181640.21664-1-vincent.guittot@linaro.org>
 <xm26r1yhtbjr.fsf@bsegall-linux.svl.corp.google.com>
 <CAKfTPtBm9Gt16gqQgxoErOOmpbUHit6bNf4CVLvDzf04SjWtEg@mail.gmail.com>
 <8f72ea72-f36d-2611-e026-62ddff5c3422@arm.com>
 <CAKfTPtC9bkMQJsWw6Z2QD0RrV=qN7yMFviVnSeTpDp=-vLBL0g@mail.gmail.com>
 <CAKfTPtD4iVQmxWgNDDVhKPbu+rYEf=_1xKoPVOy343qo51pD_A@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <cf26f6c8-0e09-4c8c-b7e8-f010f4a4488c@arm.com>
Date:   Thu, 27 Feb 2020 15:17:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtD4iVQmxWgNDDVhKPbu+rYEf=_1xKoPVOy343qo51pD_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.02.20 14:58, Vincent Guittot wrote:
> On Thu, 27 Feb 2020 at 14:10, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
>>
>> On Thu, 27 Feb 2020 at 12:20, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>
>>> On 26.02.20 21:01, Vincent Guittot wrote:
>>>> On Wed, 26 Feb 2020 at 20:04, <bsegall@google.com> wrote:
>>>>>
>>>>> Vincent Guittot <vincent.guittot@linaro.org> writes:

[...]

>>> Shouldn't this be 'current' rather 'new' h_nr_running for
>>> group_se->runnable_weight? IMHO, you want to cache the current value
>>> before you add/subtract task_delta.
>>
>> hmm... it can't be current in both places. In my explanation,
>> "current" means the current situation when we started to throttle cfs
>> and "new" means the new situation after we finished to throttle the
>> cfs. I should probably use old and new to prevent any
>> misunderstanding.
> 
> I'm about to send a new version to fix some minor changes: The if
> statement should have some  { }   as there are some on the else part
> 
> Would it be better for you if i use old and new instead of current and
> new in the commit message ?

Personally yes, but now I understand the other wording as well. Thanks.

[...]
