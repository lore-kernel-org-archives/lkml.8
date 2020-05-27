Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8260BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AD202078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LFjk88MN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgE0THK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 15:07:10 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4357 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgE0THJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:07:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eceba090002>; Wed, 27 May 2020 12:05:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 27 May 2020 12:07:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 27 May 2020 12:07:09 -0700
Received: from [10.2.87.74] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 May
 2020 19:07:08 +0000
Subject: Re: [PATCH] drm/radeon: Convert get_user_pages() --> pin_user_pages()
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <1590526802-3008-1-git-send-email-jrdr.linux@gmail.com>
 <69a033cf-63b2-7da6-6a5e-a5bbc94b8afb@nvidia.com>
 <20200527084852.GN206103@phenom.ffwll.local>
 <20200527085117.GO206103@phenom.ffwll.local>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <aaf62285-981e-3753-5501-07bbba98fc36@nvidia.com>
Date:   Wed, 27 May 2020 12:07:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200527085117.GO206103@phenom.ffwll.local>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590606345; bh=cJGxgyxUMS7+SGXB5PmVaX93dA/VtdD9tLRCxZnqybQ=;
        h=X-PGP-Universal:Subject:To:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=LFjk88MNH0RKsXsLEslCB9oYqWO/+qMh7mtsWwHzujVQNvjhVM3PMi5vWNhtfXxso
         crnY9sWfLYHUbXyb1qBHZ2T3NZDECLkFwKYXj5JCxdqvsHElOFJDUqLmcZZUmwz8vw
         kNSQ1hzCmul6R2atxy7vC4gHnhTLSubpC9+XFFM2R5zhstiVlSIQRp6Lp3IE/8L2SM
         CucGGzQ8NCIIWK2j5pvWa5Jr7e6iP/ggLLIduMbh7MVZHCREBVJ5dVoD8IhyWo0M2N
         1yF68YtM+toIRVk1NkUTaZRPr5GOd1ry/MnsmndslsBkJVaLj7Xb9e0kKPDZlgLWIs
         sDMfQem0oi7Vw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-27 01:51, Daniel Vetter wrote:
> On Wed, May 27, 2020 at 10:48:52AM +0200, Daniel Vetter wrote:
>> On Tue, May 26, 2020 at 03:57:45PM -0700, John Hubbard wrote:
>>> On 2020-05-26 14:00, Souptick Joarder wrote:
>>>> This code was using get_user_pages(), in a "Case 2" scenario
>>>> (DMA/RDMA), using the categorization from [1]. That means that it's
>>>> time to convert the get_user_pages() + release_pages() calls to
>>>> pin_user_pages() + unpin_user_pages() calls.
>>>>
>>>> There is some helpful background in [2]: basically, this is a small
>>>> part of fixing a long-standing disconnect between pinning pages, and
>>>> file systems' use of those pages.
>>>>
>>>> [1] Documentation/core-api/pin_user_pages.rst
>>>>
>>>> [2] "Explicit pinning of user-space pages":
>>>>       https://lwn.net/Articles/807108/
>>
>> I don't think this is a case 2 here, nor is it any of the others. Feels
>> like not covered at all by the doc.
>>
>> radeon has a mmu notifier (might be a bit broken, but hey whatever there's
>> other drivers which have the same concept, but less broken). So when you
>> do an munmap, radeon will release the page refcount.
> 

Aha, thanks Daniel. I withdraw my misinformed ACK, then.

> I forgot to add: It's also not case 3, since there's no hw page fault
> support. It's all faked in software, and explicitly synchronizes against
> pending io (or preempts it, that depends a bit upon the jobs running).
> 

This is what case 3 was *intended* to cover, but it looks like case 3 needs to
be written a little better. I'll attempt that, and Cc you on the actual patch
to -mm. (I think we also need a case 5 for an unrelated scenario, too, so
it's time.)


thanks,
-- 
John Hubbard
NVIDIA


>> Which case it that?
>>
>> Note that currently only amdgpu doesn't work like that for gpu dma
>> directly to userspace ranges, it uses hmm and afaiui doens't hold a full
>> page pin refcount.
>>
>> Cheers, Daniel
>>
>>
>>>>
>>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>>> Cc: John Hubbard <jhubbard@nvidia.com>
>>>>
>>>> Hi,
>>>>
>>>> I'm compile tested this, but unable to run-time test, so any testing
>>>> help is much appriciated.
>>>> ---
>>>>    drivers/gpu/drm/radeon/radeon_ttm.c | 6 +++---
>>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
>>>> index 5d50c9e..e927de2 100644
>>>> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
>>>> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
>>>> @@ -506,7 +506,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_tt *ttm)
>>>>    		uint64_t userptr = gtt->userptr + pinned * PAGE_SIZE;
>>>>    		struct page **pages = ttm->pages + pinned;
>>>> -		r = get_user_pages(userptr, num_pages, write ? FOLL_WRITE : 0,
>>>> +		r = pin_user_pages(userptr, num_pages, write ? FOLL_WRITE : 0,
>>>>    				   pages, NULL);
>>>>    		if (r < 0)
>>>>    			goto release_pages;
>>>> @@ -535,7 +535,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_tt *ttm)
>>>>    	kfree(ttm->sg);
>>>>    release_pages:
>>>> -	release_pages(ttm->pages, pinned);
>>>> +	unpin_user_pages(ttm->pages, pinned);
>>>>    	return r;
>>>>    }
>>>> @@ -562,7 +562,7 @@ static void radeon_ttm_tt_unpin_userptr(struct ttm_tt *ttm)
>>>>    			set_page_dirty(page);
>>>
>>>
>>> Maybe we also need a preceding patch, to fix the above? It should be
>>> set_page_dirty_lock(), rather than set_page_dirty(), unless I'm overlooking
>>> something (which is very possible!).
>>>
>>> Either way, from a tunnel vision perspective of changing gup to pup, this
>>> looks good to me, so
>>>
>>>      Acked-by: John Hubbard <jhubbard@nvidia.com>
>>>
>>>
>>> thanks,
>>> -- 
>>> John Hubbard
>>> NVIDIA
>>>
>>>>    		mark_page_accessed(page);
>>>> -		put_page(page);
>>>> +		unpin_user_page(page);
>>>>    	}
>>>>    	sg_free_table(ttm->sg);
>>>>
>>>
>>
>> -- 
>> Daniel Vetter
>> Software Engineer, Intel Corporation
>> http://blog.ffwll.ch
> 

