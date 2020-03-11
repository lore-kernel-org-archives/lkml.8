Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	RDNS_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from mga12.intel.com ([192.55.52.136]:45305 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730123AbgCKQLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:11:54 -0400
Date: Wed, 11 Mar 2020 09:11:52 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6 03/14] KVM: X86: Don't track dirty for
 KVM_SET_[TSS_ADDR|IDENTITY_MAP_ADDR]
Message-ID: <20200311161152.GF21852@linux.intel.com>
References: <20200309214424.330363-1-peterx@redhat.com>
 <20200309214424.330363-4-peterx@redhat.com>
 <20200310150637.GB7600@linux.intel.com>
 <20200311160119.GF479302@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311160119.GF479302@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 11, 2020 at 12:01:19PM -0400, Peter Xu wrote:
> On Tue, Mar 10, 2020 at 08:06:37AM -0700, Sean Christopherson wrote:
> > On Mon, Mar 09, 2020 at 05:44:13PM -0400, Peter Xu wrote:
> > > -	idx = srcu_read_lock(&kvm->srcu);
> > > -	fn = to_kvm_vmx(kvm)->tss_addr >> PAGE_SHIFT;
> > > -	r = kvm_clear_guest_page(kvm, fn, 0, PAGE_SIZE);
> > > -	if (r < 0)
> > > -		goto out;
> > > +	for (idx = 0; idx < 3; idx++) {
> > > +		r = __copy_to_user(ua + PAGE_SIZE * idx, zero_page, PAGE_SIZE);
> > > +		if (r)
> > > +			return -EFAULT;
> > > +	}
> > 
> > Can this be done in a single __copy_to_user(), or do those helpers not like
> > crossing page boundaries?
> 
> Maybe because the zero_page is only PAGE_SIZE long? :)

Ha, yeah, that'd be a good reason to loop.

> [...]

