Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FC1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B826C20836
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgFLRnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 13:43:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:50155 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgFLRnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 13:43:08 -0400
IronPort-SDR: Gey2vFqDNLwq8mWskcfR2rYJ8SzcHHctWBJ3r70UIM/wn5Fixc08nisp91q/kXcapYbYc4qfR6
 4YvLUtzkzIlw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 10:43:07 -0700
IronPort-SDR: 0Lbe9ZUz45hL+o9jfKw8BJKKb6Tbmv7wGJamhC/TkFjY7ubOLMpdOFLFnIfgrRMJzrdkE7Skjs
 fbNFXwlqHdbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,504,1583222400"; 
   d="scan'208";a="419537122"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by orsmga004.jf.intel.com with ESMTP; 12 Jun 2020 10:43:07 -0700
Date:   Fri, 12 Jun 2020 10:43:07 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/msr: Filter MSR writes
Message-ID: <20200612174307.GD1026@linux.intel.com>
References: <20200612105026.GA22660@zn.tnic>
 <20200612163406.GA1026@linux.intel.com>
 <20200612164602.GC22660@zn.tnic>
 <20200612165709.GB1026@linux.intel.com>
 <20200612170303.GD22660@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612170303.GD22660@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 07:03:03PM +0200, Borislav Petkov wrote:
> On Fri, Jun 12, 2020 at 09:57:09AM -0700, Sean Christopherson wrote:
> > DS_AREA takes a virtual (linear) address, i.e. the address can be legal from
> > the CPUs perspective but still lead to a #PF due to the address not being
> > mapped in the page tables.
> 
> It's not that - peterz and tglx - and I assume you meant that too - you
> all want to taint on the very *attempt* to WRMSR, regardless of whether
> the MSR exists or not.
> 
> I don't necessarily agree with that because I don't think we should
> taint when the MSR doesn't exist but if you all want it, sure, whatever.
> I don't care that deeply.

The problem is a fault on WRMSR doesn't mean the MSR doesn't exist, it only
means WRMSR faulted.  WRMSR can for all intents and purpose trigger completely
arbitrary microcode flows, e.g. WRMSR 0x79 can fundamentally change the
behavior of the CPU.

And it's not like the WRMSR->taint is atomic, e.g. changing a platform scoped
MSR that affects voltage settings or something of that nature could easily
tank the system on a successful WRMSR before the kernel can be marked tainted.

> > So users don't have to unload and reload the module just to enable or
> > disable writes.  I don't think it changes the protections in any way, a
> > priveleged user still needs to explicitly toggle the control.
> 
> There's /sys/module/msr/parameters/. A privileged user can do whatever.
> A non-privileged should not disable that.

0400 only allows a privelged user to read the parameter, e.g. for parameters
that are snapshotted at module load time and/or changing the param while the
module is running would cause breakage.

0600 allows a priveleged user to read and write the parameter, which AFAICT
is safe here.

0644 allows a priveleged user to read and write the parameter, and allows an
unpriveleged user to read the param.  

> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
