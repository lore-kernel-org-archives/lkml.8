Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DF7C7619D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 23:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972782465D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 23:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582156074;
	bh=mbaeW+r88KjheUsIl1WTzCrvEHuy4ZUe2qcfaQLZbWs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=MBTCE4hj86ppT88o2MePk27hKppiZyqc+P24z626ui8UFo9D0BKiWQOt0QBZsxpDT
	 ZOvUPEDzw4WwAXjxnCNtPfzYTqkYGkvhVBTYNUWe6BJl2rNG09II4utuZgmIAlba2w
	 /F91meIVILMrP4xgaDqcNUJ7y7avD8OVjLtPAwdo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgBSXrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 18:47:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:49698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbgBSXrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 18:47:53 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 910DE24656;
        Wed, 19 Feb 2020 23:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582156072;
        bh=mbaeW+r88KjheUsIl1WTzCrvEHuy4ZUe2qcfaQLZbWs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mHTgAVE0Is2l111GAs7w6Uvt8bMY2fBOu+n/NgR1ntTYp+sKgu+IQ9Bxo5vdW+icR
         oGJCqM1sqw4V4FCWn19FC5CGnT1d8/0nVxDTdiid4yBqIGCJ0BCilkoOXn6KWEVMv2
         OrmdHfLR0eL1qq0LmkelsjgPz33uG9TPO+fzY7KQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1E5563520BB6; Wed, 19 Feb 2020 15:47:52 -0800 (PST)
Date:   Wed, 19 Feb 2020 15:47:52 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, John Hubbard <jhubbard@nvidia.com>,
        elver@google.com, david@redhat.com, jack@suse.cz,
        ira.weiny@intel.com, dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] mm: annotate a data race in page_zonenum()
Message-ID: <20200219234752.GS2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1581619089-14472-1-git-send-email-cai@lca.pw>
 <c1b1b448-ec64-c245-896c-462c55d94b3b@nvidia.com>
 <1582149340.7365.103.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1582149340.7365.103.camel@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 04:55:40PM -0500, Qian Cai wrote:
> Andrew, since you had picked the similar one which also depends
> on ASSERT_EXCLUSIVE_*, can you pick up this patch as well?
> 
> On Thu, 2020-02-13 at 13:20 -0800, John Hubbard wrote:
> > On 2/13/20 10:38 AM, Qian Cai wrote:
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
> > 
> > 
> > Much cleaner, thanks to this new macro. You can add:
> > 
> > 
> >     Reviewed-by: John Hubbard <jhubbard@nvidia.com>

It looks like Andrew already pulled this one in, but let me know if
he drops it for whatever reason.

							Thanx, Paul
