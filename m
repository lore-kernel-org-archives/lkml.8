Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64765C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9B3246EB
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697065;
	bh=D484hfL1Ka1ychiwgumcKtTIXt+aZrJA0ykv8bHyOPc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=uotbhcBBR8wwasjnkc10Xn3cGVk267ECsUgGsUzCCYpDuZ+R66H4L2kq2UEsACmn+
	 2FTLCQQjrLWX8tdfta5FsOL5KSm/YUJzuDFc3kWgXmfNSKLd9D/QaICU3I0QQjcfsk
	 wnaFppboM9cmGTnQHkM8w05Zd2lrlbr59P/q3byQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404547AbgBNQRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:17:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:47622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392628AbgBNQQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:16:42 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [193.85.242.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE900206D7;
        Fri, 14 Feb 2020 16:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697002;
        bh=D484hfL1Ka1ychiwgumcKtTIXt+aZrJA0ykv8bHyOPc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=L1ZVQb4vN+H8w/KqSlEO0oiUdRh4uaSM9dr6HiLNvMZN6Qu3j3wrco258SdfPIfHq
         6O03JtS+nUwZkxe2mc2SLEOADy4uYeZg/OaXvjq/lO4kz0gw4ZoMZU4hOnchL+b81O
         eSRAfe882jqJMRc9ZpW9iOp0b8Dlzt9sTPyHkZKU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6D6103520CAA; Fri, 14 Feb 2020 08:16:39 -0800 (PST)
Date:   Fri, 14 Feb 2020 08:16:39 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, elver@google.com, david@redhat.com,
        jack@suse.cz, jhubbard@nvidia.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] mm: annotate a data race in page_zonenum()
Message-ID: <20200214161639.GR2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1581619089-14472-1-git-send-email-cai@lca.pw>
 <20200213192659.GJ2935@paulmck-ThinkPad-P72>
 <1581690626.7365.61.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581690626.7365.61.camel@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 09:30:26AM -0500, Qian Cai wrote:
> On Thu, 2020-02-13 at 11:26 -0800, Paul E. McKenney wrote:
> > On Thu, Feb 13, 2020 at 01:38:09PM -0500, Qian Cai wrote:
> > >  BUG: KCSAN: data-race in page_cpupid_xchg_last / put_page
> > > 
> > >  write (marked) to 0xfffffc0d48ec1a00 of 8 bytes by task 91442 on cpu 3:
> > >   page_cpupid_xchg_last+0x51/0x80
> > >   page_cpupid_xchg_last at mm/mmzone.c:109 (discriminator 11)
> > >   wp_page_reuse+0x3e/0xc0
> > >   wp_page_reuse at mm/memory.c:2453
> > >   do_wp_page+0x472/0x7b0
> > >   do_wp_page at mm/memory.c:2798
> > >   __handle_mm_fault+0xcb0/0xd00
> > >   handle_pte_fault at mm/memory.c:4049
> > >   (inlined by) __handle_mm_fault at mm/memory.c:4163
> > >   handle_mm_fault+0xfc/0x2f0
> > >   handle_mm_fault at mm/memory.c:4200
> > >   do_page_fault+0x263/0x6f9
> > >   do_user_addr_fault at arch/x86/mm/fault.c:1465
> > >   (inlined by) do_page_fault at arch/x86/mm/fault.c:1539
> > >   page_fault+0x34/0x40
> > > 
> > >  read to 0xfffffc0d48ec1a00 of 8 bytes by task 94817 on cpu 69:
> > >   put_page+0x15a/0x1f0
> > >   page_zonenum at include/linux/mm.h:923
> > >   (inlined by) is_zone_device_page at include/linux/mm.h:929
> > >   (inlined by) page_is_devmap_managed at include/linux/mm.h:948
> > >   (inlined by) put_page at include/linux/mm.h:1023
> > >   wp_page_copy+0x571/0x930
> > >   wp_page_copy at mm/memory.c:2615
> > >   do_wp_page+0x107/0x7b0
> > >   __handle_mm_fault+0xcb0/0xd00
> > >   handle_mm_fault+0xfc/0x2f0
> > >   do_page_fault+0x263/0x6f9
> > >   page_fault+0x34/0x40
> > > 
> > >  Reported by Kernel Concurrency Sanitizer on:
> > >  CPU: 69 PID: 94817 Comm: systemd-udevd Tainted: G        W  O L 5.5.0-next-20200204+ #6
> > >  Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
> > > 
> > > A page never changes its zone number. The zone number happens to be
> > > stored in the same word as other bits which are modified, but the zone
> > > number bits will never be modified by any other write, so it can accept
> > > a reload of the zone bits after an intervening write and it don't need
> > > to use READ_ONCE(). Thus, annotate this data race using
> > > ASSERT_EXCLUSIVE_BITS() to also assert that there are no concurrent
> > > writes to it.
> > > 
> > > Suggested-by: Marco Elver <elver@google.com>
> > > Signed-off-by: Qian Cai <cai@lca.pw>
> > > ---
> > > 
> > > v2: use ASSERT_EXCLUSIVE_BITS().
> > > 
> > > BTW, not sure if it is easier for Andrew with Paul to pick this up (with
> > > Andrew's ACK), since ASSERT_EXCLUSIVE_BITS() is in -rcu tree only (or likely
> > > tomorrow's -next tree).
> > 
> > Here are the options I know of, any of which work for me:
> > 
> > 1.	I take the patch given appropriate acks/reviews.
> > 
> > 2.	Someone hangs onto the patch until the KCSAN infrastructure
> > 	hits mainline and then sends it up via whatever path.
> > 
> > 3.	One way to do #2 is to merge the -rcu tree's "kcsan" branch and
> > 	then queue this patch on top of that, again sending this patch
> > 	along once KCSAN hits mainline.  Unusually for the -rcu tree,
> > 	the "kcsan" branch is not supposed to be rebased.
> > 
> > Either way, just let me know!
> 
> I suppose it is up to Andrew what he prefers. I may have another pile of patches
> depends on some of those KCSAN things (except the data_race() macro) are coming,
> so I'd like to find a way to get into -next first rather than waiting to send
> them in April (once KCSAN hit the mainline) if possible.

Any of the three options above would get you into -next quickly.

So just let me know how you would like to proceed.

							Thanx, Paul

> > >  include/linux/mm.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 52269e56c514..0d70fafd055c 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -920,6 +920,7 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
> > >  
> > >  static inline enum zone_type page_zonenum(const struct page *page)
> > >  {
> > > +	ASSERT_EXCLUSIVE_BITS(page->flags, ZONES_MASK << ZONES_PGSHIFT);
> > >  	return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
> > >  }
> > >  
> > > -- 
> > > 1.8.3.1
> > > 
