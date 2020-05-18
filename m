Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88C8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7516B207D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g4W6H63Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgERMJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 08:09:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46436 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgERMJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 08:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2VGBdxQS+aq5Aez0CmebGynNgZc/bdd+iTJZs2pkOaw=; b=g4W6H63ZwAfRo19i0iOUdrAmU0
        8k3m9gA7ijSIm5dzuH8YEqIjrGjJFukLa1QKT7NlU0NtkMBMdkgvHy9ZPpi7FjAbQCWujfq3zStBL
        dqkmGDoUJYsfrqXLJUxOFJ6o8C/z0FsEp25I9zXP0qNghdPAuF4mKHFFtm/gKkJ42D4C5BAAP7iTf
        1MeU224jjU7NfRAgtX+p13AW/+hbwtaEoJF80z95vaoT3jsEr7Gix2PjvGint6VBA0u+GE9gE+RAq
        PB/f6VXpvYGCCLuTSum2yzeAweOTBvJkJD2jmlc3PFsuYSXX2/o7J9kfqqfAPNylxayb/nY5MKNza
        /bT6fWgg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jaeTH-0001Sh-5l; Mon, 18 May 2020 12:02:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 21AB23011E8;
        Mon, 18 May 2020 14:02:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0519C2B3D1C58; Mon, 18 May 2020 14:02:05 +0200 (CEST)
Date:   Mon, 18 May 2020 14:02:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>, ak@linux.intel.com,
        wei.w.wang@intel.com
Subject: Re: [PATCH v11 05/11] perf/x86: Keep LBR stack unchanged in host
 context for guest LBR event
Message-ID: <20200518120205.GF277222@hirez.programming.kicks-ass.net>
References: <20200514083054.62538-1-like.xu@linux.intel.com>
 <20200514083054.62538-6-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514083054.62538-6-like.xu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 04:30:48PM +0800, Like Xu wrote:
> @@ -544,7 +562,12 @@ void intel_pmu_lbr_enable_all(bool pmi)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  
> -	if (cpuc->lbr_users)
> +	/*
> +	 * When the LBR hardware is scheduled for a guest LBR event,
> +	 * the guest will dis/enables LBR itself at the appropriate time,
> +	 * including configuring MSR_LBR_SELECT.
> +	 */
> +	if (cpuc->lbr_users && !cpuc->guest_lbr_enabled)
>  		__intel_pmu_lbr_enable(pmi);
>  }

No!, that should be done through perf_event_attr::exclude_host, as I
believe all the other KVM event do it.
