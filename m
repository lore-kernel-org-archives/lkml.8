Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE81DC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01662469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgB1PJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:09:17 -0500
Received: from mga01.intel.com ([192.55.52.88]:29335 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbgB1PJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:09:15 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 07:09:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,496,1574150400"; 
   d="scan'208";a="437442091"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga005.fm.intel.com with ESMTP; 28 Feb 2020 07:09:14 -0800
Date:   Fri, 28 Feb 2020 07:09:14 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 39/61] KVM: SVM: Convert feature updates from CPUID to
 KVM cpu caps
Message-ID: <20200228150914.GB2329@linux.intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com>
 <20200201185218.24473-40-sean.j.christopherson@intel.com>
 <0f21b023-000d-9d78-b9b4-b9d377840385@redhat.com>
 <20200228002833.GB30452@linux.intel.com>
 <20200228003613.GC30452@linux.intel.com>
 <052d2bdf-d2da-36c0-2fb5-563b5bf5f2ed@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <052d2bdf-d2da-36c0-2fb5-563b5bf5f2ed@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 08:03:33AM +0100, Paolo Bonzini wrote:
> On 28/02/20 01:36, Sean Christopherson wrote:
> > Regarding NRIPS, the original commit added the "Support next_rip if host
> > supports it" comment, but I can't tell is "host supports" means "supported
> > in hardware" or "supported by KVM".  In other words, should I make the cap
> > dependent "nrips" or leave it as is?
> > 
> 
> The "nrips" parameter came later.  For VMX we generally remove guest
> capabilities if the corresponding parameter is on, so it's a good idea
> to do the same for SVM.

Huh.  I swear I looked at the code from the original commit and saw nrips
there, but it was clearly added in 2019 via commit d647eb63e671 ("KVM: svm:
add nrips module parameter").
