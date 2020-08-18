Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B76C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7BD9206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgHRI3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:29:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:29035 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgHRI3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:29:46 -0400
IronPort-SDR: O+H3jEO6LcQZETTNZRvCczdYUg08cKoDS/dcXsQ8TaZO6Rx94v/ccCyxe7fk6VjD7j2TgjRPU5
 ZlN+1VoDmZ6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="152272031"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="152272031"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 01:29:45 -0700
IronPort-SDR: fhO4aQsUo9lOdKcpUe21R7LSa6ve5iULPzuKL8QgJ0Pol0BqK9qOYmKk2hlmFO0FV7L9r4RKVb
 m3T3+J6/V9lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="441147947"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by orsmga004.jf.intel.com with ESMTP; 18 Aug 2020 01:29:43 -0700
Date:   Tue, 18 Aug 2020 16:29:43 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [LKP] Re: [x86/mce] 1de08dccd3: will-it-scale.per_process_ops
 -14.1% regression
Message-ID: <20200818082943.GA65567@shbuild999.sh.intel.com>
References: <20200425114414.GU26573@shao2-debian>
 <20200425130136.GA28245@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200425130136.GA28245@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On Sat, Apr 25, 2020 at 03:01:36PM +0200, Borislav Petkov wrote:
> On Sat, Apr 25, 2020 at 07:44:14PM +0800, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we noticed a -14.1% regression of will-it-scale.per_process_ops due to commit:
> > 
> > 
> > commit: 1de08dccd383482a3e88845d3554094d338f5ff9 ("x86/mce: Add a struct mce.kflags field")
> 
> I don't see how a struct mce member addition will cause any performance
> regression. Please check your test case.

Sorry for the late response.

We've done more rounds of test, and the test results are consistent.

Our suspect is the commit changes the data alignment of other kernel
domains than mce, which causes the performance change to this malloc
microbenchmark.

Without the patch, size of 'struct mce' is 120 bytes, while it will
be 128 bytes after adding the '__u64 kflags' 

And we also debugged further:

* add "mce=off" to kernel cmdline, the performance change keeps. 

* change the 'kflags' from __u64 to __u32 (the size of mce will
  go back to 120 bytes), the performance change is gone

* only comment off '__u64 kflags', peformance change is gone.

We also tried perf c2c tool to capture some data, but the platform
is a Xeon Phi which doesn't support it. Capturing raw HITM event
also can not provide useful data.

0day has reported quite some strange peformance bump like this,
  https://lore.kernel.org/lkml/20200205123216.GO12867@shao2-debian/
  https://lore.kernel.org/lkml/20200114085637.GA29297@shao2-debian/
  https://lore.kernel.org/lkml/20200330011254.GA14393@feng-iot/
for some of which, the bump could be gone if we hack to force all
kernel functions to be aligned, but it doesn't work for this case.

So together with the debugging above, we thought this could be a
data alignment change caused performance bump.

Thanks,
Feng

> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
