Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA41C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FDBE2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgE1C1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 22:27:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:22888 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgE1C1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 22:27:31 -0400
IronPort-SDR: 8f3bTmbZuOGH7yXlZ3Y2GC8WA2sEtl34y6kr35CD8+9RILwhDldoSixBNYkxMGMx5OFR7SvXKp
 7TVS5tEJZj+Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 19:27:31 -0700
IronPort-SDR: 6zwQDLrGWUi0I7d9r+VRi31OHGVG6seEkmHrcq1o8BsT639tTmyTSUKYYjypC2PChrLLZt2uyI
 EjXdS/JnZrUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,443,1583222400"; 
   d="scan'208";a="270692992"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by orsmga006.jf.intel.com with ESMTP; 27 May 2020 19:27:31 -0700
Date:   Wed, 27 May 2020 19:27:31 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+904752567107eefb728c@syzkaller.appspotmail.com
Subject: Re: [PATCH] KVM: x86: Initialize tdp_level during vCPU creation
Message-ID: <20200528022730.GE25962@linux.intel.com>
References: <20200527085400.23759-1-sean.j.christopherson@intel.com>
 <875zch66fy.fsf@vitty.brq.redhat.com>
 <c444fbcc-8ac3-2431-4cdb-2a37b93b1fa2@redhat.com>
 <20200527162318.GD24461@linux.intel.com>
 <e2b9d767-df19-2974-8457-737b925749d3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2b9d767-df19-2974-8457-737b925749d3@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 06:56:02PM +0200, Paolo Bonzini wrote:
> On 27/05/20 18:23, Sean Christopherson wrote:
> > Hmm, one option would be to make .get_tdp_level() pure function by passing
> > in vcpu->arch.maxphyaddr.  That should make the comment redundant.  I don't
> > love bleeding VMX's implementation into the prototype, but that ship has
> > kinda already sailed.
> 
> Well, it's not bleeding the implementation that much, guest MAXPHYADDR
> is pretty much the only reason why it's a function and not a constant.
> 
> Another possibility BTW is to make the callback get_max_tdp_level and
> make get_tdp_level a function in mmu.c.

I like that idea.  We could even avoid get_max_tdp_level() by passing that
info into kvm_configure_mmu(), though that may not actually be cleaner.
I'll play around with it.
