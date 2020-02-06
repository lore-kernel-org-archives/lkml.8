Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E16C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E16922464
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgBFJEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 04:04:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:44876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgBFJEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 04:04:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0B3A3ADC2;
        Thu,  6 Feb 2020 09:04:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6B79A1E0E31; Thu,  6 Feb 2020 10:04:36 +0100 (CET)
Date:   Thu, 6 Feb 2020 10:04:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        ira.weiny@intel.com, dan.j.williams@intel.com, jack@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm: mark a intentional data race in page_zonenum()
Message-ID: <20200206090436.GF14001@quack2.suse.cz>
References: <20200206035235.2537-1-cai@lca.pw>
 <480a7dde-f678-c07b-2231-4da8e0a38753@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <480a7dde-f678-c07b-2231-4da8e0a38753@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-02-20 20:50:34, John Hubbard wrote:
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
> Perhaps a clearer explanation is that the read of the page flags is
> always looking at a bit range (zone number: up to 3 bits) that is not
> being written to by the writer.

Well, that's not quite true because we do store full long there. You're
right that we do that with cmpxchg() and modify only some bits in that word
but that may be too difficult for the sanitizer to find out.

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

So in this particular case, store tearing is non-issue because we use
atomic operation to store the value in page_cpupid_xchg_last(). I think it
would make some sense to use READ_ONCE(page->flags) here to prevent
compiler from loading page->flags several times - I have hard time finding
a reason why a compiler would want to do that but conceptually that
protection makes sense, it is for free performance wise, and will still
allow KCSAN to find a race in case we ever grow a place that modifies
page's zone non-atomically (which might be a real problem). And it should
also silence the KCSAN warning AFAIU.

								Honza
--
Jan Kara <jack@suse.com>
SUSE Labs, CR
