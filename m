Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97119C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795682072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgCEQAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 11:00:24 -0500
Received: from mga02.intel.com ([134.134.136.20]:42329 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbgCEQAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 11:00:24 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 08:00:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="259222061"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga002.jf.intel.com with ESMTP; 05 Mar 2020 08:00:18 -0800
Date:   Thu, 5 Mar 2020 08:00:18 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: x86: VMX: rename 'kvm_area' to 'vmxon_region'
Message-ID: <20200305160017.GE11500@linux.intel.com>
References: <20200305100123.1013667-1-vkuznets@redhat.com>
 <20200305100123.1013667-2-vkuznets@redhat.com>
 <20200305153623.GA11500@linux.intel.com>
 <875zfig5ec.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zfig5ec.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 04:58:35PM +0100, Vitaly Kuznetsov wrote:
> Sean Christopherson <sean.j.christopherson@intel.com> writes:
> 
> > Super nit: can I convince you to use "KVM: VMX:" instead of "KVM: x86: VMX:"?
> >
> >   $ glo | grep -e "KVM: x86: nVMX" -e "KVM: x86: VMX:" | wc -l
> >   8
> >   $ glo | grep -e "KVM: nVMX" -e "KVM: VMX:" | wc -l
> >   1032
> >
> > I'm very conditioned to scan for "KVM: *VMX:", e.g. I was about to complain
> > that this used the wrong scope :-)   And in the event that Intel adds a new
> > technology I'd like to be able to use "KVM: Intel:" and "KVM: ***X:"
> > instead of "KVM: x86: Intel:" and "KVM: x86: Intel: ***X:" for code that is
> > common to Intel versus specific to a technology.
> 
> What if someone else adds VMX instead? :-)

I never said it was a _good_ plan :-D
