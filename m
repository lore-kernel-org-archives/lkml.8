Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D750C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1171520720
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8bpL4uv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgBGLNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 06:13:40 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34668 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGLNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 06:13:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id s144so2953090wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 03:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QknLuFso+EjeVasobDT6tf+o7TVotTuV29a6UTTUovA=;
        b=N8bpL4uv0++S1xr0+cesInouAUzyHeV96mNcy+kpei91X8w8zcqO8DNewaAByyIQjt
         yVLDIA9UQ9Q4hCJ2anN7XdtkCHytHOp6tMTB7h5g9gkvqNKp82ayg6EpQFehNN397ihL
         M8oIDy6JYf9ZDQlJjbR+cel4AdFW2GjPMF3QhaOUpXokd0lPBmgP5QAxrU2+2et8NCCf
         O9RfZDq/FcziEKaCnSt+lZ/opPjAoMpp9ut82QxwEqQh7QlYadhs2OxZc0gYV2tFsqu7
         VjDFLouHpmQO5pKo3glOAzSClGa7RDVUrj/iR2A1XJdWF3U/QX00XwmokgD5CkBjF8yT
         nnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QknLuFso+EjeVasobDT6tf+o7TVotTuV29a6UTTUovA=;
        b=nZCmzjAXtygdajXOjkPXROQnYBUw3SZcAg6u9OE/5zoYK5OFOA8qMM3KVKB6xIj3u/
         u1C8ZzM8OPZ5yymoeHMkQKq57NjvLu5sfLsmDPb6Ot1LadU1mtQFi4+yhmibys2VSjRp
         JZRzYp1Uj2u60lR/6a/GCmh+w349DETK0dSQLDMwQFdyvTIh82yBW7kNzutb26xeu8nh
         Py+bXJw6PPPpd8vXub1QLTRVm603or3f2M0GR36kMbnUuThdXrScdErLU3eouU4WIpIA
         gILqLkZ7YcQ/u8SDkZLNn87IAnCgnDLwmVPjHzMjkj7w8ANgHfEZpRQTuCkZk5ENUVrb
         QB/Q==
X-Gm-Message-State: APjAAAW/eBNXPzfbSJaFY+Pf6KgP+Wyt3B5wRWH124MqNw5sF6aSutCJ
        J5gDhDTZS+XwU77CUuvR0EM=
X-Google-Smtp-Source: APXvYqzYRigbJrYG+TPi9gzBXAlpgwW5tXJ+db807JSjsO+hHYou47MN83jEUR047SO6LqTkgF4PGw==
X-Received: by 2002:a1c:9c87:: with SMTP id f129mr4054000wme.26.1581074017905;
        Fri, 07 Feb 2020 03:13:37 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a16sm2882233wrx.87.2020.02.07.03.13.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Feb 2020 03:13:37 -0800 (PST)
Date:   Fri, 7 Feb 2020 11:13:37 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 2/3] mm/sparsemem: get physical address to page struct
 instead of virtual address to pfn
Message-ID: <20200207111337.bqahz3ex65ggu2ri@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200206231629.14151-1-richardw.yang@linux.intel.com>
 <20200206231629.14151-3-richardw.yang@linux.intel.com>
 <CAPcyv4h7dKE85EQ9jR1akXnT6PcG2M2g7YCCLqse=kKieP1H9w@mail.gmail.com>
 <20200207031011.GR8965@MiWiFi-R3L-srv>
 <CAPcyv4jDVe-LZ5OqyV3wJ=7xcXsp5WEtf79fqFPTpRs5KcpA8g@mail.gmail.com>
 <20200207033636.GS8965@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207033636.GS8965@MiWiFi-R3L-srv>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 11:36:36AM +0800, Baoquan He wrote:
>On 02/06/20 at 07:21pm, Dan Williams wrote:
>> On Thu, Feb 6, 2020 at 7:10 PM Baoquan He <bhe@redhat.com> wrote:
>> >
>> > Hi Dan,
>> >
>> > On 02/06/20 at 06:19pm, Dan Williams wrote:
>> > > On Thu, Feb 6, 2020 at 3:17 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
>> > > > diff --git a/mm/sparse.c b/mm/sparse.c
>> > > > index b5da121bdd6e..56816f653588 100644
>> > > > --- a/mm/sparse.c
>> > > > +++ b/mm/sparse.c
>> > > > @@ -888,7 +888,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>> > > >         /* Align memmap to section boundary in the subsection case */
>> > > >         if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) &&
>> > > >                 section_nr_to_pfn(section_nr) != start_pfn)
>> > > > -               memmap = pfn_to_kaddr(section_nr_to_pfn(section_nr));
>> > > > +               memmap = pfn_to_page(section_nr_to_pfn(section_nr));
>> > >
>> > > Yes, this looks obviously correct. This might be tripping up
>> > > makedumpfile. Do you see any practical effects of this bug? The kernel
>> > > mostly avoids ->section_mem_map in the vmemmap case and in the
>> > > !vmemmap case section_nr_to_pfn(section_nr) should always equal
>> > > start_pfn.
>> >
>> > The practical effects is that the memmap for the first unaligned section will be lost
>> > when destroy namespace to hot remove it. Because we encode the ->section_mem_map
>> > into mem_section, and get memmap from the related mem_section to free it in
>> > section_deactivate(). In fact in vmemmap, we don't need to encode the ->section_mem_map
>> > with memmap.
>> 
>> Right, but can you actually trigger that in the SPARSEMEM_VMEMMAP=n case?
>
>I think no, the lost memmap should only happen in vmemmap case.
>
>> 
>> > By the way, sub-section support is only valid in vmemmap case, right?
>> 
>> Yes.
>> 
>> > Seems yes from code, but I don't find any document to prove it.
>> 
>> check_pfn_span() enforces this requirement.

I saw this function, but those combination of vmemmap and !vmemmap make my
brain not work properly.

>
>Thanks for your confirmation. Do you mind if I add some document
>sentences somewhere make clear this?

Thanks, hope this would help the future audience.


-- 
Wei Yang
Help you, Help me
