Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FB2C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6932220736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgDXOQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 10:16:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:2322 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727087AbgDXOQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 10:16:50 -0400
IronPort-SDR: +ysYkP1Z5oqCkJ5aPXtvICR0DRZUTtpyzlqYSfIJlxCuHBxJzmKvcIDSKK3ujqYapU29jY0d19
 sBCsT6Hkfhiw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 07:16:49 -0700
IronPort-SDR: 8lWKh+lFmaDdfLAVEWNkwWjRNvnGgEH772h9/wxepDx3LQ69+kAzq6ZmP4y4y+NdkiRIm2+1CY
 N1zlqFWAN9IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,311,1583222400"; 
   d="scan'208";a="256380052"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga003.jf.intel.com with ESMTP; 24 Apr 2020 07:16:49 -0700
Date:   Fri, 24 Apr 2020 07:16:49 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: nVMX: Store vmcs.EXIT_QUALIFICATION as an unsigned
 long, not u32
Message-ID: <20200424141649.GA30013@linux.intel.com>
References: <20200423001127.13490-1-sean.j.christopherson@intel.com>
 <87wo65nm67.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo65nm67.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 01:44:00PM +0200, Vitaly Kuznetsov wrote:
> I also did 'git grep -W 'u32.*exit_qual' kvm/queue' and I can see a few
> more places where 'exit_qual' is u32:
> nested_vmx_check_guest_state()
> nested_vmx_enter_non_root_mode()
> vmx_set_nested_state()
> 
> Being too lazy to check an even if there are no immediate issues with
> that, should we just use 'unsigned long' everywhere?

Yes, absolutely, I'll send a patch.

The existing cases are benign, they're all related to setting the exit_qual
for a nested VM-Enter failure, which could fit in a u8.  But still worth
fixing.
