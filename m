Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355E8C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2075120780
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbgDQTMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:12:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:48467 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728223AbgDQTL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:11:59 -0400
IronPort-SDR: MF9Yyj5QDdOYabRmE6wT1eVt8xxz34g2Z4hEIC/siSN3Q93xG7rG/MMxnYVen/xvuWkPwlXoQR
 rTwEmXjwOyhg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 12:11:59 -0700
IronPort-SDR: Cj7NFqYKB4Vr6aF2AtD3poafxbzMBlmyVx6d5dkZft7ZJuuLNPoM5oig1wPwbpktNDe/4x57D+
 UbzJm7ZhR1Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,395,1580803200"; 
   d="scan'208";a="244789479"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga007.fm.intel.com with ESMTP; 17 Apr 2020 12:11:59 -0700
Date:   Fri, 17 Apr 2020 12:11:59 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH 0/3] KVM: x86: move nested-related kvm_x86_ops to a
 separate struct
Message-ID: <20200417191159.GA14609@linux.intel.com>
References: <20200417164413.71885-1-pbonzini@redhat.com>
 <20200417190553.GI287932@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417190553.GI287932@xz-x1>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 03:05:53PM -0400, Peter Xu wrote:
> On Fri, Apr 17, 2020 at 12:44:10PM -0400, Paolo Bonzini wrote:
> > While this reintroduces some pointer chasing that was removed in
> > afaf0b2f9b80 ("KVM: x86: Copy kvm_x86_ops by value to eliminate layer
> > of indirection", 2020-03-31), the cost is small compared to retpolines
> > and anyway most of the callbacks are not even remotely on a fastpath.
> > In fact, only check_nested_events should be called during normal VM
> > runtime.  When static calls are merged into Linux my plan is to use them
> > instead of callbacks, and that will finally make things fast again by
> > removing the retpolines.
> 
> Paolo,
> 
> Just out of curiousity: is there an explicit reason to not copy the
> whole kvm_x86_nested_ops but use pointers (since after all we just
> reworked kvm_x86_ops)?

Ya, my vote would be to copy by value as well.  I'd also be in favor of
dropping the _ops part, e.g.

  struct kvm_x86_ops {
        struct kvm_x86_nested_ops nested;

        ...
  };

and drop the "nested" parts from the ops, e.g.

  check_nested_events() -> check_events()

which yields:

	r = kvm_x86_ops.nested.check_events(vcpu);
	if (r != 0)
		return r;

I had this coded up but shelved it when svm.c got fractured :-).
