Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D62FC32771
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 11:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFFD214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 11:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732653AbgALLEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 06:04:04 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:51497 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732641AbgALLED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 06:04:03 -0500
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 00CB40vT035022;
        Sun, 12 Jan 2020 20:04:00 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp);
 Sun, 12 Jan 2020 20:04:00 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040062084.bbtec.net [126.40.62.84])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 00CB3sXg034964
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 12 Jan 2020 20:04:00 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [FIX] slub: Remove kmalloc under list_lock from
 list_slab_objects() V2
To:     Vlastimil Babka <vbabka@suse.cz>, Yu Zhao <yuzhao@google.com>,
        Christopher Lameter <cl@linux.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20191108193958.205102-1-yuzhao@google.com>
 <20191108193958.205102-2-yuzhao@google.com>
 <alpine.DEB.2.21.1911092024560.9034@www.lameter.com>
 <20191109230147.GA75074@google.com>
 <alpine.DEB.2.21.1911092313460.32415@www.lameter.com>
 <20191110184721.GA171640@google.com>
 <alpine.DEB.2.21.1911111543420.10669@www.lameter.com>
 <alpine.DEB.2.21.1911111553020.15366@www.lameter.com>
 <20191130150908.06b2646edfa7bdc12a943c25@linux-foundation.org>
 <alpine.DEB.2.21.1912021511250.15780@www.lameter.com>
 <20191207220320.GA67512@google.com>
 <e9f26cbd-593b-116e-2e4a-f8e0e16c23fc@suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <e0ed44ae-8dae-e8db-9d14-2b09b239af8e@i-love.sakura.ne.jp>
Date:   Sun, 12 Jan 2020 20:03:53 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <e9f26cbd-593b-116e-2e4a-f8e0e16c23fc@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/01/10 23:11, Vlastimil Babka wrote:
> On 12/7/19 11:03 PM, Yu Zhao wrote:
>> On Mon, Dec 02, 2019 at 03:12:20PM +0000, Christopher Lameter wrote:
>>> On Sat, 30 Nov 2019, Andrew Morton wrote:
>>>
>>>>> Perform the allocation in free_partial() before the list_lock is taken.
>>>>
>>>> No response here?  It looks a lot simpler than the originally proposed
>>>> patch?
>>>
>>> Yup. I prefer this one but its my own patch so I cannot Ack this.
>>
>> Hi, there is a pending question from Tetsuo-san. I'd be happy to ack
>> once it's address.
> 
> Tetsuo's mails don't reach linux-mm for a while and he has given up
> trying to do something about it. It's hard to discuss anything outside
> the direct CC group then. I don't know what's the pending question, for
> example.
> 

Hmm, this one? Even non-ML destinations are sometimes rejected (e.g.
  554 5.7.1 Service unavailable; Client host [202.181.97.72] blocked using b.barracudacentral.org; http://www.barracudanetworks.com/reputation/?pr=1&ip=202.181.97.72
). Anyway, I just worried whether it is really safe to do memory allocation
which might involve memory reclaim. You MM guys know better...

-------- Forwarded Message --------
Subject: Re: [FIX] slub: Remove kmalloc under list_lock from list_slab_objects() V2
Message-ID: <54b6c6a1-f9e4-5002-c828-3084c5203489@i-love.sakura.ne.jp>
Date: Sun, 1 Dec 2019 10:17:38 +0900

On 2019/12/01 8:09, Andrew Morton wrote:
>> Perform the allocation in free_partial() before the list_lock is taken.
> 
> No response here?  It looks a lot simpler than the originally proposed
> patch?
> 
>> --- linux.orig/mm/slub.c	2019-10-15 13:54:57.032655296 +0000
>> +++ linux/mm/slub.c	2019-11-11 15:52:11.616397853 +0000
>> @@ -3690,14 +3690,15 @@ error:
>>  }
>>
>>  static void list_slab_objects(struct kmem_cache *s, struct page *page,
>> -							const char *text)
>> +					const char *text, unsigned long *map)
>>  {
>>  #ifdef CONFIG_SLUB_DEBUG
>>  	void *addr = page_address(page);
>>  	void *p;
>> -	unsigned long *map = bitmap_zalloc(page->objects, GFP_ATOMIC);

Changing from !(__GFP_IO | __GFP_FS) allocation to

>> +
>>  	if (!map)
>>  		return;
>> +
>>  	slab_err(s, page, text, s->name);
>>  	slab_lock(page);
>>
>> @@ -3723,6 +3723,11 @@ static void free_partial(struct kmem_cac
>>  {
>>  	LIST_HEAD(discard);
>>  	struct page *page, *h;
>> +	unsigned long *map = NULL;
>> +
>> +#ifdef CONFIG_SLUB_DEBUG
>> +	map = bitmap_alloc(oo_objects(s->max), GFP_KERNEL);

__GFP_IO | __GFP_FS allocation.
How is this path guaranteed to be safe to perform __GFP_IO | __GFP_FS reclaim?

>> +#endif
>>
>>  	BUG_ON(irqs_disabled());
>>  	spin_lock_irq(&n->list_lock);
