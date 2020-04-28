Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E67C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA67620575
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbgD1SyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729263AbgD1SyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:54:21 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3438C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 11:54:21 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jTVMo-0002sR-0A; Tue, 28 Apr 2020 20:54:02 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 40B54100FC0; Tue, 28 Apr 2020 20:54:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Jacob Pan \(Jun\)" <jacob.jun.pan@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org,
        jacob.jun.pan@intel.com
Subject: Re: [PATCH 5/7] x86/mmu: Allocate/free PASID
In-Reply-To: <20200428112113.000033bd@intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com> <1585596788-193989-6-git-send-email-fenghua.yu@intel.com> <87pnbus3du.fsf@nanos.tec.linutronix.de> <20200428112113.000033bd@intel.com>
Date:   Tue, 28 Apr 2020 20:54:01 +0200
Message-ID: <87tv13o306.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Jacob Pan (Jun)" <jacob.jun.pan@intel.com> writes:
> On Sun, 26 Apr 2020 16:55:25 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> Fenghua Yu <fenghua.yu@intel.com> writes:
>> > The PASID is freed when the process exits (so no need to keep
>> > reference counts on how many SVM devices are sharing the PASID).  
>> 
>> I'm not buying that. If there is an outstanding request with the PASID
>> of a process then tearing down the process address space and freeing
>> the PASID (which might be reused) is fundamentally broken.
>> 
> Device driver unbind PASID is tied to FD release. So when a process
> exits, FD close causes driver to do the following:
>
> 1. stops DMA
> 2. unbind PASID (clears the PASID entry in IOMMU, flush all TLBs, drain
> in flight page requests)

Fair enough. Explaining that somewhere might be helpful.

> For bare metal SVM, if the last mmdrop always happens after FD release,
> we can ensure no outstanding requests at the point of ioasid_free().
> Perhaps this is a wrong assumption?

If fd release cleans up then how should there be something in flight at
the final mmdrop?

> For guest SVM, there will be more users of a PASID. I am also
> working on adding refcounting to ioasid. ioasid_free() will not release
> the PASID back to the pool until all references are dropped.

What does more users mean?

>> > +	if (mm && mm->context.pasid && !(flags &
>> > SVM_FLAG_PRIVATE_PASID)) {
>> > +		/*
>> > +		 * Once a PASID is allocated for this mm, the PASID
>> > +		 * stays with the mm until the mm is dropped. Reuse
>> > +		 * the PASID which has been already allocated for
>> > the
>> > +		 * mm instead of allocating a new one.
>> > +		 */
>> > +		ioasid_set_data(mm->context.pasid, svm);  
>> 
>> So if the PASID is reused several times for different SVMs then every
>> time ioasid_data->private is set to a different SVM. How is that
>> supposed to work?
>> 
> For the lifetime of the mm, there is only one PASID. svm_bind/unbind_mm
> could happen many times with different private data: intel_svm.
> Multiple devices can bind to the same PASID as well. But private data
> don't change within the first bind and last unbind.

Ok. I read through that spaghetti of intel_svm_bind_mm() again and now I
start to get an idea how that is supposed to work. What a mess.

That function really wants to be restructured in a way so it is
understandable to mere mortals. 

Thanks,

        tglx
