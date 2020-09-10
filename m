Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D386C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 11:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4E1F214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 11:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599737924;
	bh=K5vBZ3S/QdRzsbugWeoWqbFxwvvquZDyxhGWk5y47jA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=StynMkYHr7ALA/nGQMsZSdYNfoNepWjaIN+Ba6lOm48gZnfJ1HoNikhiCA6QdCl5w
	 hHVlgUsVApoftaAZ2wl4kgQSGBEQhEGCSttT+rUGLNKnraaFcypmQveahIQnGhb5Qn
	 LHUKQ/2nlikOKENRBS0yj9MD89+gUeGghIXBOnVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgIJLhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 07:37:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730337AbgIJLOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 07:14:55 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA38520684;
        Thu, 10 Sep 2020 11:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599736494;
        bh=K5vBZ3S/QdRzsbugWeoWqbFxwvvquZDyxhGWk5y47jA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZtMWVprcRDARi/mFEdxdWUYDJ1yvceQsdsAuWYG213Q729kyTpfcIs9UUdg6OakoE
         HEq10BkfYHGqYOQS1h2qY/NsFBS7obYFJxH49HdFwzSpS5WU7UQ6hjhCxvP9Y31Qga
         J59dYab27y53wSUazxdVZYvU/kckmTsEVm1GWd9g=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B658540D3D; Thu, 10 Sep 2020 08:14:52 -0300 (-03)
Date:   Thu, 10 Sep 2020 08:14:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 2/3] perf metricgroup: Fix typo in comment.
Message-ID: <20200910111452.GB4018363@kernel.org>
References: <20200910032632.511566-1-irogers@google.com>
 <20200910032632.511566-2-irogers@google.com>
 <CAM9d7cjiL92Y8pCurXUpVznDUYZ8F2N0H-fSW4sPi8=M3gGSfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjiL92Y8pCurXUpVznDUYZ8F2N0H-fSW4sPi8=M3gGSfQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 10, 2020 at 02:38:58PM +0900, Namhyung Kim escreveu:
> On Thu, Sep 10, 2020 at 12:26 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Add missing character.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Applied this and the first one, continuing...

- Arnaldo
 
> Thanks
> Namhyung
> 
> > ---
> >  tools/perf/util/metricgroup.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index 8831b964288f..662f4e8777d5 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -150,7 +150,7 @@ static void expr_ids__exit(struct expr_ids *ids)
> >  }
> >
> >  /**
> > - * Find a group of events in perf_evlist that correpond to those from a parsed
> > + * Find a group of events in perf_evlist that correspond to those from a parsed
> >   * metric expression. Note, as find_evsel_group is called in the same order as
> >   * perf_evlist was constructed, metric_no_merge doesn't need to test for
> >   * underfilling a group.
> > --
> > 2.28.0.526.ge36021eeef-goog
> >

-- 

- Arnaldo
