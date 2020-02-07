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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2341FC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 12:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF9B20838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 12:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZW0vVT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgBGMO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 07:14:58 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46320 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgBGMO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 07:14:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so2377709wrl.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 04:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D+DJ3MiV/rAwduMcYLUzMxxDEjOIvkp9prmU1gHjEWI=;
        b=EZW0vVT/8ToglsskcvB7pO/NK/uGzBxoZFPvWQwkUOpSUBe6+BTaL27aLeRY7TzBOd
         oDISQbFTS93cmfBmWo8eUwPN3PWSP0kC0GDNvfUaGziNAoN6lc/AELr41KV6HQIHqCBc
         JIEmXiZIfUDNUx5mPqKZVGTCmXIHbOIanuS+i6QnxSAK+X5Mg830zPZg56BbFDkpYE+k
         B8wlLl8FdHn1CWZV2hXWLmeiNeBPYOquQ8L0OUKHVIeahpE/aoWCO0sLx6vskGsM99SH
         Wk5tvPOykdJHURYkNgVIebtbEzeq+N2PNJsF+/fmBTWEvH9NGsJqqH8XSLqpn+vIw4Xx
         GLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=D+DJ3MiV/rAwduMcYLUzMxxDEjOIvkp9prmU1gHjEWI=;
        b=HnF0o3sKFE3IrUH14pXIp9+3oKtEl567GhPXXuFYQpWY8KqmIFkmUFvOiA8FqparBA
         isy1vikwmCyt9bt3VP048XuLsjIATQbX2ZCNH7/TeOuS+cieQDQF6sHNy8X9njmboh3q
         vxhGu6tfgSCZG3pxrQ6+8tM1UgnUGHuZrTKl7nToQv4g6wJVpRwI4T99+uNk227zPP8J
         IYFujv0Q2hZECI2qzcOmQlraSXZC5uNJ4VJ2Alq+7YuQ4NkMIjVlNDVBguhXPFZ2lONk
         m8WiC/Z5J0kaIkO+aKxoRI+lPYCGZsCDoWaGNUokaTeqaC4NnvzBDfgpGzav2/TvliBt
         23Ow==
X-Gm-Message-State: APjAAAXbFkAF9Yw46CmrwONfwdLfOfwEjtye8mXSF1P0fU/9ofxQDzRn
        FWfLGKeW3hUo23t6wRY2mpQ=
X-Google-Smtp-Source: APXvYqyf7afUCNAQVdJ5niEs/j9rjlttWxI0pheKOqKFQUqprZM6nczwXNDpeTOK5useb0g24hJVdw==
X-Received: by 2002:adf:c54e:: with SMTP id s14mr4271269wrf.385.1581077694469;
        Fri, 07 Feb 2020 04:14:54 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id y12sm3175421wmj.6.2020.02.07.04.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Feb 2020 04:14:53 -0800 (PST)
Date:   Fri, 7 Feb 2020 12:14:53 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Baoquan He <bhe@redhat.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 2/3] mm/sparsemem: get physical address to page struct
 instead of virtual address to pfn
Message-ID: <20200207121453.pgi4axyvx6peqgeo@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200206231629.14151-1-richardw.yang@linux.intel.com>
 <20200206231629.14151-3-richardw.yang@linux.intel.com>
 <CAPcyv4h7dKE85EQ9jR1akXnT6PcG2M2g7YCCLqse=kKieP1H9w@mail.gmail.com>
 <20200207031011.GR8965@MiWiFi-R3L-srv>
 <CAPcyv4jDVe-LZ5OqyV3wJ=7xcXsp5WEtf79fqFPTpRs5KcpA8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jDVe-LZ5OqyV3wJ=7xcXsp5WEtf79fqFPTpRs5KcpA8g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 07:21:49PM -0800, Dan Williams wrote:
>On Thu, Feb 6, 2020 at 7:10 PM Baoquan He <bhe@redhat.com> wrote:
>>
>> Hi Dan,
>>
>> On 02/06/20 at 06:19pm, Dan Williams wrote:
>> > On Thu, Feb 6, 2020 at 3:17 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
>> > > diff --git a/mm/sparse.c b/mm/sparse.c
>> > > index b5da121bdd6e..56816f653588 100644
>> > > --- a/mm/sparse.c
>> > > +++ b/mm/sparse.c
>> > > @@ -888,7 +888,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>> > >         /* Align memmap to section boundary in the subsection case */
>> > >         if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) &&
>> > >                 section_nr_to_pfn(section_nr) != start_pfn)
>> > > -               memmap = pfn_to_kaddr(section_nr_to_pfn(section_nr));
>> > > +               memmap = pfn_to_page(section_nr_to_pfn(section_nr));
>> >
>> > Yes, this looks obviously correct. This might be tripping up
>> > makedumpfile. Do you see any practical effects of this bug? The kernel
>> > mostly avoids ->section_mem_map in the vmemmap case and in the
>> > !vmemmap case section_nr_to_pfn(section_nr) should always equal
>> > start_pfn.
>>
>> The practical effects is that the memmap for the first unaligned section will be lost
>> when destroy namespace to hot remove it. Because we encode the ->section_mem_map
>> into mem_section, and get memmap from the related mem_section to free it in
>> section_deactivate(). In fact in vmemmap, we don't need to encode the ->section_mem_map
>> with memmap.
>
>Right, but can you actually trigger that in the SPARSEMEM_VMEMMAP=n case?
>
>> By the way, sub-section support is only valid in vmemmap case, right?
>
>Yes.

Just one question from curiosity. Why we don't want sub-section for !vmemmap
case? Because it will wast memory for memmap?

>
>> Seems yes from code, but I don't find any document to prove it.
>
>check_pfn_span() enforces this requirement.

-- 
Wei Yang
Help you, Help me
