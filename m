Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0360EC81857
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 22:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9ED92074F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 22:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgD0WTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 18:19:22 -0400
Received: from mga07.intel.com ([134.134.136.100]:8694 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgD0WTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 18:19:21 -0400
IronPort-SDR: 007CryCb4mwg1j35+hUgLy1K9p8bic7Gbm5GUWq0qkQzTfi8+xblYRAUaIDFTIy+feQ7yIU+CH
 qj1ZjCMG5DAA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 15:19:21 -0700
IronPort-SDR: BFmJTyB98rA6mgCORWnTzUTjoDeK1ZBZg5m2FQFa7vx5ekRq+U/gnzi9yqFs2Ublnezg9760tu
 56TLnBdbWElA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; 
   d="scan'208";a="275629371"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga002.jf.intel.com with ESMTP; 27 Apr 2020 15:19:21 -0700
Date:   Mon, 27 Apr 2020 15:18:25 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org
Subject: Re: [PATCH 5/7] x86/mmu: Allocate/free PASID
Message-ID: <20200427221825.GF242333@romley-ivt3.sc.intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
 <1585596788-193989-6-git-send-email-fenghua.yu@intel.com>
 <87pnbus3du.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnbus3du.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 04:55:25PM +0200, Thomas Gleixner wrote:
> Fenghua Yu <fenghua.yu@intel.com> writes:
> > +++ b/arch/x86/include/asm/mmu.h @@ -50,6 +50,10 @@ typedef struct {
> >  	u16 pkey_allocation_map; s16 execute_only_pkey;
> >  #endif
> > + +#ifdef CONFIG_INTEL_IOMMU_SVM +	int pasid;
> 
> int? It's a value which gets programmed into the MSR along with the valid 
> bit (bit 31) set.

The pasid is defined as "int" in struct intel_svm and in 
intel_svm_bind_mm() and intel_svm_unbind_mm(). So the pasid defined in this 
patch follows the same type defined in those places.

But as you pointed out below, ioasid_t is defined as "unsigned int".

> 
> >  extern void switch_mm(struct mm_struct *prev, struct mm_struct *next, 
> > diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c 
> > index d7f2a5358900..da718a49e91e 100644 --- a/drivers/iommu/intel-svm.c 
> > +++ b/drivers/iommu/intel-svm.c @@ -226,6 +226,45 @@ static 
> > LIST_HEAD(global_svm_list);
> >  	list_for_each_entry((sdev), &(svm)->devs, list)	\
> >  		if ((d) != (sdev)->dev) {} else
> >  
> > +/* + * If this mm already has a PASID we can use it. Otherwise 
> > allocate a new one. + * Let the caller know if we did an allocation via 
> > 'new_pasid'. + */ +static int alloc_pasid(struct intel_svm *svm, struct 
> > mm_struct *mm, + int pasid_max, bool *new_pasid, int flags)
> 
> Again, data types please. flags are generally unsigned and not plain int. 
> Also pasid_max is certainly not plain int either.

The caller defines pasid_max and flags as "int". This function just follows
the caller's definitions.

But I will change their definitions to "unsigned int" here.

> 
> > + *new_pasid = false; + + return mm->context.pasid; + } + + /* + * 
> > Allocate a new pasid. Do not use PASID 0, reserved for RID to + * 
> > PASID. + */ + pasid = ioasid_alloc(NULL, PASID_MIN, pasid_max - 1, 
> > svm);
> 
> ioasid_alloc() uses ioasid_t which is
> 
> typedef unsigned int ioasid_t;
> 
> Can we please have consistent types and behaviour all over the place?

Should I just define "pasid", "pasid_max", "flags" as "unsigned int" for
the new functions/code?

Or should I also change their types to "unsigned int" in the original
svm code (struct intel_svm, ...bind_mm(), etc)? I'm afraid that will be
a lot of changes and should be in a separate preparation patch.

Thanks.

-Fenghua
