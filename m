Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2314FC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 02:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB062214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 02:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKFrqDsj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgBFC0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 21:26:48 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38175 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgBFC0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 21:26:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so5260926wrh.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 18:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+zyZWPUkPVNFFY3hh4hIyv4aMVD0rm8A2cdK0RoicIE=;
        b=cKFrqDsjIr1tl3iYOfd8i5N+6WGzExpQt1zEZE4gvoGS50mQCgSgyZWyjH3eOkzKo9
         RDZJ7NGW4fHobWlOyv+mw9wMyrPzJ0l2M/Tr9bUZnsDU3sOw8hSExu6gSVFJ+/naExPa
         3j+vXynaLBvNZWqGR5zWPtemWPE/G90t0fdbH08FGxXrjOHcGTcoWb6pVVgAsanK0U1O
         nNLMye7+70Jq5JwQ1B5n7GC/BSQhlnC+UxpgsGw6P6YeCoCrJiDuqFpIlIV1WQcMupxm
         OP/bVGVx5o9J10VeIrGC4WNueyE97I5ze8BTnGKxwzLnX+nTIB/Ts+PumcdStVqzFw27
         k5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+zyZWPUkPVNFFY3hh4hIyv4aMVD0rm8A2cdK0RoicIE=;
        b=sx0mE0dEllWj32HHHtmLPtSz98y5UfpmyxJSaWEXJqAwpazyeh7c09O5TuLxvTtRq3
         3ulyKdWwC7zlI1pTLfUwhDd4Sb3cpwh4cAr830cJ/Cp5iSoqYQeL+4XRLAmXdjLvI6WE
         eJ8ET+rbnIjfHAUR5v+gfRO3K3wFiVUjDH2lbuItb3CyeHY7EdTegMm3O5vLY1DrVxPT
         nO+oz9NbyloUY2TsR/n+GoV76BVmY1zRh5r6U2kHwglt1PTyinQC3DqX7Kg8SsNZZ4g2
         6mTkVzegztFeppqISW3zvkeIta2y8LtRSG9LCjOg//wU9EujrKGk2e0hPWUE/g8lBXfh
         Cxvg==
X-Gm-Message-State: APjAAAXoDDUDpvxhzLTeA7KvKzr3qeNmWXbUfzi4AaoKc2rEc0Pdp6lO
        w1LJt2CxAsfHdeRTRPpoC7o=
X-Google-Smtp-Source: APXvYqxPkWZV7sd4ISuJQkqpONwJExPC3C4PjxmS7dKJsknBYSqhu5M7+AwEwYv5/9+Y33VJrUXPNg==
X-Received: by 2002:a5d:4052:: with SMTP id w18mr707506wrp.112.1580956005652;
        Wed, 05 Feb 2020 18:26:45 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id c13sm2396166wrx.9.2020.02.05.18.26.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Feb 2020 18:26:44 -0800 (PST)
Date:   Thu, 6 Feb 2020 02:26:44 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1] mm/memory_hotplug: Easier calculation to get pages to
 next section boundary
Message-ID: <20200206022644.6u7pxf7by2w5trmi@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200205135251.37488-1-david@redhat.com>
 <20200205231945.GB28446@richard>
 <20200205235007.GA28870@richard>
 <20200206001317.GH8965@MiWiFi-R3L-srv>
 <20200206003736.GI8965@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206003736.GI8965@MiWiFi-R3L-srv>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 08:37:36AM +0800, Baoquan He wrote:
>On 02/06/20 at 08:13am, Baoquan He wrote:
>> On 02/06/20 at 07:50am, Wei Yang wrote:
>> > On Thu, Feb 06, 2020 at 07:19:45AM +0800, Wei Yang wrote:
>> > >On Wed, Feb 05, 2020 at 02:52:51PM +0100, David Hildenbrand wrote:
>> > >>Let's use a calculation that's easier to understand and calculates the
>> > >>same result. Reusing existing macros makes this look nicer.
>> > >>
>> > >>We always want to have the number of pages (> 0) to the next section
>> > >>boundary, starting from the current pfn.
>> > >>
>> > >>Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
>> > >>Cc: Andrew Morton <akpm@linux-foundation.org>
>> > >>Cc: Michal Hocko <mhocko@kernel.org>
>> > >>Cc: Oscar Salvador <osalvador@suse.de>
>> > >>Cc: Baoquan He <bhe@redhat.com>
>> > >>Cc: Wei Yang <richardw.yang@linux.intel.com>
>> > >>Signed-off-by: David Hildenbrand <david@redhat.com>
>> > >
>> > >Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
>> > >
>> > >BTW, I got one question about hotplug size requirement.
>> > >
>> > >I thought the hotplug range should be section size aligned, while taking a
>> > >look into current code function check_hotplug_memory_range() guard the range.
>> 
>> A good question. The current code should be block size aligned. I
>> remember in some places we assume each block comprise all the sections.
>> Can't imagine one or some of them are half section filled.
>
>I could be wrong, half filled block may not cause problem. 
>

David must be angry about our flooding the mail list :-)

Check the code again, there are two memory range check:

  * check_hotplug_memory_range(), block/section aligned
  * check_pfn_span(), subsection aligned

The second check, check_pfn_span() in __add_pages(), enable the capability to
add a memory range with subsection size.

This means hotplug still keeps section alignment.

BTW, __add_pages() share the same logic as __remove_pages(). Why not change it
too? Do I miss something or I don't have the latest source code?

-- 
Wei Yang
Help you, Help me
