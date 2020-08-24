Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4EEC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B39F22074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgHXKAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 06:00:01 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:33983 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726884AbgHXJ7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 05:59:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0U6g21Wa_1598263186;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0U6g21Wa_1598263186)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 Aug 2020 17:59:47 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH 1/2] mm/slub: Introduce two counters for the partial
 objects
To:     Pekka Enberg <penberg@gmail.com>,
        Christopher Lameter <cl@linux.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>
References: <1593678728-128358-1-git-send-email-xlpang@linux.alibaba.com>
 <a53f9039-5cba-955b-009e-12e8c5ffb345@suse.cz>
 <CAOJsxLHX62P0yvHZcXdje41zm_2demzTraqvHXAvfhVPp2HKsA@mail.gmail.com>
 <alpine.DEB.2.22.394.2008071258020.55871@www.lameter.com>
 <CAOJsxLGqrCTgQhdOTTWKcCz0TsVfh_AxTCVWNGj6Mo4hyE5E2Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2008111250170.86069@www.lameter.com>
 <CAOJsxLHnTDjY3X69zVVaZ0MbpRab-1+Rk3L5AnZD3oQEceHD7Q@mail.gmail.com>
From:   xunlei <xlpang@linux.alibaba.com>
Message-ID: <9811b473-e09f-c2aa-cdd8-c71c34fe4707@linux.alibaba.com>
Date:   Mon, 24 Aug 2020 17:59:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAOJsxLHnTDjY3X69zVVaZ0MbpRab-1+Rk3L5AnZD3oQEceHD7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/20 PM9:58, Pekka Enberg wrote:
> Hi Christopher,
> 
> On Tue, Aug 11, 2020 at 3:52 PM Christopher Lameter <cl@linux.com> wrote:
>>
>> On Fri, 7 Aug 2020, Pekka Enberg wrote:
>>
>>> Why do you consider this to be a fast path? This is all partial list
>>> accounting when we allocate/deallocate a slab, no? Just like
>>> ___slab_alloc() says, I assumed this to be the slow path... What am I
>>> missing?
>>
>> I thought these were per object counters? If you just want to count the
>> number of slabs then you do not need the lock at all. We already have a
>> counter for the number of slabs.
> 
> The patch attempts to speed up count_partial(), which holds on to the
> "n->list_lock" (with IRQs off) for the whole duration it takes to walk
> the partial slab list:
> 
>         spin_lock_irqsave(&n->list_lock, flags);
>         list_for_each_entry(page, &n->partial, slab_list)
>                 x += get_count(page);
>         spin_unlock_irqrestore(&n->list_lock, flags);
> 
> It's counting the number of *objects*, but the counters are only
> updated in bulk when we add/remove a slab to/from the partial list.
> The counter updates are therefore *not* in the fast-path AFAICT.
> 
> Xunlei, please correct me if I'm reading your patches wrong.

Yes, it's all in slow-path.

> 
> On Tue, Aug 11, 2020 at 3:52 PM Christopher Lameter <cl@linux.com> wrote:
>>> No objections to alternative fixes, of course, but wrapping the
>>> counters under CONFIG_DEBUG seems like just hiding the actual issue...
>>
>> CONFIG_DEBUG is on by default. It just compiles in the debug code and
>> disables it so we can enable it with a kernel boot option. This is because
>> we have had numerous issues in the past with "production" kernels that
>> could not be recompiled with debug options. So just running the prod
>> kernel with another option will allow you to find hard to debug issues in
>> a full scale producton deployment with potentially proprietary modules
>> etc.
> 
> Yeah, it's been too long since I last looked at the code and did not
> realize even count_partial() is wrapped in CONFIG_DEBUG. So by all

Besides CONFIG_DEBUG, count_partial() is also wrapped in CONFIG_SYSFS.

> means, let's also wrap the counters with that too.
> 
> - Pekka
> 
