Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEC3C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E64F20722
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgCTNxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:53:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:48143 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgCTNxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:53:47 -0400
IronPort-SDR: ip6yiPGxMQo+lTkNRk/SbreZheGigzoCJM/BOcwaW7bCkw3SwIJo8sLHgomrQ0AJtfSZe4hAf/
 0qjQbU4vhyFQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 06:53:46 -0700
IronPort-SDR: gmdAWcBXmpzaTYcm0AnNoq5+jjZPB3q9980RAUKlGVDhF98GZNtOmdT0sAd9wh/RyG0VLkkdCu
 30xNVdd5+Dyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,284,1580803200"; 
   d="scan'208";a="392156602"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga004.jf.intel.com with ESMTP; 20 Mar 2020 06:53:46 -0700
Date:   Fri, 20 Mar 2020 06:53:46 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Christoffer Dall <christoffer.dall@arm.com>
Subject: Re: slab-out-of-bounds due to "KVM: Dynamically size memslot array
 based on number of used slots"
Message-ID: <20200320135346.GA16533@linux.intel.com>
References: <8922D835-ED2A-4C48-840A-F568E20B5A7C@lca.pw>
 <20200320043403.GH11305@linux.intel.com>
 <5FF6AF4E-EB99-4111-BBB2-FE09FFBEF5C4@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5FF6AF4E-EB99-4111-BBB2-FE09FFBEF5C4@lca.pw>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 09:49:03AM -0400, Qian Cai wrote:
> 
> 
> > On Mar 20, 2020, at 12:34 AM, Sean Christopherson <sean.j.christopherson@intel.com> wrote:
> > 
> > On Thu, Mar 19, 2020 at 11:59:23PM -0400, Qian Cai wrote:
> >> Reverted the linux-next commit 36947254e5f98 (“KVM: Dynamically size memslot array based on number of used slots”)
> >> fixed illegal slab object redzone accesses.
> >> 
> >> [6727.939776][ T1818] BUG: KASAN: slab-out-of-bounds in gfn_to_hva+0xc1/0x2b0 [kvm]
> >> search_memslots at include/linux/kvm_host.h:1035
> > 
> > Drat.  I'm guessing lru_slot is out of range after a memslot is deleted.
> > This should fix the issue, though it may not be the most proper fix, e.g.
> > it might be better to reset lru_slot when deleting a memslot.  I'll try and
> > reproduce tomorrow, unless you can confirm this does the trick.
> 
> It works fine.

Thanks!  I'll send a proper patch in a bit, tweaking a selftest to try and
hit this as well.
