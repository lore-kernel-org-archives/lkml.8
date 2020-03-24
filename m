Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D1BC54EEB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B25D20714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="npgD8XIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgCXUPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:15:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39232 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgCXUPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wie24ycPhjFmAEIjjhafUw7nx4nYRAcHCsCA/Tcf2nY=; b=npgD8XIUBZUzQ6uw15hxmI3ldm
        KlQP/ll+zeWGqqWfttFbkLohi84cGEGQVHG3gy68BX1Mbg07venW516+wT1H8F7OfhI3WXgFSb+/E
        G0HWvUAdTVSTJQstex07mWmCFEa+uW052JkrIdXORMqBpA/KFkamk25gxilGGPAYZIbeP4szo9H32
        RR1d42lMXPfzQ48L8zweDC7Z/mI8WePz6wwIA29pVtchNh38zXq3zcqzigSBCxy2/626560zIaQE2
        Tb2z+cUGIpEBdUWUMgx2BbBA0n/ZlIAQlqN2pj11Kz/yp/zMcJtJqCjdpytIaSOoXyvrVA903l51m
        AARBxPhg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGpxN-0002yY-5t; Tue, 24 Mar 2020 20:15:25 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D1D6983502; Tue, 24 Mar 2020 21:15:22 +0100 (CET)
Date:   Tue, 24 Mar 2020 21:15:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCHSET 00/10] perf: Improve cgroup profiling (v5)
Message-ID: <20200324201522.GP2452@worktop.programming.kicks-ass.net>
References: <20200224043749.69466-1-namhyung@kernel.org>
 <CAM9d7chneHzibiQFopmN1rED=mf-nBpy58kauXWSOSYy2zCtzQ@mail.gmail.com>
 <20200324163444.GA162390@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324163444.GA162390@mtj.duckdns.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 12:34:44PM -0400, Tejun Heo wrote:
> On Mon, Mar 23, 2020 at 08:58:04AM +0900, Namhyung Kim wrote:
> > Hello Peter, Tejun and folks.
> > 
> > Do you have any other comments on the kernel side?
> > If not, can I get your Ack?
> 
> Everything looks good from cgroup side. I think I acked all cgroup parts already
> but if not please feel free to add
> 
>  Acked-by: Tejun Heo <tj@kernel.org>

Yeah, looks good to me too. Since it's mostly userspace patches, will
you route it Arnaldo?

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
