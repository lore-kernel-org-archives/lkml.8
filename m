Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38F8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D290A20656
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbgFOSza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:55:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:26684 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729124AbgFOSza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:55:30 -0400
IronPort-SDR: PhvyGmyayz3iqNJYwVmFWTmtOB4+XuvmJ+R5Y3qbr8ozyD+7ADT6RSbrMHHeeMSt3w8T1gXS5d
 NMMI64KFzXhA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 11:55:29 -0700
IronPort-SDR: 7AOfFl+Q9Zk9+pLDv+ctsLfdexol4Ooa9fms1lqtuvgDaDmflZdjgu5bI2sLLO96QFzKhPty0n
 Vry9GVkoZi+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,515,1583222400"; 
   d="scan'208";a="382630204"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2020 11:55:30 -0700
Date:   Mon, 15 Jun 2020 11:55:29 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org,
        amd-gfx <amd-gfx@lists.freedesktop.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Message-ID: <20200615185529.GD13792@romley-ivt3.sc.intel.com>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
 <1592008893-9388-13-git-send-email-fenghua.yu@intel.com>
 <20200615075649.GK2497@hirez.programming.kicks-ass.net>
 <20200615154854.GB13792@romley-ivt3.sc.intel.com>
 <20200615160357.GA2531@hirez.programming.kicks-ass.net>
 <20200615181259.GC13792@romley-ivt3.sc.intel.com>
 <20200615183116.GD2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615183116.GD2531@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter,

On Mon, Jun 15, 2020 at 08:31:16PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 15, 2020 at 11:12:59AM -0700, Fenghua Yu wrote:
> > > I don't get why you need a rdmsr here, or why not having one would
> > > require a TIF flag. Is that because this MSR is XSAVE/XRSTOR managed?
> > 
> > My concern is TIF flags are precious (only 3 slots available). Defining
> > a new TIF flag may be not worth it while rdmsr() can check if PASID
> > is valid in the MSR. And performance here might not be a big issue
> > in #GP.
> > 
> > But if you think using TIF flag is better, I can define a new TIF flag
> > and maintain it per thread (init 0 when clone()/fork(), set 1 in fixup()).
> > Then we can avoid using rdmsr() to check valid PASID in the MSR.
> 
> WHY ?!?! What do you need a TIF flag for?

We need "a way" to check if the per thread MSR has a valid PASID. If yes,
no need to fix up the MSR (wrmsr()), and let other handler to handle the #GP.
Otherwise, apply the heuristics and fix up the MSR and exit the #GP.

The way to check the valid PASID in the MSR is rdmsr() in this series.
A TIF flag will be much faster than rdmsr() and seems a sutiable way
to check valid PASID status per thread. That's why it could replace
rdmsr() to check PASID in the MSR.

Or do you suggest to add a random new flag in struct thread_info instead
of a TIF flag?

Thanks.

-Fenghua

