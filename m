Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D5CC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B442076A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441353AbgDPIqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:46:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:60718 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502496AbgDPIlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:41:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2E2FFACAD;
        Thu, 16 Apr 2020 08:40:31 +0000 (UTC)
Message-ID: <1587026430.32139.29.camel@suse.cz>
Subject: Re: [PATCH] x86, smpboot: Disable frequency invariance when it's
 unsupported
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 16 Apr 2020 10:40:30 +0200
In-Reply-To: <bf43772d-48e5-01d4-dd03-330110e487fa@linux.intel.com>
References: <20200416020700.167294-1-like.xu@linux.intel.com>
         <1587017284.32139.20.camel@suse.cz>
         <bf43772d-48e5-01d4-dd03-330110e487fa@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-04-16 at 15:01 +0800, Like Xu wrote:
> On 2020/4/16 14:08, Giovanni Gherdovich wrote:
> > [...]
> > I've just sent fixes for these two problems here:
> > https://lore.kernel.org/lkml/20200416054745.740-1-ggherdovich@suse.cz/
> 
> Hence the "less than 4 cores" comment is weird for C6562
> but the use of "1C turbo" looks good to me.

Right, your C6562 has 24 cores, (I think) it doesn't support turbo at all,
declares 1C turbo equal to the base frequency and all other turbo ratios (2C,
4C etc) as zero.

The commit message of the fix I sent doesn't describe exactly your situation
but the patch addresses your case nonetheless. Some more comments below.

On Thu, 2020-04-16 at 15:01 +0800, Like Xu wrote:
> On 2020/4/16 14:08, Giovanni Gherdovich wrote:
> > [...]
> > Hello Like Xu,
> > 
> > thanks for reporting this and for the patch. My preferred solution for when
> > the 4 cores turbo freq is detected as zero would be to look for the 1 core turbo
> > frequency, as we're likely on a machine with less than 4 cores. Is that the
> > case on your Atom C6562? I couldn't find it on ark.intel.com.
> 
> The Atom C6562 is "24 cores" based on 
> https://www.intel.com/content/dam/www/public/us/en/documents/product-briefs/atom-p5900-product-brief.pdf
> 
> #define MSR_PLATFORM_INFO		0x000000ce
> 
> the value for this msr is 80820f9801600
> 
> #define MSR_TURBO_RATIO_LIMIT		0x000001ad
> 
> the value for this msr is 16
> 
> I know you didn't test your feature on this platform,
> but combinations of other various values are also possible
> (unless it's made clear in the specification).

That's an interesting CPU; let me indulge in a couple of comments/questions
for my own curiosity.
From the document you link, the product name in the Intel catalogue seems to
be Atom P5962B. Apparently it belongs to the "P Series" just launched:
https://ark.intel.com/content/www/us/en/ark/products/series/202693/intel-atom-processor-p-series.html
and your product brief suggests it's meant for installation in 5G base stations.

1) Can you share the output of "turbostat --interval 1 sleep 0"? I'm
   interested in the headers of the output, where all the various pm-related
   MSRs are decoded.

2) Despite not being in the Intel SDM, I was under the assumption that all
   Intel CPUs declare the "all-cores turbo" frequency, but it's not the case
   for this one. Eg: if you have 24 cores, somewhere in your MSRs I'd expect
   to find "24C turbo" (or even "30C turbo", anything greater or equal than 24).
   My understanding from
   https://ark.intel.com/content/www/us/en/ark/products/202682/intel-atom-processor-p5962b-27m-cache-2-20-ghz.html
   is that this CPU doesn't support turbo boost at all; in other CPUs without
   turbo I've seen MSRs saying the all-cores turbo freq is equal to the base
   freq (for compatibility I suppose). Here MSR_TURBO_RATIO_LIMIT says that 1C
   turbo is the same as base frequency (2.2GHz), but turbo for larger sets of
   cores is declared as zero, which I find a little odd.

3) The parsing of MSRs in the frequency invariance code is modeled after
   turbostat, and classifies CPUs in 5 groups: Atom up to Goldmont, Atom from
   Goldmont onwards, Xeon Phi, Xeon Scalable Processors onwards and "generic
   Core". As you've already found out from where your panic happens, your Atom
   falls into the "generic Core" category (function core_set_max_freq_ratio()),
   but given that it's an Atom and it's been released this very quarter I'd
   have guessed it to behave like a Goldmont. Something for me to keep in mind.


Thanks,
Giovanni Gherdovich
