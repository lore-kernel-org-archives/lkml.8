Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF840C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2A4220735
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ikEqxcCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgHUSg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgHUSgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:36:08 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72906C061796
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:27:16 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id cq28so2226820edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=shQPOS/D8M4JXXfHHqbOPcw2UQKwykbpQIY4dcI2U7Y=;
        b=ikEqxcCd/y/+zxCU3xzhcSEWvCbwaJlbGlOLU2haz4TMsmbxrj69tC+ooBZKr1P46K
         Y/7oKiPoeLuokNW96KPRtAis1XU6MgYlKWUKvQfz8bSKiVBb67RiS0n0+HRUObc5MDsW
         Hr3XRWSkRsygWIu9BTIsi89UxDTlWl8Jx9e2TdeSI6TKHW9SjyD7428aN8ZO1JgSF/V0
         +Brg8zgjea9I5lp6ABFKyqv+3kw+5eJlt3SUzM8JbPrdtocIn8IqPjTZ6pdIonV414Jr
         hemzvtz9IMppAPXxjRI7BvSPqSEEqKaV80yw0+UV60kLQjbkHtoPrvueFGux9mlE+28a
         SxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=shQPOS/D8M4JXXfHHqbOPcw2UQKwykbpQIY4dcI2U7Y=;
        b=J1mikv1GQPfL5Phrdrp0miOMLYCd6yHjOLKxf31cxo+aDykYrrote3OClOx9X355Ts
         YXj0k8M6o41pgfpz6zUI7d45oSqHOyUroLKmS6EwJdEaxOgltH0sbQaAx4Iojx4tcVNS
         X2Se8eTNQ+eqrCgM+auD/Z4iSmaer4IXHun1cK4nNGhlfaWhZgJAX0UCweQdtsOW8Wj7
         KouL3vrtSk/cLCH5WKg2GbRReN7KTK8aEvsvH0hQt3SBOYlXLpF/Urw8T9TH9PTYgGrl
         7eYhcDTRWmxzBF6Uct3W/hJ8uIdhcwiYmoS04iEzC51l1ossZK7xLl4ZOpKMGYEJiI2N
         ZJYg==
X-Gm-Message-State: AOAM531AK4XppPbY1wJXGHxHtIKdQKFo0Cj7WiOCLcjRqTdnV7UVUuas
        Cf1MriW4VP4UBDf1mMDwqgqH3WY8lZWIajVy8vuqHQ==
X-Google-Smtp-Source: ABdhPJybztVE4gXLhNJ22ci71mCL3Z3O9B1wFb6gumUxHdS4tr+MkLUxFoeUsR3zIwYETLG65En3MWLdGKGctB6CK1k=
X-Received: by 2002:a05:6402:30a5:: with SMTP id df5mr4051980edb.18.1598034434104;
 Fri, 21 Aug 2020 11:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
 <c59111f9-7c94-8b9e-2b8c-4cb96b9aa848@redhat.com> <CAPcyv4j8-5nWU5GPDBoFicwR84qM=hWRtd78DkcCg4PW-8i6Vg@mail.gmail.com>
 <6af3de0d-ffdc-8942-3922-ebaeef20dd63@redhat.com>
In-Reply-To: <6af3de0d-ffdc-8942-3922-ebaeef20dd63@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 21 Aug 2020 11:27:02 -0700
Message-ID: <CAPcyv4h=oBnzmP2PHAFX6H2jsNq8zSUzQLYySj0Ke7FAqZwb0A@mail.gmail.com>
Subject: Re: [PATCH v4 00/23] device-dax: Support sub-dividing soft-reserved ranges
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        David Airlie <airlied@linux.ie>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jason Gunthorpe <jgg@mellanox.com>, Jia He <justin.he@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Jeff Moyer <jmoyer@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andy Lutomirski <luto@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 3:15 AM David Hildenbrand <david@redhat.com> wrote:
>
> >>
> >> 1. On x86-64, e820 indicates "soft-reserved" memory. This memory is not
> >> automatically used in the buddy during boot, but remains untouched
> >> (similar to pmem). But as it involves ACPI as well, it could also be
> >> used on arm64 (-e820), correct?
> >
> > Correct, arm64 also gets the EFI support for enumerating memory this
> > way. However, I would clarify that whether soft-reserved is given to
> > the buddy allocator by default or not is the kernel's policy choice,
> > "buddy-by-default" is ok and is what will happen anyways with older
> > kernels on platforms that enumerate a memory range this way.
>
> Is "soft-reserved" then the right terminology for that? It sounds very
> x86-64/e820 specific. Maybe a compressed for of "performance
> differentiated memory" might be a better fit to expose to user space, no?

No. The EFI "Specific Purpose" bit is an attribute independent of
e820, it's x86-Linux that entangles those together. There is no
requirement for platform firmware to use that designation even for
drastic performance differentiation between ranges, and conversely
there is no requirement that memory *with* that designation has any
performance difference compared to the default memory pool. So it
really is a reservation policy about a memory range to keep out of the
buddy allocator by default.

[..]
> > Both, but note that PMEM is already hard-reserved by default.
> > Soft-reserved is about a memory range that, for example, an
> > administrator may want to reserve 100% for a weather simulation where
> > if even a small amount of memory was stolen for the page cache the
> > application may not meet its performance targets. It could also be a
> > memory range that is so slow that only applications with higher
> > latency tolerances would be prepared to consume it.
> >
> > In other words the soft-reserved memory can be used to indicate memory
> > that is either too precious, or too slow for general purpose OS
> > allocations.
>
> Right, so actually performance-differentiated in any way :)

... or not differentiated at all which is Joao's use case for example.

[..]
> > Numa node numbers / are how performance differentiated memory ranges
> > are enumerated. The expectation is that all distinct performance
> > memory targets have unique ACPI proximity domains and Linux numa node
> > numbers as a result.
>
> Makes sense to me (although it's somehow weird, because memory of the
> same socket/node would be represented via different NUMA nodes), thanks!

Yes, numa ids as only physical socket identifiers is no longer a
reliable assumption since the introduction of the ACPI HMAT.
