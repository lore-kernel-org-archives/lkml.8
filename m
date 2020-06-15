Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6204C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93BB320707
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D0jY9gpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbgFOScD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbgFOScC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:32:02 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD56C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0uaXx1a8X6ge6muz2Sp6fD7wbgSxal+3tZhrZaa6Nx0=; b=D0jY9gpNa4VuJV7CCVE0XGTQx+
        wFyrLfr7o8wDoY51qJTNQjm/4B8lqrCNzGQDtIaw4ik+p3fchHqc7GxZQo3PPjYkyaFuJN0vv+3BM
        2lQuY83HRICjGt/2OvYBHm3yWeok729oCC5gH6Ce1JzaIhM3P6pBkVkSZtPK8xvoWPiuvbFN6y7Wn
        Urz7U9kmgzIn63lIN4t/iFRfGFOxrO7VZC7rNkYDf7PaemLg1BDQRCIIRd845l7uL243G3Kxz+WFs
        Tlh3KXfKbIpNqHotyfOur8ysWtNG2ghRlTkgsgoiArC27XGJ1RhR25u1/kKY8q02E0olPt8AwdSSc
        AroCuvcA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkttA-0003xc-97; Mon, 15 Jun 2020 18:31:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D9C03003E1;
        Mon, 15 Jun 2020 20:31:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4B487203B815D; Mon, 15 Jun 2020 20:31:16 +0200 (CEST)
Date:   Mon, 15 Jun 2020 20:31:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
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
Message-ID: <20200615183116.GD2531@hirez.programming.kicks-ass.net>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
 <1592008893-9388-13-git-send-email-fenghua.yu@intel.com>
 <20200615075649.GK2497@hirez.programming.kicks-ass.net>
 <20200615154854.GB13792@romley-ivt3.sc.intel.com>
 <20200615160357.GA2531@hirez.programming.kicks-ass.net>
 <20200615181259.GC13792@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615181259.GC13792@romley-ivt3.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 11:12:59AM -0700, Fenghua Yu wrote:
> > I don't get why you need a rdmsr here, or why not having one would
> > require a TIF flag. Is that because this MSR is XSAVE/XRSTOR managed?
> 
> My concern is TIF flags are precious (only 3 slots available). Defining
> a new TIF flag may be not worth it while rdmsr() can check if PASID
> is valid in the MSR. And performance here might not be a big issue
> in #GP.
> 
> But if you think using TIF flag is better, I can define a new TIF flag
> and maintain it per thread (init 0 when clone()/fork(), set 1 in fixup()).
> Then we can avoid using rdmsr() to check valid PASID in the MSR.

WHY ?!?! What do you need a TIF flag for?
