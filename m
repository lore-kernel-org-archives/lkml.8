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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6329FC352A4
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3966E206CC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tz59ekar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgBGKxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 05:53:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46762 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgBGKxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 05:53:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so2060470wrl.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 02:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IWNDGmY1e8M5D8JRbBopRmmoalFOAS1alYmUSyJzGYs=;
        b=tz59ekarYwIFCdZOORiDerp1hArIkcXN1iavOwu8ViH8ACOJx0DVWg0/G2bBnpkiQA
         IasrQSQKV9TCzTJvF+ECkaf1V2QwnHBnSW4oJUTfpKsDcR5PfCv3UUX715iyALqUi6iM
         1IE1FRS9waM1uyia96MIHRMTkJT7iSMGiHCWytp387OKJbT1aR/nPbX7j2Zeflk2lbRk
         cqpZwf0lc3v4wpmbdL6GOJjJnPv0mYFPfywmG/OubMti1OApCqHETK/SuGusxcgYfHU5
         b9t3RAjL6ID9FVfSYlNiAoTrg22Qze7SLcQ/4T62xO1da9ySB6RAuAo7wNbhZGsxJf6X
         LJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IWNDGmY1e8M5D8JRbBopRmmoalFOAS1alYmUSyJzGYs=;
        b=lLRhdf0vSwM0zrZo0IXDCsHDZDzmc8cS7HoGsHq/JrcXdkaZUvNQxrSbFWxzSPQPU2
         Hid8Xbb85XtN+bZ5vnW8VzGa5tvenwrLyQ4uCVIAKCQl069n08cJEgounWNCQet9z9di
         p5PTIeTYDd6cz/rwe6T1+wp8h14AjEjbehqk6Vey/OyPcSVID+2hfGXnI7yp+Q6DDfQJ
         I8qQnUwfmciLU+lVFR4q56fW7DVDrxqeHlF3WXwGInODwhD9xxcvPU2jbRiRnWJRQteF
         VzYmMTRqo4G6PlxektGftHCMuJ7l9QtxJv/irkHw7LsLNotTepC+GeIA8YYLnow0cjS0
         BaXg==
X-Gm-Message-State: APjAAAX5cGY8VZo66wNwZ/cXzwrZ81+4JIpZE+IwEpkdRDBdxVMX3n8G
        i/8SPFodDInJipK6U7cbKeI=
X-Google-Smtp-Source: APXvYqwO5sH1SiCp247j2q6M05PDiCnK7J7PeqJ3uenpIELW0ZSnWHY6saKZFwwAsFLwRkwHWox8aA==
X-Received: by 2002:adf:9b87:: with SMTP id d7mr4226967wrc.64.1581072795433;
        Fri, 07 Feb 2020 02:53:15 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id o15sm2883026wra.83.2020.02.07.02.53.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Feb 2020 02:53:15 -0800 (PST)
Date:   Fri, 7 Feb 2020 10:53:14 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, osalvador@suse.de,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, david@redhat.com
Subject: Re: [PATCH 2/3] mm/sparsemem: get physical address to page struct
 instead of virtual address to pfn
Message-ID: <20200207105314.axkvp4b5glm2snfw@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200206231629.14151-1-richardw.yang@linux.intel.com>
 <20200206231629.14151-3-richardw.yang@linux.intel.com>
 <20200207041134.GC25537@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207041134.GC25537@MiWiFi-R3L-srv>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 12:11:34PM +0800, Baoquan He wrote:
>On 02/07/20 at 07:16am, Wei Yang wrote:
>> memmap should be the physical address to page struct instead of virtual
>> address to pfn.
>
>Maybe not, memmap stores a virtual address.
>
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
>>  	/* Align memmap to section boundary in the subsection case */
>>  	if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) &&
>>  		section_nr_to_pfn(section_nr) != start_pfn)
>> -		memmap = pfn_to_kaddr(section_nr_to_pfn(section_nr));
>> +		memmap = pfn_to_page(section_nr_to_pfn(section_nr));
>
>With Dan's confirmation, sub-section is only valid in vmemmap case. I
>think the old if (section_nr_to_pfn(section_nr) != start_pfn) is enough
>to filter out non vmemmap case. So only below code is good:
>
> +		memmap = pfn_to_page(section_nr_to_pfn(section_nr));
>

You mean replace pfn_to_kaddr with pfn_to_page ?

>>  	sparse_init_one_section(ms, section_nr, memmap, ms->usage, 0);
>>  
>>  	return 0;
>> -- 
>> 2.17.1
>> 

-- 
Wei Yang
Help you, Help me
