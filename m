Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3569C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1A0B204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgFRIcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 04:32:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:33096 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbgFRIcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 04:32:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1EBA8AD35;
        Thu, 18 Jun 2020 08:32:20 +0000 (UTC)
Subject: Re: [PATCH 7/9] mm, slub: introduce kmem_cache_debug_flags()
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        vinmenon@codeaurora.org, Matthew Garrett <mjg59@google.com>,
        Roman Gushchin <guro@fb.com>, Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>
References: <20200610163135.17364-1-vbabka@suse.cz>
 <20200610163135.17364-8-vbabka@suse.cz> <202006171055.64F6EB665@keescook>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <5dcd5d95-15e9-cc17-908c-a2de9f61e97f@suse.cz>
Date:   Thu, 18 Jun 2020 10:32:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <202006171055.64F6EB665@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/20 7:56 PM, Kees Cook wrote:
> On Wed, Jun 10, 2020 at 06:31:33PM +0200, Vlastimil Babka wrote:
>> There are few places that call kmem_cache_debug(s) (which tests if any of debug
>> flags are enabled for a cache) immediatelly followed by a test for a specific
>> flag. The compiler can probably eliminate the extra check, but we can make the
>> code nicer by introducing kmem_cache_debug_flags() that works like
>> kmem_cache_debug() (including the static key check) but tests for specifig
>> flag(s). The next patches will add more users.
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  mm/slub.c | 18 ++++++++++++++----
>>  1 file changed, 14 insertions(+), 4 deletions(-)
>> 
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 24d3e5f832aa..c8e8b4ae2451 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -122,18 +122,28 @@ DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
>>  #endif
>>  #endif
>>  
>> -static inline int kmem_cache_debug(struct kmem_cache *s)
>> +/*
>> + * Returns true if any of the specified slub_debug flags is enabled for the
>> + * cache. Use only for flags parsed by setup_slub_debug() as it also enables
>> + * the static key.
>> + */
>> +static inline int kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t flags)
> 
> This should return slab_flag_t, yes?

bool, actually

>>  {
>>  #ifdef CONFIG_SLUB_DEBUG
>>  	if (static_branch_unlikely(&slub_debug_enabled))
>> -		return s->flags & SLAB_DEBUG_FLAGS;
>> +		return s->flags & flags;
>>  #endif
>>  	return 0;
>>  }
>>  
>> +static inline int kmem_cache_debug(struct kmem_cache *s)
> 
> And this too, as long as we're making changes here.

OK
