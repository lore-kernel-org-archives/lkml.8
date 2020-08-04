Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA8CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 18:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56EBF21744
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 18:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgHDSls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 14:41:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:6550 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbgHDSlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 14:41:47 -0400
IronPort-SDR: /tAu4mTCxE/zxSxUg73ixnRKXY/ii5wVZV9FQSAIJiclNWhnub3/NX0RO//4JQZs26DmViJw1a
 OWpxf/JE7tMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="151614819"
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="151614819"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 11:41:47 -0700
IronPort-SDR: P+On/KCPJFb54D29X8R4zo1HrfN2yDd2vovuqum2UHaH3TWSdydxYK2ttZHqE8ilDjkYRjI05E
 uGGxcFW5k0fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="322855740"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.160])
  by orsmga008.jf.intel.com with ESMTP; 04 Aug 2020 11:41:46 -0700
Date:   Tue, 4 Aug 2020 11:41:46 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
Subject: Re: [PATCH] KVM: x86: Don't attempt to load PDPTRs when 64-bit mode
 is enabled
Message-ID: <20200804184146.GA16023@linux.intel.com>
References: <20200714015732.32426-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714015732.32426-1-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 06:57:32PM -0700, Sean Christopherson wrote:
> Don't attempt to load PDPTRs if EFER.LME=1, i.e. if 64-bit mode is
> enabled.  A recent change to reload the PDTPRs when CR0.CD or CR0.NW is
> toggled botched the EFER.LME handling and sends KVM down the PDTPR path
> when is_paging() is true, i.e. when the guest toggles CD/NW in 64-bit
> mode.
> 
> Split the CR0 checks for 64-bit vs. 32-bit PAE into separate paths.  The
> 64-bit path is specifically checking state when paging is toggled on,
> i.e. CR0.PG transititions from 0->1.  The PDPTR path now needs to run if
> the new CR0 state has paging enabled, irrespective of whether paging was
> already enabled.  Trying to shave a few cycles to make the PDPTR path an
> "else if" case is a mess.
> 
> Fixes: d42e3fae6faed ("kvm: x86: Read PDPTEs on CR0.CD and CR0.NW changes")
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Oliver Upton <oupton@google.com>
> Cc: Peter Shier <pshier@google.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---

Ping.  This really needs to be in the initial pull for 5.9, as is kvm/queue
has a 100% fatality rate for me.
