Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B12C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 20:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F38062075E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 20:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgHRUG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 16:06:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:63785 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgHRUG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 16:06:56 -0400
IronPort-SDR: x7jglw/EPxBN7QNFSS/6yCtYlC3EG4PCN4OHcun73mzbIp7S86OZQimRvNymis+A4kjbBr5f0l
 pPCs0fa4k2jg==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="152621147"
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="152621147"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 13:06:55 -0700
IronPort-SDR: znV74kiYGOhhJnrcLnl5GWFG0dFWOcrxfJ5zvNbZp+daB3mR+sdDa4wQRzQxYPcng1uKQy1RMs
 CkTE+lOFiVGw==
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="320213111"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 13:06:55 -0700
Date:   Tue, 18 Aug 2020 13:06:54 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Borislav Petkov <bp@suse.de>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [LKP] Re: [x86/mce] 1de08dccd3: will-it-scale.per_process_ops
 -14.1% regression
Message-ID: <20200818200654.GA21494@agluck-desk2.amr.corp.intel.com>
References: <20200425114414.GU26573@shao2-debian>
 <20200425130136.GA28245@zn.tnic>
 <20200818082943.GA65567@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818082943.GA65567@shbuild999.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 04:29:43PM +0800, Feng Tang wrote:
> Hi Borislav,
> 
> On Sat, Apr 25, 2020 at 03:01:36PM +0200, Borislav Petkov wrote:
> > On Sat, Apr 25, 2020 at 07:44:14PM +0800, kernel test robot wrote:
> > > Greeting,
> > > 
> > > FYI, we noticed a -14.1% regression of will-it-scale.per_process_ops due to commit:
> > > 
> > > 
> > > commit: 1de08dccd383482a3e88845d3554094d338f5ff9 ("x86/mce: Add a struct mce.kflags field")
> > 
> > I don't see how a struct mce member addition will cause any performance
> > regression. Please check your test case.
> 
> Sorry for the late response.
> 
> We've done more rounds of test, and the test results are consistent.
> 
> Our suspect is the commit changes the data alignment of other kernel
> domains than mce, which causes the performance change to this malloc
> microbenchmark.
> 
> Without the patch, size of 'struct mce' is 120 bytes, while it will
> be 128 bytes after adding the '__u64 kflags' 
> 
> And we also debugged further:
> 
> * add "mce=off" to kernel cmdline, the performance change keeps. 
> 
> * change the 'kflags' from __u64 to __u32 (the size of mce will
>   go back to 120 bytes), the performance change is gone
> 
> * only comment off '__u64 kflags', peformance change is gone.
> 
> We also tried perf c2c tool to capture some data, but the platform
> is a Xeon Phi which doesn't support it. Capturing raw HITM event
> also can not provide useful data.
> 
> 0day has reported quite some strange peformance bump like this,
>   https://lore.kernel.org/lkml/20200205123216.GO12867@shao2-debian/
>   https://lore.kernel.org/lkml/20200114085637.GA29297@shao2-debian/
>   https://lore.kernel.org/lkml/20200330011254.GA14393@feng-iot/
> for some of which, the bump could be gone if we hack to force all
> kernel functions to be aligned, but it doesn't work for this case.
> 
> So together with the debugging above, we thought this could be a
> data alignment change caused performance bump.

So if this was a change to a structure in some performance sensitive
path, I'd totally understand how it could end up with a 14% change on
some benchmark that stressed that code path.

But I doubt the kernel ever touches a "struct mce" during execution
of your benchmark (I presume your test machine isn't getting thousands
of corrected memory errors during the test :-) ).

We do have some DEFINE_PER_CPU data objects of type "struct mce":

$ git grep 'DEFINE_PER_CPU(struct mce,'
arch/x86/kernel/cpu/mce/core.c:static DEFINE_PER_CPU(struct mce, mces_seen);
arch/x86/kernel/cpu/mce/core.c:DEFINE_PER_CPU(struct mce, injectm);

Maybe making those slightly bigger has pushed some other per_cpu object
into an unfortunate alignment where some frequently used data is now
split between two cache lines instead of sitting in one?

Can you collect some perf trace data for the benchmark when running
on kernels with kflags as __u32 and __u64 (looks to be the minimal
possible change that you found that still exhibits this problem).

We'd like to find out which kernel functions are burning extra CPU
cycles and maybe understand why.

The answer isn't to tinker with "struct mce". Other changes could trigger
this same change in alignment. Anything that is this perfomance sensitive
needs to have some "__attribute__((aligned(64)))" (or whatever) to
make sure arbitrary changes elsewhere don't do this.

-Tony
