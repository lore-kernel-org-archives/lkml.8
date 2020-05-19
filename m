Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2641BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 11:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E225D204EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 11:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bs+G7VX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgESLGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 07:06:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:32846 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgESLGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 07:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J9d+m4V5triwaXNGvm5EH9MRoAlSjk0m+9i2L2q2oJk=; b=Bs+G7VX1wRWj6afTmpcUxLpoi/
        JBtUsQIVq//6O+iZjieaPDTS8aED+dpeTxPG84OFimXYcb9AN9hznGDEmnHTPRi+84ZGUI3pirhvh
        FN8sIWI5Z2HJaLgK7CQQZBLk4A74x23YufEi4WMRfTQ2Jj76ITvKKQM6U7YqQuESPBOIXZLBpCshl
        hRX2Ypjw49xHp2pscgjpc9fMgSyn6pb2EZGEuhFssdW3K+EsjrCUQ36cwiGvKAPjBCDu+94uIe1hs
        BeuY86keLJwVRZ99VXfDU/xWc9XEqLAMqPz4bV4GWwPXQC6MS6Lvbatqzi7AHanP8WyGTu1UmoP3U
        5vxLEsWw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jb02O-0005ff-Pv; Tue, 19 May 2020 11:03:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3A547304A59;
        Tue, 19 May 2020 13:03:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 25A7220BE636B; Tue, 19 May 2020 13:03:55 +0200 (CEST)
Date:   Tue, 19 May 2020 13:03:55 +0200
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
Message-ID: <20200519110355.GI279861@hirez.programming.kicks-ass.net>
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
> @@ -6698,6 +6698,7 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  
>  	if (vcpu_to_pmu(vcpu)->version)
>  		atomic_switch_perf_msrs(vmx);
> +
>  	atomic_switch_umwait_control_msr(vmx);
>  
>  	if (enable_preemption_timer)

Is this where the test to see if any of the KVM events went into ERROR
state should go?

	if (event->state == PERF_EVENT_STATE_ERROR) {
		pr_warn("unhappy, someone stole our counter\n");
	}

like..
