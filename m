Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7BFC32771
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 01:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2F62072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 01:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578620214;
	bh=aH/Cb27AjGqGNq6jKzO83mg4/3u60GJatR1APEkeNY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FeEsKV9/Qkpm7ffsICw+itaYxYKA8/FHc36+KcJJ5esva80ZHrfWxq/BHUdQEpen8
	 TWXdlBLNyMHkuHk5zWIWiuZmlh+dfWyOQGv47YfWXHFAJ+N3/naXSlA86nhmMtPlXn
	 GPZ1VAbdyva2oz2DEamFaVYH54atebi6ptRDJTg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbgAJBgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 20:36:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:40224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730594AbgAJBgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 20:36:53 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C83820673;
        Fri, 10 Jan 2020 01:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578620212;
        bh=aH/Cb27AjGqGNq6jKzO83mg4/3u60GJatR1APEkeNY8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zfgXAf7sSX6vasaDNLU9IBzgPUHuci0DCVo0eDaruqyLs0ZLCw6MZ9/dZMSd0P6i6
         ohAQ06ZOnyRc7y3fVAj4J3aQgXqbcw463FHkdplqDU5tFSF5treeADcQb9ZMsj1Y+p
         1ED3/D0NKSyRiARPFyrV59aQUb9QdDlBmeCYyceI=
Date:   Fri, 10 Jan 2020 10:36:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Namhyung Kim <namhyung@kernel.org>,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdl?= =?ISO-2022-JP?B?bnNlbg==?= 
        <thoiland@redhat.com>, Jean-Tsung Hsiao <jhsiao@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] list corruption while enabling multi call uprobes via
 perf
Message-Id: <20200110103647.f2182be4584886b9a62d6161@kernel.org>
In-Reply-To: <20200109133846.GA2158@kernel.org>
References: <20200108171611.GA8472@kernel.org>
        <20200109111056.484a181fc6acc20196344f9a@kernel.org>
        <20200109183356.5a81ad2bfed6804f9934faee@kernel.org>
        <20200109133846.GA2158@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2020 10:38:46 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Thu, Jan 09, 2020 at 06:33:56PM +0900, Masami Hiramatsu escreveu:
> > Hi,
> > 
> > On Thu, 9 Jan 2020 11:10:56 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > Hmm, this seems that the event->hw.tp_list is not initialized when removing
> > > from the list in uprobe_perf_close().
> > 
> > Oops, that's wrong. Of course my patch can ease (avoid kernel panic) the
> > issue, but not fixing the root cause.
> > The root cause is that the uprobe event tries to open multiple probes with
> > one perf_event. So the perf_event is reused on different probes.
> > 
> > In the reported case, if we remove the multiple probe event before perf-stat,
> > no problem happens.
> > 
> > I'll try to fix it.
> 
> Ok!
> 
> For reference, I rebooted it with a fedora kernel, 5.3ish and it seems
> to work:

Yes, since it was my commit 60d53e2c3b75 ("tracing/probe: Split trace_event
related data from trace_probe") broke list operation...
I'll send a fix soon.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
