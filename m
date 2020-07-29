Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72616C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5271920658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgG2UAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:00:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:11104 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgG2UAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 16:00:34 -0400
IronPort-SDR: HSyCi0ApK43FaJoyEu4DyFhi4qP7cvQYh0kuMm5wlsPI1ioGyNLZLIeUZNq426YPInjHLZ2gh2
 yLSFZ1RqF5Xg==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="236355402"
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="236355402"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 13:00:34 -0700
IronPort-SDR: c5pCVcZ5j2g/cSL1l/HYgX8CAz4uicvS1sIoXCU5M0cDOny4XTNMkLskYbfy/bB5rWb2zSE9qt
 sIN/HCk5R20A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="322663584"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jul 2020 13:00:33 -0700
Date:   Wed, 29 Jul 2020 13:00:33 -0700
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
Message-ID: <20200729200033.GJ27751@linux.intel.com>
References: <1595021700-68460-1-git-send-email-fenghua.yu@intel.com>
 <20200729030232.GE5583@linux.intel.com>
 <e23b04a2adc54a5dbca48271987de822@intel.com>
 <20200729184614.GI27751@linux.intel.com>
 <20200729194259.GA318576@otcwcpicx6.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729194259.GA318576@otcwcpicx6.sc.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 07:42:59PM +0000, Fenghua Yu wrote:
> > Smushing the two into a single option is confusing, e.g. from the table
> > below it's not at all clear what will happen if sld=fatal, both features
> > are supported, and the kernel generates a split lock.
> > 
> > Given that both SLD (per-core, not architectural) and BLD (#DB recursion and
> > inverted DR6 flag) have warts, it would be very nice to enable/disable them
> > independently.  The lock to non-WB behavior for BLD may also be problematic,
> > e.g. maybe it turns out that fixing drivers to avoid locks to non-WB isn't
> > as straightforward as avoiding split locks.
> 
> But the two features are related if both of them are enabled in hardware:
> If a split lock happens, SLD will generate #AC before instruction execution
> and BLD will generate #DB after instruction execution.
> 
> The software needs to make them exclusive. The same kernel option reflects
> the relationship and make them exclusive, e.g. "fatal" enables SLD and
> disables BLD, "warn" does the other way.

Why do they need to be exclusive?  We've already established that BLD catches
things that SLD does not.  What's wrong with running sld=fatal and bld=ratelimit
so that split locks never happen and kill applications, and non-WB locks are
are ratelimited?

Sure, sld==warn with bld!=off is a bit silly, but the kernel can easily handle
that particular case.

> If using two different kernel options, the user needs to give right options
> to make both work, e.g. can the user give this combination
> "split_lock_detect=fatal bus_lock_detect=warn"? What does the combination
> mean?

Split locks are fatal, non-WB locks are logged but not fatal.

> There could be many combinations of the two options, some of them
> are meaningful and some of them aren't. Maintaining the combinations is
> unnecessary complex, right?

Honestly, it seems less complex than deciphering the resulting behavior from
that table.

  sld=off|warn|fatal
  bld=off|warn|ratelimit

As above, sld then could become

  if (sld == warn && bld != off) {
          pr_warn("disabling SLD in favor of BLD\n");
          sld = off;
  }

Everything else should simply work.  The necessary refactoring for SLD should
be minimial as well.
