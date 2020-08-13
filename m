Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8D0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 14:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC1820781
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 14:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgHMO6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 10:58:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:45764 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbgHMO6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 10:58:32 -0400
IronPort-SDR: ImYcp27394g5JMsJdaV0wtoStB2zIUshf//fGvvDNikEQ9bYrYRNC/mixuzNULB/jn72nnJ4bw
 JDhg29xUXRiQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="218569598"
X-IronPort-AV: E=Sophos;i="5.76,308,1592895600"; 
   d="scan'208";a="218569598"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 07:58:32 -0700
IronPort-SDR: 7Czy6wr9NPub7O8BcsmIwwO1jHX/zgsBwf7s4wfVw95vsjFydJ8midzJwQxoY2ChnGuqgQ9N98
 Hsw2Hqd+6S/A==
X-IronPort-AV: E=Sophos;i="5.76,308,1592895600"; 
   d="scan'208";a="439799614"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.160])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 07:58:31 -0700
Date:   Thu, 13 Aug 2020 07:58:30 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 2/2] KVM: LAPIC: Guarantee the timer is in
 tsc-deadline mode when setting
Message-ID: <20200813145830.GF29439@linux.intel.com>
References: <1597213838-8847-1-git-send-email-wanpengli@tencent.com>
 <1597213838-8847-2-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597213838-8847-2-git-send-email-wanpengli@tencent.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 02:30:38PM +0800, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Check apic_lvtt_tscdeadline() mode directly instead of apic_lvtt_oneshot()
> and apic_lvtt_period() to guarantee the timer is in tsc-deadline mode when
> wrmsr MSR_IA32_TSCDEADLINE.
> 
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>

Gah, I take back my comment about squashing these, I assumed this was the
same fix but just in the write path.

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>

> ---
> v1 -> v2:
>  * fix indentation
> 
>  arch/x86/kvm/lapic.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 79599af..abaf48e 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2193,8 +2193,7 @@ void kvm_set_lapic_tscdeadline_msr(struct kvm_vcpu *vcpu, u64 data)
>  {
>  	struct kvm_lapic *apic = vcpu->arch.apic;
>  
> -	if (!kvm_apic_present(vcpu) || apic_lvtt_oneshot(apic) ||
> -			apic_lvtt_period(apic))
> +	if (!kvm_apic_present(vcpu) || !apic_lvtt_tscdeadline(apic))
>  		return;
>  
>  	hrtimer_cancel(&apic->lapic_timer.timer);
> -- 
> 2.7.4
> 
