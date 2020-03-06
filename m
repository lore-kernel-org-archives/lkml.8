Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA223C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A0A2070E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgCFOWd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:22:33 -0500
Received: from mga14.intel.com ([192.55.52.115]:46024 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgCFOWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:22:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 06:22:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,522,1574150400"; 
   d="scan'208";a="233344852"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga007.fm.intel.com with ESMTP; 06 Mar 2020 06:22:32 -0800
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 6 Mar 2020 06:22:32 -0800
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 6 Mar 2020 06:22:31 -0800
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.137]) by
 SHSMSX108.ccr.corp.intel.com ([169.254.8.235]) with mapi id 14.03.0439.000;
 Fri, 6 Mar 2020 22:22:29 +0800
From:   "Sang, Oliver" <oliver.sang@intel.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Valentin Schneider" <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "lkp@lists.01.org" <lkp@lists.01.org>
Subject: RE: [sched/numa]  6499b1b2dd:
 phoronix-test-suite.aom-av1.0.frames_per_second -25.0% regression
Thread-Topic: [sched/numa]  6499b1b2dd:
 phoronix-test-suite.aom-av1.0.frames_per_second -25.0% regression
Thread-Index: AQHV84jgMm9YV/qxsU2eLzhEFZLXOag7nhjw
Date:   Fri, 6 Mar 2020 14:22:29 +0000
Message-ID: <F09C421E5D2EBE40AFD7EEA977444DDC4D5D6DC7@SHSMSX103.ccr.corp.intel.com>
References: <20200306023551.GE9382@xsang-OptiPlex-9020>
 <20200306072827.14452-1-hdanton@sina.com>
In-Reply-To: <20200306072827.14452-1-hdanton@sina.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYThlOGQ1NTQtNTgyNS00YmI2LThlYjYtMjkzMGNhMmY1YjI3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUVpkMFM5VWpKcjhnejRPQStWVU1XSUJvcWFvdVNURGVLY2Q0c05KZ1RKd2lPNlM4Z3ZuQkFMZ1h0akxrT2o0TyJ9
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Hillf Danton <hdanton@sina.com>
> Sent: Friday, March 6, 2020 3:28 PM
> To: Sang, Oliver <oliver.sang@intel.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>; Ingo Molnar
> <mingo@kernel.org>; Mel Gorman <mgorman@techsingularity.net>; Peter
> Zijlstra <a.p.zijlstra@chello.nl>; Juri Lelli <juri.lelli@redhat.com>; Valentin
> Schneider <valentin.schneider@arm.com>; Phil Auld <pauld@redhat.com>; Hillf
> Danton <hdanton@sina.com>; LKML <linux-kernel@vger.kernel.org>; Andrew
> Morton <akpm@linux-foundation.org>; Stephen Rothwell
> <sfr@canb.auug.org.au>; lkp@lists.01.org
> Subject: Re: [sched/numa] 6499b1b2dd: phoronix-test-suite.aom-
> av1.0.frames_per_second -25.0% regression
> 
> 
> On Fri, 6 Mar 2020 10:35:51 +0800 from kernel test robot
> <oliver.sang@intel.com>
> >
> > Greeting,
> >
> > FYI, we noticed a -25.0% regression of phoronix-test-suite.aom-
> av1.0.frames_per_second due to commit:
> >
> >
> > commit: 6499b1b2dd1b8d404a16b9fbbf1af6b9b3c1d83d ("sched/numa:
> Replace
> > runnable_load_avg by load_avg")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git
> > master
> >
> Hi Oliver
> 
> Thanks for your report.
> 
> It's fixed in fb86f5b21192 ("sched/numa: Use similar logic to the load balancer
> for moving between domains with spare capacity") and if you're curious, see the
> force of that cure using the following diff.
> 
> Hillf

Thanks a lot for information!

> --
> 
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1594,11 +1594,6 @@ static bool load_too_imbalanced(long src
>  	long orig_src_load, orig_dst_load;
>  	long src_capacity, dst_capacity;
> 
> -
> -	/* If dst node has spare capacity, there is no real load imbalance */
> -	if (env->dst_stats.node_type == node_has_spare)
> -		return false;
> -
>  	/*
>  	 * The load is corrected for the CPU capacity available on each node.
>  	 *
> --

