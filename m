Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7E0C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 189902074B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595004297;
	bh=mPWcubb+1OOeRzCC8UaJsYvbCOgciE/eu3GRXnDMqn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T9iyjH5+b4xouuHyRZvq5fC2f0ESJk+hEr9mzKsLPFqB3lfkyTICAImIvQhMpwLKO
	 hIW78iS0iG2bcwyr31QHUeadIzt8cLY3tVvapfx3k1kDRq/KhnN39aMhSW9Nw5YXfe
	 qwX/VUZuKE2IwSGDJh0VJI3hDJJLg++dvb9SqkG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgGQQoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:44:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbgGQQoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:44:55 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA8B72067D;
        Fri, 17 Jul 2020 16:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595004294;
        bh=mPWcubb+1OOeRzCC8UaJsYvbCOgciE/eu3GRXnDMqn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E6RAlCz9b+Ikt9EraXleXTwMUVyhK00b2BBD5ALr+iMoIYV53B34WuB8VKq6DFXad
         ZPXsKEzSTLAyLHubdD/H5Jaky24B5gXj6AmsXwAW8pMAXlSO9sSbIoccfpwWEhYglY
         PDSmIYTEkuADK47QgPZsut6sBttMgxzxwAX2HK3I=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C8B9740482; Fri, 17 Jul 2020 13:44:52 -0300 (-03)
Date:   Fri, 17 Jul 2020 13:44:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/17] perf ftrace: add option -t/--tid to filter by
 thread id
Message-ID: <20200717164452.GD712240@kernel.org>
References: <20200711124035.6513-1-changbin.du@gmail.com>
 <20200711124035.6513-4-changbin.du@gmail.com>
 <20200716153630.GD374956@kernel.org>
 <20200717132650.i32oovllal22b35i@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717132650.i32oovllal22b35i@mail.google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 17, 2020 at 09:26:50PM +0800, Changbin Du escreveu:
> On Thu, Jul 16, 2020 at 12:36:30PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Sat, Jul 11, 2020 at 08:40:21PM +0800, Changbin Du escreveu:
> > > +++ b/tools/perf/Documentation/perf-ftrace.txt
> > > @@ -38,6 +38,10 @@ OPTIONS
> > >  --pid=::
> > >  	Trace on existing process id (comma separated list).

> > > +-t::
> > > +--tid=::
> > > +	Trace on existing thread id (comma separated list).

> > Humm, I just  tried:

> > [root@five ~]# yes > /dev/null &
> > [1] 18265
> > [root@five ~]# perf ftrace --tid 18265
> > ^C[root@five ~]#

> > After waiting for a while, nothing, what am I doing wrong?

> I got it wrong. Currently ftrace only can filter by pid. If the pid is not
> the main thread it won't work.
 
> So this patch makes no sense. will drop this.

I think you could alternatively keep it but inform the user that this
target, available to other perf commands, isn't available for ftrace as
it doesn't support it, this way when the user goes from:

perf trace|top|record|script|report --tid 1234

to:

perf ftrace --tid 1234

He gets a message like:

ERROR: 'ftrace' doesn't support the --tid target, try with --pid

And that would be more useful, provides an explanation as why that
target can't be used and suggests an alternative.

- Arnaldo
