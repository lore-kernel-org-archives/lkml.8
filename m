Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC2FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8B5720657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgERPg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 11:36:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:52584 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbgERPg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 11:36:27 -0400
IronPort-SDR: bIYnN5syGY37mgDMUMGYSoLdIsVJd3CcTXLjJ99yTjCslzcfxRhAt0TX6tfVQm6HZliWSFJLLs
 /sLYvpYN/6Gw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 08:36:26 -0700
IronPort-SDR: EBWpU7kI4FcX/FzZY338bkrsNFKTnEs31wopuXGl68VDrRTcdblCgkfGYPeTT3X90JkAU7RBz4
 A3a6I84EL+0w==
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="253093251"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 08:36:26 -0700
Date:   Mon, 18 May 2020 08:36:25 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jue Wang <juew@google.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/mm: Don't try to change poison pages to uncacheable
 in a guest
Message-ID: <20200518153625.GA31444@agluck-desk2.amr.corp.intel.com>
References: <20200516150229.GB19372@zn.tnic>
 <8022D1E6-A8BC-4610-9F58-67A06B9A9575@intel.com>
 <CAPcxDJ50pbuTbittyvPwKq1uUT8q8jJ+dHH8rCug8a1DDZXVYw@mail.gmail.com>
 <CAPcxDJ6f3pBpwiR9nvXN_g_HBa1RAMG+aOmgfXLFT6aZ9HQn3w@mail.gmail.com>
 <20200518134813.GC25034@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200518134813.GC25034@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 03:48:13PM +0200, Borislav Petkov wrote:
> Hi,
> 
> lemme try to reply to three emails at once.
> 
> First of all, the two of you: pls do not top-post.

Sorry. Phone e-mail client is dumb.

> On Sat, May 16, 2020 at 6:52 PM Luck, Tony <tony.luck@intel.com> wrote:
> > But the guest isn’t likely to do the right thing with a page fault.
> > The guest just accessed a page that it knows is poisoned (VMM just told
> > it once that it was poisoned). There is no reason that the VMM should
> > let the guest actually touch the poison a second time. But if the guest
> > does, then the guest should get the expected response. I.e. another
> > machine check.
> 
> So Jue says below that the VMM has unmapped the guest page from the EPT.
> So the guest cannot touch the poison anymore.
> 
> How is then possible for the guest to touch it again if the page is not
> mapped anymore?

The VMM wants to make sure that the guest can't touch the poison
(this is important because not every touch of poison results in a
recoverable machine check. If the guest's next touch is an unaligned
access that crosses from the poison cache line to a non-poisoned line
then h/w will signal a fatal machinecheck and the whole machine will
go down).

> The guest should get a #PF when the page is unmapped and cause a new
> page to be mapped.

The VMM gets the page fault (because the unmapping of the guest
physical address is at the VMM EPT level).  The VMM can't map a new
page into that guest physical address because it has no way to
replace the contents of the old page.  The VMM could pass the #PF
to the guest, but that would just confuse the guest (its page tables
all say that the page is still valid). In this particular case the
page is part of the 1:1 kernel map. So the kernel will OOPS (I think).

> On Sun, May 17, 2020 at 07:36:00AM -0700, Jue Wang wrote:
> > The stack is from guest MCE handler's processing of the first MCE injected.
> 
> Aha, so you've flipped the functions order in the trace. It all starts
> at
> 
>   set_mce_nospec(m->addr >> PAGE_SHIFT);
> 
> Now it makes sense.
> 
> > Note before the first MCE is injected into guest (i.e., after the host MCE
> > handler successfully finished MCE handling and notified VMM via SIGBUS with
> > BUS_MCEERR_AR), VMM unmaps the guest page from EPT.
> 
> Ok, good.
> 
> > The guest MCE handler finished the "normal" MCE handling and recovery
> > (memory_failure() in mm/memory_failure.cc) successfully, it's the aftermath
> > below leading to the stack trace:
> > https://github.com/torvalds/linux/blob/5a9ffb954a3933d7867f4341684a23e008d6839b/arch/x86/kernel/cpu/mce/core.c#L1101
> 
> On Sun, May 17, 2020 at 08:33:00AM -0700, Jue Wang wrote:
> > In other words, it's the *do_memory_failure -> set_mce_nospec*  flow of
> > guest MCE handler acting on the *first* MCE injection. As a result, the
> > guest panics and resets *whenever* there is an MCE injected, even when the
> > injected MCE is recoverable.
> 
> So IIUC that set_mce_nospec() thing should check whether m->addr is
> mapped first and only then mark it _uc and whatever monkey business it
> does. Not this blanket

PLease explain how a guest (that doesn't even know that it is a guest)
is going to figure out that the EPT tables (that it has no way to access)
have marked this page invalid in guest physical address space.

>   if am I a guest?
> 
> test.
> 
> Imagine a hypervisor which doesn't set X86_FEATURE_HYPERVISOR, i.e.,
> CPUID(1)[EDX, bit 31]?

Guest is going to be screwed in this case.

-Tony
