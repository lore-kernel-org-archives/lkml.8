Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58638C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 278B22083B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599159355;
	bh=PlV0ogQ3BYV2vyw/Whr/eqIeWVtVv7WHX47K59pJfUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H7yO4j62kGkMJWirHuVPP3a//vjf8lynCM2fvrvBVPL6taWPOHru1ACIVeFmeM4Qr
	 jJSC9RKDORDKnsWr+eComwMlJ0eWkWOxB71mtKazmT8IRyUJkSbNgCzLaiKEIxpr/P
	 2m92s1KGkVJ8vnDrgwK33fDeuO2H1HcmgUZH8hLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgICSzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:55:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbgICSzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:55:52 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C021320722;
        Thu,  3 Sep 2020 18:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599159352;
        bh=PlV0ogQ3BYV2vyw/Whr/eqIeWVtVv7WHX47K59pJfUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SQC14Ve6DUbFopOG2ik3RCP8nRdMHakXTQpNvMJuaqD0IygxWglp5qOGcg1lN2gSs
         Xxn4j/xB+192OgH0nN5VQgxoancWvuTlFIZti4bFLAvCZu67lU+9WBHds+Q8pWycog
         vrGphEb+KermeY3sK5mYn2ZlSDpaowJvBC3xFwXM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E537B40D3D; Thu,  3 Sep 2020 15:55:49 -0300 (-03)
Date:   Thu, 3 Sep 2020 15:55:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, irogers@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] perf bench: fix return value check in
 do_run_multi_threaded()
Message-ID: <20200903185549.GG3495158@kernel.org>
References: <20200902140526.26916-1-yuehaibing@huawei.com>
 <20200903185301.GE3495158@kernel.org>
 <20200903185451.GF3495158@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903185451.GF3495158@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 03, 2020 at 03:54:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Sep 03, 2020 at 03:53:01PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Sep 02, 2020 at 10:05:26PM +0800, YueHaibing escreveu:
> > > In case of error, the function perf_session__new() returns ERR_PTR()
> > > and never returns NULL. The NULL test in the return value check
> > > should be replaced with IS_ERR()
> > > 
> > > Fixes: 13edc237200c ("perf bench: Add a multi-threaded synthesize benchmark")
> > > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > 
> > Thanks, applied, kudos for adding the Fixes: tag, appreciated!
> 
> But...
>  
> > > ---
> > >  tools/perf/bench/synthesize.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
> > > index 8d624aea1c5e..e39daa609db2 100644
> > > --- a/tools/perf/bench/synthesize.c
> > > +++ b/tools/perf/bench/synthesize.c
> > > @@ -162,8 +162,8 @@ static int do_run_multi_threaded(struct target *target,
> > >  	init_stats(&event_stats);
> > >  	for (i = 0; i < multi_iterations; i++) {
> > >  		session = perf_session__new(NULL, false, NULL);
> > > -		if (!session)
> > > -			return -ENOMEM;
> > > +		if (IS_ERR(session)) {
> > > +			return PTR_ERR(session);
> 
> This doesn't compile, so I take back that kudo ;-\
> 
> I'm fixing this by removing that needless '{'.

diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
index e39daa609db2ed9b..b2924e3181dc3844 100644
--- a/tools/perf/bench/synthesize.c
+++ b/tools/perf/bench/synthesize.c
@@ -162,7 +162,7 @@ static int do_run_multi_threaded(struct target *target,
 	init_stats(&event_stats);
 	for (i = 0; i < multi_iterations; i++) {
 		session = perf_session__new(NULL, false, NULL);
-		if (IS_ERR(session)) {
+		if (IS_ERR(session))
 			return PTR_ERR(session);
 
 		atomic_set(&event_count, 0);
