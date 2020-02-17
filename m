Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951AFC35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 11:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616262070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 11:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggesFZJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgBQLGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 06:06:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36586 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726401AbgBQLGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 06:06:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581937601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zNtY/nNqfqPU7yx//NA5MFtqxD+KRrPgN40vD5HFU88=;
        b=ggesFZJPefEtEAvVRxzPaOc6EJ6syjGhg53Ce0gYHqExve5bj0z8AioCMH57mhbGiTtygJ
        2dTB5d56ewC0XEvQr7rk+SZTARoAnLRWT5qt86MeqN0SP9DGUaoptl2yyYIJdyU4UMbZnR
        yARiq3wqF1rgqnWb7o3y/4mZZdq7nj0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-esC-ZNXROwKekOxSNWgz0w-1; Mon, 17 Feb 2020 06:06:35 -0500
X-MC-Unique: esC-ZNXROwKekOxSNWgz0w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A58258014CA;
        Mon, 17 Feb 2020 11:06:33 +0000 (UTC)
Received: from krava (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 90425867F9;
        Mon, 17 Feb 2020 11:06:31 +0000 (UTC)
Date:   Mon, 17 Feb 2020 12:06:29 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4] perf stat: Show percore counts in per CPU output
Message-ID: <20200217110629.GD157041@krava>
References: <20200214080452.26402-1-yao.jin@linux.intel.com>
 <20200216225407.GB157041@krava>
 <d79a1bbe-bca5-0420-0480-1d508d2a038c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d79a1bbe-bca5-0420-0480-1d508d2a038c@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 09:22:57AM +0800, Jin, Yao wrote:
> 
> 
> On 2/17/2020 6:54 AM, Jiri Olsa wrote:
> > On Fri, Feb 14, 2020 at 04:04:52PM +0800, Jin Yao wrote:
> > 
> > SNIP
> > 
> > >   CPU1               1,009,312      cpu/event=cpu-cycles,percore/
> > >   CPU2               2,784,072      cpu/event=cpu-cycles,percore/
> > >   CPU3               2,427,922      cpu/event=cpu-cycles,percore/
> > >   CPU4               2,752,148      cpu/event=cpu-cycles,percore/
> > >   CPU6               2,784,072      cpu/event=cpu-cycles,percore/
> > >   CPU7               2,427,922      cpu/event=cpu-cycles,percore/
> > > 
> > >          1.001416041 seconds time elapsed
> > > 
> > >   v4:
> > >   ---
> > >   Ravi Bangoria reports an issue in v3. Once we offline a CPU,
> > >   the output is not correct. The issue is we should use the cpu
> > >   idx in print_percore_thread rather than using the cpu value.
> > 
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > 
> 
> Thanks so much for ACK this patch. :)
> 
> > btw, there's slight misalignment in -I output, but not due
> > to your change, it's there for some time now, and probably
> > in other agregation  outputs as well:
> > 
> > 
> >    $ sudo ./perf stat -e cpu/event=cpu-cycles/ -a -A  -I 1000
> >    #           time CPU                    counts unit events
> >         1.000224464 CPU0               7,251,151      cpu/event=cpu-cycles/
> >         1.000224464 CPU1              21,614,946      cpu/event=cpu-cycles/
> >         1.000224464 CPU2              30,812,097      cpu/event=cpu-cycles/
> > 
> > should be (extra space after CPUX):
> > 
> >         1.000224464 CPU2               30,812,097      cpu/event=cpu-cycles/
> > 
> > I'll put it on my TODO, but if you're welcome to check on it ;-)
> > 
> > thanks,
> > jirka
> > 
> 
> I have a simple fix for this misalignment issue.
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index bc31fccc0057..95b29c9cba36 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -114,11 +114,11 @@ static void aggr_printout(struct perf_stat_config
> *config,
>                         fprintf(config->output, "S%d-D%d-C%*d%s",
>                                 cpu_map__id_to_socket(id),
>                                 cpu_map__id_to_die(id),
> -                               config->csv_output ? 0 : -5,
> +                               config->csv_output ? 0 : -3,
>                                 cpu_map__id_to_cpu(id), config->csv_sep);
>                 } else {
> -                       fprintf(config->output, "CPU%*d%s ",
> -                               config->csv_output ? 0 : -5,
> +                       fprintf(config->output, "CPU%*d%s",
> +                               config->csv_output ? 0 : -7,
>                                 evsel__cpus(evsel)->map[id],
>                                 config->csv_sep);

I guess that's ok, will that work with higher (3 digit) cpu numbers?

jirka

>                 }
> 
> Following command lines are tested OK.
> 
> perf stat -e cpu/event=cpu-cycles/ -I 1000
> perf stat -e cpu/event=cpu-cycles/ -a -I 1000
> perf stat -e cpu/event=cpu-cycles/ -a -A -I 1000
> perf stat -e cpu/event=cpu-cycles,percore/ -a -A -I 1000
> perf stat -e cpu/event=cpu-cycles,percore/ -a -A --percore-show-thread -I
> 1000
> 
> Could you help to look at that?
> 
> Thanks
> Jin Yao
> 

