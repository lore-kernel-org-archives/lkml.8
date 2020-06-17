Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC23C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7BAD208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgFQLYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 07:24:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:43984 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgFQLYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 07:24:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9F06BACDB;
        Wed, 17 Jun 2020 11:24:26 +0000 (UTC)
Subject: Re: [PATCH v6 00/19] The new cgroup slab memory controller
To:     Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>
References: <20200608230654.828134-1-guro@fb.com>
 <CALvZod7ThL=yMwxzCLvrTtq=+Dr5ooUSX-iFP8AhiAGURByFBA@mail.gmail.com>
 <20200617024147.GA10812@carbon.lan>
 <CALvZod4vLQb4kns=ao8btL_g--9axZfcaxhMnj+CoTrCkyWoWQ@mail.gmail.com>
 <20200617033217.GE10812@carbon.lan>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <e510e964-2703-d123-120c-816bbdd35743@suse.cz>
Date:   Wed, 17 Jun 2020 13:24:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200617033217.GE10812@carbon.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/20 5:32 AM, Roman Gushchin wrote:
> On Tue, Jun 16, 2020 at 08:05:39PM -0700, Shakeel Butt wrote:
>> On Tue, Jun 16, 2020 at 7:41 PM Roman Gushchin <guro@fb.com> wrote:
>> >
>> > On Tue, Jun 16, 2020 at 06:46:56PM -0700, Shakeel Butt wrote:
>> > > On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
>> > > >
>> [...]
>> > >
>> > > Have you performed any [perf] testing on SLAB with this patchset?
>> >
>> > The accounting part is the same for SLAB and SLUB, so there should be no
>> > significant difference. I've checked that it compiles, boots and passes
>> > kselftests. And that memory savings are there.
>> >
>> 
>> What about performance? Also you mentioned that sharing kmem-cache
>> between accounted and non-accounted can have additional overhead. Any
>> difference between SLAB and SLUB for such a case?
> 
> Not really.
> 
> Sharing a single set of caches adds some overhead to root- and non-accounted
> allocations, which is something I've tried hard to avoid in my original version.
> But I have to admit, it allows to simplify and remove a lot of code, and here
> it's hard to argue with Johanness, who pushed on this design.
> 
> With performance testing it's not that easy, because it's not obvious what
> we wanna test. Obviously, per-object accounting is more expensive, and
> measuring something like 1000000 allocations and deallocations in a line from
> a single kmem_cache will show a regression. But in the real world the relative
> cost of allocations is usually low, and we can get some benefits from a smaller
> working set and from having shared kmem_cache objects cache hot.
> Not speaking about some extra memory and the fragmentation reduction.
> 
> We've done an extensive testing of the original version in Facebook production,
> and we haven't noticed any regressions so far. But I have to admit, we were
> using an original version with two sets of kmem_caches.
> 
> If you have any specific tests in mind, I can definitely run them. Or if you
> can help with the performance evaluation, I'll appreciate it a lot.

Jesper provided some pointers here [1], it would be really great if you could
run at least those microbenchmarks. With mmtests it's the major question of
which subset/profiles to run, maybe the referenced commits provide some hints,
or maybe Mel could suggest what he used to evaluate SLAB vs SLUB not so long ago.

[1] https://lore.kernel.org/linux-mm/20200527103545.4348ac10@carbon/

> Thanks!
> 

