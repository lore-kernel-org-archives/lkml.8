Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4248BC35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B462073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H1wPemHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgBUK6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 05:58:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42590 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgBUK6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 05:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mN2ry1gqY7iOMcWFX6PDe/yjH041nighn7Vq+N4RRho=; b=H1wPemHmzR69jODR1q5tMyaExP
        csN9+Fz/Qp/t7ylh5ctVYkQQxo6+Tnrlz0YcL3S2+RiwHRJXxqm6ONIVZrVtVSI5WXolNN8MJFXcZ
        TeiZne17kmeufh8+/NxgaiJKvUdnrWvZq6VvtmMg1SgCitrRYHo6gaSj3FWXv5oittIu39WYS43/x
        iWONuayzK5JCgiD640AFTogd6fW1rbCh1CK9JmHJtBx379EDQPvKP7BgfI0qV0+Hg48cUtKxG9otZ
        8V4I651dB49/+Hwls+Vi12u4lH4ZTsgJ+o5VIIG556die7xcP5ycgaXQs9coEL2SjoJLvPOj9PWaP
        A+mc8xCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j560R-0006OA-9n; Fri, 21 Feb 2020 10:58:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D3B1930008D;
        Fri, 21 Feb 2020 11:56:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 025BC2014E22A; Fri, 21 Feb 2020 11:58:00 +0100 (CET)
Date:   Fri, 21 Feb 2020 11:58:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
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
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        andi.kleen@intel.com, ying.huang@intel.com
Subject: Re: [LKP] Re: [perf/x86] 81ec3f3c4c: will-it-scale.per_process_ops
 -5.5% regression
Message-ID: <20200221105800.GF18400@hirez.programming.kicks-ass.net>
References: <20200205123216.GO12867@shao2-debian>
 <20200205125804.GM14879@hirez.programming.kicks-ass.net>
 <20200221080325.GA67807@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221080325.GA67807@shbuild999.sh.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 04:03:25PM +0800, Feng Tang wrote:

> We checked more on this. We run 14 times test for it, and the
> results are consistent about the 5.5% degradation, and we
> run the same test on several other platforms, whose test results
> are also consistent, though there are no such -5.5% seen.

> So likely, this commit changes the layout of the kernel text
> and data, which may trigger some cacheline level change. From
> the system map of the 2 kernels, a big trunk of symbol's address
> changes which follow the global "pmu",
> 
> 5.0-rc6-systemap:
> 
> ffffffff8221d000 d pmu
> ffffffff8221d100 d pmc_reserve_mutex
> ffffffff8221d120 d amd_f15_PMC53
> ffffffff8221d160 d amd_f15_PMC50
> 
> 5.0-rc6+pmu-change-systemap:
> 
> ffffffff8221d000 d pmu
> ffffffff8221d120 d pmc_reserve_mutex
> ffffffff8221d140 d amd_f15_PMC53
> ffffffff8221d180 d amd_f15_PMC50
> 
> But we can hardly identify which exact symbol is responsible
> for the change, as too many symbols are offseted. 

*groan*, that's horrible.

Thanks for digging into this.
