Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B9CC54FCF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DAE2077D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRzMaolB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgCYPWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:22:22 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:47333 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727488AbgCYPWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585149739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DdhKJXE/99PfeU3KvZHkWk8Q0IeQ2XK8anu6Byn+KFk=;
        b=BRzMaolBphwPHpj+fsoekP/sU5eneha0o9bxunzE36mbpOrJ/uD8IyvisC7NHPf6LXEqG3
        As8TxSe0I0cdD1EGxUpYmVDxuABirIGWeMeMLTdZ2Xe5vI7dZo4HvcPtgBEd02uvc8y+ym
        NQAaaNdn7C0w97XBBheKZrW0ANkyQ50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-eE4soRceN8G2bTfvKpOoXw-1; Wed, 25 Mar 2020 11:22:17 -0400
X-MC-Unique: eE4soRceN8G2bTfvKpOoXw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 990F713F5;
        Wed, 25 Mar 2020 15:22:16 +0000 (UTC)
Received: from krava (unknown [10.40.192.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8727960BF3;
        Wed, 25 Mar 2020 15:22:15 +0000 (UTC)
Date:   Wed, 25 Mar 2020 16:22:11 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Add missing Intel CPU events to parser
Message-ID: <20200325152211.GA1908530@krava>
References: <20200324150443.28832-1-adrian.hunter@intel.com>
 <20200325103345.GA1856035@krava>
 <20200325131549.GB14102@kernel.org>
 <20200325135350.GA1888042@krava>
 <20200325142214.GD14102@kernel.org>
 <ea516b26-6249-e870-20bf-819ea1a2d2c2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea516b26-6249-e870-20bf-819ea1a2d2c2@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 04:24:58PM +0200, Adrian Hunter wrote:
> On 25/03/20 4:22 pm, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Mar 25, 2020 at 02:53:50PM +0100, Jiri Olsa escreveu:
> >> On Wed, Mar 25, 2020 at 10:15:49AM -0300, Arnaldo Carvalho de Melo wrote:
> >>> Em Wed, Mar 25, 2020 at 11:33:45AM +0100, Jiri Olsa escreveu:
> >>>> On Tue, Mar 24, 2020 at 05:04:43PM +0200, Adrian Hunter wrote:
> >>>>> perf list expects CPU events to be parseable by name, e.g.
> >>>
> >>>>>     # perf list | grep el-capacity-read
> >>>>>       el-capacity-read OR cpu/el-capacity-read/          [Kernel PMU event]
> >>>
> >>>>> But the event parser does not recognize them that way, e.g.
> >>>
> >>>>>     # perf test -v "Parse event"
> >>>>>     <SNIP>
> >>>>>     running test 54 'cycles//u'
> >>>>>     running test 55 'cycles:k'
> >>>>>     running test 0 'cpu/config=10,config1,config2=3,period=1000/u'
> >>>>>     running test 1 'cpu/config=1,name=krava/u,cpu/config=2/u'
> >>>>>     running test 2 'cpu/config=1,call-graph=fp,time,period=100000/,cpu/config=2,call-graph=no,time=0,period=2000/'
> >>>>>     running test 3 'cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp'
> >>>>>     -> cpu/event=0,umask=0x11/
> >>>>>     -> cpu/event=0,umask=0x13/
> >>>>>     -> cpu/event=0x54,umask=0x1/
> >>>>>     failed to parse event 'el-capacity-read:u,cpu/event=el-capacity-read/u', err 1, str 'parser error'
> >>>>>     event syntax error: 'el-capacity-read:u,cpu/event=el-capacity-read/u'
> >>>>>                            \___ parser error test child finished with 1
> >>>>>     ---- end ----
> >>>>>     Parse event definition strings: FAILED!
> >>>
> >>>>> Fix by adding missing Intel CPU events to the event parser.
> >>>>> Missing events were found by using:
> >>>
> >>>>>     grep -r EVENT_ATTR_STR arch/x86/events/intel/core.c
> >>>>>
> >>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >>>>
> >>>> Acked-by: Jiri Olsa <jolsa@redhat.com>
> >>>
> >>> So, I'm not being able to reproduce this, what an I missing?
> >>
> >> I think you need to be on some really recent intel
> >> which defines events which we did not covered yet
> >> like el-capacity-write in icelake
> > 
> > That is why I tried with el-capacity, which is moved to the parser as
> > well, I've replaced el-capacity-read, which I don't have in this Kaby
> > Lake machine, with el-capacity, that is present:
> > 
> > [root@seventh ~]# perf list | grep el-capacity
> >   el-capacity OR cpu/el-capacity/                    [Kernel PMU event]
> > [root@seventh ~]#
> 
> I just checked that and it seems to be a "feature" of the parser that it
> gets confused between el-capacity and el-capacity-read.
> 
> Making them explicit in parse-events.l makes the problem go away, but I
> wonder now if the parser could be better in this regard.

so we have that PRE/SUFFIX logic that allows us
to specify any sysfs event term as standalone event

the lexer in this case below was used to handle special cases..
and IIUC think having more than one '-' is one of them

could you check if the patch below will fix that for you?

jirka


---
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 7b1c8ee537cf..347eb3e6794a 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -342,11 +342,15 @@ bpf-output					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_BPF_OUT
 	 * Because the prefix cycles is mixed up with cpu-cycles.
 	 * loads and stores are mixed up with cache event
 	 */
-cycles-ct					{ return str(yyscanner, PE_KERNEL_PMU_EVENT); }
-cycles-t					{ return str(yyscanner, PE_KERNEL_PMU_EVENT); }
-mem-loads					{ return str(yyscanner, PE_KERNEL_PMU_EVENT); }
-mem-stores					{ return str(yyscanner, PE_KERNEL_PMU_EVENT); }
-topdown-[a-z-]+					{ return str(yyscanner, PE_KERNEL_PMU_EVENT); }
+cycles-ct				|
+cycles-t				|
+mem-loads				|
+mem-stores				|
+topdown-[a-z-]+				|
+tx-capacity-read			|
+tx-capacity-write			|
+el-capacity-read			|
+el-capacity-write			{ return str(yyscanner, PE_KERNEL_PMU_EVENT); }
 
 L1-dcache|l1-d|l1d|L1-data		|
 L1-icache|l1-i|l1i|L1-instruction	|

