Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEEFC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 02:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7236C21775
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 02:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbgGaC5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 22:57:42 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:50260 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731162AbgGaC5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 22:57:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U4Gz1EO_1596164257;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0U4Gz1EO_1596164257)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 31 Jul 2020 10:57:38 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH 1/2] mm/slub: Introduce two counters for the partial
 objects
To:     Pekka Enberg <penberg@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1593678728-128358-1-git-send-email-xlpang@linux.alibaba.com>
 <CAOJsxLErUqY=eBEaj0G3iRAY-YuyyLnxOnBLTP6SkCjhq1On2g@mail.gmail.com>
 <7374a9fd-460b-1a51-1ab4-25170337e5f2@linux.alibaba.com>
 <CAOJsxLFnY=4v6UQigyiZKTMTQXKakVOKf6KA+bCkMe-XVY6sqA@mail.gmail.com>
From:   xunlei <xlpang@linux.alibaba.com>
Message-ID: <5eeb5c3d-1a34-ad96-9010-4d8a5ac32241@linux.alibaba.com>
Date:   Fri, 31 Jul 2020 10:57:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAOJsxLFnY=4v6UQigyiZKTMTQXKakVOKf6KA+bCkMe-XVY6sqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/7 下午11:23, Pekka Enberg wrote:
> Hi!
> 
> (Sorry for the delay, I missed your response.)
> 
> On Fri, Jul 3, 2020 at 12:38 PM xunlei <xlpang@linux.alibaba.com> wrote:
>>
>> On 2020/7/2 PM 7:59, Pekka Enberg wrote:
>>> On Thu, Jul 2, 2020 at 11:32 AM Xunlei Pang <xlpang@linux.alibaba.com> wrote:
>>>> The node list_lock in count_partial() spend long time iterating
>>>> in case of large amount of partial page lists, which can cause
>>>> thunder herd effect to the list_lock contention, e.g. it cause
>>>> business response-time jitters when accessing "/proc/slabinfo"
>>>> in our production environments.
>>>
>>> Would you have any numbers to share to quantify this jitter? I have no
>>
>> We have HSF RT(High-speed Service Framework Response-Time) monitors, the
>> RT figures fluctuated randomly, then we deployed a tool detecting "irq
>> off" and "preempt off" to dump the culprit's calltrace, capturing the
>> list_lock cost up to 100ms with irq off issued by "ss", this also caused
>> network timeouts.
> 
> Thanks for the follow up. This sounds like a good enough motivation
> for this patch, but please include it in the changelog.
> 
>>> objections to this approach, but I think the original design
>>> deliberately made reading "/proc/slabinfo" more expensive to avoid
>>> atomic operations in the allocation/deallocation paths. It would be
>>> good to understand what is the gain of this approach before we switch
>>> to it. Maybe even run some slab-related benchmark (not sure if there's
>>> something better than hackbench these days) to see if the overhead of
>>> this approach shows up.
>>
>> I thought that before, but most atomic operations are serialized by the
>> list_lock. Another possible way is to hold list_lock in __slab_free(),
>> then these two counters can be changed from atomic to long.
>>
>> I also have no idea what's the standard SLUB benchmark for the
>> regression test, any specific suggestion?
> 
> I don't know what people use these days. When I did benchmarking in
> the past, hackbench and netperf were known to be slab-allocation
> intensive macro-benchmarks. Christoph also had some SLUB
> micro-benchmarks, but I don't think we ever merged them into the tree.

I tested hackbench on 24-CPU machine, here are the results:

"hackbench 20 thread 1000"

== orignal(without any patch)
Time: 53.793
Time: 54.305
Time: 54.073

== with my patch1~2
Time: 54.036
Time: 53.840
Time: 54.066
Time: 53.449

== with my patch1~2, plus using a percpu partial free objects counter
Time: 53.303
Time: 52.994
Time: 53.218
Time: 53.268
Time: 53.739
Time: 53.072

The results show no performance regression, it's strange that the
figures even get a little better when using percpu counter.

Thanks,
Xunlei
