Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACAAC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8C4120768
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732281AbgIHTyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:54:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:38070 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730551AbgIHPhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:37:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A93B9AC26;
        Tue,  8 Sep 2020 15:36:46 +0000 (UTC)
Subject: Re: [PATCH RFC 00/10] KFENCE: A low-overhead sampling-based memory
 safety error detector
To:     Marco Elver <elver@google.com>, Dave Hansen <dave.hansen@intel.com>
Cc:     glider@google.com, akpm@linux-foundation.org,
        catalin.marinas@arm.com, cl@linux.com, rientjes@google.com,
        iamjoonsoo.kim@lge.com, mark.rutland@arm.com, penberg@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, andreyknvl@google.com,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, dvyukov@google.com,
        edumazet@google.com, gregkh@linuxfoundation.org, mingo@redhat.com,
        jannh@google.com, corbet@lwn.net, keescook@chromium.org,
        peterz@infradead.org, cai@lca.pw, tglx@linutronix.de,
        will@kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
References: <20200907134055.2878499-1-elver@google.com>
 <e399d8d5-03c2-3c13-2a43-3bb8e842c55a@intel.com>
 <20200908153102.GB61807@elver.google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <feb73053-17a6-8b43-5b2b-51a813e81622@suse.cz>
Date:   Tue, 8 Sep 2020 17:36:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908153102.GB61807@elver.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/20 5:31 PM, Marco Elver wrote:
>> 
>> How much memory overhead does this end up having?  I know it depends on
>> the object size and so forth.  But, could you give some real-world
>> examples of memory consumption?  Also, what's the worst case?  Say I
>> have a ton of worst-case-sized (32b) slab objects.  Will I notice?
> 
> KFENCE objects are limited (default 255). If we exhaust KFENCE's memory
> pool, no more KFENCE allocations will occur.
> Documentation/dev-tools/kfence.rst gives a formula to calculate the
> KFENCE pool size:
> 
> 	The total memory dedicated to the KFENCE memory pool can be computed as::
> 
> 	    ( #objects + 1 ) * 2 * PAGE_SIZE
> 
> 	Using the default config, and assuming a page size of 4 KiB, results in
> 	dedicating 2 MiB to the KFENCE memory pool.
> 
> Does that clarify this point? Or anything else that could help clarify
> this?

Hmm did you observe that with this limit, a long-running system would eventually
converge to KFENCE memory pool being filled with long-aged objects, so there
would be no space to sample new ones?

> Thanks,
> -- Marco
> 

