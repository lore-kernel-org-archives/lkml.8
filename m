Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F86C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 373952078C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588842912;
	bh=VKRH1H2qPX9wmQ2U49CHUqzSBgQdFbqB8uT9k7gA8qU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nbvr6dOsH4dzR7kSplgTab3JNGvE+vB2JZcGTimOIU2S2RVFM7vfV9esaJ+weNMGm
	 zyUDmeN+c9ZhHKP2RKD/fT74U0jsSqkKYY7mrB87vu2EF9EfIlPmE8Y1/XPLosQ9MX
	 f3l2IxNCQs5jHt00+QI9OT/l+oFtQl8pLnziwq70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgEGJPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 05:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgEGJPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 05:15:11 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D4632075E;
        Thu,  7 May 2020 09:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588842910;
        bh=VKRH1H2qPX9wmQ2U49CHUqzSBgQdFbqB8uT9k7gA8qU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mWC4V0bsdU7Igrd4LI4hXYifZeOW9//saj/LYGlC/Qs1/9FoETYLpoHkTyQhWQr1h
         9usyekkCyiOODAbcL17x6IcW3XGDc+IZHRmLOhd00Vfjsz02mvEN7S50A7m1LnGfxP
         e9vbKoEX42/RWYV5Piw8SchNW7tw3E/E94qJktx4=
Date:   Thu, 7 May 2020 18:15:05 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>
Subject: Re: [PATCH 3/3] selftests/ftrace: Use /bin/echo instead of built-in
 echo
Message-Id: <20200507181505.3e8369ee39f14d9c74ec986b@kernel.org>
In-Reply-To: <5EB3AE7C.5@cn.fujitsu.com>
References: <158834025077.28357.15141584656220094821.stgit@devnote2>
        <158834028054.28357.398159034694277189.stgit@devnote2>
        <5EB3AE7C.5@cn.fujitsu.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020 14:45:16 +0800
Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:

> On 2020/5/1 21:38, Masami Hiramatsu wrote:
> > Since the built-in echo has different behavior in POSIX shell
> > (dash) and bash, we forcibly use /bin/echo -E (not interpret
> > backslash escapes) by default.
> >
> > This also fixes some test cases which expects built-in
> > echo command.
> >
> > Reported-by: Liu Yiding<yidingx.liu@intel.com>
> > Signed-off-by: Masami Hiramatsu<mhiramat@kernel.org>
> > ---
> >   tools/testing/selftests/ftrace/test.d/functions    |    3 +++
> >   .../test.d/trigger/trigger-trace-marker-hist.tc    |    2 +-
> >   .../trigger-trace-marker-synthetic-kernel.tc       |    4 ++++
> >   .../trigger/trigger-trace-marker-synthetic.tc      |    4 ++--
> >   4 files changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
> > index 5d4550591ff9..ea59b6ea2c3e 100644
> > --- a/tools/testing/selftests/ftrace/test.d/functions
> > +++ b/tools/testing/selftests/ftrace/test.d/functions
> > @@ -1,3 +1,6 @@
> > +# Since the built-in echo has different behavior in POSIX shell (dash) and
> > +# bash, we forcibly use /bin/echo -E (not interpret backslash escapes).
> > +alias echo="/bin/echo -E"
> Hi Masami, Steven
> 
> It seems that only kprobe_syntax_errors.tc is impacted by the issue 
> currently.  Is it necessary for all tests to use /bin/echo and could we 
> just make kprobe_syntax_errors.tc use /bin/echo?

Yes, I would like to unify the "echo"'s behavior among the testcases
instead of patching each failure in the future.
Or would you have any concern on it?

Thank you,

> 
> Best Regards,
> Xiao Yang
> 
> >
> >   clear_trace() { # reset trace output
> >       echo>  trace
> > diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
> > index ab6bedb25736..b3f70f53ee69 100644
> > --- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
> > @@ -30,7 +30,7 @@ fi
> >
> >   echo "Test histogram trace_marker tigger"
> >
> > -echo 'hist:keys=common_pid'>  events/ftrace/print/trigger
> > +echo 'hist:keys=ip'>  events/ftrace/print/trigger
> >   for i in `seq 1 10` ; do echo "hello">  trace_marker; done
> >   grep 'hitcount: *10$' events/ftrace/print/hist>  /dev/null || \
> >       fail "hist trigger did not trigger correct times on trace_marker"
> > diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
> > index 18b4d1c2807e..c1625d945f4d 100644
> > --- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
> > @@ -44,6 +44,10 @@ echo 'latency u64 lat'>  synthetic_events
> >   echo 'hist:keys=pid:ts0=common_timestamp.usecs'>  events/sched/sched_waking/trigger
> >   echo 'hist:keys=common_pid:lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_waking).latency($lat)'>  events/ftrace/print/trigger
> >   echo 'hist:keys=common_pid,lat:sort=lat'>  events/synthetic/latency/trigger
> > +
> > +# We have to use the built-in echo here because waking up pid must be same
> > +# as echoing pid.
> > +alias echo=echo
> >   sleep 1
> >   echo "hello">  trace_marker
> >
> > diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
> > index dd262d6d0db6..23e52c8d71de 100644
> > --- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
> > @@ -36,8 +36,8 @@ fi
> >   echo "Test histogram trace_marker to trace_marker latency histogram trigger"
> >
> >   echo 'latency u64 lat'>  synthetic_events
> > -echo 'hist:keys=common_pid:ts0=common_timestamp.usecs if buf == "start"'>  events/ftrace/print/trigger
> > -echo 'hist:keys=common_pid:lat=common_timestamp.usecs-$ts0:onmatch(ftrace.print).latency($lat) if buf == "end"'>>  events/ftrace/print/trigger
> > +echo 'hist:keys=ip:ts0=common_timestamp.usecs if buf == "start"'>  events/ftrace/print/trigger
> > +echo 'hist:keys=ip:lat=common_timestamp.usecs-$ts0:onmatch(ftrace.print).latency($lat) if buf == "end"'>>  events/ftrace/print/trigger
> >   echo 'hist:keys=common_pid,lat:sort=lat'>  events/synthetic/latency/trigger
> >   echo -n "start">  trace_marker
> >   echo -n "end">  trace_marker
> >
> >
> >
> > .
> >
> 
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
