Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E8EC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A58227BF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgBERCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 12:02:10 -0500
Received: from mga04.intel.com ([192.55.52.120]:15693 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbgBERCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 12:02:10 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 09:02:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,406,1574150400"; 
   d="scan'208";a="220160548"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga007.jf.intel.com with ESMTP; 05 Feb 2020 09:02:09 -0800
Date:   Wed, 5 Feb 2020 09:02:09 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 04/26] KVM: x86: Add a kvm_x86_ops hook to query
 virtualized MSR support
Message-ID: <20200205170209.GH4877@linux.intel.com>
References: <20200129234640.8147-1-sean.j.christopherson@intel.com>
 <20200129234640.8147-5-sean.j.christopherson@intel.com>
 <87eev9ksqy.fsf@vitty.brq.redhat.com>
 <20200205145923.GC4877@linux.intel.com>
 <8736bpkqif.fsf@vitty.brq.redhat.com>
 <20200205153508.GD4877@linux.intel.com>
 <87tv45j7nf.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tv45j7nf.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 05:55:32PM +0100, Vitaly Kuznetsov wrote:
> Sean Christopherson <sean.j.christopherson@intel.com> writes:
> > I dug deeper into the CPUID crud after posting this series because I really
> > didn't like the end result for vendor-specific leafs, and ended up coming
> > up with (IMO) a much more elegant solution.
> >
> > https://lkml.kernel.org/r/20200201185218.24473-1-sean.j.christopherson@intel.com/
> >
> > or on patchwork
> >
> > https://patchwork.kernel.org/cover/11361361/
> >
> 
> Thanks, I saw it. I tried applying it to kvm/next earlier today but
> failed. Do you by any chance have a git branch somewhere? I'll try to
> review it and test at least AMD stuff (if AMD people don't beat me to it
> of course).

Have you tried kvm/queue?  I'm pretty sure I based the code on kvm/queue.
If that doesn't work, I'll push a tag to my github repo.

This is exactly why I usually note the base for large series.  *sigh*
