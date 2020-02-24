Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F082C38BE2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 19:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D4F2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 19:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgBXTmr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 14:42:47 -0500
Received: from mga02.intel.com ([134.134.136.20]:47751 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgBXTmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 14:42:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 11:42:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,481,1574150400"; 
   d="scan'208";a="255690915"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga002.jf.intel.com with ESMTP; 24 Feb 2020 11:42:46 -0800
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.107]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.242]) with mapi id 14.03.0439.000;
 Mon, 24 Feb 2020 11:42:46 -0800
From:   "Kleen, Andi" <andi.kleen@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Tang, Feng" <feng.tang@intel.com>
CC:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Chen, Rong A" <rong.a.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Vince Weaver" <vincent.weaver@maine.edu>,
        Jiri Olsa <jolsa@kernel.org>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "Huang, Ying" <ying.huang@intel.com>
Subject: RE: [LKP] Re: [perf/x86] 81ec3f3c4c: will-it-scale.per_process_ops
 -5.5% regression
Thread-Topic: [LKP] Re: [perf/x86] 81ec3f3c4c: will-it-scale.per_process_ops
 -5.5% regression
Thread-Index: AQHV60gfK6eA3q3jR0u6sMXxx2rr5qgqvXYq
Date:   Mon, 24 Feb 2020 19:42:45 +0000
Message-ID: <E8ECBC65D0B2554DAD44EBE43059B3740F2AA1@ORSMSX110.amr.corp.intel.com>
References: <20200205123216.GO12867@shao2-debian>
 <20200205125804.GM14879@hirez.programming.kicks-ass.net>
 <20200221080325.GA67807@shbuild999.sh.intel.com>
 <20200221132048.GE652992@krava>
 <20200223141147.GA53531@shbuild999.sh.intel.com>
 <CAHk-=wjKFTzfDWjAAabHTZcityeLpHmEQRrKdTuk0f4GWcoohQ@mail.gmail.com>
 <20200224003301.GA5061@shbuild999.sh.intel.com>
 <CAHk-=whi87NNOnNXJ6CvyyedmhnS8dZA2YkQQSajvBArH5XOeA@mail.gmail.com>
 <20200224021915.GC5061@shbuild999.sh.intel.com>,<CAHk-=wjkSb1OkiCSn_fzf2v7A=K0bNsUEeQa+06XMhTO+oQUaA@mail.gmail.com>
In-Reply-To: <CAHk-=wjkSb1OkiCSn_fzf2v7A=K0bNsUEeQa+06XMhTO+oQUaA@mail.gmail.com>
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

>Does anybody else have any ideas?

We've had problems with atomics having strange ordering constraints before.

But it might be c2c missing the right cache line. There are some known cases where that can happen.

Feng, can you double check with 

perf record -a -d -e mem_load_l3_hit_retired.xsnp_hitm:pp,mem_load_l3_miss_retired.remote_hitm:pp ...

Does it report the same hot IPs as c2c?
What's the break down between the first and the second event for the hot IPs? The first is inside socket, the second between sockets.

-Andi

