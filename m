Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342A4C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E25E2242C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgGNQqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 12:46:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:63426 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbgGNQqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:46:14 -0400
IronPort-SDR: 9AspnhHnJKxdjgvKNxAcbIGKlh8Lj+n1Sbv4yQcJZ6L4JBinBPzZAA2xbjlZG8jP/PJSfbyv4f
 YRvw2kX+PD/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="137096649"
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800"; 
   d="scan'208";a="137096649"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 09:46:14 -0700
IronPort-SDR: 0zIglL1rGjfXbMiyccoWIdYK7nyGnLsYlddSeTXk2lQJMEzThC5kWDM/9+ts/3x4JBnBUVHkha
 DaQY8d300C2w==
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800"; 
   d="scan'208";a="316437149"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 09:46:13 -0700
Date:   Tue, 14 Jul 2020 09:46:12 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        sean.j.christopherson@intel.com, torvalds@linux-foundation.org,
        x86@kernel.org, kernel-team@fb.com,
        Matthew Garrett <matthewgarrett@google.com>
Subject: Re: [PATCH -v2.1] x86/msr: Filter MSR writes
Message-ID: <20200714164612.GA28474@agluck-desk2.amr.corp.intel.com>
References: <20200615063837.GA14668@zn.tnic>
 <20200714121955.GA2080@chrisdown.name>
 <20200714154728.GA3101@nazgul.tnic>
 <20200714160448.GC2080@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714160448.GC2080@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 05:04:48PM +0100, Chris Down wrote:
> Borislav Petkov writes:
> > On Tue, Jul 14, 2020 at 01:19:55PM +0100, Chris Down wrote:
> > > That is, even with pr_err_ratelimited, we still end up logging on basically
> > > every single write, even though it's from the same TGID writing to the same
> > > MSRs, and end up becoming >80% of kmsg.
> > > 
> > > Of course, one can boot with `allow_writes=1` to avoid these messages at
> > 
> > Yes, use that.
> > 
> > From a quick scan over that "tool" you pointed me at, it pokes at some
> > MSRs from userspace which the kernel *also* writes to and this is
> > exactly what should not be allowed.
> 
> I don't think we're in disagreement about that. My concern is strictly about
> the amount of spam caused for some of those existing use cases during the
> transition phase. People should know that their tools would break, but there
> shouldn't be so many messages generated that it inevitably pushes other
> useful information out of the kmsg buffer.

Maybe we just need smarter filtering of warnings.  It doesn't
seem at all useful to warn for the same MSR 1000's of times.
Maybe keep a count of warnings for each MSR and just stop
all reports when reach a threshold?

-Tony
