Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F26C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 03:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A35C20639
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 03:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgHSDPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 23:15:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:46296 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbgHSDPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 23:15:53 -0400
IronPort-SDR: u7w4/VFZCWBInrHizdBZz/asjwkJyYcl1wJSb8qoUAte/zrjUAJ8hN6MUyPYpU0YAo1fKS3wwS
 T74SPqbjsAaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="154304311"
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="154304311"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 20:15:53 -0700
IronPort-SDR: zXLuRtJ8qM3fEIi5i4ituO1UIQm+2OT627pgXOK6XZe1crqJCZnEVDvaPpe+XP6EbooxpE8m27
 DZ6EYZfdiPsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="371101364"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by orsmga001.jf.intel.com with ESMTP; 18 Aug 2020 20:15:51 -0700
Date:   Wed, 19 Aug 2020 11:15:50 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@suse.de>,
        "Chen, Rong A" <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>
Subject: Re: [LKP] Re: [x86/mce] 1de08dccd3: will-it-scale.per_process_ops
 -14.1% regression
Message-ID: <20200819031550.GA59663@shbuild999.sh.intel.com>
References: <20200425114414.GU26573@shao2-debian>
 <20200425130136.GA28245@zn.tnic>
 <20200818082943.GA65567@shbuild999.sh.intel.com>
 <20200818200654.GA21494@agluck-desk2.amr.corp.intel.com>
 <20200819020437.GA2605@shbuild999.sh.intel.com>
 <149e0cfb5b7e48dfb9bea966c7741336@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149e0cfb5b7e48dfb9bea966c7741336@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 10:23:11AM +0800, Luck, Tony wrote:
> 	0000000000019260 D pqr_state
> 
> Do you have /sys/fs/resctrl mounted?  This variable is read on every context switch.
> If your benchmark does a lot of context switching and this now shares a cache line
> with something different (especially something that is sometimes modified from another
> CPU) that could cause some cache line bouncing.

No, the kernel doesn't has /sys/fs/resctrl mounted.

And the test case is not context switch intensive. It just forks a task
for each CPU which loops running malloc/free and counts the number of
complted operations for 300 seconds.

Thanks,
Feng
