Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69F4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8887B206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgG2UjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:39:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:21659 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgG2UjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 16:39:06 -0400
IronPort-SDR: p6U9T9kG69l6Y3+r/Bhm4j1ik+TNN4NPlkPGA74B10cP+XmIsEAgYi/EepG3r0a9YH6QFnKoID
 n/lREAYTpGKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="151475459"
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="151475459"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 13:39:06 -0700
IronPort-SDR: 5bj+HJhB3g6OZan9Ybk8bv1rZ1uEMY3gM6zY+I/QWBh05HaHXFTiKSD2OD5oayFhMGelAS5Ff+
 QYnBIteO5eEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="394768547"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jul 2020 13:39:05 -0700
Date:   Wed, 29 Jul 2020 13:39:05 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Li, Xiaoyao" <xiaoyao.li@intel.com>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] x86/bus_lock: Enable bus lock detection
Message-ID: <20200729203905.GN27751@linux.intel.com>
References: <1595021700-68460-1-git-send-email-fenghua.yu@intel.com>
 <20200729030232.GE5583@linux.intel.com>
 <e23b04a2adc54a5dbca48271987de822@intel.com>
 <20200729184614.GI27751@linux.intel.com>
 <20200729194259.GA318576@otcwcpicx6.sc.intel.com>
 <20200729200033.GJ27751@linux.intel.com>
 <20200729203557.GA318595@otcwcpicx6.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729203557.GA318595@otcwcpicx6.sc.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 08:35:57PM +0000, Fenghua Yu wrote:
> Hi, Sean,
> 
> On Wed, Jul 29, 2020 at 01:00:33PM -0700, Sean Christopherson wrote:
> > On Wed, Jul 29, 2020 at 07:42:59PM +0000, Fenghua Yu wrote:
> > > > Smushing the two into a single option is confusing, e.g. from the table
> > > > below it's not at all clear what will happen if sld=fatal, both features
> > > > are supported, and the kernel generates a split lock.
> > > > 
> > > > Given that both SLD (per-core, not architectural) and BLD (#DB recursion and
> > > > inverted DR6 flag) have warts, it would be very nice to enable/disable them
> > > > independently.  The lock to non-WB behavior for BLD may also be problematic,
> > > > e.g. maybe it turns out that fixing drivers to avoid locks to non-WB isn't
> > > > as straightforward as avoiding split locks.
> > > 
> > > But the two features are related if both of them are enabled in hardware:
> > > If a split lock happens, SLD will generate #AC before instruction execution
> > > and BLD will generate #DB after instruction execution.
> > > 
> > > The software needs to make them exclusive. The same kernel option reflects
> > > the relationship and make them exclusive, e.g. "fatal" enables SLD and
> > > disables BLD, "warn" does the other way.
> > 
> > Why do they need to be exclusive?  We've already established that BLD catches
> > things that SLD does not.  What's wrong with running sld=fatal and bld=ratelimit
> > so that split locks never happen and kill applications, and non-WB locks are
> > are ratelimited?
> 
> Sorry if I didn't explain bus lock and split lock detections clearly before.
> 
> There are two causes of bus locks:
> 1. a locked access across cache line boundary: this is split lock.
> 2. a locked access to non-WB memory.
> 
> BLD detects both causes and SLD only detects the first one, i.e. BLD can detect
> both split lock AND lock to non-WB memory.
> 
> If sld=fatal and bld=ratelimit (both sld and bld are enabled in hw),
> a split lock always generates #AC and kills the app and bld will never have
> a chance to trigger #DB for split lock. So effectively the combination makes
> the kernel to take two different actions after detecting a bus lock: if the
> bus lock comes from a split lock, fatal (sld); if the bus lock comes from
> lock to non-WB memory, ratelimit (bld). Seems this is not a useful combination
> and is not what the user really wants to do because the user wants ratelimit
> for BLD, right?

I understood all off that.  And as I user I want to run sld=fatal and
bld=ratelimit to provide maximum protection, i.e. disallow split locks at
all times, and ratelimit the crud SLD #AC can't catch.
