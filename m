Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68410C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A086208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgCFJGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:06:13 -0500
Received: from outbound-smtp45.blacknight.com ([46.22.136.57]:36873 "EHLO
        outbound-smtp45.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725959AbgCFJGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:06:13 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp45.blacknight.com (Postfix) with ESMTPS id 4C9D9FAC3B
        for <linux-kernel@vger.kernel.org>; Fri,  6 Mar 2020 09:06:11 +0000 (GMT)
Received: (qmail 17492 invoked from network); 6 Mar 2020 09:06:11 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 6 Mar 2020 09:06:10 -0000
Date:   Fri, 6 Mar 2020 09:06:08 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@lists.01.org
Subject: Re: [sched/numa]  6499b1b2dd:
 phoronix-test-suite.aom-av1.0.frames_per_second -25.0% regression
Message-ID: <20200306090608.GS3818@techsingularity.net>
References: <20200306023551.GE9382@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200306023551.GE9382@xsang-OptiPlex-9020>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 10:35:51AM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -25.0% regression of phoronix-test-suite.aom-av1.0.frames_per_second due to commit:
> 
> 
> commit: 6499b1b2dd1b8d404a16b9fbbf1af6b9b3c1d83d ("sched/numa: Replace runnable_load_avg by load_avg")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: phoronix-test-suite
> on test machine: 16 threads Intel(R) Xeon(R) CPU X5570 @ 2.93GHz with 48G memory
> with following parameters:
> 
> 	test: aom-av1-1.2.0
> 	cpufreq_governor: performance
> 	ucode: 0x1d
> 
> test-description: The Phoronix Test Suite is the most comprehensive testing and benchmarking platform available that provides an extensible framework for which new tests can be easily added.
> test-url: http://www.phoronix-test-suite.com/
> 

The middle of this series is not safe for bisection from a performance
perspective. It needs to be determined if the series is ok only after
all the patches are applied.

-- 
Mel Gorman
SUSE Labs
