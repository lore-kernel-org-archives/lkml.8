Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB44CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C0652067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbgFOLgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 07:36:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:50556 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728285AbgFOLga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 07:36:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DEF8BAD41;
        Mon, 15 Jun 2020 11:36:32 +0000 (UTC)
Subject: Re: [PATCH v2] page_alloc: consider highatomic reserve in wmartermark
 fast
To:     Baoquan He <bhe@redhat.com>, Jaewon Kim <jaewon31.kim@gmail.com>
Cc:     Jaewon Kim <jaewon31.kim@samsung.com>, mgorman@techsingularity.net,
        minchan@kernel.org, mgorman@suse.de, hannes@cmpxchg.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ytk.lee@samsung.com,
        cmlaika.kim@samsung.com
References: <CGME20200612085027epcas1p46383a7eda792eabbd1e74cd08fe988c9@epcas1p4.samsung.com>
 <20200613025102.12880-1-jaewon31.kim@samsung.com>
 <20200613094228.GB3346@MiWiFi-R3L-srv>
 <CAJrd-Ut=QcK5FQP2TUm6==mowoVK_QVCB7x=LL4iUnZxBLYAmA@mail.gmail.com>
 <20200613231736.GJ20367@MiWiFi-R3L-srv>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <26a6a2c2-56e6-1a34-84ac-8ff9f74c34ce@suse.cz>
Date:   Mon, 15 Jun 2020 13:36:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200613231736.GJ20367@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/20 1:17 AM, Baoquan He wrote:
> On 06/13/20 at 10:08pm, Jaewon Kim wrote:
> ...
>> > > This is an example of ALLOC_HARDER allocation failure.
>> > >
>> > > <4>[ 6207.637280]  [3:  Binder:9343_3:22875] Binder:9343_3: page allocation failure: order:0, mode:0x480020(GFP_ATOMIC), nodemask=(null)
>> > > <4>[ 6207.637311]  [3:  Binder:9343_3:22875] Call trace:
>> > > <4>[ 6207.637346]  [3:  Binder:9343_3:22875] [<ffffff8008f40f8c>] dump_stack+0xb8/0xf0
>> > > <4>[ 6207.637356]  [3:  Binder:9343_3:22875] [<ffffff8008223320>] warn_alloc+0xd8/0x12c
>> > > <4>[ 6207.637365]  [3:  Binder:9343_3:22875] [<ffffff80082245e4>] __alloc_pages_nodemask+0x120c/0x1250
>> > > <4>[ 6207.637374]  [3:  Binder:9343_3:22875] [<ffffff800827f6e8>] new_slab+0x128/0x604
>> > > <4>[ 6207.637381]  [3:  Binder:9343_3:22875] [<ffffff800827b0cc>] ___slab_alloc+0x508/0x670
>> > > <4>[ 6207.637387]  [3:  Binder:9343_3:22875] [<ffffff800827ba00>] __kmalloc+0x2f8/0x310
>> > > <4>[ 6207.637396]  [3:  Binder:9343_3:22875] [<ffffff80084ac3e0>] context_struct_to_string+0x104/0x1cc
>> > > <4>[ 6207.637404]  [3:  Binder:9343_3:22875] [<ffffff80084ad8fc>] security_sid_to_context_core+0x74/0x144
>> > > <4>[ 6207.637412]  [3:  Binder:9343_3:22875] [<ffffff80084ad880>] security_sid_to_context+0x10/0x18
>> > > <4>[ 6207.637421]  [3:  Binder:9343_3:22875] [<ffffff800849bd80>] selinux_secid_to_secctx+0x20/0x28
>> > > <4>[ 6207.637430]  [3:  Binder:9343_3:22875] [<ffffff800849109c>] security_secid_to_secctx+0x3c/0x70
>> > > <4>[ 6207.637442]  [3:  Binder:9343_3:22875] [<ffffff8008bfe118>] binder_transaction+0xe68/0x454c
>> > > <4>[ 6207.637569]  [3:  Binder:9343_3:22875] Mem-Info:
>> > > <4>[ 6207.637595]  [3:  Binder:9343_3:22875] active_anon:102061 inactive_anon:81551 isolated_anon:0
>> > > <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  active_file:59102 inactive_file:68924 isolated_file:64
>> > > <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  unevictable:611 dirty:63 writeback:0 unstable:0
>> > > <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  slab_reclaimable:13324 slab_unreclaimable:44354
>> > > <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  mapped:83015 shmem:4858 pagetables:26316 bounce:0
>> > > <4>[ 6207.637595]  [3:  Binder:9343_3:22875]  free:2727 free_pcp:1035 free_cma:178
>> > > <4>[ 6207.637616]  [3:  Binder:9343_3:22875] Node 0 active_anon:408244kB inactive_anon:326204kB active_file:236408kB inactive_file:275696kB unevictable:2444kB isolated(anon):0kB isolated(file):256kB mapped:332060kB dirty:252kB writeback:0kB shmem:19432kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
>> > > <4>[ 6207.637627]  [3:  Binder:9343_3:22875] Normal free:10908kB min:6192kB low:44388kB high:47060kB active_anon:409160kB inactive_anon:325924kB active_file:235820kB inactive_file:276628kB unevictable:2444kB writepending:252kB present:3076096kB managed:2673676kB mlocked:2444kB kernel_stack:62512kB pagetables:105264kB bounce:0kB free_pcp:4140kB local_pcp:40kB free_cma:712kB
> 
> Checked this mem info, wondering why there's no 'reserved_highatomic'
> printing in all these examples.

