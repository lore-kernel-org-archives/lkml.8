Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AF5C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 22:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CAF9222C2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 22:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="OsiUhUD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgB2Whn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 17:37:43 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40379 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbgB2Whn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 17:37:43 -0500
Received: by mail-oi1-f193.google.com with SMTP id j80so4641934oih.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 14:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vMgdrB1ihQCYAIbfFMzkiv3JHJetoGVM7PTi0q5ALmo=;
        b=OsiUhUD4bT1O7upbHwDuinmveawahmkCK+8PabYGyG4OgCvzVO2Y9gPARZOt8Q/czD
         +gKk4PjNad9Cr3uGC/89VvuVJcnJzMxJ6ySwmoXkUgS4Qbmfer8kAdJCtymsZ4N4Kisj
         xhsW4Trq+pLWIg+nu+GHlVmCRXyn51E/QSA0Axc54CrRDbWXQQuvdO5+eE5LbwM4gEdp
         uF4zuIbpl+wi5BquzuZ+DBrW3+oz59DM54WqcTU+Q4EjA/hE6ZkxGgQBfjmJzKNErQrc
         d4M1+ejrtFxlmMb9QI6A2Bvzid6CQiM91vKcAXrSOKEwClT+jdHfQPTQ7XCWj2cSd8Cg
         EVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vMgdrB1ihQCYAIbfFMzkiv3JHJetoGVM7PTi0q5ALmo=;
        b=QpRlHBnGOKdJwC2v45ss53UN/mbsZO/J0C6I1N/sMSsG2DoIp4UCXNeVZ/qSGC00WQ
         eQeTZoLJ4H9SFdMbO2ykZJm2Aq8lDMGbs0RhGZTMPqj0Vf88WjAukQ4hmnL1qMzFUO6/
         56vGfCWpCdpvsktl8ijoy/rbY7/GiYe7POl2zKWvQz01AswMDwDy+SRB5KAeAQOSPDov
         /TMDEINnrTyRhQh/3Er0rs4dcPoeXOdcpostzCct4VpBPWgvFPz7JviUK6YEPHuMPplZ
         W8c9n7jYDbJIwtHeCHtjjLiYeKv6yFJOlhnHB+//0Qymz1Wb9WYCCp9ca7YHiWyjpAJc
         NUKw==
X-Gm-Message-State: APjAAAX/bVvZ7Lzn9RYcw3fwOHbHgmDTqVsfLFQKsSN5hVL2dQM7NieL
        Z56DGwveRepC36jIQ8F3gYw6m5eUNflBR12uDubtzg==
X-Google-Smtp-Source: APXvYqzG75KD/D3fDhylY7WK/HGO2n1t1MkOMUt0WzVJixm4DCk6JJ0g5eYvnxnmvSeOxw028BqGSEKkK+YHNuO1FGI=
X-Received: by 2002:a54:4098:: with SMTP id i24mr5511480oii.149.1583015862617;
 Sat, 29 Feb 2020 14:37:42 -0800 (PST)
MIME-Version: 1.0
References: <20200221182503.28317-1-logang@deltatee.com> <20200221182503.28317-4-logang@deltatee.com>
In-Reply-To: <20200221182503.28317-4-logang@deltatee.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 29 Feb 2020 14:37:31 -0800
Message-ID: <CAPcyv4ici3h_C_c+9eapcehq+Lg3cabkq3n3XXvbSg=qUrJLgQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] x86/mm: Thread pgprot_t through init_memory_mapping()
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Eric Badger <ebadger@gigaio.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 10:25 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
> In prepartion to support a pgprot_t argument for arch_add_memory().
>
> It's required to move the prototype of init_memory_mapping() seeing
> the original location came before the definition of pgprot_t.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Looks good, checked for argument confusion, passes the nvdimm unit tests.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
