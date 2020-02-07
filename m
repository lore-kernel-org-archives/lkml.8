Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5ABC352A3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA7120720
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URmXcpaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgBGLCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 06:02:05 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54928 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGLCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 06:02:04 -0500
Received: by mail-wm1-f67.google.com with SMTP id g1so2083102wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 03:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pr/AFFZh+9W+/zvI3rplARVHDi+LtGtzWNQb6hfXDww=;
        b=URmXcpaAWOrS3/SMZE4NVbt7qQF6+RTfC3TNmZdDu58fLYTCJph2tT3pLVM+DgUI3T
         mldH4MppB/34vOusWxFfmwFGuJsad1OtmCsOeaNCEd4UC2GIe9BSOpfM31IXPr6hyA59
         bi0onuaTVyGGBKCxDGxTUnLQy8UNN7EAFaeLN1V5gE5S3zNi8r6yAT3IANbs/qDls0qQ
         HkJi8k+BsSXXgQvTlBfyASCwwJUbUvs4vI97w1YTofc9bX3kCd6wQDBUBYc72d+JnQn4
         MKl1m6Bvs/amulmzzmBNBFmeE8JDI+WUrxNJhdfSQJMovI1e6nN57L7c+UAp/jMrsZKa
         8fXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pr/AFFZh+9W+/zvI3rplARVHDi+LtGtzWNQb6hfXDww=;
        b=uIPC0lIsUHzfYQA18KBsNZ29sjCAZQ1hA3dmDCBPrOUr3+RctKrwFeY4yu7NNtFj7h
         omZBCyBaK/PbtMQvLrY4zq+PAtWNtyjPcx7jCoJYOiC23emBXh/u4oiEz0/Zn+/xrctg
         ePg8Ku1/MHHN6yR5IJuJFYp2q11D3xsKCaLa6ON7lGpKauWEDUaBr86PV/LhrqzR+ENZ
         yzcQezFEcUs5b3CoPtDRL9maU8zh98cBQF082VXQCHVW/KbK7GdlRevj5JJdJoS7X4LH
         0PcNP6I6/+KMzr0VCnxfrNNB2/NWAdpM9Qo2skAMflWPnLHLwKfefQWmhHC4e1C8rouC
         vPiw==
X-Gm-Message-State: APjAAAV5uN5fPUZw9AWv0pq5wfuhqq4vRap/co8xvs5kQ40RWKsedsmS
        Yr242aN9Jy9pEPhSAshvihY=
X-Google-Smtp-Source: APXvYqwS+PwkEcLcmUSJ0LmUTIUe66RiJQKdid1n1I/l+LeBOdtfoQUgufESE1CGHjxG5EP2IzD50Q==
X-Received: by 2002:a1c:770e:: with SMTP id t14mr3791122wmi.101.1581073321737;
        Fri, 07 Feb 2020 03:02:01 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id e17sm2735445wrn.62.2020.02.07.03.02.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Feb 2020 03:02:01 -0800 (PST)
Date:   Fri, 7 Feb 2020 11:02:00 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 3/3] mm/sparsemem: avoid memmap overwrite for
 non-SPARSEMEM_VMEMMAP
Message-ID: <20200207110200.leb2uutwdp5sxmpu@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200206231629.14151-1-richardw.yang@linux.intel.com>
 <20200206231629.14151-4-richardw.yang@linux.intel.com>
 <CAPcyv4hLW5Ww1Bo0MmNi8fzUNQEvudtWpGOK23MWaiqQ+MemfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hLW5Ww1Bo0MmNi8fzUNQEvudtWpGOK23MWaiqQ+MemfA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 06:06:54PM -0800, Dan Williams wrote:
>On Thu, Feb 6, 2020 at 3:17 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
>>
>> In case of SPARSEMEM, populate_section_memmap() would allocate memmap
>> for the whole section, even we just want a sub-section. This would lead
>> to memmap overwrite if we a sub-section to an already populated section.
>>
>> Just return the populated memmap for non-SPARSEMEM_VMEMMAP case.
>>
>> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> CC: Dan Williams <dan.j.williams@intel.com>
>> ---
>>  mm/sparse.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/mm/sparse.c b/mm/sparse.c
>> index 56816f653588..c75ca40db513 100644
>> --- a/mm/sparse.c
>> +++ b/mm/sparse.c
>> @@ -836,6 +836,16 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
>>         if (nr_pages < PAGES_PER_SECTION && early_section(ms))
>>                 return pfn_to_page(pfn);
>>
>> +       /*
>> +        * If it is not SPARSEMEM_VMEMMAP, we always populate memmap for the
>> +        * whole section, even for a sub-section.
>> +        *
>> +        * Return its memmap if already populated to avoid memmap overwrite.
>> +        */
>> +       if (!IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) &&
>> +               valid_section(ms))
>> +               return __section_mem_map_addr(ms);
>
>Again, is check_pfn_span() failing to prevent this path?

Oh, you are right. Thanks

-- 
Wei Yang
Help you, Help me
