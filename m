Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94478C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 12:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AAB42071E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 12:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgBVMoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 07:44:05 -0500
Received: from mga06.intel.com ([134.134.136.31]:54138 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbgBVMoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 07:44:05 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Feb 2020 04:44:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,471,1574150400"; 
   d="scan'208";a="255104506"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.113])
  by orsmga002.jf.intel.com with ESMTP; 22 Feb 2020 04:44:00 -0800
Date:   Sat, 22 Feb 2020 20:43:59 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Kleen, Andi" <andi.kleen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Chen, Rong A" <rong.a.chen@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [LKP] Re: [perf/x86] 81ec3f3c4c: will-it-scale.per_process_ops
 -5.5% regression
Message-ID: <20200222124359.GA86836@shbuild999.sh.intel.com>
References: <20200205123216.GO12867@shao2-debian>
 <20200205125804.GM14879@hirez.programming.kicks-ass.net>
 <20200221080325.GA67807@shbuild999.sh.intel.com>
 <E8ECBC65D0B2554DAD44EBE43059B3740F1EAC@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E8ECBC65D0B2554DAD44EBE43059B3740F1EAC@ORSMSX110.amr.corp.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On Sat, Feb 22, 2020 at 02:05:02AM +0800, Kleen, Andi wrote:
> 
> 
> >So likely, this commit changes the layout of the kernel text
> >and data, 
> 
> It should be only data here. text changes all the time anyways,
> but data tends to be more stable.
 
Yes, I also did en experiment by modifying the gcc option to let
all functions address aligned to 32 or 64, and the 5.5% gap still
exist for the 2 commmits.

> > which may trigger some cacheline level change. From
> >the system map of the 2 kernels, a big trunk of symbol's address
> >changes which follow the global "pmu",
> 
> I wonder if it's the effect Andrew predicted a long time ago from
> using __read_mostly. If all the __read_mostlies are moved somewhere
> else the remaining read/write variables will get more sensitive to false sharing.
> 
> A simple experiment would be to add a __cacheline_aligned to align it,
> and then add
> 
> ____cacheline_aligned char dummy[0]; 
> 
> at the end to pad it to 64bytes.

Thanks for the suggestion, I tried this and the 5.5 regrssion is gone!
which also confirms the offset for the bulk of stuff following "pmu" 
causes the performance drop.

> 
> Or hopefully Jiri can figure it out from the C2C data.

I'm also trying to debug following Jiri's "perf c2c" suggestion.

Thanks,
Feng

