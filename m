Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BFDC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4047320658
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbgIHRKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:10:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:11104 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731825AbgIHRKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:10:19 -0400
IronPort-SDR: 6JxiHnR5zvlemI1pTtekuGiEdiFvhzZhCWIMebUUI0rxXkg3lgk5I3o3xAkqjTS9o1mwRht+Lg
 5JlverwLfLRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="176239158"
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="176239158"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 10:10:18 -0700
IronPort-SDR: xb3TOCto97k46V4T6BNX6Fv450dNj7J2LPuzAxhub5KUBHXPOeDrrOFcNHqXJE7f888KT2MY6I
 0KrDL5DOuj0w==
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="480110130"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.127.119])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 10:10:17 -0700
Message-ID: <22617e57e541e460fac09db04fdb370f8e96e8ef.camel@linux.intel.com>
Subject: Re: [PATCH] x86/msr: do not warn on writes to OC_MAILBOX
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Borislav Petkov <bp@suse.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kitsunyan <kitsunyan@airmail.cc>,
        "Brown, Len" <len.brown@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 08 Sep 2020 10:10:17 -0700
In-Reply-To: <20200907100647.GB10657@zn.tnic>
References: <20200907094843.1949-1-Jason@zx2c4.com>
         <20200907100647.GB10657@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-09-07 at 12:06 +0200, Borislav Petkov wrote:
> + Srinivas.
> + kitsunyan.
> 
> On Mon, Sep 07, 2020 at 11:48:43AM +0200, Jason A. Donenfeld wrote:
> > Popular tools, like intel-undervolt, use MSR 0x150 to control the
> > CPU
> > voltage offset. In fact, evidently the intel_turbo_max_3 driver in-
> > tree
> > also uses this MSR. So, teach the kernel's MSR list about this, so
> > that
> > intel-undervolt and other such tools don't spew warnings to dmesg,
> > while
> > unifying the constant used throughout the kernel.
> > 

[...]

> > -	if (reg == MSR_IA32_ENERGY_PERF_BIAS)
> > +	switch (reg) {
> > +	case MSR_IA32_ENERGY_PERF_BIAS:
There is already sysfs interface for it.

> > +	case MSR_IA32_OC_MAILBOX:
> >  		return 0;
> > +	}
> > 

[...]

> Actually, we added the filtering to catch exactly such misuses and,
> lemme check what is the proper word now... /me checks, aha, adding
> new
> MSRs to the "passlist" is the wrong thing to do.
> 
> Srinivas, can you pls convert this in-tree driver to use a proper
> sysfs
> interface for that mailbox MSR and also work with the intel-undervolt
> author - I hope I have the right person CCed from the git repo on
> github
> - to come up with a proper interface so that we can drop this MSR use
> too.

Overclocking is not architectural I/F and is supported by some special
CPU skews. I can't find any public document to specify the commands
which can be used via this OC mailbox. I have to check internally to
see if there is any. To add a proper sysfs interface we have to make
sure that we are not allowing some random commands to hardware and
crash the system.

Thanks,
Srinivas

