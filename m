Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE6DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 755FD207F7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597234510;
	bh=mm82WzoLjrVa6avpvteLu66NhBbfGWCUMUSbAG+RWYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ku21n4x5/bgInZ5U9e7kJ4q7dnVCa34e69SxcOfrQugXNqXlWMRkuXWxQa9EAQ8MZ
	 4TttLdoBEOo5RPm1MmAB5MkEYNaN2BGNT49i2ZMrDstKWRO04rkOW8MGvqE6ffiNEN
	 9KizcB2F+oWxKfCeLjX9syhLRNDlVEcib5u9cyk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgHLMPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbgHLMPH (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:15:07 -0400
Received: from quaco.ghostprotocols.net (179.176.8.134.dynamic.adsl.gvt.net.br [179.176.8.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A55BA207F7;
        Wed, 12 Aug 2020 12:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597234506;
        bh=mm82WzoLjrVa6avpvteLu66NhBbfGWCUMUSbAG+RWYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dI4uMAk1/dvf6uOjAMb7HPjOntYOGanWXwzVMoSFZDi0pEEYyPqQ2l0MH2rm5sk43
         +wp0zeftgpQeKIgm5+bsUSa1pIdgIGUVKCMPvqyfnG7jTfLxIoPGexzAA2sNabcxyQ
         uRXQRbJOk84Rq24Gm30d1j58fNhy9xT+4Tx2FguE=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B307E403C6; Wed, 12 Aug 2020 09:15:04 -0300 (-03)
Date:   Wed, 12 Aug 2020 09:15:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        like.xu@linux.intel.com
Subject: Re: [PATCH] perf parse-events: Set exclude_guest for user-space
 counting
Message-ID: <20200812121504.GE13995@kernel.org>
References: <20200812065953.22143-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812065953.22143-1-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 12, 2020 at 02:59:53PM +0800, Jin Yao escreveu:
> Currently if we run 'perf record -e cycles:u', exclude_guest is 0.
> 
> But it doesn't make sense that we request for user-space counting
> but we also get the guest report.
> 
> To keep perf semantics consistent and clear, this patch sets
> exclude_guest for user-space counting.

Applied, and also added this, that you should consider doing in the
future (modulo the "Committer testing:" header :) ):

Committer testing:

Before:

  # perf record -e cycles:u
  ^C[ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 1.231 MB perf.data (91 samples) ]
  #
  # perf evlist -v
  cycles:u: size: 120, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ID|CPU|PERIOD, read_format: ID, disabled: 1, inherit: 1, exclude_kernel: 1, exclude_hv: 1, freq: 1, sample_id_all: 1
  <SNIP>
  #

After:

  # perf record -e cycles:u
  ^C[ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 1.263 MB perf.data (403 samples) ]
  #
  # perf evlist -v
  cycles:u: size: 120, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ID|CPU|PERIOD, read_format: ID, disabled: 1, inherit: 1, exclude_kernel: 1, exclude_hv: 1, freq: 1, sample_id_all: 1, exclude_guest: 1
  #

----

I.e. show actual command output before and after that demonstrates the
problem and then the solution.

> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/parse-events.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 9f7260e69113..4d809f1fe269 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1794,6 +1794,8 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
>  		if (*str == 'u') {
>  			if (!exclude)
>  				exclude = eu = ek = eh = 1;
> +			if (!exclude_GH)
> +				eG = 1;
>  			eu = 0;
>  		} else if (*str == 'k') {
>  			if (!exclude)
> -- 
> 2.17.1
> 

-- 

- Arnaldo
