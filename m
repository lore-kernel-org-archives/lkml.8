Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D90C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD51220809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgG2TnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:43:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:27520 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2TnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 15:43:00 -0400
IronPort-SDR: HK22QScsf9v7QXhE8ubZc/cWmdtXqFs8UREcOFRMdHYQbiAPmup12c3uwCsOgcACRENYPftVDp
 hZ4ThWSijPDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="149325711"
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="149325711"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 12:42:59 -0700
IronPort-SDR: vyO1B/mhpSv8RYoTu+4lYJUGBf2tr+TOflJ3K1vNXIWZxEhSDxrxWsNncnwjZoc+FO5DSR1IBQ
 DatswMsKXP7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="272710679"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jul 2020 12:42:59 -0700
Date:   Wed, 29 Jul 2020 19:42:59 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Li, Xiaoyao" <xiaoyao.li@intel.com>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] x86/bus_lock: Enable bus lock detection
Message-ID: <20200729194259.GA318576@otcwcpicx6.sc.intel.com>
References: <1595021700-68460-1-git-send-email-fenghua.yu@intel.com>
 <20200729030232.GE5583@linux.intel.com>
 <e23b04a2adc54a5dbca48271987de822@intel.com>
 <20200729184614.GI27751@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729184614.GI27751@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Sean,

On Wed, Jul 29, 2020 at 11:46:14AM -0700, Sean Christopherson wrote:
> On Wed, Jul 29, 2020 at 11:09:16AM -0700, Yu, Fenghua wrote:
> > > > Some CPUs have ability to notify the kernel by an #DB trap after the
> > > > instruction acquires a bus lock and is executed. This allows the
> > > > kernel to enforce user application throttling or mitigations and also
> > > > provides a better environment to debug kernel split lock issues since
> > > > the kernel can continue instead of crashing.
> > > >
> > > > #DB for bus lock detect fixes all issues in #AC for split lock detect:
> > > 
> > > Fixes "all" issues... and creates some new ones, e.g. there are use cases
> > > where preventing the split lock from happening in the first place is strongly
> > > desired.  It's why that train wreck exists.
> > 
> > Bus Lock Detection doesn't replace Split Lock Detection. If both features
> > are enabled, default behavior is warning from bus lock, fatal behavior is
> > still from split lock. See the behavior table as follows.
> > 
> > > 
> > > > 1) It's architectural ... just need to look at one CPUID bit to know it
> > > >    exists
> > > > 2) The IA32_DEBUGCTL MSR, which reports bus lock in #DB, is per-thread.
> > > >    So each process or guest can have different behavior.
> > > > 3) It has support for VMM/guests (new VMEXIT codes, etc).
> > > >
> > > > Use the existing kernel command line option "split_lock_detect=" to
> > > > handle #DB for bus lock:
> > > 
> > > Are SLD and BLD mutually exclusive?  Can we even guarantee that given the
> > > track record of SLD?  If not, we'll likely want to allow the user to choose
> > > between SDL and BLD via split_lock_detect.
> > 
> > The two hardware features can be enabled on the same platform.
> > But they are mutually exclusive in the kernel because #AC from SLD happens
> > before the instruction is executed and #DB happens after the instruction is
> > executed.
> > 
> > Right now, if both of them are enabled, "warn" behavior goes to
> > bus lock and "fatal" behavior goes to split lock.
> > 
> > Do you want the user to override the behaviors by something like this?
> > 
> > split_lock_detect=warn[,sld]: if given "sld" while both features are enabled,
> > warn behavior is from split lock instead of bus lock detection.
> > 
> > split_lock_detect=fatal[,bld]: if given "bld" while both features are enabled,
> > fatal behavior is from bus lock detection.
> 
> IMO these should be completely independent features (that happen to share
> some code).
> 
> BLD in fatal mode doesn't make any sense because it can't be fatal without
> a completely different implementation, e.g. the bus lock has already
> happened and the application can eat the SIGBUS.  The current SLD code
> works because the split lock is prevented entirely, i.e. eating SIGBUS
> doesn't allow the application to make forward progress.

If "fatal" is meaningless for BLD, we can remove it for BLD. If we need
it in the future, we can add it later.

The "ratelimit:N" maybe more useful for BLD: it mitigates DOS from bus locks.

> 
> Smushing the two into a single option is confusing, e.g. from the table
> below it's not at all clear what will happen if sld=fatal, both features
> are supported, and the kernel generates a split lock.
> 
> Given that both SLD (per-core, not architectural) and BLD (#DB recursion and
> inverted DR6 flag) have warts, it would be very nice to enable/disable them
> independently.  The lock to non-WB behavior for BLD may also be problematic,
> e.g. maybe it turns out that fixing drivers to avoid locks to non-WB isn't
> as straightforward as avoiding split locks.

But the two features are related if both of them are enabled in hardware:
If a split lock happens, SLD will generate #AC before instruction execution
and BLD will generate #DB after instruction execution.

The software needs to make them exclusive. The same kernel option reflects
the relationship and make them exclusive, e.g. "fatal" enables SLD and
disables BLD, "warn" does the other way.

If using two different kernel options, the user needs to give right options
to make both work, e.g. can the user give this combination
"split_lock_detect=fatal bus_lock_detect=warn"? What does the combination
mean? There could be many combinations of the two options, some of them
are meaningful and some of them aren't. Maintaining the combinations is
unnecessary complex, right?

Thanks.

-Fenghua
