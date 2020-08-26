Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623A8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 420E62087D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598442377;
	bh=rkdJpqDKGPr3YuL3BMdQcX/bSGlko7vm4k18JNIejrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y89mDQxsAnayLh/jjZFD/LtUr4hKwEd4Acs+oCISID5DGArntcSlP9uM3ApkCAxDj
	 RuDkOZtitQ3O6GWijEVRSLjbzTaKJD6U/W5V3zAZh5qCucuXeIr4Kw+7meqzK5ylOB
	 wATZIXblxRpxbwjhsCBoeSYsRuCw4Bq5RmTm/Nig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgHZLqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:46:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728932AbgHZLdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:33:10 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 063352087C;
        Wed, 26 Aug 2020 11:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598441586;
        bh=rkdJpqDKGPr3YuL3BMdQcX/bSGlko7vm4k18JNIejrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0G+G6QnbzQCztoPazul2NDxfGxy+ETcF1gEEIZZayu7JlY9ANQnRvDrI6lUgYRi08
         xEwmaStf8q60ERX1sQjaPflMPh5yrwA7y1clzs1AnlAMTNQQG71hmcZId0Hpizshnv
         JBupRTtfjGyzEnB7/+k8pm3BG3bpH+HzHx6gfC0U=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1BD4940D3D; Wed, 26 Aug 2020 08:33:04 -0300 (-03)
Date:   Wed, 26 Aug 2020 08:33:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf test: Perf test 67 dumps core on s390
Message-ID: <20200826113304.GC1059382@kernel.org>
References: <20200825071211.16959-1-tmricht@linux.ibm.com>
 <CAP-5=fUkOyVUgagpkh6zgbjA1Dd0oP_WmP4HVA8f6J3WifwM9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUkOyVUgagpkh6zgbjA1Dd0oP_WmP4HVA8f6J3WifwM9w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 25, 2020 at 02:04:30PM -0700, Ian Rogers escreveu:
> On Tue, Aug 25, 2020 at 12:12 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> >
> > Linux 5.9 introduced perf test case "Parse and process metrics" and
> > on s390 this test case always dumps core:

<SNIP>

> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

I'll add your comments and...
 
> This also shows up with address sanitizer on all architectures
> (perhaps change the patch title) and perhaps add a "Fixes: <commit>"
> tag.
> =================================================================
> ==4718==ERROR: AddressSanitizer: global-buffer-overflow on address
> 0x55c93b4d59e8 at pc 0x55c93a1541e2 bp 0x7ffd24327c60 sp
> 0x7ffd24327c58
> READ of size 8 at 0x55c93b4d59e8 thread T0
>     #0 0x55c93a1541e1 in find_metric tools/perf/util/metricgroup.c:764:2
> > +++ b/tools/perf/tests/parse-metric.c
> > @@ -70,6 +70,11 @@ static struct pmu_event pme_test[] = {
> >  {
> >         .metric_expr    = "1/m3",
> >         .metric_name    = "M3",
> > +},
> > +{
> > +       .metric_expr    = NULL,
> > +       .metric_name    = NULL,
> > +       .metric_group   = NULL

No need to set all three to NULL, just one is enough and then the
compiler will zero out all the rest.

- Arnaldo
