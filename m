Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF92DC3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F0F2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgCEPgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:36:25 -0500
Received: from mga12.intel.com ([192.55.52.136]:35096 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbgCEPgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:36:25 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 07:36:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="413554525"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga005.jf.intel.com with ESMTP; 05 Mar 2020 07:36:23 -0800
Date:   Thu, 5 Mar 2020 07:36:23 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: x86: VMX: rename 'kvm_area' to 'vmxon_region'
Message-ID: <20200305153623.GA11500@linux.intel.com>
References: <20200305100123.1013667-1-vkuznets@redhat.com>
 <20200305100123.1013667-2-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305100123.1013667-2-vkuznets@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Super nit: can I convince you to use "KVM: VMX:" instead of "KVM: x86: VMX:"?

  $ glo | grep -e "KVM: x86: nVMX" -e "KVM: x86: VMX:" | wc -l
  8
  $ glo | grep -e "KVM: nVMX" -e "KVM: VMX:" | wc -l
  1032

I'm very conditioned to scan for "KVM: *VMX:", e.g. I was about to complain
that this used the wrong scope :-)   And in the event that Intel adds a new
technology I'd like to be able to use "KVM: Intel:" and "KVM: ***X:"
instead of "KVM: x86: Intel:" and "KVM: x86: Intel: ***X:" for code that is
common to Intel versus specific to a technology.

On Thu, Mar 05, 2020 at 11:01:22AM +0100, Vitaly Kuznetsov wrote:
> The name 'kvm_area' is misleading (as we have way too many areas which are
> KVM related), what alloc_kvm_area()/free_kvm_area() functions really do is
> allocate/free VMXON region for all CPUs. Rename accordingly.
> 
> No functional change intended.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---

+1000

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
