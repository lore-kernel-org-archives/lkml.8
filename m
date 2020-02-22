Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F463C35666
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 17:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0C5206ED
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 17:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgBVRIX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 12:08:23 -0500
Received: from mga09.intel.com ([134.134.136.24]:39051 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgBVRIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 12:08:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Feb 2020 09:08:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,472,1574150400"; 
   d="scan'208";a="229477357"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga007.fm.intel.com with ESMTP; 22 Feb 2020 09:08:21 -0800
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 22 Feb 2020 09:08:21 -0800
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.107]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.180]) with mapi id 14.03.0439.000;
 Sat, 22 Feb 2020 09:08:21 -0800
From:   "Kleen, Andi" <andi.kleen@intel.com>
To:     "Tang, Feng" <feng.tang@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
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
Subject: RE: [LKP] Re: [perf/x86] 81ec3f3c4c: will-it-scale.per_process_ops
 -5.5% regression
Thread-Topic: [LKP] Re: [perf/x86] 81ec3f3c4c: will-it-scale.per_process_ops
 -5.5% regression
Thread-Index: AQHV6X3LhetjX3VofUmXB9MXuNVibagnce9U
Date:   Sat, 22 Feb 2020 17:08:20 +0000
Message-ID: <E8ECBC65D0B2554DAD44EBE43059B3740F2241@ORSMSX110.amr.corp.intel.com>
References: <20200205123216.GO12867@shao2-debian>
 <20200205125804.GM14879@hirez.programming.kicks-ass.net>
 <20200221080325.GA67807@shbuild999.sh.intel.com>
 <E8ECBC65D0B2554DAD44EBE43059B3740F1EAC@ORSMSX110.amr.corp.intel.com>,<20200222124359.GA86836@shbuild999.sh.intel.com>
In-Reply-To: <20200222124359.GA86836@shbuild999.sh.intel.com>
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

>Thanks for the suggestion, I tried this and the 5.5 regrssion is gone!
>which also confirms the offset for the bulk of stuff following "pmu"
>causes the performance drop.

Okay that confirms that it is false sharing. Looking at c2c is the right way to
go then.

Peter, could adopt the padding as a workaround for now?

-Andi
