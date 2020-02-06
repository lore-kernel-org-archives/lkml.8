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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9AAC352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0348F214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyQ5OENC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgBFN5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 08:57:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35712 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbgBFN5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 08:57:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id w12so7347313wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 05:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=37rkqrVeTaF+mZnTFwvQ9NfsdsUskom+KVb6+jBTRMY=;
        b=WyQ5OENCxNDcGZer2tSh2fFvA+ujWZQVW0Sq1drxk3NvK4WXYuCVzMS4Smv+KqAv2q
         jQDLMZtpsPg4NhYE8M9W68qbyhtUrvTIQTC+BuqKz8imR2fZpnUZMFXJSEb7PcjYTvy5
         EV9dzmxQGtj0j4kQgFL2pZONUoLumxjg7CQCL83LqUqDx2rzo7sPtslyido2PJil4Jc4
         TZzxkwvMFwFdFdbyY58gZA0m+HGsuuBdeBGaix4P/8dNTpp7ZeqRx/4vbBeRCmEaxp0P
         5ghXItAykEskc0tJ8bP4JkEd33Lb71kzA5KqkMGRl3GRncQOf4Di0xJFtKT7aBsrR9M4
         776A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=37rkqrVeTaF+mZnTFwvQ9NfsdsUskom+KVb6+jBTRMY=;
        b=UFIGvQYZtjPca73uoDGvFDXMaTv7Ks3+eSm3dWsr+9fBS1Uese+AK4MXGwCCTT+2PJ
         GsKHZwubaeY6CXMXoDxRIr+MO84R59ubVws+LNwtRVAmn4KdwZsPhI9RAQUvt8EuFS6x
         T9SZRc48yaxVFnYmxF6Eq0+YFvSO8fcDdZy73gFfzxaS+QvFAeb/7hER5f5Tc8nA8b6Y
         gsHxstBmy2Kt2dcWAeCiArZg7GN2XR1qJOp4OYhwIb8d61jpKeuwPOcds2Y7WWaZjY0f
         tnJXMH3+/Swutcq9KaNw3dA3gG2R/3QqgiItZYxgW44A89GFeb6G52T/L0Q++LN7rlpN
         S09A==
X-Gm-Message-State: APjAAAVy0gINs27bNM6MQFztxb0LNNXk7Qi1/V/91w/6OJXI77nakwdC
        Le5TreZgsgQoN9+pDXQl8rQ=
X-Google-Smtp-Source: APXvYqwbWl3cDVywFO+VJspZ918ynJg0D0jUj6fPi4athSnC627IC8hulvLKqsnFAgFRBTrSgVhHhA==
X-Received: by 2002:adf:f787:: with SMTP id q7mr3922226wrp.297.1580997463195;
        Thu, 06 Feb 2020 05:57:43 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 124sm4030148wmc.29.2020.02.06.05.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Feb 2020 05:57:42 -0800 (PST)
Date:   Thu, 6 Feb 2020 13:57:42 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, osalvador@suse.de,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bhe@redhat.com
Subject: Re: [PATCH] mm/sparsemem: pfn_to_page is not valid yet on SPARSEMEM
Message-ID: <20200206135742.454wgna4ta76yv5w@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200206125343.9070-1-richardw.yang@linux.intel.com>
 <6d9e36cb-ee4a-00c8-447b-9b75a0262c3a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d9e36cb-ee4a-00c8-447b-9b75a0262c3a@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 02:28:53PM +0100, David Hildenbrand wrote:
>On 06.02.20 13:53, Wei Yang wrote:
>> When we use SPARSEMEM instead of SPARSEMEM_VMEMMAP, pfn_to_page()
>> doesn't work before sparse_init_one_section() is called. This leads to a
>> crash when hotplug memory.
>> 
>> We should use memmap as it did.
>> 
>> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> CC: Dan Williams <dan.j.williams@intel.com>
>> ---
>>  mm/sparse.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/mm/sparse.c b/mm/sparse.c
>> index 5a8599041a2a..2efb24ff8f96 100644
>> --- a/mm/sparse.c
>> +++ b/mm/sparse.c
>> @@ -882,7 +882,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>>  	 * Poison uninitialized struct pages in order to catch invalid flags
>>  	 * combinations.
>>  	 */
>> -	page_init_poison(pfn_to_page(start_pfn), sizeof(struct page) * nr_pages);
>> +	page_init_poison(memmap, sizeof(struct page) * nr_pages);
>
>If you add sub-sections that don't fall onto the start of the section,
>
>pfn_to_page(start_pfn) != memmap
>
>and your patch would break that under SPARSEMEM_VMEMMAP if I am not wrong.
>
>Instead of memmap, there would have to be something like
>
>memmap + (start_pfn - SECTION_ALIGN_DOWN(start_pfn))
>
>If I am not wrong :)

Hi, David, Thanks for your comment.

To be hones, I am not familiar with SPARSEMEM_VMEMMAP. Here is my
understanding about section_activate() when SPARSEMEM_VMEMMAP is set.

  section_activate(nid, start_pfn, nr_pages, altmap)
    populate_section_mmemap(start_pfn, nr_pages, nid, altmap)
      __populate_section_mmemap(start_pfn, nr_pages, nid, altmap)
        return pfn_to_page(start_pfn)

So the memmap is the page struct for start_pfn when SPARSEMEM_VMEMMAP is set.

Maybe I missed some critical part?

>
>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
