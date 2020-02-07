Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467F5C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 16:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166ED21741
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 16:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="OlrtI16M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgBGQpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 11:45:09 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46083 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgBGQpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 11:45:09 -0500
Received: by mail-oi1-f196.google.com with SMTP id a22so2539638oid.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 08:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rIOuP/1Ysr2MuixCGeN5opf7BC+IIc7SOpxNoaJ25FU=;
        b=OlrtI16MC0ud/tLym/B8Vg0C2/zcuEAfJ6/hNyd5RIQM4tAjVNYb3zY1VSpb5/ZCUa
         kRPPVciTb4JZ43LXuOse1RpL1Y8rLZulnxdNpVMdqEDc3OxG9H0RWx/1IoitGDloRa+s
         0AeQuckcBFd5uC/gKLrLoWoXEbxO39XqIBPFYr4/M3k9Z2koBjgZV4PXWow4ZHY90wr+
         6INZJuHQpTK/jX4fS+Pua80XHY6aT7WA8UM/1YIMvts4JTvmA1TT5afQhWQj3ThnE7HG
         xD1nBbgcNpyQ3wpNd6KfDJA8g5wdyglKkvx+x1Lsg3Rxp6+gTJtexD5NRTuIff+V/Q3r
         YSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rIOuP/1Ysr2MuixCGeN5opf7BC+IIc7SOpxNoaJ25FU=;
        b=b7RMWTKCULn7H16cg7FErApFROv/KpTkGfONvLfyJp8sFOdbjyGi+5cUa7CtSM4052
         EE/hte45C7ySmljPEGjnd5FiBxBjLsdvU8WAAgOQUcEo71Rw2UvxqU7Ps9vbLLzvpxoj
         DMVimKpcUXp5BemlDO9Hvspj82YRdJuycxWRoO5C6wFQhD9lUMRLAdEi9UQ10vC/jG/f
         h+rY35Xzp/MJR/SFJfAxuE+JcA1bVzxhfZqKYmkc9E+t/Ozms8fe8vYnRt0j7WjvBD9e
         TNQeaK5KSqBi9rw10JIGOvQFlqUawgGzLcwfSUX/TLHLvNWfy/pngrCjwmo6oF5A0SLn
         9lvQ==
X-Gm-Message-State: APjAAAWxNbr5KyADmBeQg1qLlwLHsJlUCRGqsrmuCm4GHeifRfNEF+Ik
        2mM8CG5XTztiKVdJk1dsMD89TcYjxdiodwfkAbWZVQ==
X-Google-Smtp-Source: APXvYqxsMTWD5WBM7p8k2Cf41qlGp2RBbdRfszi0IrIxgyPD9ETBPv5usWBVIvnJUWaZ3/0IkPif6As8KKN61jxSHFU=
X-Received: by 2002:aca:aa0e:: with SMTP id t14mr2694999oie.149.1581093908242;
 Fri, 07 Feb 2020 08:45:08 -0800 (PST)
MIME-Version: 1.0
References: <20200206231629.14151-1-richardw.yang@linux.intel.com>
 <20200206231629.14151-3-richardw.yang@linux.intel.com> <CAPcyv4h7dKE85EQ9jR1akXnT6PcG2M2g7YCCLqse=kKieP1H9w@mail.gmail.com>
 <20200207031011.GR8965@MiWiFi-R3L-srv> <CAPcyv4jDVe-LZ5OqyV3wJ=7xcXsp5WEtf79fqFPTpRs5KcpA8g@mail.gmail.com>
 <20200207121453.pgi4axyvx6peqgeo@master>
In-Reply-To: <20200207121453.pgi4axyvx6peqgeo@master>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 7 Feb 2020 08:44:57 -0800
Message-ID: <CAPcyv4h=CRYjFK7AxmLX21B-AwmnAGL0=Vtp+a5PkLi63=KUKw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/sparsemem: get physical address to page struct
 instead of virtual address to pfn
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Baoquan He <bhe@redhat.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 7, 2020 at 4:15 AM Wei Yang <richard.weiyang@gmail.com> wrote:
>
> On Thu, Feb 06, 2020 at 07:21:49PM -0800, Dan Williams wrote:
> >On Thu, Feb 6, 2020 at 7:10 PM Baoquan He <bhe@redhat.com> wrote:
> >>
> >> Hi Dan,
> >>
> >> On 02/06/20 at 06:19pm, Dan Williams wrote:
> >> > On Thu, Feb 6, 2020 at 3:17 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
> >> > > diff --git a/mm/sparse.c b/mm/sparse.c
> >> > > index b5da121bdd6e..56816f653588 100644
> >> > > --- a/mm/sparse.c
> >> > > +++ b/mm/sparse.c
> >> > > @@ -888,7 +888,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
> >> > >         /* Align memmap to section boundary in the subsection case */
> >> > >         if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) &&
> >> > >                 section_nr_to_pfn(section_nr) != start_pfn)
> >> > > -               memmap = pfn_to_kaddr(section_nr_to_pfn(section_nr));
> >> > > +               memmap = pfn_to_page(section_nr_to_pfn(section_nr));
> >> >
> >> > Yes, this looks obviously correct. This might be tripping up
> >> > makedumpfile. Do you see any practical effects of this bug? The kernel
> >> > mostly avoids ->section_mem_map in the vmemmap case and in the
> >> > !vmemmap case section_nr_to_pfn(section_nr) should always equal
> >> > start_pfn.
> >>
> >> The practical effects is that the memmap for the first unaligned section will be lost
> >> when destroy namespace to hot remove it. Because we encode the ->section_mem_map
> >> into mem_section, and get memmap from the related mem_section to free it in
> >> section_deactivate(). In fact in vmemmap, we don't need to encode the ->section_mem_map
> >> with memmap.
> >
> >Right, but can you actually trigger that in the SPARSEMEM_VMEMMAP=n case?
> >
> >> By the way, sub-section support is only valid in vmemmap case, right?
> >
> >Yes.
>
> Just one question from curiosity. Why we don't want sub-section for !vmemmap
> case? Because it will wast memory for memmap?

The effort and maintenance burden outweighs the benefit.
