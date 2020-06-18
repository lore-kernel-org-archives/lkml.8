Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C60C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E5EB212CC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgFRHdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 03:33:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:55794 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgFRHdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 03:33:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 543F8AC5E;
        Thu, 18 Jun 2020 07:33:08 +0000 (UTC)
Subject: Re: [PATCH v6 17/19] mm: memcg/slab: use a single set of kmem_caches
 for all allocations
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20200608230654.828134-1-guro@fb.com>
 <20200608230654.828134-18-guro@fb.com>
 <20200617163528.a4477749b172c387e01c3996@linux-foundation.org>
 <20200618003515.GB24694@carbon.DHCP.thefacebook.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <36879e8d-dca7-caf9-71d6-918474ace53e@suse.cz>
Date:   Thu, 18 Jun 2020 09:33:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200618003515.GB24694@carbon.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/20 2:35 AM, Roman Gushchin wrote:
> On Wed, Jun 17, 2020 at 04:35:28PM -0700, Andrew Morton wrote:
>> On Mon, 8 Jun 2020 16:06:52 -0700 Roman Gushchin <guro@fb.com> wrote:
>> 
>> > Instead of having two sets of kmem_caches: one for system-wide and
>> > non-accounted allocations and the second one shared by all accounted
>> > allocations, we can use just one.
>> > 
>> > The idea is simple: space for obj_cgroup metadata can be allocated
>> > on demand and filled only for accounted allocations.
>> > 
>> > It allows to remove a bunch of code which is required to handle
>> > kmem_cache clones for accounted allocations. There is no more need
>> > to create them, accumulate statistics, propagate attributes, etc.
>> > It's a quite significant simplification.
>> > 
>> > Also, because the total number of slab_caches is reduced almost twice
>> > (not all kmem_caches have a memcg clone), some additional memory
>> > savings are expected. On my devvm it additionally saves about 3.5%
>> > of slab memory.
>> > 
>> 
>> This ran afoul of Vlastimil's "mm, slab/slub: move and improve
>> cache_from_obj()"
>> (http://lkml.kernel.org/r/20200610163135.17364-10-vbabka@suse.cz).  I
>> resolved things as below.  Not too sure about slab.c's
>> cache_from_obj()...
> 
> It can actually be as simple as:
> static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
> {
> 	return s;
> }
> 
> But I wonder if we need it at all, or maybe we wanna rename it to
> something like obj_check_kmem_cache(void *obj, struct kmem_cache *s),
> because it has now only debug purposes.
> 
> Let me and Vlastimil figure it out and send a follow-up patch.
> Your version is definitely correct.

Well, Kees wants to restore the common version of cache_from_obj() [1] for SLAB
hardening.

To prevent all that back and forth churn entering git history, I think the best
is for me to send a -fix to my patch that is functionally same while keeping the
common function, and then this your patch should only have a minor conflict and
Kees can rebase his patches on top to become much smaller?

[1] https://lore.kernel.org/linux-mm/20200617195349.3471794-1-keescook@chromium.org/

> Thanks!
> 

