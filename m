Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11274C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 11:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7D442073A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 11:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgHJL4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 07:56:38 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:48126 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726398AbgHJL4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 07:56:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0U5LoBgT_1597060590;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0U5LoBgT_1597060590)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 10 Aug 2020 19:56:31 +0800
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
From:   xunlei <xlpang@linux.alibaba.com>
Message-ID: <d039e8e0-1d16-1fe5-c06b-1911b9dad323@linux.alibaba.com>
Date:   Mon, 10 Aug 2020 19:56:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAOJsxLGqrCTgQhdOTTWKcCz0TsVfh_AxTCVWNGj6Mo4hyE5E2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/8 上午1:28, Pekka Enberg wrote:
> Hi Christopher,
> 
> On Fri, 7 Aug 2020, Pekka Enberg wrote:
>>> I think we can just default to the counters. After all, if I
>>> understood correctly, we're talking about up to 100 ms time period
>>> with IRQs disabled when count_partial() is called. As this is
>>> triggerable from user space, that's a performance bug whatever way you
>>> look at it.
> 
> On Fri, Aug 7, 2020 at 4:02 PM Christopher Lameter <cl@linux.com> wrote:
>> Well yes under extreme conditions and this is only happening for sysfs
>> counter retrieval.
> 
> You will likely get some stall even in less extreme conditions, and in
> any case, the kernel should not allow user space to trigger such a
> stall.
> 

Yes, agree. This problem has been causing lots of trouble to us and
other people, and should be fixed.

Either my approach or the approach provided by "Vlastimil Babka" [1] is
better than doing nothing.

[1]:
https://lore.kernel.org/linux-mm/158860845968.33385.4165926113074799048.stgit@buzz/

> On Fri, Aug 7, 2020 at 4:02 PM Christopher Lameter <cl@linux.com> wrote:
>> There could be other solutions to this. This solution here is penalizing
>> evertu hotpath slab allocation for the sake of relatively infrequently
>> used counter monitoring. There the possibility of not traversing the list
>> ande simply estimating the value based on the number of slab pages
>> allocated on that node.
> 
> Why do you consider this to be a fast path? This is all partial list
> accounting when we allocate/deallocate a slab, no? Just like
> ___slab_alloc() says, I assumed this to be the slow path... What am I
> missing?

The only hot path is __slab_free(), I've made an extra patch with percpu
counter to avoid the potential performance degradation, will send v2 out
for review.

> 
> No objections to alternative fixes, of course, but wrapping the
> counters under CONFIG_DEBUG seems like just hiding the actual issue...
> 
> - Pekka
> 
