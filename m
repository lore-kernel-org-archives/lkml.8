Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE31FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88C98206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbgFOSTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:19:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:38592 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729124AbgFOSTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:19:22 -0400
IronPort-SDR: aBEMWUl0iLwja3eT48E1NVfDaFVrH3V1FHc6yPFHzgptHAyqh6yGahzDm6tlu4T9sZ6Mgl5rHe
 jWh7HSzmunxw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 11:19:21 -0700
IronPort-SDR: SdtFHoff29V9KtkfxtvNK8UK0GFz3weIqBlZYoLU507VjZSQ/qwXtL4fCM6H4L+ZylJ6G3K3Og
 KpQCvO0hDJeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,515,1583222400"; 
   d="scan'208";a="382621179"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2020 11:19:21 -0700
Date:   Mon, 15 Jun 2020 11:19:21 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org,
        amd-gfx <amd-gfx@lists.freedesktop.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Message-ID: <20200615181921.GA33928@otc-nc-03>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
 <1592008893-9388-13-git-send-email-fenghua.yu@intel.com>
 <20200615075649.GK2497@hirez.programming.kicks-ass.net>
 <20200615154854.GB13792@romley-ivt3.sc.intel.com>
 <20200615160357.GA2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615160357.GA2531@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 06:03:57PM +0200, Peter Zijlstra wrote:
> 
> I don't get why you need a rdmsr here, or why not having one would
> require a TIF flag. Is that because this MSR is XSAVE/XRSTOR managed?
> 
> > > > +	 */
> > > > +	rdmsrl(MSR_IA32_PASID, pasid_msr);
> > > > +	if (pasid_msr & MSR_IA32_PASID_VALID)
> > > > +		return false;
> > > > +
> > > > +	/* Fix up the MSR if the MSR doesn't have a valid PASID. */
> > > > +	wrmsrl(MSR_IA32_PASID, pasid | MSR_IA32_PASID_VALID);
> 
> How much more expensive is the wrmsr over the rdmsr? Can't we just
> unconditionally write the current PASID and call it a day?

The reason to check the rdmsr() is because we are using a hueristic taking
GP faults. If we already setup the MSR, but we get it a second time it
means the reason is something other than PASID_MSR not being set.

Ideally we should use the TIF_ to track this would be cheaper, but we were
told those bits aren't easy to give out. 

Cheers,
Ashok
