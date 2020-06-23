Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859FCC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 612442078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEpjg0qA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387817AbgFWVsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387455AbgFWVsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:48:50 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40FDC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:48:49 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id ga4so252846ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gLCkBZXPIIeY1g45tslFWO+PD0hc5lFZOqXooZUlWH8=;
        b=PEpjg0qAPuLDlm5VvuUC6vrEb+6MoF8l1ACkYkcY2HqZwuoRNJMD27wb3HnDkODjtD
         7kFpHy0BcQB2/OzA0cK5kmQTwI7kcUCl0JmvygO04JK875rulDjnePGKwoj5JnrZnKb+
         ZjBmoLLWlGIZk7e19y2EEYvnIAHeQytiV1c+mF86BQpgvi5Zof6n4b3a3XpWN1YujICF
         TxQIIVKpvF/ldA5iEaPNRYG2kc84ZaWkO30cR9AOQ6GJcJ18KVDxU/sG006d4RdkMT2n
         hxkuTMg9n5Xe+jCG6LDOJrK7mqgBbra0811UUw7LXPpYU1ESywqo+8/7QWdTOi9s07wT
         5RJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=gLCkBZXPIIeY1g45tslFWO+PD0hc5lFZOqXooZUlWH8=;
        b=tPzx4ks+zhTutBe/khrEl0q+C3ysy/INopNYNQXyjEcEGIKhq84EFKNzUP7ZeOZdhe
         6oa98hf+rSW39afcAcaEqWmjY93iZZvcOYLvhY6jhgGcTmJfeo0IIVK6sYOJqXYZDNf/
         MFkJ/+2ZdQlMgiaBofRcFnDnWuQ285fZpRtEX2Z/vMqxHgAPwPkW/vEtccWtmSnRmjz4
         WxMioGr6Y9OSeklgVrG7TSVeWJDkkCf9k9umc57dTSnwkQWbq+nxMJ7ETp8Jb5dH+xjd
         mthkNLG1ItJQuMFdSnfKonAAtCT9ZIrgV0f8Cviv/vhsXPVW1vJEysPeMNwC4xXvLsea
         PEZA==
X-Gm-Message-State: AOAM530tdn6mE12ztLjnpXGM//OC0aBcgWMMJ3B0hZ3k+E8WiDKOLbOq
        bDdfEdCegTx05oFL5xjAD/g=
X-Google-Smtp-Source: ABdhPJw15qKPA9jiRqrXuvtFIf8OYknB0rJ/6/dEZugcibFXL/7u/an+N7nb53QagI73h87/pd0zIA==
X-Received: by 2002:a17:906:4989:: with SMTP id p9mr23153743eju.417.1592948928712;
        Tue, 23 Jun 2020 14:48:48 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id j16sm15428301edp.35.2020.06.23.14.48.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jun 2020 14:48:47 -0700 (PDT)
Date:   Tue, 23 Jun 2020 21:48:47 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org, osalvador@suse.de,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, david@redhat.com
Subject: Re: [PATCH] mm/spase: never partially remove memmap for early section
Message-ID: <20200623214847.fggchont44kgmvs6@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200623094258.6705-1-richard.weiyang@linux.alibaba.com>
 <20200623151828.GA31426@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623151828.GA31426@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 05:18:28PM +0200, Michal Hocko wrote:
>On Tue 23-06-20 17:42:58, Wei Yang wrote:
>> For early sections, we assumes its memmap will never be partially
>> removed. But current behavior breaks this.
>> 
>> Let's correct it.
>> 
>> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>
>Can a user trigger this or is this a theoretical bug?
>

I don't expect to have a non-section aligned system, so this is a theoretical
bug to me.

>> ---
>>  mm/sparse.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/mm/sparse.c b/mm/sparse.c
>> index b2b9a3e34696..1a0069f492f5 100644
>> --- a/mm/sparse.c
>> +++ b/mm/sparse.c
>> @@ -825,10 +825,10 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>>  		ms->section_mem_map &= ~SECTION_HAS_MEM_MAP;
>>  	}
>>  
>> -	if (section_is_early && memmap)
>> -		free_map_bootmem(memmap);
>> -	else
>> +	if (!section_is_early)
>
>This begs a comment.
>

Like:

    /* Only depopulate sub-section memmap for non early section. */

Looks good to you?

>>  		depopulate_section_memmap(pfn, nr_pages, altmap);
>> +	else if (memmap)
>> +		free_map_bootmem(memmap);
>>  
>>  	if (empty)
>>  		ms->section_mem_map = (unsigned long)NULL;
>> -- 
>> 2.20.1 (Apple Git-117)
>> 
>
>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
