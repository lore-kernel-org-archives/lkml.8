Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF51C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A6A4206A5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599236966;
	bh=ijQZmDJ1VKEp4/GIBst2/UEw+3wG90aKOhvkbc/1BG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AO4Z38NJ4Z16aWC5cFT7iKAQ1DHXYG7extsh6a53HkG/JOQyEyMFoWHk5sADSfqcD
	 Ki9sXzYl4VaPEcvNJMzL6BLSwSLQEcK4dWIAJBvHWRSAhMkBhiwJ2hRUVnjFSNN03J
	 54d10M/UX7X5q6/sCsUg1zhAzDAGFZjS9R6j6s8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgIDQ3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:29:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgIDQ3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:29:23 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13596206A5;
        Fri,  4 Sep 2020 16:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599236962;
        bh=ijQZmDJ1VKEp4/GIBst2/UEw+3wG90aKOhvkbc/1BG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B2VicmmT9O0OSF/wh6e+YOLQ8CXV7yG8OLbt4+2DJ7y/8FescpdRn7f+ZoShlpOq6
         CWdF7O0i8peUfFMm8Y33AVbJd+Fiq4edwuVLMHSBJ/l8eKvd1sO5Wb9x+BKzPHxgpw
         VpymAmboad0RpYYk37M42X2ZWf2bFlGrbMc6yMJQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2202240D3D; Fri,  4 Sep 2020 13:29:20 -0300 (-03)
Date:   Fri, 4 Sep 2020 13:29:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     kajoljain <kjain@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf expr: Force encapsulation on expr_id_data
Message-ID: <20200904162920.GV3495158@kernel.org>
References: <20200826153055.2067780-1-irogers@google.com>
 <20200826155733.GB783610@krava>
 <4b6bc995-d468-3137-f00f-3867233740a3@linux.ibm.com>
 <CAP-5=fUdK2Zuv9BMpkRw669n_SvQ3kDa0s0RA=Hj1GUtqqw0YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUdK2Zuv9BMpkRw669n_SvQ3kDa0s0RA=Hj1GUtqqw0YQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 03, 2020 at 10:53:16PM -0700, Ian Rogers escreveu:
> On Thu, Aug 27, 2020 at 12:00 AM kajoljain <kjain@linux.ibm.com> wrote:
> >
> >
> >
> > On 8/26/20 9:27 PM, Jiri Olsa wrote:
> > > On Wed, Aug 26, 2020 at 08:30:55AM -0700, Ian Rogers wrote:
> > >> This patch resolves some undefined behavior where variables in
> > >> expr_id_data were accessed (for debugging) without being defined. To
> > >> better enforce the tagged union behavior, the struct is moved into
> > >> expr.c and accessors provided. Tag values (kinds) are explicitly
> > >> identified.
> >
> > Reviewed-By: Kajol Jain<kjain@linux.ibm.com>
> >
> > Thanks,
> > Kajol Jain
> > >>
> > >> Signed-off-by: Ian Rogers <irogers@google.com>
> > >
> > > great, thanks for doing this
> > >
> > > Acked-by: Jiri Olsa <jolsa@redhat.com>
> > >
> > > jirka
> > >
> 
> Thanks for the reviews! Arnaldo could this get merged? Thanks!

I'll get this and the other outstanding patches into perf/core soon as I
got urgent stuff already merged by Linus,

Thanks!

- Arnaldo