Yeah, it better be printed, especially after it's included in watermark
calculation, so we're less confused by reports of allocation failure where
watermarks are seemingly ok.

...

>> > >       /*
>> > >        * Fast check for order-0 only. If this fails then the reserves
>> > > @@ -3598,9 +3604,12 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
>> > >        * the caller is !atomic then it'll uselessly search the free
>> > >        * list. That corner case is then slower but it is harmless.
>> >
>> > Do we need remove or adjust the code comment at this place? So Mel have
>> > foreseen the corner case, just reclaiming to unreserve the highatomic
>> > might be ignored.
>> >
>> 
>> Hello thank you for your comment.
>> 
>> My previous mail to Vlastimil Babka seems to have html.
>> Let me put  again here because I also think the comment should be changed.
>> I'd like to hear opinions from the open source community.
> 
> Yeah, your replying mail to Vlastimil looks a little messy on format, I
> didn't scroll down to check.
> 
>> 
>> Additionally actually I think we need accurate counting of highatomic
>> free after this patch.
>> 
>> ----------------------------------------------------------------------------------------
>> 
>> As Mel also agreed with me in v1 mail thread, this highatomic reserved should
>> be considered even in watermark fast.
>> 
>> The comment, I think, may need to be changed. Prior to this patch, non
>> highatomic
>> allocation may do useless search, but it also can take ALL non highatomic free.
>> 
>> With this patch, non highatomic allocation will NOT do useless search. Rather,
>> it may be required direct reclamation even when there are some non
>> high atomic free.
>> 
>> i.e)
>> In following situation, watermark check fails (9MB - 8MB < 4MB) though there are
>> enough free (9MB - 4MB > 4MB). If this is really matter, we need to
>> count highatomic
>> free accurately.
> 
> Seems to make sense. We only use zone->nr_reserved_highatomic to account
> the reserved highatomic, don't track how much have been used for
> highatomic allocation. But not sure if this will happen often, or just a
> very rare case, whether taking that into account will impact anything.

Unfortunately there's a problem when trying to account free pages of a migrate
type exactly, as e.g. during reserve_highatomic_pageblock(), some pages might be
in pcplist of other cpu with other migratetype, and once they are freed, the
buddy merging will merge the different migratetypes and distort the accounting.
Fixing this for all migratetypes would have performance overhead, so we only do
that for MIGRATE_ISOLATE which is not that frequent (and it took a while to
eliminate all corner cases), and CMA which doesn't change pageblocks dynamically.

So either we live with the possible overreclaim due to inaccurate counting per
your example above, or we instead let order-0 atomic allocations use highatomic
reserves.
