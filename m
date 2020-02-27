Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161DEC35DF9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3628246A3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="1wq4hmg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbgB0RzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:55:16 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40919 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730391AbgB0RzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 12:55:16 -0500
Received: by mail-ot1-f66.google.com with SMTP id a36so1050595otb.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 09:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DMctyA7z97eyN2JvDNB9L3xQr/YlQGTFBf3sd5NKHWU=;
        b=1wq4hmg+uAsjEl/wgmRZB+WY61SnT3Q8t2Ct2r2UbddVJTiMvdR+jHFO1VPZwWNFln
         3rf7Tc5G5oXeyVoTint/38zy/H44ulX2ua0wHcyBIAHpC8mnjJr+rgmv0kKGiGmqyyyr
         L6M2BuMpkX8f0mweKz2Xgkf0GCW6ovX4yeF9bZC9VhjnwB1aov3Vbyo9tNgTGFEZTlpn
         PFau6OyWaDUbHi1RUDFKRo6s3n/qIE7YDXlscTscoKY8uEYiod5jIcG4aTjleM2sHnlx
         XFPnIuU3sek8SyIYqhhO5bL63kPvhVttnFL+49NWXf0cP337y2MPHX0eDfh4FFNryDT5
         9niw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DMctyA7z97eyN2JvDNB9L3xQr/YlQGTFBf3sd5NKHWU=;
        b=QxdVlc4hCNSYJgCgx8NDA9VgT1tk+9x5hZtrGIFiY5ncgrdPtPEX4uGZ+Ygs0LFK4z
         9O24lErTHDAtI1tPGsJO4AOuYJ6XT5zzaajTXbDgWVFZmBxxU0iwmFkxJbTYGpHRZBcX
         hrbj5hhsZh2Lify2x8HIn1WgctvAgeUHCBLJWCkhSm0IKcghnGc20Wc48Qa7bNf/H1Sg
         EtoEyS+l/LL7ubxkiVOjpUQoCxAFgAq13zP3qGzPBhgWneeDDbF0TGYm3FLPlx7d0qq5
         4QGX46sCBSPaC3tUjUq94GgioDs67ARwDkrJLJJly1UTxFGBCNixSEALCWqzxOGwjHbB
         4OUQ==
X-Gm-Message-State: APjAAAUYyWiCn0wloZzaP21/W5vjWrhjVb8hWOvelQwDcUKt6arpHDaS
        E8OCn9vQOLEMV30caOYR0zzO7b89Op9WqLAzC+jMmw==
X-Google-Smtp-Source: APXvYqxdU0nvSDit1sUOCjKYz8qzZqWLce5r/cRVMP78amOH13agUjF/G5uzdRyMv/pxEr2rQ+w8GfXKV+Y/DRwCxOw=
X-Received: by 2002:a9d:6c9:: with SMTP id 67mr43495otx.363.1582826115418;
 Thu, 27 Feb 2020 09:55:15 -0800 (PST)
MIME-Version: 1.0
References: <20200221182503.28317-1-logang@deltatee.com> <20200227171704.GK31668@ziepe.ca>
 <e8781f85-3fc7-b9ce-c751-606803cbdc77@deltatee.com> <20200227174311.GL31668@ziepe.ca>
In-Reply-To: <20200227174311.GL31668@ziepe.ca>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 27 Feb 2020 09:55:04 -0800
Message-ID: <CAPcyv4iek=EmNk9JgXq=-HcZjd9Kz4m2+qXMhnDWMshFKFZPXQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Allow setting caching mode in arch_add_memory()
 for P2PDMA
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Badger <ebadger@gigaio.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 9:43 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Feb 27, 2020 at 10:21:50AM -0700, Logan Gunthorpe wrote:
> >
> >
> > On 2020-02-27 10:17 a.m., Jason Gunthorpe wrote:
> > >> Instead of this, this series proposes a change to arch_add_memory()
> > >> to take the pgprot required by the mapping which allows us to
> > >> explicitly set pagetable entries for P2PDMA memory to WC.
> > >
> > > Is there a particular reason why WC was selected here? I thought for
> > > the p2pdma cases there was no kernel user that touched the memory?
> >
> > Yes, that's correct. I choose WC here because the existing users are
> > registering memory blocks without side effects which fit the WC
> > semantics well.
>
> Hm, AFAIK WC memory is not compatible with the spinlocks/mutexs/etc in
> Linux, so while it is true the memory has no side effects, there would
> be surprising concurrency risks if anything in the kernel tried to
> write to it.
>
> Not compatible means the locks don't contain stores to WC memory the
> way you would expect. AFAIK on many CPUs extra barriers are required
> to keep WC stores ordered, the same way ARM already has extra barriers
> to keep UC stores ordered with locking..
>
> The spinlocks are defined to contain UC stores though.

How are spinlocks and mutexes getting into p2pdma ranges in the first
instance? Even with UC, the system has bigger problems if it's trying
to send bus locks targeting PCI, see the flurry of activity of trying
to trigger faults on split locks [1].

This does raise a question about separating the cacheability of the
'struct page' memmap from the BAR range. You get this for free if the
memmap is dynamically allocated from "System RAM", but perhaps
memremap_pages() should explicitly prevent altmap configurations that
try to place the map in PCI space?

> If there is no actual need today for WC I would suggest using UC as
> the default.

That's reasonable, but it still seems to be making a broken
configuration marginally less broken. I'd be more interested in
safeguards that prevent p2pdma mappings from being used for any cpu
atomic cycles.

[1]: https://lwn.net/Articles/784864/
