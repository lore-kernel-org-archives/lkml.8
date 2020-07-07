Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD74C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C8CF20773
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594138188;
	bh=1LI+y1SfYRqh5iNLlHrjd0oahm28+M9G0r0NUNiItHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W0XN3KUFzheGEYBDE+f5wrLCoMju4AMX8frS3cfF6dUCucTwNH1KHRR0R4C6UhQI0
	 YK20fg67OsHJav05uJyIgELkaRg0OY+H6US7IL4WVcjjFKitD3a/WOlYCAkO7Ai5Me
	 wZRTDYo/Zl/faLRPSTzvbZNQFP4zzz7P7Lx5dtvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgGGQJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:09:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbgGGQJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:09:47 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 497D42073E;
        Tue,  7 Jul 2020 16:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594138186;
        bh=1LI+y1SfYRqh5iNLlHrjd0oahm28+M9G0r0NUNiItHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C2Qyhc73/tumXwMmkWZ83SCmrLW5VZhUOvO95zxaB/yRXJE9TQ//rZ0yCwfKWjFFh
         IAhLHJ3ajCWk3tbEONGGQnbflI6JcJUt6l0m8AX9eKcElQsMoFbQwnkNxoM1OGrurW
         6Rv/hEtY7+jNXIa8bSTahiV55PYWgtAVu0PPElZY=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EA230405FF; Tue,  7 Jul 2020 13:09:43 -0300 (-03)
Date:   Tue, 7 Jul 2020 13:09:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/15] perf ftrace: add support for trace option
 sleep-time
Message-ID: <20200707160943.GA1556@kernel.org>
References: <20200627133654.64863-1-changbin.du@gmail.com>
 <20200627133654.64863-11-changbin.du@gmail.com>
 <CAM9d7chsn9_5FBR5nPW_gc+k0hq9whOGSa67uZ2XKzM147OaLg@mail.gmail.com>
 <20200707152539.ldhgqf6vmnttqnfn@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707152539.ldhgqf6vmnttqnfn@mail.google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 07, 2020 at 11:35:14PM +0800, Changbin Du escreveu:
> On Fri, Jul 03, 2020 at 03:40:59PM +0900, Namhyung Kim wrote:
> > On Sat, Jun 27, 2020 at 10:38 PM Changbin Du <changbin.du@gmail.com> wrote:
> > > This adds an option '--graph-nosleep-time' which allow us only to measure
> > > on-CPU time. This option is function_graph tracer only.

> > I'd suggest --graph-sleep-time instead and set it by default.
> > Then we can have --no-graph-sleep-time as well.

> If so can we make --graph-sleep-time as default. Seems there is no something
> like OPT_BOOLEAN_DEFAULT().

> > By the way,  didn't we agree to have something like --graph-opts instead?

> As I mentioned in previous version, --graph-opts make the parsing a little
> complex.
> 	--graph-opts depth=<n>,nosleep_time,noirqs,no_tail,verbose

> While the exsiting style is '--graph-depth <n>'. The cons is we must type more
> characters. The pros is don't need to reimplement parsing and align with old
> behaviour.
> 	--graph-depth <n>
> 	--graph-nosleep-time
> 	--graph-noirqs
> 	--graph-notail
> 	--graph-verbose

This achieves the same result, yes, but it is more cumbersome, to use
all we would have to do:

    perf ftrace --graph-depth 10 --graph-nosleep-time --graph-noirqs --graph-notail --graph-verbose ...

When we could have a more compact:

    perf ftrace --graph-opts depth=10,nosleep-time,noirqs,notail,verbose ...

I.e., instead of a series of:

        OPT_INTEGER(0, "graph-depth", &ftrace.graph_depth, "Max depth for function graph tracer"),
	OPT_BOOLEAN(0, "sleep-time", &ftrace.sleep_time, "explanation"),
	OPT_BOOLEAN(0, "irqs" &ftrace.irqs, "explanation"),
	OPT_BOOLEAN(0, "tail" &ftrace.tail, "explanation"),
	OPT_BOOLEAN(0, "verbose" &ftrace.verbose, "explanation"),

We'd have a:

	OPT_CALLBACK(0, "graph-opts", &ftrace, "options", "graph options", parse_graph_opts),

And parse_graph_opts() would just have a simple strchr(opt, ',') + if
strcmp()/else loop, i.e., it would be easier for users, slightly more
difficult for perf developers :-)

- Arnaldo
