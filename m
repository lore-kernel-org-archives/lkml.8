Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7119C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FC3E2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oczihRk4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgFOH50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbgFOH5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:57:25 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCDFC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 00:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IulpOX2ZXgYia0hOJz1PbMFRWrf1LR01eti82WL5/mk=; b=oczihRk4Bm3qcABlCzOnJf+2OJ
        0XEBNhA69dQZfOVFjforrMajTMyU6oALzgTuDvb2GeMeG2T1r+tILte4kFI4uUu5taSMg3ym3qIXB
        /+SpsF9m/yFWIopT3APyh4HKoysD8lYUyRyOuZnjn6W8bh4lVl3p2NODhfXAJewux95NkSmBkzxEO
        RTgAZ+9Lvii0nNQJWkcQs7m3PJAYCZAAspLWgGZASo7fVIJQ8JP5TfSUCjCBOg204HN+5bc9ES9Xj
        +db4VuKfq1mznnM24NsJLQ4Z4kVaIXAZWi3u8V9+2eWuWqt6f5a7Pm9z7n/TEczt4pSpBO1v1vZes
        dhhuLDvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkjz8-0005nK-Rt; Mon, 15 Jun 2020 07:56:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2D9D6301A32;
        Mon, 15 Jun 2020 09:56:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1903521059BE1; Mon, 15 Jun 2020 09:56:49 +0200 (CEST)
Date:   Mon, 15 Jun 2020 09:56:49 +0200
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
Message-ID: <20200615075649.GK2497@hirez.programming.kicks-ass.net>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
 <1592008893-9388-13-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592008893-9388-13-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 05:41:33PM -0700, Fenghua Yu wrote:
> +/*
> + * Apply some heuristics to see if the #GP fault was caused by a thread
> + * that hasn't had the IA32_PASID MSR initialized.  If it looks like that
> + * is the problem, try initializing the IA32_PASID MSR. If the heuristic
> + * guesses incorrectly, take one more #GP fault.

How is that going to help? Aren't we then going to run this same
heuristic again and again and again?

> + */
> +bool __fixup_pasid_exception(void)
> +{
> +	u64 pasid_msr;
> +	unsigned int pasid;
> +
> +	/*
> +	 * This function is called only when this #GP was triggered from user
> +	 * space. So the mm cannot be NULL.
> +	 */
> +	pasid = current->mm->pasid;
> +	/* If the mm doesn't have a valid PASID, then can't help. */
> +	if (invalid_pasid(pasid))
> +		return false;
> +
> +	/*
> +	 * Since IRQ is disabled now, the current task still owns the FPU on

That's just weird and confusing. What you want to say is that you rely
on the exception disabling the interrupt.

> +	 * this CPU and the PASID MSR can be directly accessed.
> +	 *
> +	 * If the MSR has a valid PASID, the #GP must be for some other reason.
> +	 *
> +	 * If rdmsr() is really a performance issue, a TIF_ flag may be
> +	 * added to check if the thread has a valid PASID instead of rdmsr().

I don't understand any of this. Nobody except us writes to this MSR, we
should bloody well know what's in it. What gives?

> +	 */
> +	rdmsrl(MSR_IA32_PASID, pasid_msr);
> +	if (pasid_msr & MSR_IA32_PASID_VALID)
> +		return false;
> +
> +	/* Fix up the MSR if the MSR doesn't have a valid PASID. */
> +	wrmsrl(MSR_IA32_PASID, pasid | MSR_IA32_PASID_VALID);
> +
> +	return true;
> +}
> -- 
> 2.19.1
> 
