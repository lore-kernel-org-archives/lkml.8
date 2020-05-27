Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4006C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9754120C56
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbgE0LDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:03:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:36164 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387800AbgE0LDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:03:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 297E0AC9F;
        Wed, 27 May 2020 11:03:21 +0000 (UTC)
Subject: Re: [PATCH v3 08/19] mm: memcg/slab: save obj_cgroup for non-root
 slab objects
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-9-guro@fb.com>
 <3e02b3c6-2bf5-bddb-d855-83a1a1a54034@suse.cz>
 <20200526175330.GB377498@carbon.DHCP.thefacebook.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <90706966-b64d-751d-5f5a-b1e72fbfb30a@suse.cz>
Date:   Wed, 27 May 2020 13:03:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200526175330.GB377498@carbon.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/20 7:53 PM, Roman Gushchin wrote:
> On Mon, May 25, 2020 at 05:07:22PM +0200, Vlastimil Babka wrote:
>> On 4/22/20 10:46 PM, Roman Gushchin wrote:
>> > diff --git a/mm/slab.h b/mm/slab.h
>> > index 44def57f050e..525e09e05743 100644
>> > --- a/mm/slab.h
>> > +++ b/mm/slab.h
>> ...
>> > @@ -636,8 +684,8 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s, gfp_t flags,
>> >  					 s->flags, flags);
>> >  	}
>> >  
>> > -	if (memcg_kmem_enabled())
>> > -		memcg_kmem_put_cache(s);
>> > +	if (!is_root_cache(s))
>> > +		memcg_slab_post_alloc_hook(s, objcg, size, p);
>> >  }
>> >  
>> >  #ifndef CONFIG_SLOB
>> 
>> Keep also the memcg_kmem_enabled() static key check, like elsewhere?
>> 
> 
> Ok, will add, it can speed things up a little bit. My only concern is that
> the code is not ready for memcg_kmem_enabled() turning negative after being positive.
> But it's not a concern, right?
> 
> Actually, we can simplify memcg_kmem_enabled() mechanics and enable it
> only once as soon as the first memcg is fully initialized. I don't think there
> is any value in tracking the actual number of active memcgs.

Yeah, it should be acceptable that once the key is enabled after boot, there's
no way back until reboot.

> Thanks!
> 

