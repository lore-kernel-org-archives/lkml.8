Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5287EC33CAB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2782187F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733289AbgAMGKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 01:10:47 -0500
Received: from mga17.intel.com ([192.55.52.151]:56206 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgAMGKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 01:10:46 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jan 2020 22:10:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,427,1571727600"; 
   d="scan'208";a="422706793"
Received: from unknown (HELO localhost) ([10.239.159.128])
  by fmsmga005.fm.intel.com with ESMTP; 12 Jan 2020 22:10:45 -0800
Date:   Mon, 13 Jan 2020 14:15:06 +0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Yang Weijiang <weijiang.yang@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        jmattson@google.com, yu.c.zhang@linux.intel.com,
        alazar@bitdefender.com, edwin.zhai@intel.com
Subject: Re: [RESEND PATCH v10 04/10] mmu: spp: Add functions to operate SPP
 access bitmap
Message-ID: <20200113061506.GD12253@local-michael-cet-test.sh.intel.com>
References: <20200102061319.10077-1-weijiang.yang@intel.com>
 <20200102061319.10077-5-weijiang.yang@intel.com>
 <20200110173804.GD21485@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110173804.GD21485@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 09:38:04AM -0800, Sean Christopherson wrote:
> On Thu, Jan 02, 2020 at 02:13:13PM +0800, Yang Weijiang wrote:
> > Create access bitmap for SPP subpages, the bitmap can
> > be accessed with a gfn. The initial access bitmap for each
> > physical page is 0xFFFFFFFF, meaning SPP is not enabled for the
> > subpages.
> 
> Wrap changelogs at ~75 chars.
> 
> Create access bitmap for SPP subpages, the bitmap can be accessed with a
> gfn.  The initial access bitmap for each physical page is 0xFFFFFFFF,
> meaning SPP is not enabled for the subpages.
> 
> There needs to be a *lot* more information provided in all of the changelogs
> for this series.  I understand the basic concepts of SPP, but nothing in the
> documentation or changelogs explains how KVM generates the SPP tables based
> on userspace input.  Essentially, explain the design in decent detail, with
> a focus on *why* KVM does what it does.
>
OK, will modify the documentation to add SPPT setup section, thanks!

> > +static int kvm_spp_level_pages(gfn_t gfn_lower, gfn_t gfn_upper, int level)
> > +{
> > +	int page_num = KVM_PAGES_PER_HPAGE(level);
> > +	gfn_t gfn_max = (gfn_lower & ~(page_num - 1)) + page_num - 1;
> > +	int ret;
> > +
> > +	if (gfn_upper <= gfn_max)
> > +		ret = gfn_upper - gfn_lower + 1;
> > +	else
> > +		ret = gfn_max - gfn_lower + 1;
> > +
> > +	return ret;
> > +}
> > +
> >  #define SPPT_ENTRY_PHA_MASK (0xFFFFFFFFFF << 12)
> 
> There's almost certainly an existing macro for this.
>
Sure, will remove it.
> >  
> >  int kvm_spp_setup_structure(struct kvm_vcpu *vcpu,
> > @@ -220,6 +249,309 @@ int kvm_spp_setup_structure(struct kvm_vcpu *vcpu,
> >  }
> >  EXPORT_SYMBOL_GPL(kvm_spp_setup_structure);
> >  
> > +int vmx_spp_flush_sppt(struct kvm *kvm, u64 gfn_base, u32 npages)
> > +{
> > +	struct kvm_shadow_walk_iterator iter;
> > +	struct kvm_vcpu *vcpu;
> > +	gfn_t gfn = gfn_base;
> > +	gfn_t gfn_max = gfn_base + npages - 1;
> 
> s/gfn_max/gfn_end.  "max" makes me think this is literally walking every
> possible gfn.
> 
Make sense, will change it.

> > +	u64 spde;
> > +	int count;
> > +	bool flush = false;
> > +
> >  /*
> >   * The bit 0 ~ bit 15 of kvm_memory_region::flags are visible for userspace,
> >   * other bits are reserved for kvm internal use which are defined in
> > -- 
> > 2.17.2
> > 
