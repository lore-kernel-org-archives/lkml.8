Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2D9C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1B221775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="BjpOZIzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgBFNvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 08:51:38 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40601 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbgBFNvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 08:51:37 -0500
Received: by mail-qt1-f195.google.com with SMTP id v25so4488122qto.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 05:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uGZ4hGufkNPuJ0hP2u4TNpPXeNUVYk6Lnv9QB3zDm70=;
        b=BjpOZIzOlw2F1Ei4aOwJj8qBTnNeuiv+XJm1wvz+336D5+tcplAafPXFHt/8KYpOpK
         yYT0jTlf5oYH9OYEhVIVd/QbbZm0a5sTSem/Ethnv2V8iZPMejcPXmkkOKnyUhu5kNwn
         RYjg/L3kM34TTjOCLATVeyMnh5CoKSXAun+e3vB9s+dMqajAJZVvwsE0L01w1ebOLpaO
         /Slu0SYM+S3ym935L0GOIZoBJ56gDo9JDiiiANeIPFOgAe1d/BEiAKwNG2UGxQ5dT2ML
         ++4hb1OHivRuErBOlGqPFXB8DHBeE72hF5v/pyDeJ8NcW/i4WjIzaJPgcFkcf2dulanN
         BidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uGZ4hGufkNPuJ0hP2u4TNpPXeNUVYk6Lnv9QB3zDm70=;
        b=YeaMubfNplfl+SlAV5kFvFMWOkd7xZVX5zwngNjhE5Gq6RynDxIYID7msys+Ap9B6/
         k94b3Hyjgw1WFkpBNhdsCENOOUfjmgm3l/Z/Qz2OWaQEZy216tFTH6D2P+Dnq2klqNCm
         cdYR8YbKFwyEoblVJKQ3v/TNyy3o8/Gi19omNrAaVNJkHRcZfaYP6h1QNpYcDGYRQ3S9
         qUGXF5QoxBkqNU6pDsF2HEok6gev7xPHWwTwrgQl4ttd6Ee/B0Vl1PqAZZiuLec1aev9
         kqm405i7U4DtweaarWV8cRxbcuPOc7eNKKtTMTYA8axnaIALjDdAFbkvK1iaA9OC/41o
         Kk+A==
X-Gm-Message-State: APjAAAXD3UYyo1HVK7IRiQIx3PMkYmlVoD3Tlhrf4VI4yHj4rHkWyzL4
        yI0YXziJ8LAABHmeTMIQE5tAKQ==
X-Google-Smtp-Source: APXvYqyOcpuApH+bqdXXhxsdIGAfgJ25fR1CcCL67yIXv475MCVxwUg/9j4OLtGG1TaALvdaYGzaYA==
X-Received: by 2002:ac8:67d2:: with SMTP id r18mr2716247qtp.34.1580997096805;
        Thu, 06 Feb 2020 05:51:36 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o17sm1614057qtq.93.2020.02.06.05.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Feb 2020 05:51:36 -0800 (PST)
Message-ID: <1580997094.7365.11.camel@lca.pw>
Subject: Re: [PATCH] mm: fix a data race in put_page()
From:   Qian Cai <cai@lca.pw>
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc:     jhubbard@nvidia.com, ira.weiny@intel.com, dan.j.williams@intel.com,
        jack@suse.cz, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 06 Feb 2020 08:51:34 -0500
In-Reply-To: <86f8eade-f2a7-75c6-0de9-9029b3b8c1e8@redhat.com>
References: <1580995070-25139-1-git-send-email-cai@lca.pw>
         <86f8eade-f2a7-75c6-0de9-9029b3b8c1e8@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-02-06 at 14:33 +0100, David Hildenbrand wrote:
> On 06.02.20 14:17, Qian Cai wrote:
> > page->flags could be accessed concurrently as noticied by KCSAN,
> > 
> >  BUG: KCSAN: data-race in page_cpupid_xchg_last / put_page
> > 
> >  write (marked) to 0xfffffc0d48ec1a00 of 8 bytes by task 91442 on cpu 3:
> >   page_cpupid_xchg_last+0x51/0x80
> >   page_cpupid_xchg_last at mm/mmzone.c:109 (discriminator 11)
> >   wp_page_reuse+0x3e/0xc0
> >   wp_page_reuse at mm/memory.c:2453
> >   do_wp_page+0x472/0x7b0
> >   do_wp_page at mm/memory.c:2798
> >   __handle_mm_fault+0xcb0/0xd00
> >   handle_pte_fault at mm/memory.c:4049
> >   (inlined by) __handle_mm_fault at mm/memory.c:4163
> >   handle_mm_fault+0xfc/0x2f0
> >   handle_mm_fault at mm/memory.c:4200
> >   do_page_fault+0x263/0x6f9
> >   do_user_addr_fault at arch/x86/mm/fault.c:1465
> >   (inlined by) do_page_fault at arch/x86/mm/fault.c:1539
> >   page_fault+0x34/0x40
> > 
> >  read to 0xfffffc0d48ec1a00 of 8 bytes by task 94817 on cpu 69:
> >   put_page+0x15a/0x1f0
> >   page_zonenum at include/linux/mm.h:923
> >   (inlined by) is_zone_device_page at include/linux/mm.h:929
> >   (inlined by) page_is_devmap_managed at include/linux/mm.h:948
> >   (inlined by) put_page at include/linux/mm.h:1023
> >   wp_page_copy+0x571/0x930
> >   wp_page_copy at mm/memory.c:2615
> >   do_wp_page+0x107/0x7b0
> >   __handle_mm_fault+0xcb0/0xd00
> >   handle_mm_fault+0xfc/0x2f0
> >   do_page_fault+0x263/0x6f9
> >   page_fault+0x34/0x40
> > 
> >  Reported by Kernel Concurrency Sanitizer on:
> >  CPU: 69 PID: 94817 Comm: systemd-udevd Tainted: G        W  O L 5.5.0-next-20200204+ #6
> >  Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
> > 
> > Both the read and write are done only with the non-exclusive mmap_sem
> > held. Since the read will check for specific bits (up to three bits for
> > now) in the flag, load tearing could in theory trigger a logic bug.
> > 
> > To fix it, it could introduce put_page_lockless() in those places but
> > that could be an overkill, and difficult to use. Thus, just add
> > READ_ONCE() for the read in page_zonenum() for now where it should not
> > affect the performance and correctness with a small trade-off that
> > compilers might generate less efficient optimization in some places.
> > 
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> >  include/linux/mm.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 52269e56c514..f8529aa971c0 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -920,7 +920,7 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
> >  
> >  static inline enum zone_type page_zonenum(const struct page *page)
> >  {
> > -	return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
> > +	return (READ_ONCE(page->flags) >> ZONES_PGSHIFT) & ZONES_MASK;
> 
> I can understand why other bits/flags might change, but not the zone
> number? Nobody should be changing that without heavy locking (out of
> memory hot(un)plug code). Or am I missing something? Can load tearing
> actually produce an issue if these 3 bits will never change?
> 

I think you are right in this case that the writer page_cpupid_xchg_last() will
not change those 3 bits. I don't have an answer if other writers might race
here. Until someone could chime in probably from ZONE_DEVICE side to prove that
it otherwise, I'll just update the previous patch to mark it as a harmless data
race.
