Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFC0C352A4
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CEF20726
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IP5MZFON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgBGL0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 06:26:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36726 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgBGL0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 06:26:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so2364943wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 03:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SMZrIsF6ztKLhnhRtzZ68+A39XQYu+eA8LHmISXlFc4=;
        b=IP5MZFONMBrbwfIgvl9IwOOPxC8oklm3zpsWll8sVbpP5n1tJZID0WfNhYy3cKk2zW
         aCFCVlhKruDaJa4g9yk5T4Sdc02DGfbXAlx+RhKiquVng2PaemoVYHgsh0r1/Hfaq1yS
         2fPmOU35xZHtze7Ko6Y/gWeRAKi/+m3UdWQ89na0i2gnn3qZbYfkfitNIFw2k5ZJeowm
         6aOnGPEhVhVjjsto/yrjXzRjMrJw1rkJz4EvafhiFNxSl7s+52AmL1E9peo/wVkZrQOD
         f1EwjXyzyjqv1tec/FDuTrt7T3HMBRlgTLdIivveBpG0AOBWweBt8n6hjESCQEUfnBL3
         F8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SMZrIsF6ztKLhnhRtzZ68+A39XQYu+eA8LHmISXlFc4=;
        b=Ao4FVyQledP7YjDHk9b2Xq/UF1gXVT+U+QOJ/KDgRaUfBugz9koJ8i+Y2ZVjFwCsSr
         8sFJ3BlVSQ5nARyQO8iHun8htukXxfBjbWkgkw9N0xqqBP1fFjs2Bj7MyCzh1L75ZTE1
         zmjtBa7ps6niQsK+cT8gaxkSzmZVMlfu8qxFX/CRvwxk+UuDk521OXDyFVdhqEXZ3IM8
         GrBcGAO8rFjeVZ28O9r8SLt2HKgOondMf1nVot1PP+I+0JQAyIvqCdwSvj9l68FKWwm+
         XlkOoDu4GYuiEGAD8Vb32na+a2xoFXnLzc8p9l2epGFgkPNllzc8neoljJmLemckgWcC
         sh5Q==
X-Gm-Message-State: APjAAAUbFYEXlw+qxKlPdT4r1r1AAjnpcNJ/hW6aVlaaFaMB1EM+ZQjg
        ey25sr7S6RR7PAA/EK+ToyY=
X-Google-Smtp-Source: APXvYqxJqroZC3Qzk4Lf0L75oKPWEeUk2uiGdOd5OzZCjXGAaCKpQz7Hnfv6CFEcIKqG3lNleRP3UQ==
X-Received: by 2002:a1c:a514:: with SMTP id o20mr3931782wme.179.1581074793758;
        Fri, 07 Feb 2020 03:26:33 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id v14sm3109117wrm.28.2020.02.07.03.26.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Feb 2020 03:26:33 -0800 (PST)
Date:   Fri, 7 Feb 2020 11:26:32 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 2/3] mm/sparsemem: get physical address to page struct
 instead of virtual address to pfn
Message-ID: <20200207112632.5inklkwyiewhrd75@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200206231629.14151-1-richardw.yang@linux.intel.com>
 <20200206231629.14151-3-richardw.yang@linux.intel.com>
 <CAPcyv4h7dKE85EQ9jR1akXnT6PcG2M2g7YCCLqse=kKieP1H9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4h7dKE85EQ9jR1akXnT6PcG2M2g7YCCLqse=kKieP1H9w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 06:19:46PM -0800, Dan Williams wrote:
>On Thu, Feb 6, 2020 at 3:17 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
>>
>> memmap should be the physical address to page struct instead of virtual
>> address to pfn.
>>
>> Since we call this only for SPARSEMEM_VMEMMAP, pfn_to_page() is valid at
>> this point.
>>
>> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> CC: Dan Williams <dan.j.williams@intel.com>
>> ---
>>  mm/sparse.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/sparse.c b/mm/sparse.c
>> index b5da121bdd6e..56816f653588 100644
>> --- a/mm/sparse.c
>> +++ b/mm/sparse.c
>> @@ -888,7 +888,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>>         /* Align memmap to section boundary in the subsection case */
>>         if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) &&
>>                 section_nr_to_pfn(section_nr) != start_pfn)
>> -               memmap = pfn_to_kaddr(section_nr_to_pfn(section_nr));
>> +               memmap = pfn_to_page(section_nr_to_pfn(section_nr));
>
>Yes, this looks obviously correct. This might be tripping up
>makedumpfile. Do you see any practical effects of this bug? The kernel
>mostly avoids ->section_mem_map in the vmemmap case and in the
>!vmemmap case section_nr_to_pfn(section_nr) should always equal
>start_pfn.

I took another look into the code. Looks there is no practical effect after
this. Because in the vmemmap case, we don't need ->section_mem_map to retrieve
the real memmap.

But leave a inconsistent data in section_mem_map is not a good practice.

-- 
Wei Yang
Help you, Help me
