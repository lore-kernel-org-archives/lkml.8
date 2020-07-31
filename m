Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90E3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACC92208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbgGaQOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:14:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:18961 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbgGaQOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:14:21 -0400
IronPort-SDR: 6nl4joxa2k2tFxZenENqN4k3D+raFyw2iKj+1Eb8cAJgpk3RKEpzLM0I8NbRwi62oAqjeBdNkk
 fea5HLHqiK+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="151012185"
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="151012185"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 09:14:20 -0700
IronPort-SDR: dcfSfRqna+b/OcMeLDfeSmDU7oMmp6G608bPD1hJpA5kgwCixNQOcj8tcs3JsmXsyp09VcY/hS
 FFezIxF0K/LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="287216972"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.160])
  by orsmga003.jf.intel.com with ESMTP; 31 Jul 2020 09:14:19 -0700
Date:   Fri, 31 Jul 2020 09:14:19 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] KVM: x86: Pull the PGD's level from the MMU instead
 of recalculating it
Message-ID: <20200731161419.GB31451@linux.intel.com>
References: <20200716034122.5998-1-sean.j.christopherson@intel.com>
 <20200716034122.5998-6-sean.j.christopherson@intel.com>
 <871rl3pj9d.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rl3pj9d.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 07:11:26PM +0200, Vitaly Kuznetsov wrote:
> Sean Christopherson <sean.j.christopherson@intel.com> writes:
> > diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> > index 4d561edf6f9ca..50b56622e16a6 100644
> > --- a/arch/x86/kvm/vmx/nested.c
> > +++ b/arch/x86/kvm/vmx/nested.c
> > @@ -2162,7 +2162,7 @@ static void prepare_vmcs02_constant_state(struct vcpu_vmx *vmx)
> >  	 * consistency checks.
> >  	 */
> >  	if (enable_ept && nested_early_check)
> > -		vmcs_write64(EPT_POINTER, construct_eptp(&vmx->vcpu, 0));
> > +		vmcs_write64(EPT_POINTER, construct_eptp(&vmx->vcpu, 0, 4));
> 
> Nit: could we use MMU's PT64_ROOT_4LEVEL instead of '4' here?

My strategy of procrastinating until Paolo queued the series paid off.

Short answer, yes, that could be done.  But to be consistent we'd want to
change vmx_get_max_tdp_level() and kvm_mmu_get_tdp_level() to also use
PT64_ROOT_4LEVEL and PT64_ROOT_5LEVEL, and for me at least that doesn't
improve readability.
