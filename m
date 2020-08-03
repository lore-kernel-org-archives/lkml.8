Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195CEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1B972076B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmETOhWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgHCLbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 07:31:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59738 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725945AbgHCLbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 07:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596454299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pV1pPCL8X5xFckLn2VsESyYpW3VEpaZwtKKkcIg4hHY=;
        b=ZmETOhWdH0Vz673bhndk6SP50A4BLZmDrudefwj6w27bmcjMfgT2KWgASJhutOHawyissE
        /SNv/Cvc1ZPmIpffyuH6kAJonrHU6tedLq2Grqp5SPlefHv1zo27O2fY9ZTil1KzfUiHzF
        jA3p95PqVurjdScN4Q5vL1CC1N0XSWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-AHN8_81nNN2UuaXi_HCXSA-1; Mon, 03 Aug 2020 07:31:34 -0400
X-MC-Unique: AHN8_81nNN2UuaXi_HCXSA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9901E1923761;
        Mon,  3 Aug 2020 11:31:32 +0000 (UTC)
Received: from krava (unknown [10.40.194.212])
        by smtp.corp.redhat.com (Postfix) with SMTP id C905174F45;
        Mon,  3 Aug 2020 11:31:28 +0000 (UTC)
Date:   Mon, 3 Aug 2020 13:31:27 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        =?iso-8859-1?Q?Genevi=E8ve?= Bastien <gbastien@versatic.net>,
        Wang Nan <wangnan0@huawei.com>,
        Jeremie Galarneau <jgalar@efficios.com>
Subject: Re: [PATCH 4/6] perf tools: Add support to store time of day in CTF
 data conversion
Message-ID: <20200803113127.GD139381@krava>
References: <20200730213950.1503773-1-jolsa@kernel.org>
 <20200730213950.1503773-5-jolsa@kernel.org>
 <20200803040012.GB686281@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803040012.GB686281@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 01:00:12PM +0900, Namhyung Kim wrote:
> On Thu, Jul 30, 2020 at 11:39:48PM +0200, Jiri Olsa wrote:
> > Adding support to convert and store time of day in CTF
> > data conversion for 'perf data convert' subcommand.
> > 
> > The perf.data used for conversion needs to have clock data
> > information - must be recorded with -k/--clockid option).
> > 
> > New --tod option is added to 'perf data convert' subcommand
> > to convert data with timestamps converted to wall clock time.
> > 
> > Record data with clockid set:
> >   # perf record -k CLOCK_MONOTONIC kill
> >   kill: not enough arguments
> >   [ perf record: Woken up 1 times to write data ]
> >   [ perf record: Captured and wrote 0.033 MB perf.data (8 samples) ]
> > 
> > Convert data with TOD timestamps:
> >   # perf data convert --tod --to-ctf ./ctf
> >   [ perf data convert: Converted 'perf.data' into CTF data './ctf' ]
> >   [ perf data convert: Converted and wrote 0.000 MB (8 samples) ]
> > 
> > Display data in perf script:
> >   # perf script -F+tod --ns
> >             perf 262150 2020-07-13 18:38:50.097678523 153633.958246159:          1 cycles: ...
> >             perf 262150 2020-07-13 18:38:50.097682941 153633.958250577:          1 cycles: ...
> >             perf 262150 2020-07-13 18:38:50.097684997 153633.958252633:          7 cycles: ...
> >   ...
> 
> I believe this belongs to a later patch.

I wanted to show in changelog that the timestamps match
for both script and data convert tools

jirka

> 
> Thanks
> Namhyung
> 
> > 
> > Display data in babeltrace:
> >   # babeltrace --clock-date  ./ctf
> >   [2020-07-13 18:38:50.097678523] (+?.?????????) cycles: { cpu_id = 0 }, { perf_ip = 0xFFF ...
> >   [2020-07-13 18:38:50.097682941] (+0.000004418) cycles: { cpu_id = 0 }, { perf_ip = 0xFFF ...
> >   [2020-07-13 18:38:50.097684997] (+0.000002056) cycles: { cpu_id = 0 }, { perf_ip = 0xFFF ...
> >   ...
> > 
> > It's available only for recording with clockid specified,
> > because it's the only case where we can get reference time
> > to wallclock time. It's can't do that with perf clock yet.
> > 
> > Error is display if you want to use --tod on data without
> > clockid specified:
> > 
> >   # perf data convert --tod --to-ctf ./ctf
> >   Can't provide --tod time, missing clock data. Please record with -k/--clockid option.
> >   Failed to setup CTF writer.
> >   Error during conversion setup.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/Documentation/perf-data.txt |  3 ++
> >  tools/perf/builtin-data.c              |  1 +
> >  tools/perf/util/data-convert-bt.c      | 56 +++++++++++++++++---------
> >  tools/perf/util/data-convert.h         |  1 +
> >  4 files changed, 41 insertions(+), 20 deletions(-)
> 

