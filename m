Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE36C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 360E2207FC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596544412;
	bh=eSlqTeWIqmcZE3q+Gfvd1jr+bh2g/hw8JgWUU6WliCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xtXp4c7vj0GoFfZComst3u1e5rzUWbUFBcIv0uxYww7hoG93Wp9h5NPcQEnjYqDfr
	 Vzu6rEjF/MKvxo7TmmcMhRL/qLuExn9/v+g5jgoqnYDqF6DtMjVxxSjX1k7Y3YmQ7b
	 C68EWVu4OoQlzXCmqNjSPYGad2uksUOrA5zOuSQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgHDMda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 08:33:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726724AbgHDMaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 08:30:19 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.178.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB8C5208A9;
        Tue,  4 Aug 2020 12:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596542860;
        bh=eSlqTeWIqmcZE3q+Gfvd1jr+bh2g/hw8JgWUU6WliCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VMKmSvp0nKcmGbkhmsB5nmfJcMNgnc9YEvWZqREuXvfPyRrQn8TmB+e+PPkF6PmLC
         goqGsWZ4XKkP68yGhOqVnR1xGlWJAdwwCQtcuis1S46yijqSQ+De7n0Rdfyi311Vaj
         9+atWYJxP6kGA9K9j5jcHWXS95rVtqSoWr9tjBV4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AF69E40C7C; Tue,  4 Aug 2020 09:07:37 -0300 (-03)
Date:   Tue, 4 Aug 2020 09:07:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Jin Yao <yao.jin@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: add psw_idle and psw_idle_exit to list of idle
 symbols
Message-ID: <20200804120737.GE3440834@kernel.org>
References: <20200707171457.85707-1-svens@linux.ibm.com>
 <yt9dv9i02dsh.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dv9i02dsh.fsf@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 03, 2020 at 01:02:06PM +0200, Sven Schnelle escreveu:
> Sven Schnelle <svens@linux.ibm.com> writes:
> 
> > Add the s390 idle functions so they don't show up in top when
> > using software sampling.
> >
> > Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> > ---
> >  tools/perf/util/symbol.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index 5ddf84dcbae7..d33d24c61d24 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -666,6 +666,8 @@ static bool symbol__is_idle(const char *name)
> >  		"poll_idle",
> >  		"ppc64_runlatch_off",
> >  		"pseries_dedicated_idle_sleep",
> > +		"psw_idle",
> > +		"psw_idle_exit",
> >  		NULL
> >  	};
> >  	int i;
> 
> gentle ping?

This was merged already:


commit 19bf119ccfa071b73a54465e8082ab2c8f8c30eb
Author:     Sven Schnelle <svens@linux.ibm.com>
AuthorDate: Tue Jul 7 19:14:55 2020 +0200
Commit:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue Jul 7 16:44:57 2020 -0300

    perf symbols: Add s390 idle functions 'psw_idle' and 'psw_idle_exit' to list of idle symbols
