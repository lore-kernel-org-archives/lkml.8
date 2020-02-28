Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BFFC3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 01:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C2324697
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 01:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbgB1Bh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 20:37:26 -0500
Received: from mga02.intel.com ([134.134.136.20]:32960 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730374AbgB1Bh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 20:37:26 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 17:37:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; 
   d="scan'208";a="227381654"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga007.jf.intel.com with ESMTP; 27 Feb 2020 17:37:24 -0800
Date:   Thu, 27 Feb 2020 17:37:24 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/61] KVM: x86: Introduce KVM cpu caps
Message-ID: <20200228013724.GD30452@linux.intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com>
 <87wo8ak84x.fsf@vitty.brq.redhat.com>
 <a52b3d92-5df6-39bd-f3e7-2cdd4f3be6cb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a52b3d92-5df6-39bd-f3e7-2cdd4f3be6cb@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 04:25:34PM +0100, Paolo Bonzini wrote:
> On 25/02/20 16:18, Vitaly Kuznetsov wrote:
> > Would it be better or worse if we eliminate set_supported_cpuid() hook
> > completely by doing an ugly hack like (completely untested):
> 
> Yes, it makes sense.

Works for me, I'll tack it on.  I think my past self kept it because I was
planning on using vmx_set_supported_cpuid() for SGX, which adds multiple
sub-leafs, but I'm pretty sure I can squeeze them into kvm_cpu_caps with
a few extra shenanigans.
