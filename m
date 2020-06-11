Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFEEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AF2C20835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgFKJ5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 05:57:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:51618 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgFKJ46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 05:56:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4FA33AEE9;
        Thu, 11 Jun 2020 09:56:59 +0000 (UTC)
Subject: Re: [PATCH 9/9] mm, slab/slub: move and improve cache_from_obj()
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        vinmenon@codeaurora.org, Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>
References: <20200610163135.17364-1-vbabka@suse.cz>
 <20200610163135.17364-10-vbabka@suse.cz>
 <20200610224611.GD702969@carbon.DHCP.thefacebook.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <8ed46959-dcbd-041b-5c1c-172d5dce1eb0@suse.cz>
Date:   Thu, 11 Jun 2020 11:56:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200610224611.GD702969@carbon.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/20 12:46 AM, Roman Gushchin wrote:
> On Wed, Jun 10, 2020 at 06:31:35PM +0200, Vlastimil Babka wrote:
>> @@ -3672,6 +3672,14 @@ void *__kmalloc_track_caller(size_t size, gfp_t flags, unsigned long caller)
>>  }
>>  EXPORT_SYMBOL(__kmalloc_track_caller);
>>  
>> +static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
>> +{
>> +	if (memcg_kmem_enabled())
>> +		return virt_to_cache(x);
>> +	else
>> +		return s;
>> +}
> 
> Hm, it looks like all the SLAB version doesn't perform any sanity checks anymore.
> Is it intended?

Yes, it was the same before commit b9ce5ef49f00. The commit could have been more
precise - kmemcg needs virt_to_cache(), but not the sanity check. The SLUB
version also shouldn't really be doing the sanity check if only
memcg_kmem_enabled() is true (and not the debugging/hardening), but the code
then looks ugly and I hope this will just fix itself with your kmemcg slab rework.

> Also, Is it ever possible that s != virt_to_cache(x) if there are no bugs?

Well, only in the kmemcg case it should be possible.

> kmem_cache_free_bulk() in slab.c does contain the following:
> 	if (!orig_s) /* called via kfree_bulk */
> 		s = virt_to_cache(objp);
> 	else
> 		s = cache_from_obj(orig_s, objp);
> which looks a bit strange with the version above.

Looks fine to me. If we are called with non-NULL s, and kmemcg is not enabled,
we can just trust s. If we are called with NULL s (via kfree_bulk()) we need to
get cache from the object, even if kmemcg is not enabled, so we do
virt_to_cache() unconditionally.
Once your series is fully accepted, we can remove SLAB's cache_from_obj() and
the whole 'else' part in the hunk above. Or am I missing something?


>> @@ -3175,6 +3179,23 @@ void ___cache_free(struct kmem_cache *cache, void *x, unsigned long addr)
>>  }
>>  #endif
>>  
>> +static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
>> +{
>> +	struct kmem_cache *cachep;
>> +
>> +	if (!IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
>> +	    !memcg_kmem_enabled() &&
>> +	    !kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS))
>> +		return s;
>> +
>> +	cachep = virt_to_cache(x);
>> +	if (WARN(cachep && !slab_equal_or_root(cachep, s),
>> +		  "%s: Wrong slab cache. %s but object is from %s\n",
>> +		  __func__, s->name, cachep->name))
>> +		print_tracking(cachep, x);
>> +	return cachep;
>> +}
> 
> Maybe we can define a trivial SLAB version of kmem_cache_debug_flags()
> and keep a single version of cache_from_obj()?

I think the result would be more obfuscated than just making it plain that SLAB
doesn't have those SLUB features. And I still hope SLAB's version will go away
completely. If your series is accepted first, then this patch based in that will
not introduce slab.c cache_from_obj() at all.

> Thank you!
> 

