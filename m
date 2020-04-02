Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9CFC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8372072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwhMaNmj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389143AbgDBPQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:16:47 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39373 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389053AbgDBPQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:16:47 -0400
Received: by mail-qt1-f193.google.com with SMTP id f20so3542072qtq.6;
        Thu, 02 Apr 2020 08:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d4XEhzJwWS1gTxtxswDRDBuJHjNbQq0+6erxkcN6aEQ=;
        b=CwhMaNmj75v9ZsdgR2qqkblPwTyg4JsSTe/GMmCY/hNzObGKALD7q4tlr26S0tLRYb
         gUh7Ulrl3ab8k6OpwP7caM2LpHf43nCv77KMA5pJ/bzeK2Q0a+K7Abs9OCaP9ZEUFiet
         gUOcNT9hqjdkBAm7pqinIX9Q4v07qIIMKN0EfV3+AyEOu71rrZ8T8/+mjXzYjZ2zUZ6B
         AoOaI3UNawOFXEfY90yRAtr0RBSFRz+YVvAQnuv1lHThylhglIfJ4UUCZfEJs2GMTC4D
         5t0UzRWNt7qjoJ2uYPngPTliCqVSVge2pDaamQ/HtsJ1hbaBTeL+Q4r71KGZnIJJuZdi
         32Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d4XEhzJwWS1gTxtxswDRDBuJHjNbQq0+6erxkcN6aEQ=;
        b=U0J/aZ9MlFYQ4VpnjXQIBSXyhawD+pFRnWS9pOPI+Uups5cdcpxze26S6VzARAvojm
         pyZilWfiD6i6hHtmNNBgnnv6MRdi1IbKSa4DOauV2Rvs95Vvsfg/gZThoczfdKETRqGm
         mKWn4BxHPpEWg3qmws/B0Zue0aGakYLooHLCkxHqXmp35WVhwLFer9TL8t8h/rH+Uxxz
         PYZ9PLNFLHulBoheb3dPmpArwd4+TBnJBY4H4cVhIyQiCcwAxsV6FopmykS0AAvz2BRr
         1w+Bhma5UsZ6q6XQEi5tIX8SI99RzgsFDSHN52P7Lgblgkp5QJpfCnTE6X/xxCJvw0uF
         EQUQ==
X-Gm-Message-State: AGi0PubN2JEtw8kke9v/FS1R3bgDyyI8LVlwWj/QLQRGeKI6GHZw1bt6
        9psdsAa0DXIqM2iIlLq+onk=
X-Google-Smtp-Source: APiQypJrLmvg6e8tx7O6zon/307fyafWM1FEmfUVpL+QnjYahN4yCxjJ5vwTom6CDExrrOWaFB0mvQ==
X-Received: by 2002:aed:2314:: with SMTP id h20mr3494425qtc.184.1585840605945;
        Thu, 02 Apr 2020 08:16:45 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id s26sm3597919qkm.114.2020.04.02.08.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 08:16:45 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6D058409A3; Thu,  2 Apr 2020 12:16:43 -0300 (-03)
Date:   Thu, 2 Apr 2020 12:16:43 -0300
To:     Andreas Gerstmayr <agerstmayr@redhat.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script report: fix segfault when using DWARF mode
Message-ID: <20200402151643.GB8736@kernel.org>
References: <05e0d633-54b4-fb3b-3d08-8963271017ea@amd.com>
 <20200402125417.422232-1-agerstmayr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402125417.422232-1-agerstmayr@redhat.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 02, 2020 at 02:54:16PM +0200, Andreas Gerstmayr escreveu:
> When running perf script report with a Python script and a callgraph in
> DWARF mode, intr_regs->regs can be 0 and therefore crashing the regs_map
> function.
> 
> Added a check for this condition (same check as in builtin-script.c:595).

Thanks, applied to perf/urgent.

- Arnaldo
 
> Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
> ---
>  tools/perf/util/scripting-engines/trace-event-python.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 8c1b27cd8b99..2c372cf5495e 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -694,6 +694,9 @@ static int regs_map(struct regs_dump *regs, uint64_t mask, char *bf, int size)
>  
>  	bf[0] = 0;
>  
> +	if (!regs || !regs->regs)
> +		return 0;
> +
>  	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
>  		u64 val = regs->regs[i++];
>  
> -- 
> 2.25.1
> 

-- 

- Arnaldo
