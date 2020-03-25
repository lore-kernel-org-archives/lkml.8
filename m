Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E59EC54FCF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4760020719
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgCYPsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:48:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:41526 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbgCYPsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:48:12 -0400
IronPort-SDR: H7QHC5JvcRqbdIxTOlGsqRWkg5rV+ZM8TKJjwjweEte28FiRCDtHFPN3/HjRTvdRhm93nSc4NZ
 iIC83QxYrHwQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 08:48:12 -0700
IronPort-SDR: cueDm/sOY9PGMvf3GoIW8dpFzWxkHFbyNLfYb/y86MuDHH4bAV7S6l6IHqmSdsP3daRE039x/X
 +IWa1pi/7NNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; 
   d="scan'208";a="446660860"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga005.fm.intel.com with ESMTP; 25 Mar 2020 08:48:10 -0700
Date:   Wed, 25 Mar 2020 08:48:10 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Junaid Shahid <junaids@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 14/37] KVM: x86: Move "flush guest's TLB" logic to
 separate kvm_x86_ops hook
Message-ID: <20200325154810.GE14294@linux.intel.com>
References: <20200320212833.3507-1-sean.j.christopherson@intel.com>
 <20200320212833.3507-15-sean.j.christopherson@intel.com>
 <87369w7mxe.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87369w7mxe.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 11:23:41AM +0100, Vitaly Kuznetsov wrote:
> Sean Christopherson <sean.j.christopherson@intel.com> writes:
> I *think* I've commented on the previous version that we also have
> hyperv-style PV TLB flush and this will likely need to be switched to
> tlb_flush_guest().

Oh, you most definitely commented about HyperV's PV TLB flush, looking at
that code is what led me down this rabbit hole :-)
