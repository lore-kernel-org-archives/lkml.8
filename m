Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565D7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34C2D2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgHXKEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 06:04:30 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:36598 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726086AbgHXKE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 06:04:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U6giGpr_1598263465;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0U6giGpr_1598263465)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 Aug 2020 18:04:25 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH v2 0/3] mm/slub: Fix count_partial() problem
To:     Pekka Enberg <penberg@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <1597061872-58724-1-git-send-email-xlpang@linux.alibaba.com>
 <CAOJsxLE9SkLY5V=D=Ot1oyLkbAORagfozYqxk1iNDW6b7QZrwg@mail.gmail.com>
From:   xunlei <xlpang@linux.alibaba.com>
Message-ID: <f0355157-d70a-893b-5b85-b8cb90e03361@linux.alibaba.com>
Date:   Mon, 24 Aug 2020 18:04:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAOJsxLE9SkLY5V=D=Ot1oyLkbAORagfozYqxk1iNDW6b7QZrwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/20 下午10:02, Pekka Enberg wrote:
> On Mon, Aug 10, 2020 at 3:18 PM Xunlei Pang <xlpang@linux.alibaba.com> wrote:
>>
>> v1->v2:
>> - Improved changelog and variable naming for PATCH 1~2.
>> - PATCH3 adds per-cpu counter to avoid performance regression
>>   in concurrent __slab_free().
>>
>> [Testing]
>> On my 32-cpu 2-socket physical machine:
>> Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz
>> perf stat --null --repeat 10 -- hackbench 20 thread 20000
>>
>> == original, no patched
>>       19.211637055 seconds time elapsed                                          ( +-  0.57% )
>>
>> == patched with patch1~2
>>  Performance counter stats for 'hackbench 20 thread 20000' (10 runs):
>>
>>       21.731833146 seconds time elapsed                                          ( +-  0.17% )
>>
>> == patched with patch1~3
>>  Performance counter stats for 'hackbench 20 thread 20000' (10 runs):
>>
>>       19.112106847 seconds time elapsed                                          ( +-  0.64% )
>>
>>
>> Xunlei Pang (3):
>>   mm/slub: Introduce two counters for partial objects
>>   mm/slub: Get rid of count_partial()
>>   mm/slub: Use percpu partial free counter
>>
>>  mm/slab.h |   2 +
>>  mm/slub.c | 124 +++++++++++++++++++++++++++++++++++++++++++-------------------
>>  2 files changed, 89 insertions(+), 37 deletions(-)
> 
> We probably need to wrap the counters under CONFIG_SLUB_DEBUG because
> AFAICT all the code that uses them is also wrapped under it.

/sys/kernel/slab/***/partial sysfs also uses it, I can wrap it with
CONFIG_SLUB_DEBUG or CONFIG_SYSFS for backward compatibility.

> 
> An alternative approach for this patch would be to somehow make the
> lock in count_partial() more granular, but I don't know how feasible
> that actually is.
> 
> Anyway, I am OK with this approach:
> 
> Reviewed-by: Pekka Enberg <penberg@kernel.org>

Thanks!

> 
> You still need to convince Christoph, though, because he had
> objections over this approach.

Christoph, what do you think, or any better suggestion to address this
*in production* issue?

> 
> - Pekka
> 
