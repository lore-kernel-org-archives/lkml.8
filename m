Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEF5C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A002064A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="ddn28xO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgB1QAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:00:50 -0500
Received: from st43p00im-ztdg10073201.me.com ([17.58.63.177]:44507 "EHLO
        st43p00im-ztdg10073201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727110AbgB1QAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:00:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1582905648; bh=Jp5Jx4TT3jU6jf6tGENjtbuH3RdcUZ/t+syzDFb4508=;
        h=Date:From:To:Subject:Message-ID:Content-Type;
        b=ddn28xO36TnsDne0mn8CLJQ7TPSP9bzqJocPvW9t735IWgyMWsOPWmMem8EAioqZ+
         IIkQkq+bSpy4gL/oQbGnsfIy6BbDleFxHaVqG7hoZS1BiKq1Bd5FO+OuuHjP7JYrmm
         8no4hBawJeBuGNEjyUtTJVlzu26Q2HxoIz+lCjjIUZWJI2KEXpVQ/TVPYEwMgWwZS6
         X0St9457hQlUpr43qJ1i1RD8nNmNryUhJVjVj452D2amLA3i/rydHQMzAPt9ZwRgMX
         lhYn55c78OaoRYcvBgjYB6NwwJHV5RwdFLCUDUO4SKnXzjIAGswsyJVYcw0FHo7fvE
         d7ZnSSBaq47tA==
Received: from shwetrath.localdomain (unknown [66.199.8.131])
        by st43p00im-ztdg10073201.me.com (Postfix) with ESMTPSA id B34E222214B;
        Fri, 28 Feb 2020 16:00:47 +0000 (UTC)
Date:   Fri, 28 Feb 2020 11:00:45 -0500
From:   Vijay Thakkar <vijaythakkar@me.com>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 2/3] perf vendor events amd: add Zen2 events
Message-ID: <20200228160045.GA23708@shwetrath.localdomain>
References: <20200225192815.50388-1-vijaythakkar@me.com>
 <20200225192815.50388-3-vijaythakkar@me.com>
 <6f2a1097-a656-8226-1be3-36a337539412@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f2a1097-a656-8226-1be3-36a337539412@amd.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-02-28_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2002280127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +  {
> > +    "EventName": "ls_pref_instr_disp.prefetch_nta",
> > +    "EventCode": "0x4b",
> > +    "BriefDescription": "Software Prefetch Instructions (PREFETCHNTA instruction) Dispatched.",
> > +    "PublicDescription": "Software Prefetch Instructions (PREFETCHNTA instruction) Dispatched.",
> > +    "UMask": "0x4"
> > +  },
> > +  {
> > +    "EventName": "ls_pref_instr_disp.store_prefetch_w",
> > +    "EventCode": "0x4b",
> > +    "BriefDescription": "Software Prefetch Instructions (3DNow PREFETCHW instruction) Dispatched.",
> > +    "PublicDescription": "Software Prefetch Instructions (3DNow PREFETCHW instruction) Dispatched.",
> > +    "UMask": "0x2"
> > +  },
> > +  {
> > +    "EventName": "ls_pref_instr_disp.load_prefetch_w",
> > +    "EventCode": "0x4b",
> > +    "BriefDescription": "Prefetch, Prefetch_T0_T1_T2.",
> > +    "PublicDescription": "Software Prefetch Instructions Dispatched. Prefetch, Prefetch_T0_T1_T2.",
> > +    "UMask": "0x1"
> > +  },
These three are present in the PPR for model 71h (56176 Rev 3.06 - Jul
17, 2019) but are missing from the PPR for model 31h (55803 Rev 0.54 -
Sep 12, 2019). Not sure what to do about it. 

Similarly, PMC 0x0AF - Dispatch Resource Stall Cycles 0 only has one
subcounter in the model 31h PPR, whereas the PPR for 71h is the one that
contains the eight subcounters we see in the mainline right now.

There could be more subtle differences like these, since I have not
really compared the PPR versions that thoroughly. I was going with the
assumption that since both are for SoCs based on the Zen2, they would
have identical events. 

Otherwise, I have made all the other changes and corrections, and will
send in v3 after you suggest how to proceed about the above two.

Best,
Vijay
