Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B57C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 01:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D79C206E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 01:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHZBqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 21:46:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:48706 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbgHZBqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 21:46:01 -0400
IronPort-SDR: I+KjmFhqnqChobdF0J/4eLyiKgLlO/4Mt9vIrIJYoFZzDTWi4z6vpIGI8IR1EwCFDxeQpjTHib
 RIYUMTbut+Zw==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="156211434"
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="156211434"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 18:46:01 -0700
IronPort-SDR: bywuvKU1786MClS10ZZLwShMJM+68apVAuEAph5z9aduHixWIjk4bwKZsdL4ObFh2DQWOYYOyQ
 YKQBgTLOQg2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="336692138"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Aug 2020 18:45:59 -0700
Date:   Wed, 26 Aug 2020 09:45:58 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@suse.de>,
        "Chen, Rong A" <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        Mel Gorman <mgorman@suse.com>
Subject: Re: [LKP] Re: [x86/mce] 1de08dccd3: will-it-scale.per_process_ops
 -14.1% regression
Message-ID: <20200826014558.GC83850@shbuild999.sh.intel.com>
References: <20200425130136.GA28245@zn.tnic>
 <20200818082943.GA65567@shbuild999.sh.intel.com>
 <20200818200654.GA21494@agluck-desk2.amr.corp.intel.com>
 <20200819020437.GA2605@shbuild999.sh.intel.com>
 <20200821020259.GA90000@shbuild999.sh.intel.com>
 <20200824151425.GF4794@zn.tnic>
 <20200824153300.GA56944@shbuild999.sh.intel.com>
 <20200824161238.GI4794@zn.tnic>
 <20200825062305.GA83850@shbuild999.sh.intel.com>
 <b704f3c6298f46abbc59105ec0d52d14@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b704f3c6298f46abbc59105ec0d52d14@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 12:44:37AM +0800, Luck, Tony wrote:
> > These 2 variables are accessed in 2 hot call stacks (for this 288 CPU
> > Xeon Phi platform):
> 
> This might be the key element of "weirdness" for this system. It
> has 288 CPUs ... cache alignment problems are often not too bad
> on "small" systems. The as you scale up to bigger machines you
> suddenly hit some critical point and performance drops dramatically.
> 
> It's good that you are picking up tips on how to bisect these and diagnose
> the underlying problem. Number of cores is going to keep increasing, so
> we will keep finding new issues like this.

Yes, now we have one more bullet for shooting this kind of strange
performance changes :)

Thanks,
Feng

> -Tony
