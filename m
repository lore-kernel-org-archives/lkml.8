Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D5DC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFCCE208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgD1UkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:40:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:11887 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgD1UkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 16:40:11 -0400
IronPort-SDR: cuYURl/TkHWPWgl6E4blwG/3hYJAzBPAd1xdCaI3Vy/drJlXO5WN9gypfDKhjN1O4c/y8U9Bj9
 jkcYLyVsFvHQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 13:40:11 -0700
IronPort-SDR: v6udWB+U4wE/22S2l8Wz/OFuo988K6Pf+8JjY9MBQ2pKbKK8v+meEgtG9vZQqIntj8Th5MCUzK
 uvqiQkGvxSpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; 
   d="scan'208";a="246624870"
Received: from jpan9-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.240.17])
  by orsmga007.jf.intel.com with SMTP; 28 Apr 2020 13:40:10 -0700
Date:   Tue, 28 Apr 2020 13:40:09 -0700
From:   "Jacob Pan (Jun)" <jacob.jun.pan@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, <iommu@lists.linux-foundation.org>,
        jacob.jun.pan@intel.com, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 5/7] x86/mmu: Allocate/free PASID
Message-ID: <20200428134009.00002f0d@intel.com>
In-Reply-To: <87tv13o306.fsf@nanos.tec.linutronix.de>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
        <1585596788-193989-6-git-send-email-fenghua.yu@intel.com>
        <87pnbus3du.fsf@nanos.tec.linutronix.de>
        <20200428112113.000033bd@intel.com>
        <87tv13o306.fsf@nanos.tec.linutronix.de>
Organization: intel
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 20:54:01 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> "Jacob Pan (Jun)" <jacob.jun.pan@intel.com> writes:
> > On Sun, 26 Apr 2020 16:55:25 +0200
> > Thomas Gleixner <tglx@linutronix.de> wrote:  
> >> Fenghua Yu <fenghua.yu@intel.com> writes:  
> >> > The PASID is freed when the process exits (so no need to keep
> >> > reference counts on how many SVM devices are sharing the
> >> > PASID).    
> >> 
> >> I'm not buying that. If there is an outstanding request with the
> >> PASID of a process then tearing down the process address space and
> >> freeing the PASID (which might be reused) is fundamentally broken.
> >>   
> > Device driver unbind PASID is tied to FD release. So when a process
> > exits, FD close causes driver to do the following:
> >
> > 1. stops DMA
> > 2. unbind PASID (clears the PASID entry in IOMMU, flush all TLBs,
> > drain in flight page requests)  
> 
> Fair enough. Explaining that somewhere might be helpful.
> 
Will do. I plan to document this in a kernel doc for IOASID/PASID
lifecycle management.

> > For bare metal SVM, if the last mmdrop always happens after FD
> > release, we can ensure no outstanding requests at the point of
> > ioasid_free(). Perhaps this is a wrong assumption?  
> 
> If fd release cleans up then how should there be something in flight
> at the final mmdrop?
> 
> > For guest SVM, there will be more users of a PASID. I am also
> > working on adding refcounting to ioasid. ioasid_free() will not
> > release the PASID back to the pool until all references are
> > dropped.  
> 
> What does more users mean?
For VT-d, a PASID can be used by VFIO, IOMMU driver, KVM, and Virtual
Device Composition Module (VDCM*) at the same time.

*https://software.intel.com/en-us/download/intel-data-streaming-accelerator-preliminary-architecture-specification

There are HW context associated with the PASID in IOMMU, KVM, and VDCM.
So before the lifetime of the PASID is over, clean up must be done in
all of the above. PASID cannot be reclaimed until the last user drops
its reference. Our plan is to do notification and refcouting.


> 
> >> > +	if (mm && mm->context.pasid && !(flags &
> >> > SVM_FLAG_PRIVATE_PASID)) {
> >> > +		/*
> >> > +		 * Once a PASID is allocated for this mm, the
> >> > PASID
> >> > +		 * stays with the mm until the mm is dropped.
> >> > Reuse
> >> > +		 * the PASID which has been already allocated
> >> > for the
> >> > +		 * mm instead of allocating a new one.
> >> > +		 */
> >> > +		ioasid_set_data(mm->context.pasid, svm);    
> >> 
> >> So if the PASID is reused several times for different SVMs then
> >> every time ioasid_data->private is set to a different SVM. How is
> >> that supposed to work?
> >>   
> > For the lifetime of the mm, there is only one PASID.
> > svm_bind/unbind_mm could happen many times with different private
> > data: intel_svm. Multiple devices can bind to the same PASID as
> > well. But private data don't change within the first bind and last
> > unbind.  
> 
> Ok. I read through that spaghetti of intel_svm_bind_mm() again and
> now I start to get an idea how that is supposed to work. What a mess.
> 
> That function really wants to be restructured in a way so it is
> understandable to mere mortals. 
> 

Agreed. We are adding many new features and converging with generic
sva_bind_device. Things will get more clear after we have fewer moving
pieces.


> Thanks,
> 
>         tglx

