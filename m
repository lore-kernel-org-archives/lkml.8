Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF317C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966BF2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pnmv1SuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgBFOOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 09:14:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53638 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgBFOOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 09:14:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id s10so135693wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 06:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L4wzPANWYgERy1cMwQMGoaERgyMcBgGsGEw8L2NAiws=;
        b=Pnmv1SuSGpo08+31yoUVLBO9aAPsOeeVIP8x10+b/qESSGN6MXZBXMwoEFH7wsK1RF
         ANxyhhZl+x0TDBBToxCfaVO+ryfneBJLcSSV8Ksb53u8X8r2XTTecLzYwCVmSnKo3PZ+
         3ZB/q6nzkFlokp3Vf9lQyDpOvlnu4iYJ2BZ6oiGXugU4bPTI79ddB3l2bL7bDBqwoTok
         MS3rtYTLZLTkpZIDEpye8GdvNcU2UHD99Qm0C2bU52Afr5UN/5XObojYPEyb8uVVx5k8
         9Yuz/CYrIT84XQ83RDMxrWdV9fZV+fCWuVmeSc4jAloQwL02lZ8caLEUL4//AHtqNbMr
         nseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=L4wzPANWYgERy1cMwQMGoaERgyMcBgGsGEw8L2NAiws=;
        b=hpqBnt4ppdfPjYslQRE2cRYM2OjAMv49fdW+rPhAawzFQBwSD1hkCJAMXa+yi17fQJ
         CN5yx37Mp27Zni/8R30w+mU5J4e97C3UxbRi5332TvpGBJRgrt/rqPAMSZo5urSJC19S
         LEYONuYk4eOnUZlqrdBdhFLc0UHgpzVBH3Zr9FXnesDG6EIKpJYB+iQtle9vPFMSIINo
         g1Z+1/Z/CKHDMbLWDmS3vvBSZjeAuiUgtYLNl2x4Ww+KvCcNoL9/w32cWWvU7OJMRW9Y
         lzUYNml5PP+vckFAsV2Y/XMwC8m9Q7I8GSyT8lqGYwz9N/lQ03ZHd5x2x/DPGcN5dKLa
         LJIA==
X-Gm-Message-State: APjAAAVBHnkU9vuqFRosO/SxPYXft3b4KJ25xsaeZ9l4/jV8eUXA9N7a
        h7Yf0bfsLqOIJGzzTe53XyQ=
X-Google-Smtp-Source: APXvYqxghAN5gjnjGAKwUOP9mL/xlFo3XoZhE8qAtbakKGvgyXc0jIjYm7P29ZowE4GrMji/ce7Zzg==
X-Received: by 2002:a7b:ce8b:: with SMTP id q11mr4948042wmj.100.1580998474529;
        Thu, 06 Feb 2020 06:14:34 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id g21sm3731908wmh.17.2020.02.06.06.14.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Feb 2020 06:14:33 -0800 (PST)
Date:   Thu, 6 Feb 2020 14:14:33 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, osalvador@suse.de,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bhe@redhat.com
Subject: Re: [PATCH] mm/sparsemem: pfn_to_page is not valid yet on SPARSEMEM
Message-ID: <20200206141433.dqtqcuhb4g4wzyxd@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200206125343.9070-1-richardw.yang@linux.intel.com>
 <6d9e36cb-ee4a-00c8-447b-9b75a0262c3a@redhat.com>
 <20200206135742.454wgna4ta76yv5w@master>
 <185d502e-d5a8-9149-18fc-1ef9b251843e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <185d502e-d5a8-9149-18fc-1ef9b251843e@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 02:59:50PM +0100, David Hildenbrand wrote:
>On 06.02.20 14:57, Wei Yang wrote:
>> On Thu, Feb 06, 2020 at 02:28:53PM +0100, David Hildenbrand wrote:
>>> On 06.02.20 13:53, Wei Yang wrote:
>>>> When we use SPARSEMEM instead of SPARSEMEM_VMEMMAP, pfn_to_page()
>>>> doesn't work before sparse_init_one_section() is called. This leads to a
>>>> crash when hotplug memory.
>>>>
>>>> We should use memmap as it did.
>>>>
>>>> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
>>>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>>>> CC: Dan Williams <dan.j.williams@intel.com>
>>>> ---
>>>>  mm/sparse.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/sparse.c b/mm/sparse.c
>>>> index 5a8599041a2a..2efb24ff8f96 100644
>>>> --- a/mm/sparse.c
>>>> +++ b/mm/sparse.c
>>>> @@ -882,7 +882,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>>>>  	 * Poison uninitialized struct pages in order to catch invalid flags
>>>>  	 * combinations.
>>>>  	 */
>>>> -	page_init_poison(pfn_to_page(start_pfn), sizeof(struct page) * nr_pages);
>>>> +	page_init_poison(memmap, sizeof(struct page) * nr_pages);
>>>
>>> If you add sub-sections that don't fall onto the start of the section,
>>>
>>> pfn_to_page(start_pfn) != memmap
>>>
>>> and your patch would break that under SPARSEMEM_VMEMMAP if I am not wrong.
>>>
>>> Instead of memmap, there would have to be something like
>>>
>>> memmap + (start_pfn - SECTION_ALIGN_DOWN(start_pfn))
>>>
>>> If I am not wrong :)
>> 
>> Hi, David, Thanks for your comment.
>> 
>> To be hones, I am not familiar with SPARSEMEM_VMEMMAP. Here is my
>> understanding about section_activate() when SPARSEMEM_VMEMMAP is set.
>> 
>>   section_activate(nid, start_pfn, nr_pages, altmap)
>>     populate_section_mmemap(start_pfn, nr_pages, nid, altmap)
>>       __populate_section_mmemap(start_pfn, nr_pages, nid, altmap)
>>         return pfn_to_page(start_pfn)
>> 
>> So the memmap is the page struct for start_pfn when SPARSEMEM_VMEMMAP is set.
>> 
>> Maybe I missed some critical part?
>
>I was assuming that memmap is the memmap of the section, not of the
>sub-section. (judging from the change in the original patch)
>
>If the right memmap pointer to the sub-section is returned, then we are
>fine. Will double check :)
>

Thanks, your comments are valuable :-)

>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
