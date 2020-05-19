Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BD3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 11:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED2F920709
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 11:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JJPCqgBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgESLA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 07:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbgESLA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 07:00:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A598CC061A0C;
        Tue, 19 May 2020 04:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VT+X+5rq1DXaytjnI7YmoqX52Zbfd4pwFpxuEA+HGCI=; b=JJPCqgBxpP9DGH5rpeekl2GoZM
        pHe0x8uC/1s8dhbyftZRdkMnSvTj5b578nfrCWKKmppBKl91gEvjTNe3yJEmrA5xYz5gEDx8S7xop
        jh6tVVIxpoeZ+Y9eX1KXMhMqq9QH0lcXI4GbjpGXIYc52vG/ZUVc6vb4Ovj3vViFIi26L9a8OFrxX
        ykC+mlurLMxvYJnoHP5MQWp17aufSX6sJTYX6jID51x5YxRIlo5QNoWZjAspU6Vw8QNdpz12wi4e+
        399tRlBoNmInNaBNULWtdHSDEULvdtaIrniRNWFuWDoLcjI+clEWX2uFEo8I/OeLXovqJA4lLDQb9
        X9aaVLLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jazyn-0007S9-6j; Tue, 19 May 2020 11:00:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4ACAC3008A8;
        Tue, 19 May 2020 13:00:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 371C12B16F2CA; Tue, 19 May 2020 13:00:11 +0200 (CEST)
Date:   Tue, 19 May 2020 13:00:11 +0200
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
Subject: Re: [PATCH v11 08/11] KVM: x86/pmu: Emulate LBR feature via guest
 LBR event
Message-ID: <20200519110011.GG279861@hirez.programming.kicks-ass.net>
References: <20200514083054.62538-1-like.xu@linux.intel.com>
 <20200514083054.62538-9-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514083054.62538-9-like.xu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 04:30:51PM +0800, Like Xu wrote:
> +static inline bool event_is_oncpu(struct perf_event *event)
> +{
> +	return event && event->oncpu != -1;
> +}


> +/*
> + * It's safe to access LBR msrs from guest when they have not
> + * been passthrough since the host would help restore or reset
> + * the LBR msrs records when the guest LBR event is scheduled in.
> + */
> +static bool intel_pmu_access_lbr_msr(struct kvm_vcpu *vcpu,
> +				     struct msr_data *msr_info, bool read)
> +{
> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +	u32 index = msr_info->index;
> +
> +	if (!intel_is_valid_lbr_msr(vcpu, index))
> +		return false;
> +
> +	if (!msr_info->host_initiated && !pmu->lbr_event)
> +		intel_pmu_create_lbr_event(vcpu);
> +
> +	/*
> +	 * Disable irq to ensure the LBR feature doesn't get reclaimed by the
> +	 * host at the time the value is read from the msr, and this avoids the
> +	 * host LBR value to be leaked to the guest. If LBR has been reclaimed,
> +	 * return 0 on guest reads.
> +	 */
> +	local_irq_disable();
> +	if (event_is_oncpu(pmu->lbr_event)) {
> +		if (read)
> +			rdmsrl(index, msr_info->data);
> +		else
> +			wrmsrl(index, msr_info->data);
> +	} else if (read)
> +		msr_info->data = 0;
> +	local_irq_enable();
> +
> +	return true;
> +}

So this runs in the vCPU thread in host context to emulate the MSR
access, right?

