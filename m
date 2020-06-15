Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B957BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FC712071A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kZsZQvXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbgFOScZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbgFOScZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:32:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAF6C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kaLeQNKpwo/3pmt93qdeNrph7VCKxinWeBQB+muxlqU=; b=kZsZQvXl1NJZtySSQyofXqG2gJ
        LGW3VjHm9TuX25UqvO3KZKb2oOIY9GxryxwgyWiyhctAhFfedcv/u0AMokGAfuDcuQv/YwEGvsQmY
        8hielzOiarmpwSn/5Z/0ZHjthHpnyNcIvvdozZPWoKwXF1+6ZCXlGxvI5cc6bKSJLMgkeQfJy9onI
        UNvacJvt2GszmscxRPRxdOJ3tSlgyXdm46wtChlF5IIN4RMh0tlBKzaD0+BDmhBAEVFIMAXXXwcY2
        cISoF7L3RZDb4UNipJqrTeB82lsBma2Gf1fHVAikvl9tjy6NvvycYEJ6lHhJjlERcYaO3c4E8tvMX
        H2PwgC9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkttx-000598-1L; Mon, 15 Jun 2020 18:32:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C7A7430604B;
        Mon, 15 Jun 2020 20:32:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B5E05203DCA15; Mon, 15 Jun 2020 20:32:04 +0200 (CEST)
Date:   Mon, 15 Jun 2020 20:32:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Raj, Ashok" <ashok.raj@intel.com>
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
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Message-ID: <20200615183204.GE2531@hirez.programming.kicks-ass.net>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
 <1592008893-9388-13-git-send-email-fenghua.yu@intel.com>
 <20200615075649.GK2497@hirez.programming.kicks-ass.net>
 <20200615154854.GB13792@romley-ivt3.sc.intel.com>
 <20200615160357.GA2531@hirez.programming.kicks-ass.net>
 <20200615181921.GA33928@otc-nc-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615181921.GA33928@otc-nc-03>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 11:19:21AM -0700, Raj, Ashok wrote:
> On Mon, Jun 15, 2020 at 06:03:57PM +0200, Peter Zijlstra wrote:
> > 
> > I don't get why you need a rdmsr here, or why not having one would
> > require a TIF flag. Is that because this MSR is XSAVE/XRSTOR managed?
> > 
> > > > > +	 */
> > > > > +	rdmsrl(MSR_IA32_PASID, pasid_msr);
> > > > > +	if (pasid_msr & MSR_IA32_PASID_VALID)
> > > > > +		return false;
> > > > > +
> > > > > +	/* Fix up the MSR if the MSR doesn't have a valid PASID. */
> > > > > +	wrmsrl(MSR_IA32_PASID, pasid | MSR_IA32_PASID_VALID);
> > 
> > How much more expensive is the wrmsr over the rdmsr? Can't we just
> > unconditionally write the current PASID and call it a day?
> 
> The reason to check the rdmsr() is because we are using a hueristic taking
> GP faults. If we already setup the MSR, but we get it a second time it
> means the reason is something other than PASID_MSR not being set.
> 
> Ideally we should use the TIF_ to track this would be cheaper, but we were
> told those bits aren't easy to give out. 

Why do you need a TIF flag? Why not any other random flag in current?
