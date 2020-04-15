Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07A4C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDB4C2076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411284AbgDORcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:32:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:2222 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411254AbgDORcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:32:23 -0400
IronPort-SDR: wvHLy714rTSlYcNhNlv+aRA5aHOerVTU7dJQbUch7nE3n99YpLYvKoOKz7fK7tI78g8g28zIiP
 jFDC2ytqc2FQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 10:32:21 -0700
IronPort-SDR: UPm9YQA1HstvxIqgWlU3zNpxyUt+ZwupuVkwia5v26qAtu66LLTG2cj0kvhRT5lV/Dwn4+r2AP
 c2pza6vfIk6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,387,1580803200"; 
   d="scan'208";a="363732914"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga001.fm.intel.com with ESMTP; 15 Apr 2020 10:32:21 -0700
Date:   Wed, 15 Apr 2020 10:32:21 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jon Cargille <jcargill@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Northup <digitaleric@gmail.com>,
        Eric Northup <digitaleric@google.com>
Subject: Re: [PATCH 1/1] KVM: pass through CPUID(0x80000006)
Message-ID: <20200415173221.GC30627@linux.intel.com>
References: <20200415012320.236065-1-jcargill@google.com>
 <20200415023726.GD12547@linux.intel.com>
 <20200415025105.GE12547@linux.intel.com>
 <CANxmayh4P5hhbJPxAnA2nvbzZC9EwFPeVCxDrkHzu8h6Y7JPPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANxmayh4P5hhbJPxAnA2nvbzZC9EwFPeVCxDrkHzu8h6Y7JPPQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 10:22:16AM -0700, Jon Cargille wrote:
> > I assume you want to say something like:
> 
> That's a much better commit message--thank you, Sean!
> 
> > Jim's tag is unnecessary, unless he was a middleman between Eric and Jon,
> 
> I appreciate the feedback; I was trying to capture that Jim "was in the
> patch's delivery path." (per submitting-patches.rst), but it sounds like that
> is intended for a more explicit middle-man relationship than I had
> understood.

Yep, exactly.

> Jim reviewed it internally before sending, which sounds like it should be
> expressed as an "Acked-by" instead; is that accurate?

Or Reviewed-by.  The proper (and easiest) way to handle this is to use
whatever tag Jim (or any other reviewer) provides, e.g. submitting-patches
states, under 12) When to use Acked-by:, Cc:, and Co-developed-by:, states:

  If a person has had the opportunity to comment on a patch, but has not
  provided such comments, you may optionally add a ``Cc:`` tag to the patch.
  This is the only tag which might be added without an explicit action by the
  person it names

I.e. all *-by tags are only supposed to be used with explicit permission
from the named person.  This doesn't mean the person has to literally write
Reviewed-by or whatever (though that's usually the case), but it does mean
you should confirm it's ok to add a tag, e.g. if someone replies "LGTM" and
you want to interpret that as a Reviewed-by or Acked-by, explicitly ask if
it's ok to add the tag.
