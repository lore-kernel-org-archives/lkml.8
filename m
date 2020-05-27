Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7CDC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C21F20873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590594444;
	bh=WZsX7p4BrtvJjSVQGq1sQsPzta2zmG19cJCNu/CZl7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Oq9qrAr0a2JN8rWBoPTymH3VqlK7HJr4QhGTnBf61WHwSZEV2wYzDHoQlH1kOuuRI
	 YebS2G74ggv9cO2gDoCDLQTLP0FXV0NMEyHn3xs2wW28RbtZA2oeaiLZaulcOdDQxg
	 PCM7goOTjaTjUfpMa7bUxSvH/bvSK7E56QVcwP3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390008AbgE0PrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:47:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389890AbgE0PrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:47:22 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8904B20776;
        Wed, 27 May 2020 15:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590594441;
        bh=WZsX7p4BrtvJjSVQGq1sQsPzta2zmG19cJCNu/CZl7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y43wthzSjIKeYkxVxGTdGPOmke5eE60scWENqh0RX/uF7cwPj1hQxKE1HEQbHS5S1
         Bkkuk6IWTqaU+1RSU1r8Fa8hPxN+9ZNdp6XbLKwVNKcDv0e25923i07XyvFAY8mv75
         WcMG0sVovB6VsdoYWy54bFH1raesh2dxMnZKAZqM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7D41E40AFD; Wed, 27 May 2020 12:47:16 -0300 (-03)
Date:   Wed, 27 May 2020 12:47:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 00/15] perf/x86: Add perf text poke events
Message-ID: <20200527154716.GC16490@kernel.org>
References: <20200512121922.8997-1-adrian.hunter@intel.com>
 <bee04840-143c-18bb-df82-5aa58d70730e@intel.com>
 <20200520014001.GF28228@kernel.org>
 <20200520155634.GQ317569@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520155634.GQ317569@hirez.programming.kicks-ass.net>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 20, 2020 at 05:56:34PM +0200, Peter Zijlstra escreveu:
> On Tue, May 19, 2020 at 10:40:01PM -0300, Arnaldo Carvalho de Melo wrote:
> > PeterZ, from what we discussed for the next merge Window, perhaps we
> > should route the kernel bits via the tip tree while I will push the
> > tooling bits on my 5.8 merge request to Linus, Ok?
> 
> Sure, I can take the kernel bits. Thanks!

So, I'm going thru the userpace bits and stopped at the patch copying
include/uapi/linux/perf_events.h to
tools/include/uapi/linux/perf_events.h to get the text_poke
perf_event_attr bit, looked at tip/ and this hasn't landed there yet,
any issues with the kernel bits?

I can try to put a separate branch, merge the kernel bits, and do a pull
request to Ingo/Thomas to get that going, would that help?

- Arnaldo
