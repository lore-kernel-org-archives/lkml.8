Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128EAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC5BE206F1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgFQObN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:31:13 -0400
Received: from outbound-smtp05.blacknight.com ([81.17.249.38]:47858 "EHLO
        outbound-smtp05.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725901AbgFQObN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:31:13 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp05.blacknight.com (Postfix) with ESMTPS id 3046CCCCF7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 15:31:12 +0100 (IST)
Received: (qmail 14256 invoked from network); 17 Jun 2020 14:31:12 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.5])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Jun 2020 14:31:11 -0000
Date:   Wed, 17 Jun 2020 15:31:10 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH v6 00/19] The new cgroup slab memory controller
Message-ID: <20200617143110.GJ3183@techsingularity.net>
References: <20200608230654.828134-1-guro@fb.com>
 <CALvZod7ThL=yMwxzCLvrTtq=+Dr5ooUSX-iFP8AhiAGURByFBA@mail.gmail.com>
 <20200617024147.GA10812@carbon.lan>
 <CALvZod4vLQb4kns=ao8btL_g--9axZfcaxhMnj+CoTrCkyWoWQ@mail.gmail.com>
 <20200617033217.GE10812@carbon.lan>
 <e510e964-2703-d123-120c-816bbdd35743@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <e510e964-2703-d123-120c-816bbdd35743@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 01:24:21PM +0200, Vlastimil Babka wrote:
> > Not really.
> > 
> > Sharing a single set of caches adds some overhead to root- and non-accounted
> > allocations, which is something I've tried hard to avoid in my original version.
> > But I have to admit, it allows to simplify and remove a lot of code, and here
> > it's hard to argue with Johanness, who pushed on this design.
> > 
> > With performance testing it's not that easy, because it's not obvious what
> > we wanna test. Obviously, per-object accounting is more expensive, and
> > measuring something like 1000000 allocations and deallocations in a line from
> > a single kmem_cache will show a regression. But in the real world the relative
> > cost of allocations is usually low, and we can get some benefits from a smaller
> > working set and from having shared kmem_cache objects cache hot.
> > Not speaking about some extra memory and the fragmentation reduction.
> > 
> > We've done an extensive testing of the original version in Facebook production,
> > and we haven't noticed any regressions so far. But I have to admit, we were
> > using an original version with two sets of kmem_caches.
> > 
> > If you have any specific tests in mind, I can definitely run them. Or if you
> > can help with the performance evaluation, I'll appreciate it a lot.
> 
> Jesper provided some pointers here [1], it would be really great if you could
> run at least those microbenchmarks. With mmtests it's the major question of
> which subset/profiles to run, maybe the referenced commits provide some hints,
> or maybe Mel could suggest what he used to evaluate SLAB vs SLUB not so long ago.
> 

Last time the list of mmtests configurations I used for a basic
comparison were

db-pgbench-timed-ro-small-ext4
db-pgbench-timed-ro-small-xfs
io-dbench4-async-ext4
io-dbench4-async-xfs
io-bonnie-dir-async-ext4
io-bonnie-dir-async-xfs
io-bonnie-file-async-ext4
io-bonnie-file-async-xfs
io-fsmark-xfsrepair-xfs
io-metadata-xfs
network-netperf-unbound
network-netperf-cross-node
network-netperf-cross-socket
network-sockperf-unbound
network-netperf-unix-unbound
network-netpipe
network-tbench
pagereclaim-shrinker-ext4
scheduler-unbound
scheduler-forkintensive
workload-kerndevel-xfs
workload-thpscale-madvhugepage-xfs
workload-thpscale-xfs

Some were more valid than others in terms of doing an evaluation. I
followed up later with a more comprehensive comparison but that was
overkill.

Each time I did a slab/slub comparison in the past, I had to reverify
the rate that kmem_cache_* functions were actually being called as the
pattern can change over time even for the same workload.  A comparison
gets more complicated when comparing cgroups as ideally there would be
workloads running in multiple group but that gets complex and I think
it's reasonable to just test the "basic" case without cgroups.

-- 
Mel Gorman
SUSE Labs
