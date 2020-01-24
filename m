Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7196C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 21:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74FAA2071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 21:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgAXVdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 16:33:53 -0500
Received: from mga06.intel.com ([134.134.136.31]:18199 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgAXVdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 16:33:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2020 13:33:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,359,1574150400"; 
   d="scan'208";a="428415627"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga006.fm.intel.com with ESMTP; 24 Jan 2020 13:33:26 -0800
Date:   Fri, 24 Jan 2020 13:33:26 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, KVM <kvm@vger.kernel.org>
Subject: Re: linux-next: Tree for Jan 24 (kvm)
Message-ID: <20200124213326.GQ2109@linux.intel.com>
References: <20200124173302.2c3228b2@canb.auug.org.au>
 <38d53302-b700-b162-e766-2e2a461fc569@infradead.org>
 <8f6e1118-85ef-6e0d-b023-1277e7d42a1c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f6e1118-85ef-6e0d-b023-1277e7d42a1c@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 12:59:56PM -0800, Randy Dunlap wrote:
> On 1/24/20 12:51 PM, Randy Dunlap wrote:
> > On 1/23/20 10:33 PM, Stephen Rothwell wrote:
> >> Hi all,
> >>
> >> Changes since 20200123:
> >>
> >> The kvm tree gained a conflict against Linus' tree.
> >>
> > 
> > on i386:
> > 
> > ../arch/x86/kvm/x86.h:363:16: warning: right shift count >= width of type [-Wshift-count-overflow]
> > 
> > 
> 
> Sorry, I missed these 2 warnings:
> 
> ../arch/x86/kvm/vmx/vmx.c: In function 'vmx_set_msr':
> ../arch/x86/kvm/vmx/vmx.c:2001:14: warning: '~' on a boolean expression [-Wbool-operation]
>    if (data & ~kvm_spec_ctrl_valid_bits(vcpu))
>               ^
> 
> 
> ../arch/x86/kvm/svm.c: In function 'svm_set_msr':
> ../arch/x86/kvm/svm.c:4289:14: warning: '~' on a boolean expression [-Wbool-operation]
>    if (data & ~kvm_spec_ctrl_valid_bits(vcpu))
>               ^
> ../arch/x86/kvm/svm.c:4289:14: note: did you mean to use logical not?
>    if (data & ~kvm_spec_ctrl_valid_bits(vcpu))
>               ^
>               !

Paolo has a fix in the works for this[1], pretty sure he's going to fixup
the offending commit directly[2].

Thanks!

[1] https://lkml.kernel.org/r/6b725990-f0c2-6577-be7e-44e101e540b5@redhat.com
[2] https://lkml.kernel.org/r/8f43bd04-9f4e-5c06-8d1d-cb84bba40278@redhat.com

> 
> -- 
> ~Randy
> 
