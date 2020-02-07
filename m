Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77550C35247
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 03:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39784222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 03:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="SRUwGOdt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgBGDWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 22:22:02 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44143 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgBGDWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 22:22:02 -0500
Received: by mail-ot1-f68.google.com with SMTP id h9so779791otj.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 19:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kxpaWa0+XSv/h0KyQxfmm1U0ZcFkiwyNbxIjpRoQTj8=;
        b=SRUwGOdtnBUCm1UeN6UybVy3HWKNJQYv6Cun4Q4qZ4+j6V03oVjWN+ymSfEBujs0Jo
         7OiWUOADGWcS9B4nBOQiVrk4Wcj4pDsdQcy+lB3+jE+AaVbpZ9O0PazxSc9Ew6Jd+OvV
         FlwuOTU11PQ9fwf3N/HIyV2V2KzDVCHZbix3wMtLMpCkov2cy30OPk9Y6B7fOZgbuF5L
         wVYAe1ncis6YsTzehBRjpFT9KJ2oTkTwMuoZwYGOKjh/1IUwyrGM/+KtXCJP9grQX80x
         pI0n47uRF9TyeMmOkxj+UGu6cpdsd2762wBnYL0+OD4PmrwufFBhVyLVRJL/OALFmil8
         GePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kxpaWa0+XSv/h0KyQxfmm1U0ZcFkiwyNbxIjpRoQTj8=;
        b=uKd9p7UOj3lgG5j6qV9nDNUobs9IYyYfBsPmARHJ/pRqOM4IE5eeZXH3w83bdBEuEh
         7XPjj6A4xFqFIr/c0h539LH+dDAaTjPog6k413gvRuoxMd9MUxYY9qeUTzJPZVssZmpt
         BvsnlJvHdIITpFdFh5gaXZfaa2FJtcXZwyBs1yuhmLKSh7Xb+aUjKW1XyXtLlxRNTb2M
         rOhn5m4j0nHr9lberubfgS5B1KkctbAaPuriAPJFhkAIkMrS9uENFKahFKattU7V/mhu
         DT12imdemKj11DLZ1NdKa4eYpw8MS5bXGO71pBS/IY+VNzMK82tY+mHifLVIH1/JChk7
         pPHg==
X-Gm-Message-State: APjAAAUI0QxfjDAriYh4a3XRgT85ZPWhY6psHABJR0BgaL0buwkK3kNr
        ua8Sg+NXx+ulNqe0mE2V/1kG+DOx60XwhjZ8JcAeCw==
X-Google-Smtp-Source: APXvYqycOOqZbrsrgZIHLorFMhqC8CHJBV/Sp+UA39PVezcTB0HsHMqFkMM4nfiqq41oArfHBA3eUly4UFh6/xuMF0o=
X-Received: by 2002:a9d:7852:: with SMTP id c18mr996969otm.247.1581045721063;
 Thu, 06 Feb 2020 19:22:01 -0800 (PST)
MIME-Version: 1.0
References: <20200206231629.14151-1-richardw.yang@linux.intel.com>
 <20200206231629.14151-3-richardw.yang@linux.intel.com> <CAPcyv4h7dKE85EQ9jR1akXnT6PcG2M2g7YCCLqse=kKieP1H9w@mail.gmail.com>
 <20200207031011.GR8965@MiWiFi-R3L-srv>
In-Reply-To: <20200207031011.GR8965@MiWiFi-R3L-srv>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 6 Feb 2020 19:21:49 -0800
Message-ID: <CAPcyv4jDVe-LZ5OqyV3wJ=7xcXsp5WEtf79fqFPTpRs5KcpA8g@mail.gmail.com>
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

On Thu, Feb 6, 2020 at 7:10 PM Baoquan He <bhe@redhat.com> wrote:
>
> Hi Dan,
>
> On 02/06/20 at 06:19pm, Dan Williams wrote:
> > On Thu, Feb 6, 2020 at 3:17 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
> > > diff --git a/mm/sparse.c b/mm/sparse.c
> > > index b5da121bdd6e..56816f653588 100644
> > > --- a/mm/sparse.c
> > > +++ b/mm/sparse.c
> > > @@ -888,7 +888,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
> > >         /* Align memmap to section boundary in the subsection case */
> > >         if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) &&
> > >                 section_nr_to_pfn(section_nr) != start_pfn)
> > > -               memmap = pfn_to_kaddr(section_nr_to_pfn(section_nr));
> > > +               memmap = pfn_to_page(section_nr_to_pfn(section_nr));
> >
> > Yes, this looks obviously correct. This might be tripping up
> > makedumpfile. Do you see any practical effects of this bug? The kernel
> > mostly avoids ->section_mem_map in the vmemmap case and in the
> > !vmemmap case section_nr_to_pfn(section_nr) should always equal
> > start_pfn.
>
> The practical effects is that the memmap for the first unaligned section will be lost
> when destroy namespace to hot remove it. Because we encode the ->section_mem_map
> into mem_section, and get memmap from the related mem_section to free it in
> section_deactivate(). In fact in vmemmap, we don't need to encode the ->section_mem_map
> with memmap.

Right, but can you actually trigger that in the SPARSEMEM_VMEMMAP=n case?

> By the way, sub-section support is only valid in vmemmap case, right?

Yes.

> Seems yes from code, but I don't find any document to prove it.

check_pfn_span() enforces this requirement.
