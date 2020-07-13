Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01E5C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C265120771
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="shNHxqlE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgGMPm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 11:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730029AbgGMPmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 11:42:53 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041FBC08C5DE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 08:42:53 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w6so17736295ejq.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 08:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KYHsayQ+qnaeJrGEqb3AbWD3OCs6eDEgmK0sEjz5stk=;
        b=shNHxqlEshcLM+d6HS5/rUuF/G7IfTpZe/gUMK2OQCtYZavKPmFx9lPmSy+8XWB0KK
         35jBVVrUdNO+Jfvrrp+eIP/JvR08WY9U0DdkU6T89bTgCxQCuK1PVuWJIjGMTLjE8rE3
         XTJ5PHCfIDj2m3E204SFtns5sNa6dcgofuJWbiwgwOmwi0NipOUB6QrkLZ+DoEueqmMB
         PgWCgNO4So36JTX6IgokxC3NYAKVD194ZFfivEOk1MU5Ch8Hq+JnhQK68aoXqc58zKh0
         6H4qLbRrffd4vFYKWrXDmxbjRxZ7jEpY4zZCg4XrAX2YN8jpDHcMkBByyN832GpItPwM
         QGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KYHsayQ+qnaeJrGEqb3AbWD3OCs6eDEgmK0sEjz5stk=;
        b=WiNFarKIGmEr4dqvYq8IKTFFM3N+1JTwj3hh17V+Lebnhj5QcU7l/5045tCqWyWW4C
         b1zyvcNeTMPiGHPRaWyFCJ5w/uxRT/OtH1pBZbd0iO/x9x9Wp3Duu3juCz567fPPAZda
         zeR0GrZKcOXmSfnKwrwtefhXw0Pht5dSWYZALhiAebTBvd6Kx4sNntKawk5jbwKD1+af
         YJ6b8A4d6D6ZJ2lq7gT/UdRMy6xq1lMfqjB2PkmCLoYBB+Wss7Hy2Ywtee1PqCZEGugI
         xnWJhgK2HGSpFX68nA7ITwzBa96nAl0oy14QqqdJh8F4eQGLBhOFBDd/jKm7nN9A42eJ
         Smnw==
X-Gm-Message-State: AOAM530MAC3ebxS0NxWTNc/W3GmuOZdTmt8qTUIpHair9MmVKYy+pS8i
        RAlIIFZLd75n11yfWBs1MKRJwa+N5+g8Hgc/6yYRvOWQ
X-Google-Smtp-Source: ABdhPJxUImaKchQhePlG2M01YtnBmwJfKXSrMtOhR08dhoQCgRWcxaVYGh90/4tQIBcAr8wpwsrZSqeoZAyg7POGAfM=
X-Received: by 2002:a17:907:20af:: with SMTP id pw15mr393528ejb.204.1594654971733;
 Mon, 13 Jul 2020 08:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159457120334.754248.12908401960465408733.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200713065801.GB11000@linux.ibm.com>
In-Reply-To: <20200713065801.GB11000@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 13 Jul 2020 08:42:41 -0700
Message-ID: <CAPcyv4gBgCptZupxhzbDN3qscnuJ9HNWHHvfhH6z+z84VE1cPg@mail.gmail.com>
Subject: Re: [PATCH v2 07/22] numa: Introduce a generic memory_add_physaddr_to_nid()
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Jia He <justin.he@arm.com>, Will Deacon <will@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Joao Martins <joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 11:58 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> Hi Dan,
>
> On Sun, Jul 12, 2020 at 09:26:43AM -0700, Dan Williams wrote:
> > For architectures that opt into storing their numa data in memblock
> > (only ARM64 currently), add a memblock generic way to interrogate that
> > data for memory_add_physaddr_to_nid(). This requires ARCH_KEEP_MEMBLOCK
> > to keep memblock text and data around after boot.
>
> I afraid we are too far from using memblock as a generic placeholder for
> numa data. Although all architectures now have the numa info in
> memblock, only arm64 uses memblock as the primary source of that data.
>
> I'd rather prefer Jia's solution [1] to have a weak default for
> memory_add_physaddr_to_nid() and let architectures override it.

I'm ok with that as long as we do the same for phys_to_target_node().

Will had the concern about adding a generic numa-info facility the
last I tried this. I just don't see a practical way to get there in
the near term.
