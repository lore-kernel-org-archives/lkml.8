Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C075C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 18:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D755214DB
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 18:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgB2Sib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 13:38:31 -0500
Received: from mga14.intel.com ([192.55.52.115]:58868 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727209AbgB2Sib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 13:38:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 10:38:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,500,1574150400"; 
   d="scan'208";a="385812059"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga004.jf.intel.com with ESMTP; 29 Feb 2020 10:38:30 -0800
Date:   Sat, 29 Feb 2020 10:38:30 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 48/61] KVM: x86: Do host CPUID at load time to mask KVM
 cpu caps
Message-ID: <20200229183830.GB22451@linux.intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com>
 <20200201185218.24473-49-sean.j.christopherson@intel.com>
 <fd7c8e54-b5e1-fa0c-02c7-d308ecfbac80@redhat.com>
 <20200225210843.GI9245@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225210843.GI9245@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 01:08:43PM -0800, Sean Christopherson wrote:
> On Tue, Feb 25, 2020 at 04:18:12PM +0100, Paolo Bonzini wrote:
> > On 01/02/20 19:52, Sean Christopherson wrote:
> > > +#ifdef CONFIG_KVM_CPUID_AUDIT
> > > +	/* Entry needs to be fully populated when auditing is enabled. */
> > > +	entry.function = cpuid.function;
> > > +	entry.index = cpuid.index;
> > > +#endif
> > 
> > This shows that the audit case is prone to bitrot, which is good reason
> > to enable it by default.
> 
> I have no argument against that, especially since I missed this case during
> development and only caught it when running on a different system that I
> had happened to configure with CONFIG_KVM_CPUID_AUDIT=y. :-)

I ended up dropping the audit code altogether.  The uops overhead wasn't
bad, but the code bloat was pretty rough, ~16 bytes per instance.  The
final nail in the coffin was that the auditing would trigger false
positives if userspace configured CPUID leafs with a non-signficant index
to have a non-zero index, e.g. is_matching_cpuid_entry() ignores the index
if KVM_CPUID_FLAG_SIGNIFCANT_INDEX isn't set.
