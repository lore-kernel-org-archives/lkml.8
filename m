Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7E6C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC8421775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="biwqBwiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgBFOBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 09:01:25 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:32810 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgBFOBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 09:01:25 -0500
Received: by mail-qv1-f66.google.com with SMTP id z3so2894681qvn.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 06:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L9C8qzeLGecp6MibU+zz8IQnQpkCpPY0Z5NyRniIhZg=;
        b=biwqBwiM7hHH0dL9cRlaKCx4diR6R8gCGHdwBlsDVTGJqp9Yi2F3fL9gDACQqIhBaj
         +WUo9m6XaQqPuDmsrsuZzsVo1lxSJm4zdgZuYtACXk3Le6Pal3ILqrJ3fZmf74hf2BLA
         cmyO4Eec6zatppnKkaFeOmqhXCnM8K0wozXH19IoegYk661TaK2u87ahJyGKdsYx+iWo
         4ELNjteN+09ISZ49wF2Q1CSB1VQstJZt+bzLnwPoKrrGhnHGCArdp88VCKSwRBRMPKDx
         eq4979kHA8C/1hxC1bPSzuD8aq5vNxMH2rVANFuGmPq8XNGP1m2hVN1aQ9nDYIh9eod0
         8Gag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L9C8qzeLGecp6MibU+zz8IQnQpkCpPY0Z5NyRniIhZg=;
        b=K1GDryPsqFxX/F9dGbLCCraxJnzaP4O0nZbuBa9VCVW/Rou/xtPbibrT3WgeTgTzUi
         ODL9HmbNbYPS+p6a8UV2fclyE3UGS9Si5EcLe29hse8kmrTpX45s96gUmGj7LmcBa0Hi
         KmJiqPEVesJAAqWAzhWvdZgYOIOU9mBaLTSLf3afpxftEKPU5dpqLuE8vahWQacRVCtK
         pdX4qHQi5HNs+HGIBfCNddll1PS6ZWeXlNqiL/9F30hq6r+SJOFowFgkbh7P09amnKk7
         CugXMXmBpql+1cVjSAQgusDbpLQC6sPhGMnd0y9ArCsnfNXNYT8o75LqhGUgHUxi0DP5
         HseA==
X-Gm-Message-State: APjAAAUJdwelzQMx1NWCwDWtaFY31HLtBs+kXivx2JW18U7RKR1SytyY
        I93IHbfxTfVOSbNpavliRqSC/4awJWcrUQ==
X-Google-Smtp-Source: APXvYqx8L0U9nIMMo9Uz38/l0opNMUQCU9QBV9wOBlyte26vC9Frrj5Tc9qoWlSnmrV3cX6hl8dUrQ==
X-Received: by 2002:a05:6214:1150:: with SMTP id b16mr2444019qvt.71.1580997683177;
        Thu, 06 Feb 2020 06:01:23 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v78sm1485309qkb.48.2020.02.06.06.01.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Feb 2020 06:01:22 -0800 (PST)
Message-ID: <1580997681.7365.14.camel@lca.pw>
Subject: Re: [PATCH -next] mm: mark a intentional data race in page_zonenum()
From:   Qian Cai <cai@lca.pw>
To:     John Hubbard <jhubbard@nvidia.com>, akpm@linux-foundation.org
Cc:     ira.weiny@intel.com, dan.j.williams@intel.com, jack@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, elver@google.com
Date:   Thu, 06 Feb 2020 09:01:21 -0500
In-Reply-To: <480a7dde-f678-c07b-2231-4da8e0a38753@nvidia.com>
References: <20200206035235.2537-1-cai@lca.pw>
         <480a7dde-f678-c07b-2231-4da8e0a38753@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-02-05 at 20:50 -0800, John Hubbard wrote:
> On 2/5/20 7:52 PM, Qian Cai wrote:
> > The commit 07d802699528 ("mm: devmap: refactor 1-based refcounting for
> > ZONE_DEVICE pages") introduced a data race as page->flags could be
> 
> Hi,
> 
> I really don't think so. This "race" was there long before that commit.
> Anyway, more below:
> 
> > accessed concurrently as noticied by KCSAN,
> > 
> >   BUG: KCSAN: data-race in page_cpupid_xchg_last / put_page
> > 
> >   write (marked) to 0xfffffc0d48ec1a00 of 8 bytes by task 91442 on cpu 3:
> >    page_cpupid_xchg_last+0x51/0x80
> >    page_cpupid_xchg_last at mm/mmzone.c:109 (discriminator 11)
> >    wp_page_reuse+0x3e/0xc0
> >    wp_page_reuse at mm/memory.c:2453
> >    do_wp_page+0x472/0x7b0
> >    do_wp_page at mm/memory.c:2798
> >    __handle_mm_fault+0xcb0/0xd00
> >    handle_pte_fault at mm/memory.c:4049
> >    (inlined by) __handle_mm_fault at mm/memory.c:4163
> >    handle_mm_fault+0xfc/0x2f0
> >    handle_mm_fault at mm/memory.c:4200
> >    do_page_fault+0x263/0x6f9
> >    do_user_addr_fault at arch/x86/mm/fault.c:1465
> >    (inlined by) do_page_fault at arch/x86/mm/fault.c:1539
> >    page_fault+0x34/0x40
> > 
> >   read to 0xfffffc0d48ec1a00 of 8 bytes by task 94817 on cpu 69:
> >    put_page+0x15a/0x1f0
> >    page_zonenum at include/linux/mm.h:923
> >    (inlined by) is_zone_device_page at include/linux/mm.h:929
> >    (inlined by) page_is_devmap_managed at include/linux/mm.h:948
> >    (inlined by) put_page at include/linux/mm.h:1023
> >    wp_page_copy+0x571/0x930
> >    wp_page_copy at mm/memory.c:2615
> >    do_wp_page+0x107/0x7b0
> >    __handle_mm_fault+0xcb0/0xd00
> >    handle_mm_fault+0xfc/0x2f0
> >    do_page_fault+0x263/0x6f9
> >    page_fault+0x34/0x40
> > 
> >   Reported by Kernel Concurrency Sanitizer on:
> >   CPU: 69 PID: 94817 Comm: systemd-udevd Tainted: G        W  O L 5.5.0-next-20200204+ #6
> >   Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
> > 
> > Both the read and write are done only with the non-exclusive mmap_sem
> > held. Since the read only check for a specific bit in the flag, even if
> 
> 
> Perhaps a clearer explanation is that the read of the page flags is always
> looking at a bit range (zone number: up to 3 bits) that is not being written to by
> the writer.
> 
> 
> > load tearing happens, it will be harmless, so just mark it as an
> > intentional data races using the data_race() macro.
> > 
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> >   include/linux/mm.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 52269e56c514..cafccad584c2 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -920,7 +920,7 @@ vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf);
> >   
> >   static inline enum zone_type page_zonenum(const struct page *page)
> >   {
> > -	return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
> > +	return data_race((page->flags >> ZONES_PGSHIFT) & ZONES_MASK);
> 
> 
> I don't know about this. Lots of the kernel is written to do this sort
> of thing, and adding a load of "data_race()" everywhere is...well, I'm not
> sure if it's really the best way.  I wonder: could we maybe teach this
> kcsan thing to understand a few of the key idioms, particularly about page
> flags, instead of annotating all over the place?

My understanding is that it is rather difficult to change the compilers, but it
is a good question and I Cc Marco who is the maintainer for KCSAN that might
give you a definite answer.

