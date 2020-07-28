Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1B0C433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA6CB20714
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C76rDEI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgG1MzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:55:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43243 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729556AbgG1MzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595940907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1jIaH9mui3VhKIIC+urPLmqB7hNXFRcpyGysV6l0cLE=;
        b=C76rDEI5NV3uvQPyGJpSmHaUyXRFn4k/iIKSAkys7LBEE352Gv2Ejweb44wxQf6uJYG+Z1
        6fKqR3HaYq1gXKvYLmg9lE78BJg/75CJPg+v6Q/d9J+DgtQ66xs/IyCH50weJ+7LhGqPeQ
        H6LpLqT7BhFsfp+vBRcSkuVzX3sNkUw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-mz2Gj0wfPkKqLeSCgzuwHw-1; Tue, 28 Jul 2020 08:55:03 -0400
X-MC-Unique: mz2Gj0wfPkKqLeSCgzuwHw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05A0B8017FB;
        Tue, 28 Jul 2020 12:55:01 +0000 (UTC)
Received: from krava (unknown [10.40.192.211])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9B33671D0E;
        Tue, 28 Jul 2020 12:54:57 +0000 (UTC)
Date:   Tue, 28 Jul 2020 14:54:56 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     kajoljain <kjain@linux.ibm.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCHv3 00/19] perf metric: Add support to reuse metric
Message-ID: <20200728125456.GD1243191@krava>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <dbe59791-937d-de95-4ba0-c34e7a1cd273@linux.ibm.com>
 <20200720072237.GC760733@krava>
 <6cb72b48-5244-9faf-a9e5-67858c732b83@linux.ibm.com>
 <20200720081943.GE760733@krava>
 <dd465647-da63-c473-9944-bdfec2abe484@linux.ibm.com>
 <20200720191625.GL760733@krava>
 <20200728123955.GZ40195@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728123955.GZ40195@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 09:39:55AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jul 20, 2020 at 09:16:25PM +0200, Jiri Olsa escreveu:
> > On Mon, Jul 20, 2020 at 02:32:40PM +0530, kajoljain wrote:
> > > 
> > > 
> > > On 7/20/20 1:49 PM, Jiri Olsa wrote:
> > > > On Mon, Jul 20, 2020 at 01:39:24PM +0530, kajoljain wrote:
> > > > 
> > > > SNIP
> > > > 
> > > >> This is with your perf/metric branch:
> > > >> command# ./perf stat -M PowerBUS_Frequency -C 0 -I 1000
> > > >> assertion failed at util/metricgroup.c:709
> > > >> #           time             counts unit events
> > > >>      1.000054545          7,807,505      hv_24x7/pm_pb_cyc,chip=0/ #      2.0 GHz  PowerBUS_Frequency_0
> > > >>      1.000054545          7,807,485      hv_24x7/pm_pb_cyc,chip=1/                                   
> > > >>      2.000232761          7,807,500      hv_24x7/pm_pb_cyc,chip=0/ #      2.0 GHz  PowerBUS_Frequency_0
> > > >>      2.000232761          7,807,478      hv_24x7/pm_pb_cyc,chip=1/                                   
> > > >>      3.000363762          7,799,665      hv_24x7/pm_pb_cyc,chip=0/ #      1.9 GHz  PowerBUS_Frequency_0
> > > >>      3.000363762          7,807,502      hv_24x7/pm_pb_cyc,chip=1/                                   
> > > >> ^C     3.259418599          2,022,150      hv_24x7/pm_pb_cyc,chip=0/ #      0.5 GHz  PowerBUS_Frequency_0
> > > >>      3.259418599          2,022,164      hv_24x7/pm_pb_cyc,chip=1/                                   
> > > >>
> > > >>  Performance counter stats for 'CPU(s) 0':
> > > >>
> > > >>         25,436,820      hv_24x7/pm_pb_cyc,chip=0/ #      6.4 GHz  PowerBUS_Frequency_0
> > > >>         25,444,629      hv_24x7/pm_pb_cyc,chip=1/                                   
> > > >>
> > > >>        3.259505529 seconds time elapsed
> > > > 
> > > > I found the bug, we are not adding runtime metrics as standalone ones,
> > > > but as referenced metrics.. will fix and try to add test for that
> > > > 
> > > > as for testing.. do I need some special ppc server to have support for this? 
> > > 
> > > Hi jiri,
> > >     We need power9 lpar machine and need to make sure `CONFIG_HV_PERF_CTRS` is
> > > enabled.
> > 
> > could you please try with following patch on top?
> 
> So, can you point me to the cset that this should be merged into? Or can
> it come as a separate patch? I'll put what I have in the tmp.perf/core
> branch, and will do testing, please let me know if you want to fold it
> or as a followup patch.

sorry for delay.. I planned to squash the change in, but if you already
pushed something out, I'll rebase on top, I will post new version tomorrow

1st 7 patches are good to go in any case

thanks,
jirka

