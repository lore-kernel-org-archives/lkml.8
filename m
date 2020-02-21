Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71188C35657
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7B820722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbgBUSFF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 13:05:05 -0500
Received: from mga01.intel.com ([192.55.52.88]:14812 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgBUSFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:05:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 10:05:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,469,1574150400"; 
   d="scan'208";a="225289409"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga007.jf.intel.com with ESMTP; 21 Feb 2020 10:05:03 -0800
Received: from orsmsx161.amr.corp.intel.com (10.22.240.84) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 21 Feb 2020 10:05:03 -0800
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.107]) by
 ORSMSX161.amr.corp.intel.com ([169.254.4.11]) with mapi id 14.03.0439.000;
 Fri, 21 Feb 2020 10:05:03 -0800
From:   "Kleen, Andi" <andi.kleen@intel.com>
To:     "Tang, Feng" <feng.tang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "Chen, Rong A" <rong.a.chen@intel.com>,
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
Subject: RE: [LKP] Re: [perf/x86] 81ec3f3c4c: will-it-scale.per_process_ops
 -5.5% regression
Thread-Topic: [LKP] Re: [perf/x86] 81ec3f3c4c: will-it-scale.per_process_ops
 -5.5% regression
Thread-Index: AQHV6I1t87VLv9kiVEyQ9lHGZx1Mi6gl75j1
Date:   Fri, 21 Feb 2020 18:05:02 +0000
Message-ID: <E8ECBC65D0B2554DAD44EBE43059B3740F1EAC@ORSMSX110.amr.corp.intel.com>
References: <20200205123216.GO12867@shao2-debian>
 <20200205125804.GM14879@hirez.programming.kicks-ass.net>,<20200221080325.GA67807@shbuild999.sh.intel.com>
In-Reply-To: <20200221080325.GA67807@shbuild999.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.3.86.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>So likely, this commit changes the layout of the kernel text
>and data, 

It should be only data here. text changes all the time anyways,
but data tends to be more stable.

> which may trigger some cacheline level change. From
>the system map of the 2 kernels, a big trunk of symbol's address
>changes which follow the global "pmu",

I wonder if it's the effect Andrew predicted a long time ago from
using __read_mostly. If all the __read_mostlies are moved somewhere
else the remaining read/write variables will get more sensitive to false sharing.

A simple experiment would be to add a __cacheline_aligned to align it,
and then add

____cacheline_aligned char dummy[0]; 

at the end to pad it to 64bytes.

Or hopefully Jiri can figure it out from the C2C data.

>btw, we've seen similar case that an irrelevant commit changes
>the benchmark, like a hugetlb patch improves pagefault test on
>a platform that never uses hugetlb https://lkml.org/lkml/2020/1/14/150

Yes we've had similar problems with the data segment before.

-Andi
