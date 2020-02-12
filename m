Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C886C35242
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 01:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6174B20724
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 01:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgBLBaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 20:30:08 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:37913 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727330AbgBLBaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 20:30:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TpjeQz9_1581471003;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TpjeQz9_1581471003)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 12 Feb 2020 09:30:04 +0800
Subject: Re: [RFC] why can't dynamic isolation just like the static way
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
References: <fed10a26-7423-23b5-316c-c74d354870dd@linux.alibaba.com>
 <20200211114350.GJ14914@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <4800c9fd-2fbd-df35-cfa9-c048f9fe8b11@linux.alibaba.com>
Date:   Wed, 12 Feb 2020 09:30:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211114350.GJ14914@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/2/11 下午7:43, Peter Zijlstra wrote:
> On Tue, Feb 11, 2020 at 04:17:34PM +0800, 王贇 wrote:
>> Hi, folks
>>
>> We are dealing with isolcpus these days and try to do the isolation
>> dynamically.
>>
>> The kernel doc lead us into the cpuset.sched_load_balance, it's fine
>> to achieve the dynamic isolation with it, however we got problem with
>> the systemd stuff.
> 
> Then don't use systemd :-) Also, if systemd is the problem, why are you
> bugging us?

Well, that's... fair enough :-P

What we try to understand is why dynamic isolation is so different with
the way of static isolation, is it not good to have a simple way instead?

Regards,
Michael Wang

> 
