Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F51C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 208C1206A5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599246510;
	bh=I0jfF82yrQxWZ2EhB0sazskljXeVGuhyyCq7fsp81yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jl6Gea9Pc7ctXu3P69nc8VckDmB30gYJcGLLbQXC2BU82vB1N1Rismi0Bno3gH1xB
	 pKZew/u/dtz1kXx26ls+jDpdE91V1b61S39d6VHW4AGGaG7/2D1jkjbd3tXQWR0qHp
	 FwGdXHfjPKIpDFEiSoCaX1agk5DjtuXqU0ngsql4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgIDTI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 15:08:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgIDTI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 15:08:28 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED62120684;
        Fri,  4 Sep 2020 19:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599246508;
        bh=I0jfF82yrQxWZ2EhB0sazskljXeVGuhyyCq7fsp81yc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rCOWE/CSov1DWvwFjxDnYfCc2S/qsNiWSR4flrEPWQe4Ht6WrrbtNi98q00/ovMaj
         h8EbTK3083w3mrJFfTcmcOAX1yP/0ec8M59g9XkrBYwedDJhdMbV5JjHfsH5FrUAhq
         ZRkvGmE2s4riqqB0LjCl9MtEoh0EK8wCvkguCt+0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0F01E40D3D; Fri,  4 Sep 2020 16:08:26 -0300 (-03)
Date:   Fri, 4 Sep 2020 16:08:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     peterz@infradead.org, Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Wei Li <liwei391@huawei.com>,
        Al Grant <al.grant@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Stephane Eranian <eranian@google.com>,
        Nick Gasson <nick.gasson@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Steve MacLean <Steve.MacLean@microsoft.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] perf tsc: Add rdtsc() for Arm64
Message-ID: <20200904190826.GC3753976@kernel.org>
References: <20200902132131.36304-1-leo.yan@linaro.org>
 <20200902132131.36304-3-leo.yan@linaro.org>
 <20200902134805.GI1362448@hirez.programming.kicks-ass.net>
 <20200903022354.GA1583@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903022354.GA1583@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 03, 2020 at 10:23:54AM +0800, Leo Yan escreveu:
> Hi Peter,
> 
> On Wed, Sep 02, 2020 at 03:48:05PM +0200, Peter Zijlstra wrote:
> > On Wed, Sep 02, 2020 at 02:21:27PM +0100, Leo Yan wrote:
> > > The system register CNTVCT_EL0 can be used to retrieve the counter from
> > > user space.  Add rdtsc() for Arm64.
> > 
> > > +u64 rdtsc(void)
> > > +{
> > > +	u64 val;
> > 
> > Would it make sense to put a comment in that this counter is/could-be
> > 'short' ? Because unlike x86-TSC, this thing isn't architecturally
> > specified to be 64bits wide.
> 
> Will add below comments:
> 
> According to ARM DDI 0487F.c, from Armv8.0 to Armv8.5 inclusive, the
> system counter is at least 56 bits wide; from Armv8.6, the counter must
> be 64 bits wide.  So the system counter could be less than 64 bits wide
> and it is attributed with the flag 'cap_user_time_short' is true.

Ok, so waiting for v4.

- Arnaldo
