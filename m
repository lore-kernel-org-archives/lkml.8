Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDA7C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7BE21744
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgAJRzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:55:38 -0500
Received: from mga01.intel.com ([192.55.52.88]:14202 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728616AbgAJRzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:55:38 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 09:55:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,417,1571727600"; 
   d="scan'208";a="238279735"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga002.jf.intel.com with ESMTP; 10 Jan 2020 09:55:37 -0800
Date:   Fri, 10 Jan 2020 09:55:37 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, jmattson@google.com,
        yu.c.zhang@linux.intel.com, alazar@bitdefender.com,
        edwin.zhai@intel.com
Subject: Re: [RESEND PATCH v10 06/10] vmx: spp: Set up SPP paging table at
 vmentry/vmexit
Message-ID: <20200110175537.GF21485@linux.intel.com>
References: <20200102061319.10077-1-weijiang.yang@intel.com>
 <20200102061319.10077-7-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102061319.10077-7-weijiang.yang@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 02:13:15PM +0800, Yang Weijiang wrote:
> If write to subpage is not allowed, EPT violation generates
> and it's handled in fast_page_fault().
> 
> In current implementation, SPPT setup is only handled in handle_spp()
> vmexit handler, it's triggered when SPP bit is set in EPT leaf
> entry while SPPT entries are not ready.
> 
> A SPP specific bit(11) is added to exit_qualification and a new
> exit reason(66) is introduced for SPP.

...

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 6f92b40d798c..c41791ebee65 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -6372,6 +6427,8 @@ unsigned long kvm_mmu_calculate_default_mmu_pages(struct kvm *kvm)
>  	return nr_mmu_pages;
>  }
>  
> +#include "spp.c"
> +

Unless there is a *very* good reason for these shenanigans, spp.c needs
to built via the Makefile like any other source.  If this is justified
for whatever reason, then that justification needs to be very clearly
stated in the changelog.

In general, the code organization of this entire series likely needs to
be overhauled.  There are gobs exports which are either completely
unnecessary or completely backswards.

E.g. exporting VMX-only functions from spp.c, which presumably are only
callbed by VMX.

	EXPORT_SYMBOL_GPL(vmx_spp_flush_sppt);
	EXPORT_SYMBOL_GPL(vmx_spp_init);

Exporting ioctl helpers from the same file, which are presumably called
only from x86.c.

	EXPORT_SYMBOL_GPL(kvm_vm_ioctl_get_subpages);
	EXPORT_SYMBOL_GPL(kvm_vm_ioctl_set_subpages);
