Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C82C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9678E2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgESFWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 01:22:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:51202 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbgESFWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 01:22:45 -0400
IronPort-SDR: G5K4S4F383RAUMFfAAZG5mDBOBz0zI3nwMtWSNCa+c1YWweHK5BHKDkazB/+gRNGZ73F1nv9pP
 ksvJJYGr0eIQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 22:22:44 -0700
IronPort-SDR: AhkzmbkWX38xXcob9pOX6FDms5yyEkcqPRQmz5qHbjanBtpsHOH+wrnsEktONyWD5IVorUZI8H
 3Y4nXLAfZCgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,409,1583222400"; 
   d="scan'208";a="411514911"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by orsmga004.jf.intel.com with ESMTP; 18 May 2020 22:22:44 -0700
Date:   Mon, 18 May 2020 22:22:44 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Jue Wang <juew@google.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/mm: Don't try to change poison pages to uncacheable
 in a guest
Message-ID: <20200519052244.GB5081@linux.intel.com>
References: <20200516150229.GB19372@zn.tnic>
 <8022D1E6-A8BC-4610-9F58-67A06B9A9575@intel.com>
 <CAPcxDJ50pbuTbittyvPwKq1uUT8q8jJ+dHH8rCug8a1DDZXVYw@mail.gmail.com>
 <CAPcxDJ6f3pBpwiR9nvXN_g_HBa1RAMG+aOmgfXLFT6aZ9HQn3w@mail.gmail.com>
 <20200518134813.GC25034@zn.tnic>
 <20200518153625.GA31444@agluck-desk2.amr.corp.intel.com>
 <20200518165500.GD25034@zn.tnic>
 <20200518182629.GA2957@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518182629.GA2957@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 11:26:29AM -0700, Luck, Tony wrote:
> Maybe it isn't pretty. But I don't see another practical solution.
> 
> The VMM is doing exactly the right thing here. It should not trust
> that the guest will behave and not touch the poison location again.
> If/when the guest does touch the poison, the right action is
> for the VMM to fake a new machine check to the guest.
> 
> Theoretlcally the VMM could decode the instruction that the guest
> was trying to use on the poison page and decide "oh, this is that
> weird case in Linux where it's just trying to CLFLUSH the page. I'll
> just step the return IP past the CLFLUSH and let the guest continue".

That's actually doable in KVM, e.g. a hack could be done in <10 lines of
code.  A proper fix that integrates with KVM's emulator would be
substantially more code and effort though.

> But that doesn't sound at all reasonable to me (especially as the
> next step is to realize that Linux is going to repeat that for every
> cache line in the page, so you also want to VMM to fudge the register
> contents to skip to the end of the loop and avoid another 63 VMEXITs).

Eh, 63 VM-Exits is peanuts in the grand scheme.  Even with the host-side
gup() that's probably less than 50us.

> N.B. Linux wants to switch the page to uncacheable so that in the
> persistant memory case the filesytem code can continue to access
> the other "blocks" in the page, rather than lose all of them. That's
> futile in the case where the VMM took the whole 4K away. Maybe Dan
> needs to think about the guest case too.

This is where I'm unclear as to the guest behavior.  Is it doing *just*
CLFLUSH, or is it doing CLFLUSH followed by other accesses to the poisoned
page?  If it's the former, then it's probably worth at least exploring a
KVM fix.  If it's the latter, then yeah, emulating CLFLUSH for a poisoned
#MC is pointless.  I assume it's the latter since the goal is to recover
data?

Oh, and FWIW, the guest won't actually get UC for that page.
