Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0213DC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CB1227BF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgBFOzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 09:55:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:34950 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbgBFOzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 09:55:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 83D90ABF4;
        Thu,  6 Feb 2020 14:55:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D7FD31E0DEB; Thu,  6 Feb 2020 15:55:01 +0100 (CET)
Date:   Thu, 6 Feb 2020 15:55:01 +0100
From:   Jan Kara <jack@suse.cz>
To:     David Hildenbrand <david@redhat.com>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        jhubbard@nvidia.com, ira.weiny@intel.com, dan.j.williams@intel.com,
        jack@suse.cz, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix a data race in put_page()
Message-ID: <20200206145501.GD26114@quack2.suse.cz>
References: <1580995070-25139-1-git-send-email-cai@lca.pw>
 <86f8eade-f2a7-75c6-0de9-9029b3b8c1e8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86f8eade-f2a7-75c6-0de9-9029b3b8c1e8@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06-02-20 14:33:22, David Hildenbrand wrote:
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

I don't think the problem is real. The question is how to make KCSAN happy
in a way that doesn't silence other possibly useful things it can find and
also which makes it most obvious to the reader what's going on... IMHO
using READ_ONCE() fulfills these targets nicely - it is free
performance-wise in this case, it silences the checker without impacting
other races on page->flags, its kind of obvious we don't want the load torn
in this case so it makes sense to the reader (although a comment may be
nice).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
