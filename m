Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44966C2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 04:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C922051A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 04:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="1rL8Wdo/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgBGEFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 23:05:49 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38801 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGEFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 23:05:48 -0500
Received: by mail-oi1-f194.google.com with SMTP id l9so761462oii.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 20:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cpd417pmla8xBu1RjMHRvWNYHG4LX3DmsJ9QusfXKc4=;
        b=1rL8Wdo/5eIm7IoF28G2FUHnSYk0XpmnaHZzJWrYUvY+Tm2f0F2zJmDp8CfFxmEGjL
         pnzS70GtljKulQZGbhcBvJJDgkhx3+bap+isASnFzIpyrB26goh/03igzV1b6E24z7Dk
         dqujhitlEXnHYWPI5fuaWE7LiGvCTPzkoZGt845Ftzg09EelaKpXzZ4nClqujuskgQo2
         WZ0GK7DsHBhg+7naaIoaxKbDBpbNdFo3t0Ev43wfqgtoCjH9WQ/dtf+yqn2RCkqVQ1K+
         +yf8xQEAVnPTDNpdkee14SUSovbqXaDaO6mrt+ASppf/yP+pBtUai08+KOhDKtXbBTZR
         UD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cpd417pmla8xBu1RjMHRvWNYHG4LX3DmsJ9QusfXKc4=;
        b=AVSUvMOsUVHoAi7eyL2imd4fP5LuNZEOqdQ4NtW8ctiDDmC1X//BOaHSOSMQraMYdU
         3RJf3ixlkG/FW9WvyPs9XLvRM3fyHOmjTHeb+rTKpgroiGJpOTnqEl7+lMbEfDG1zAPT
         3pFhEajV+ALxrD/X7vHyFDxGU9ZFoKNfIo6Cx3009RQvrF5rUG0t4vAJDihI3ojRkted
         9o/s5iry93wRW1jTsA2qxIBlDcD/nIAsirtaYGnO8nSeelQ+P8q1VnZ6pfhpRtE0Cikc
         9g34C7ip4gpJJlmE4RVBWU7BbIrvUZfAWiOc2if2RQklXtj0uaIzDRYhJITvMKirm/wr
         n7OA==
X-Gm-Message-State: APjAAAVJxXO6MGL3UwETfY3EsltO62c1jTw0AOAphIAL57RKEpGOaBVE
        L6LstV9iMDxbSKgBBZruvSLKtYfK5zxlomtaT4JZbg==
X-Google-Smtp-Source: APXvYqzuD5vb2b4+PvPNDgqgs4e4BOi3l9N4zVUFZJyrhfz4FPZZX4melafcYP/sZMbIAT1KeYflNG9MIbAD8PIugU8=
X-Received: by 2002:a05:6808:a83:: with SMTP id q3mr850210oij.0.1581048348209;
 Thu, 06 Feb 2020 20:05:48 -0800 (PST)
MIME-Version: 1.0
References: <20200206231629.14151-1-richardw.yang@linux.intel.com>
 <20200206231629.14151-3-richardw.yang@linux.intel.com> <CAPcyv4h7dKE85EQ9jR1akXnT6PcG2M2g7YCCLqse=kKieP1H9w@mail.gmail.com>
 <20200207031011.GR8965@MiWiFi-R3L-srv> <CAPcyv4jDVe-LZ5OqyV3wJ=7xcXsp5WEtf79fqFPTpRs5KcpA8g@mail.gmail.com>
 <20200207033636.GS8965@MiWiFi-R3L-srv>
In-Reply-To: <20200207033636.GS8965@MiWiFi-R3L-srv>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 6 Feb 2020 20:05:36 -0800
Message-ID: <CAPcyv4i0uxkoKLtiLoGE8H7ECDE1QHj-DDb8eSYssFWsDEmOZg@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/sparsemem: get physical address to page struct
 instead of virtual address to pfn
To:     Baoquan He <bhe@redhat.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
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

On Thu, Feb 6, 2020 at 7:36 PM Baoquan He <bhe@redhat.com> wrote:
>
> On 02/06/20 at 07:21pm, Dan Williams wrote:
> > On Thu, Feb 6, 2020 at 7:10 PM Baoquan He <bhe@redhat.com> wrote:
> > >
> > > Hi Dan,
> > >
> > > On 02/06/20 at 06:19pm, Dan Williams wrote:
> > > > On Thu, Feb 6, 2020 at 3:17 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
> > > > > diff --git a/mm/sparse.c b/mm/sparse.c
> > > > > index b5da121bdd6e..56816f653588 100644
> > > > > --- a/mm/sparse.c
> > > > > +++ b/mm/sparse.c
> > > > > @@ -888,7 +888,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
> > > > >         /* Align memmap to section boundary in the subsection case */
> > > > >         if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) &&
> > > > >                 section_nr_to_pfn(section_nr) != start_pfn)
> > > > > -               memmap = pfn_to_kaddr(section_nr_to_pfn(section_nr));
> > > > > +               memmap = pfn_to_page(section_nr_to_pfn(section_nr));
> > > >
> > > > Yes, this looks obviously correct. This might be tripping up
> > > > makedumpfile. Do you see any practical effects of this bug? The kernel
> > > > mostly avoids ->section_mem_map in the vmemmap case and in the
> > > > !vmemmap case section_nr_to_pfn(section_nr) should always equal
> > > > start_pfn.
> > >
> > > The practical effects is that the memmap for the first unaligned section will be lost
> > > when destroy namespace to hot remove it. Because we encode the ->section_mem_map
> > > into mem_section, and get memmap from the related mem_section to free it in
> > > section_deactivate(). In fact in vmemmap, we don't need to encode the ->section_mem_map
> > > with memmap.
> >
> > Right, but can you actually trigger that in the SPARSEMEM_VMEMMAP=n case?
>
> I think no, the lost memmap should only happen in vmemmap case.
>
> >
> > > By the way, sub-section support is only valid in vmemmap case, right?
> >
> > Yes.
> >
> > > Seems yes from code, but I don't find any document to prove it.
> >
> > check_pfn_span() enforces this requirement.
>
> Thanks for your confirmation. Do you mind if I add some document
> sentences somewhere make clear this?
>

Sure, I'd be happy to review as well.
