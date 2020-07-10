Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39503C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16DC820748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594383293;
	bh=+DQn2ABxFIeH2E8eyeHAHR2kX1rDKuCsIIS7EZbr/Pk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=NrIhwgjhOVJ4Ta+5C6dGsE2bZNn9keIU9LsDEcAZnxATR3Uu649BvOqtnwpP3wpCr
	 sPxxukTQHUa+xMcUMBJS6QgA8F3Tr5qxw0ambpn7RDpDhWM6SD/kbVzF4UoZ7aD/Kb
	 Hwv5w+I0/wWEK5XxKKRJKP78zXIxW4HXP0H9E0EA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgGJMOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:14:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbgGJMOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:14:51 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16E9B20720;
        Fri, 10 Jul 2020 12:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594383290;
        bh=+DQn2ABxFIeH2E8eyeHAHR2kX1rDKuCsIIS7EZbr/Pk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X0wFFz+2N7kZTdGzftkv0OdulkABi6xKNNRVJJcPjUjtZaqtj7RQ5gvMKz8ALoiWz
         PjP9OJPneHsDu2xduCDi8/cUmYb411qd/drmjPmUmZRUDgvhr2tzJxusbaid0vuD+h
         WGOfwzbYhVWyQly73uCUGv72bejf6Vd1eHDXYap4=
Date:   Fri, 10 Jul 2020 21:14:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <andi@firstfloor.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/4] perf-probe: Avoid setting probes on same address on
 same event
Message-Id: <20200710211447.da9a6e436f7b527c26849c4c@kernel.org>
In-Reply-To: <20200710111847.GN874@linux.vnet.ibm.com>
References: <159428201109.56570.3802208017109058146.stgit@devnote2>
        <159428202173.56570.3555041287477206859.stgit@devnote2>
        <20200710111847.GN874@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020 16:48:47 +0530
Srikar Dronamraju <srikar@linux.vnet.ibm.com> wrote:

> * Masami Hiramatsu <mhiramat@kernel.org> [2020-07-09 17:07:01]:
> 
> > There is a case that the several same-name symbols points
> > same address. In that case, perf probe returns an error.
> > 
> > E.g.
> > 
> > With this patch;
> > 
> >   # perf probe -x /lib64/libc-2.30.so -a "memcpy arg1=%di"
> >   Failed to find the location of the '%di' variable at this address.
> >    Perhaps it has been optimized out.
> >    Use -V with the --range option to show '%di' location range.
> >   Added new events:
> >     probe_libc:memcpy    (on memcpy in /usr/lib64/libc-2.30.so with arg1=%di)
> >     probe_libc:memcpy    (on memcpy in /usr/lib64/libc-2.30.so with arg1=%di)
> > 
> >   You can now use it in all perf tools, such as:
> > 
> >   	perf record -e probe_libc:memcpy -aR sleep 1
> > 
> > 
> > Reported-by: Andi Kleen <andi@firstfloor.org>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> One small nit:
> 
> > ---
> >  tools/perf/util/probe-event.c |    9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > index df713a5d1e26..1e95a336862c 100644
> > --- a/tools/perf/util/probe-event.c
> > +++ b/tools/perf/util/probe-event.c
> > @@ -2968,6 +2968,15 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
> >  	for (j = 0; j < num_matched_functions; j++) {
> >  		sym = syms[j];
> > 
> > +		/* There can be duplicated symbols in the map */
> > +		for (i = 0; i < j; i++)
> > +			if (sym->start == syms[i]->start) {
> > +				pr_debug("find duplicated symbol %s @ %lx\n", sym->name, sym->start);
> 	
> Would "Found" sound better than "find"?

OK.

> 
> > +				break;
> > +			}
> > +		if (i != j)
> > +			continue;
> > +
> 
> Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Thank you!

> 
> 
> >  		tev = (*tevs) + ret;
> >  		tp = &tev->point;
> >  		if (ret == num_matched_functions) {
> > 
> 
> -- 
> Thanks and Regards
> Srikar Dronamraju


-- 
Masami Hiramatsu <mhiramat@kernel.org>
