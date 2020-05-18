Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8E8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC12A20657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387851AbgERS0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:26:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:27641 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728898AbgERS0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:26:32 -0400
IronPort-SDR: JyuzkzXPtPV3syQh/yWxnhYEqHF7SJGBqxRYvbOghJiNPbW+8x92L0GfZfkoo0epadsVzxP2fP
 yEMbiUVm27SQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 11:26:31 -0700
IronPort-SDR: EiDGEjtD5niwotAU58G4e/Ralcrx0+UnsF4cgXMSm0BivSD302e9Yg0i9/0jjpwnbzMdw/5d0Y
 pe1OKqDQvz/Q==
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="253135674"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 11:26:30 -0700
Date:   Mon, 18 May 2020 11:26:29 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jue Wang <juew@google.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/mm: Don't try to change poison pages to uncacheable
 in a guest
Message-ID: <20200518182629.GA2957@agluck-desk2.amr.corp.intel.com>
References: <20200516150229.GB19372@zn.tnic>
 <8022D1E6-A8BC-4610-9F58-67A06B9A9575@intel.com>
 <CAPcxDJ50pbuTbittyvPwKq1uUT8q8jJ+dHH8rCug8a1DDZXVYw@mail.gmail.com>
 <CAPcxDJ6f3pBpwiR9nvXN_g_HBa1RAMG+aOmgfXLFT6aZ9HQn3w@mail.gmail.com>
 <20200518134813.GC25034@zn.tnic>
 <20200518153625.GA31444@agluck-desk2.amr.corp.intel.com>
 <20200518165500.GD25034@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518165500.GD25034@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 06:55:00PM +0200, Borislav Petkov wrote:
> On Mon, May 18, 2020 at 08:36:25AM -0700, Luck, Tony wrote:
> > The VMM gets the page fault (because the unmapping of the guest
> > physical address is at the VMM EPT level).  The VMM can't map a new
> > page into that guest physical address because it has no way to
> > replace the contents of the old page.  The VMM could pass the #PF
> > to the guest, but that would just confuse the guest (its page tables
> > all say that the page is still valid). In this particular case the
> > page is part of the 1:1 kernel map. So the kernel will OOPS (I think).
> 
> ...
> 
> > PLease explain how a guest (that doesn't even know that it is a guest)
> > is going to figure out that the EPT tables (that it has no way to access)
> > have marked this page invalid in guest physical address space.
> 
> So somewhere BUS_MCEERR_AR was mentioned. So I'm assuming the error
> severity was "action required". What does happen in the kernel, on
> baremetal, with an AR error in kernel space, i.e., kernel memory?

Outside of the now infamous memcpy_mcsafe() any kernel consumption
of poison results in a panic as the mce_severity() code will trip
this case:

        MCESEV(
                PANIC, "Data load in unrecoverable area of kernel",
                SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR|MCACOD, MCI_UC_SAR|MCI_ADDR|MCACOD_DATA),
                KERNEL
                ),

> If we can't fixup the exception, we die.
> 
> So why should the guest behave any differently?

We don't see this particular problem on baremetal because a CLFLUSH
instruction isn't *consuming* data. It's just evicting things from
the cache to memory. So we reference the virtual address, which works
fine on baremetal because the kernel 1:1 map is still active. But in
the guest case the guest physical address has gone away. So we trap
to the VMM.

> Now, if you want for the guest to be more "robust" and handle that
> thing, fine. But then you'd need an explicit way to tell the guest
> kernel: "you've just had an MCE and I unmapped the page" so that the
> guest kernel can figure out what do to. Even if it means, to panic.
> 
> I.e., signal in an explicit way that EPT violation Jue is talking about
> in the other mail.
> 
> You can inject a #PF or better yet the *first* MCE which is being
> injected should say with a bit somehwere "I unmapped the address in
> m->addr". So that the guest kernel can handle that properly and know
> what *exactly* it is getting an MCE for.

That question only makes any sense if you know you are running as a
guest and that someone else has unmapped the address. It's a meaningless
question to ask if you are running bare metal. So we'd still have a check
for FEATURE_HYPERVISOR

> What I don't like is the "am I running as a guest" check. Because
> someone else would come later and say, err, I'm not virtualizing this
> portion of MCA either, lemme add another "am I guest" check.
> 
> Sure, it is a lot easier but when stuff like that starts spreading
> around in the MCE code, then we can just as well disable MCE when
> virtualized altogether. It would be a lot easier for everybody.

Maybe it isn't pretty. But I don't see another practical solution.

The VMM is doing exactly the right thing here. It should not trust
that the guest will behave and not touch the poison location again.
If/when the guest does touch the poison, the right action is
for the VMM to fake a new machine check to the guest.

Theoretlcally the VMM could decode the instruction that the guest
was trying to use on the poison page and decide "oh, this is that
weird case in Linux where it's just trying to CLFLUSH the page. I'll
just step the return IP past the CLFLUSH and let the guest continue".

But that doesn't sound at all reasonable to me (especially as the
next step is to realize that Linux is going to repeat that for every
cache line in the page, so you also want to VMM to fudge the register
contents to skip to the end of the loop and avoid another 63 VMEXITs).

N.B. Linux wants to switch the page to uncacheable so that in the
persistant memory case the filesytem code can continue to access
the other "blocks" in the page, rather than lose all of them. That's
futile in the case where the VMM took the whole 4K away. Maybe Dan
needs to think about the guest case too.

-Tony
