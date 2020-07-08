Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FD2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F257D20656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIcwIJ7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbgGHM73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbgGHM73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:59:29 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC4EC08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 05:59:29 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id b9so617201plx.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AR/+kkmrZYJx40sEb+zRuBli/0RUxgaF5v240jClZxk=;
        b=qIcwIJ7nxSDfZqK+fE9ZdVWlWyRHkHL/3Q8tw+K/dY6Nf/6VxorwVTGVayZKrc/0b7
         Y0CM62/v17XcWlDLnbXhBmNz8qvl5GQAHl2nFXnNzAoO2jNmhkrYeY9EMKdwc40+N4vS
         tGvTgdYhVy0Fg1jig3VoEc7zw4eC3vo9Tv+qOYlDMs5WGDwzgHfeFsWI5QLjr1vhGn5k
         v1HjzQoT7jzNWyPGuHC5CD64ZPVYKdrAdNTorswV2J78Ja5fHlbvP3WJ3V+IJSavU4xl
         BZ5M/eBHYaxRNwPRK2i7Tl6GHmh8LpPxHehujPs9fB25rmB5peow3YDO7l8t+YMBzl09
         8Pvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AR/+kkmrZYJx40sEb+zRuBli/0RUxgaF5v240jClZxk=;
        b=b9ytcID2FPDhEAXcVj+pCN6u5iPxXlIQKnGXAb0lecxS0RfHxvgImwgamatEs+mNW2
         MP83wbOhii6ZrwysFaeAOCu2Xd0A05tRjhqzrWEBBWa2VGI/50SN1gqPwJN8JSLILIVm
         ucH9nE6s+RdJvS/kFu4guuiN0kv7psm2NXGAh5g+4E6EXlEhwvd2DJ6lt46OzbgzdYFh
         QpUeAwN74HLcg2t28mSXLwp/jh5UQtNQf5BsQEBqZpdFIWVadzhnrwEF8GDnlvYTvuFq
         t/AiWhyANOHVNxwfaHZH0MdM6YHF4QtKu1jd9895SG3BLpTyU/YXa4Yvl6OtAXA982ni
         yc1A==
X-Gm-Message-State: AOAM533oTamKixgnhGsqOANM7O1zlxiDSXiKZK2bK1Z0k2eB8/6rk9bs
        swLwocx/2UgA4wx8uPhDzJI=
X-Google-Smtp-Source: ABdhPJw9yPrBUe3qPw3/orUGn1BqLeqaVkdkdLhuZlTYz7ZmO1gJA0//ZKiQxFdQsq/NKOegt0IP9A==
X-Received: by 2002:a17:902:b687:: with SMTP id c7mr49600899pls.102.1594213168676;
        Wed, 08 Jul 2020 05:59:28 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id 199sm3922422pgc.79.2020.07.08.05.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 05:59:27 -0700 (PDT)
Date:   Wed, 8 Jul 2020 20:59:20 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/15] perf ftrace: add support for trace option
 sleep-time
Message-ID: <20200708125920.nmsq27otrjxmpjfx@mail.google.com>
References: <20200627133654.64863-1-changbin.du@gmail.com>
 <20200627133654.64863-11-changbin.du@gmail.com>
 <CAM9d7chsn9_5FBR5nPW_gc+k0hq9whOGSa67uZ2XKzM147OaLg@mail.gmail.com>
 <20200707152539.ldhgqf6vmnttqnfn@mail.google.com>
 <20200707160943.GA1556@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707160943.GA1556@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 01:09:43PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jul 07, 2020 at 11:35:14PM +0800, Changbin Du escreveu:
> > On Fri, Jul 03, 2020 at 03:40:59PM +0900, Namhyung Kim wrote:
> > > On Sat, Jun 27, 2020 at 10:38 PM Changbin Du <changbin.du@gmail.com> wrote:
> > > > This adds an option '--graph-nosleep-time' which allow us only to measure
> > > > on-CPU time. This option is function_graph tracer only.
> 
> > > I'd suggest --graph-sleep-time instead and set it by default.
> > > Then we can have --no-graph-sleep-time as well.
> 
> > If so can we make --graph-sleep-time as default. Seems there is no something
> > like OPT_BOOLEAN_DEFAULT().
> 
> > > By the way,  didn't we agree to have something like --graph-opts instead?
> 
> > As I mentioned in previous version, --graph-opts make the parsing a little
> > complex.
> > 	--graph-opts depth=<n>,nosleep_time,noirqs,no_tail,verbose
> 
> > While the exsiting style is '--graph-depth <n>'. The cons is we must type more
> > characters. The pros is don't need to reimplement parsing and align with old
> > behaviour.
> > 	--graph-depth <n>
> > 	--graph-nosleep-time
> > 	--graph-noirqs
> > 	--graph-notail
> > 	--graph-verbose
> 
> This achieves the same result, yes, but it is more cumbersome, to use
> all we would have to do:
> 
>     perf ftrace --graph-depth 10 --graph-nosleep-time --graph-noirqs --graph-notail --graph-verbose ...
> 
> When we could have a more compact:
> 
>     perf ftrace --graph-opts depth=10,nosleep-time,noirqs,notail,verbose ...
> 
> I.e., instead of a series of:
> 
>         OPT_INTEGER(0, "graph-depth", &ftrace.graph_depth, "Max depth for function graph tracer"),
> 	OPT_BOOLEAN(0, "sleep-time", &ftrace.sleep_time, "explanation"),
> 	OPT_BOOLEAN(0, "irqs" &ftrace.irqs, "explanation"),
> 	OPT_BOOLEAN(0, "tail" &ftrace.tail, "explanation"),
> 	OPT_BOOLEAN(0, "verbose" &ftrace.verbose, "explanation"),
> 
> We'd have a:
> 
> 	OPT_CALLBACK(0, "graph-opts", &ftrace, "options", "graph options", parse_graph_opts),
> 
> And parse_graph_opts() would just have a simple strchr(opt, ',') + if
> strcmp()/else loop, i.e., it would be easier for users, slightly more
> difficult for perf developers :-)
>
And we also have to parse key-value pairs for 'graph-depth' and move option
'--graph-depth' to 'graph-opts'.

There is an existing similr option '--debug'. It can be factored out as a
general interface.
	--debug --debug verbose=2,stderr

> - Arnaldo

-- 
Cheers,
Changbin Du
