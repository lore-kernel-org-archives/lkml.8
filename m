Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E34C38BF9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C922072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgBXWmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:42:21 -0500
Received: from mga06.intel.com ([134.134.136.31]:24890 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgBXWmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 17:42:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 14:42:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,481,1574150400"; 
   d="scan'208";a="237471606"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga003.jf.intel.com with ESMTP; 24 Feb 2020 14:42:19 -0800
Date:   Mon, 24 Feb 2020 14:42:19 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 27/61] KVM: x86: Introduce
 cpuid_entry_{change,set,clear}() mutators
Message-ID: <20200224224219.GN29865@linux.intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com>
 <20200201185218.24473-28-sean.j.christopherson@intel.com>
 <87ftf0p0d0.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftf0p0d0.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 02:43:07PM +0100, Vitaly Kuznetsov wrote:
> Sean Christopherson <sean.j.christopherson@intel.com> writes:
> 
> > diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> > index 64e96e4086e2..51f19eade5a0 100644
> > --- a/arch/x86/kvm/cpuid.h
> > +++ b/arch/x86/kvm/cpuid.h
> > @@ -135,6 +135,37 @@ static __always_inline bool cpuid_entry_has(struct kvm_cpuid_entry2 *entry,
> >  	return cpuid_entry_get(entry, x86_feature);
> >  }
> >  
> > +static __always_inline void cpuid_entry_clear(struct kvm_cpuid_entry2 *entry,
> > +					      unsigned x86_feature)
> > +{
> > +	u32 *reg = cpuid_entry_get_reg(entry, x86_feature);
> > +
> > +	*reg &= ~__feature_bit(x86_feature);
> > +}
> > +
> > +static __always_inline void cpuid_entry_set(struct kvm_cpuid_entry2 *entry,
> > +					    unsigned x86_feature)
> > +{
> > +	int *reg = cpuid_entry_get_reg(entry, x86_feature);
> 
> I think 'reg' should be 'u32', similar to cpuid_entry_clear()

Doh, thanks!

> > +
> > +	*reg |= __feature_bit(x86_feature);
> > +}
> > +
> > +static __always_inline void cpuid_entry_change(struct kvm_cpuid_entry2 *entry,
> > +					       unsigned x86_feature, bool set)
> > +{
> > +	int *reg = cpuid_entry_get_reg(entry, x86_feature);
> 
> Ditto.
> 
