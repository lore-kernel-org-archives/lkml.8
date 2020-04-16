Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6B3C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 880A5206A2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPAP3fsG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407126AbgDPOyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405907AbgDPOyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:54:31 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58362C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 07:54:31 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w29so16178281qtv.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 07:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Etbk7rdNgMqH7Cm8FhnpqP53Wbqbw8Y1RuUVXb+PXc0=;
        b=mPAP3fsGoyvk1dnOOsH0XuvNzRFb5Jg50JWZ4sXWpWeMM88oUYkrd7xnyCnkhz9abZ
         M0tvegs1eXEdDVTgD1mIOrssZf0+UbBQVBNEMzNgHbXSO5032WKTKgC9VdrBeR+9X1cV
         pSg7OlcUuubn/X8tcG7T3wlNxPaoS8ty1329CIt/c7AExIdPScqmU4RHjigWP6ymcEwZ
         Gjy+FnbuKId4045xM2NkGxdqzZmWjO4XGu7Fv8LNKy/axEl7fAaUUOvbcXgJ5M4AtWn2
         hA9Wskt5DOvDWwXGoiZVymfGI6wp3b9QnVDPoTtLB/TStossYehgvTmWij4KETVqMuJz
         9cfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Etbk7rdNgMqH7Cm8FhnpqP53Wbqbw8Y1RuUVXb+PXc0=;
        b=WqSyzFWkikaoi1x5KOS3qLU2Ytx9yYu8j95/MmHYQzqxwCj/TaOgb4/gysINVTAfkj
         ifbv6YqCEkMwBz+A9dPn0H9ggUT0ma19+1KEJu4WNPSCl7I+oY9bKgOBw5ILCrA1oziU
         18nu80gM9M1zVLp3ZkZulB1NBMJUO4rhVqi1dO5U+u4QbHOkdMrEyD4FEHzG1ufuDlwp
         TJbQpUrjpm/GAh9sCpDQPIFFW5xbbUQ0JcsvLa5z4F/1w7gssx6W8El7DnxhP1TRwD6o
         Avpf9T9J+KDqxP4GwPob1hfE1azEt7lwO6V2xIuukizkteWbCBUFqSFnXnYdMIGXdCn3
         z6bw==
X-Gm-Message-State: AGi0PuaTv9aPhfJjp11m/STf+KZ4yVZiA84ghOFGT3DHh8478JZkkKSf
        pEUGEm6mvRLADicriruTv74=
X-Google-Smtp-Source: APiQypLux5mTNMuigb4n9Q+X+zhIREe2Oc8Nq38zS8fpePrHuEK54ntNvmlKfjsnxNLCeIYzOKDxhQ==
X-Received: by 2002:ac8:3466:: with SMTP id v35mr26649342qtb.308.1587048870419;
        Thu, 16 Apr 2020 07:54:30 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id y17sm11707586qky.33.2020.04.16.07.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 07:54:29 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B7A70409A3; Thu, 16 Apr 2020 11:54:26 -0300 (-03)
Date:   Thu, 16 Apr 2020 11:54:26 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/16] perf tools: Add support for synthesized sample type
Message-ID: <20200416145426.GA31666@kernel.org>
References: <20200401101613.6201-1-adrian.hunter@intel.com>
 <20200401101613.6201-11-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401101613.6201-11-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 01, 2020 at 01:16:07PM +0300, Adrian Hunter escreveu:
> For reporting purposes, an evsel sample can have a callchain synthesized
> from AUX area data. Add support for keeping track of synthesized sample
> types. Note, the recorded sample_type cannot be changed because it is
> needed to continue to parse events.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/evsel.c |  2 +-
>  tools/perf/util/evsel.h | 15 ++++++++++++++-
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index eb880efbce16..60e6cd49dee3 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2136,7 +2136,7 @@ int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  		}
>  	}
>  
> -	if (evsel__has_callchain(evsel)) {
> +	if (type & PERF_SAMPLE_CALLCHAIN) {
>  		const u64 max_callchain_nr = UINT64_MAX / sizeof(u64);

This ends up looking unrelated, I had to go and look at the source to
see that this is just a simplification, i.e. earlier in this function
(perf_evsel__parse_sample) we have:

        u64 type = evsel->core.attr.sample_type;

So the above doesn't change anything, good, but slowed reviewing a bit,
please consider next time to have this in a separate patch, I'll do it
this time.

Thanks,

- Arnaldo
  
>  		OVERFLOW_CHECK_u64(array);
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 53187c501ee8..e64ed4202cab 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -104,6 +104,14 @@ struct evsel {
>  		perf_evsel__sb_cb_t	*cb;
>  		void			*data;
>  	} side_band;
> +	/*
> +	 * For reporting purposes, an evsel sample can have a callchain
> +	 * synthesized from AUX area data. Keep track of synthesized sample
> +	 * types here. Note, the recorded sample_type cannot be changed because
> +	 * it is needed to continue to parse events.
> +	 * See also evsel__has_callchain().
> +	 */
> +	__u64			synth_sample_type;
>  };
>  
>  struct perf_missing_features {
> @@ -398,7 +406,12 @@ static inline bool perf_evsel__has_branch_hw_idx(const struct evsel *evsel)
>  
>  static inline bool evsel__has_callchain(const struct evsel *evsel)
>  {
> -	return (evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN) != 0;
> +	/*
> +	 * For reporting purposes, an evsel sample can have a recorded callchain
> +	 * or a callchain synthesized from AUX area data.
> +	 */
> +	return evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN ||
> +	       evsel->synth_sample_type & PERF_SAMPLE_CALLCHAIN;
>  }
>  
>  struct perf_env *perf_evsel__env(struct evsel *evsel);
> -- 
> 2.17.1
> 

-- 

- Arnaldo
