Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5421C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C48AB206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgESFEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 01:04:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:14988 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgESFEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 01:04:38 -0400
IronPort-SDR: HOMxLVA5QY8j40KYmrVNLWYt4H+rvEL7wGeMOOP/s+xupSUxmAVv9Itnc/x8/gyoKmFrjCWfXs
 Vy1cVofjcUtA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 22:04:37 -0700
IronPort-SDR: lXg3lZMGKLB5oOLt8aTas2/gb1GkmlyCgJ3w4UfRu9bUExeKF1BgWoowYDlQTybEPxm4cmKgEO
 amn7z4MX2J9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,409,1583222400"; 
   d="scan'208";a="439484898"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by orsmga005.jf.intel.com with ESMTP; 18 May 2020 22:04:35 -0700
Date:   Mon, 18 May 2020 22:04:35 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>, Jue Wang <juew@google.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/mm: Don't try to change poison pages to uncacheable
 in a guest
Message-ID: <20200519050435.GA5081@linux.intel.com>
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
User-Agent: Mutt/1.5.24 (2015-08-30)
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
> 
> If we can't fixup the exception, we die.
> 
> So why should the guest behave any differently?
> 
> Now, if you want for the guest to be more "robust" and handle that
> thing, fine. But then you'd need an explicit way to tell the guest
> kernel: "you've just had an MCE and I unmapped the page" so that the
> guest kernel can figure out what do to. Even if it means, to panic.
> 
> I.e., signal in an explicit way that EPT violation Jue is talking about
> in the other mail.

Well, technically the CLFUSH thing is a KVM emulation bug, but it sounds
like that's a moot point since the pmem-enabled guest will make real
accesses to the poisoned page shortly thereafter.  E.g. teaching KVM to
eat the -EHWPOISON on CLFLUSH would only postpone the guest's death.

As for how the second #MC occurs, on the EPT violation, KVM does a gup() to
translate the virtual address to a pfn (KVM maintains a simple GPA->HVA
lookup).  gup() returns -EHWPOISON for the poisoned page, which KVM
redirects into a BUS_MCEERR_AR.  The userspace VMM, e.g. Qemu, sees the
BUS_MCEERR_AR and sends it back into the guest as a virtual #MC.

> You can inject a #PF or better yet the *first* MCE which is being
> injected should say with a bit somehwere "I unmapped the address in
> m->addr". So that the guest kernel can handle that properly and know
> what *exactly* it is getting an MCE for.
> 
> What I don't like is the "am I running as a guest" check. Because
> someone else would come later and say, err, I'm not virtualizing this
> portion of MCA either, lemme add another "am I guest" check.
> 
> Sure, it is a lot easier but when stuff like that starts spreading
> around in the MCE code, then we can just as well disable MCE when
> virtualized altogether. It would be a lot easier for everybody.
