Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4D0C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0922051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlWP3mt4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbgCPNwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 09:52:33 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42673 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731258AbgCPNwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 09:52:32 -0400
Received: by mail-qt1-f196.google.com with SMTP id g16so14128061qtp.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 06:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+mIagcNlLV23hWMgbTXkOPcYJY6f7UGcWyy4Ts6o6v8=;
        b=dlWP3mt4TjttmxUhygJ3hRZZO8qHHuskVxJg1S0+lLUlh8oTvq1+EMIPFHFP/wvXHz
         kZC87wPrmiBaNowwCaELIrP0uzti0yPRXfvyYmLc2Iwyx4G74NlnuXBXUwi1Ff9Ip97U
         9W4iwTsJL4hoNR8v17+BswlCdkEzD0Tw8uQe5fhSEdT3ezlUIOIAWJX87Wx8I3/oOQKA
         g7zJ9CVBXjbhirKC6p+9DOOH0dgkIx57Bcs7V/8h89KxbG2v0UTgc0VCTebS69GRuPT3
         t8w/EZmx+vwLlRtBxs/7aIjIvv5KwiiMhPSc5wIRL2JWxQR8I70KQwCxZmbozC+cNM8+
         Ht/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+mIagcNlLV23hWMgbTXkOPcYJY6f7UGcWyy4Ts6o6v8=;
        b=dTUP0yoE2F59qX8FPXLXT4abllyyUGsKffKRP+u6X8KoLLB42PdGjpzQkyikm/h9xk
         hFnoHxdVkrI+hJHo6E1fDeIoChC38ODtLbCDtxBvvrnkr18PynJrI927uMJ7l1SZG5aa
         YqRB+L84qkcVoQfhK8qpn1IWPppNyoA+hMC6URTP6SpE9+PVRCRHrBfp0nzJTnGDze3R
         MW2qONG44pjO19p8OsBSTkXO0rgiH5XUpvPIv1YHg9kS/bSEGEK3XtTgoHEh5wnxON5g
         naqhz1apJesKcGh/9m41dxNw+UujNXBzasE74tLQstYpooJTlxqqzVCnmKxSZkaUBWIL
         inbA==
X-Gm-Message-State: ANhLgQ1QahhrKtt6pfTKSe6Kz/93WlBbHh7wHteiBToWPrspsnRfWp1g
        +mUo47uaa1uX5OkbgXdO/Bo=
X-Google-Smtp-Source: ADFU+vt7xgzuKlsTCqdSsFMx3/UfL0q/y8Lz/8WQRJQiVODAa6lLpk+gVKLpmmoyikIrKhO8l9mGjw==
X-Received: by 2002:ac8:764f:: with SMTP id i15mr74751qtr.255.1584366750734;
        Mon, 16 Mar 2020 06:52:30 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id 73sm5189700qkf.82.2020.03.16.06.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 06:52:30 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2F07140009; Mon, 16 Mar 2020 10:52:28 -0300 (-03)
Date:   Mon, 16 Mar 2020 10:52:28 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>
Subject: Re: [PATCH perf/urgent] perf expr: Fix copy/paste mistake
Message-ID: <20200316135228.GG9917@kernel.org>
References: <20200315155609.603948-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315155609.603948-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Mar 15, 2020 at 04:56:09PM +0100, Jiri Olsa escreveu:
> Copy/paste leftover from recent refactor.

This has not made into perf/urgent, so I've applied it to my perf/core
branch, thanks,

[acme@quaco perf]$ git tag --contains 26226a97724d
perf-core-for-mingo-5.7-20200310
[acme@quaco perf]$

- Arnaldo
 
> Fixes: 26226a97724d ("perf expr: Move expr lexer to flex")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/expr.l | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> index 1928f2a3dddc..eaad29243c23 100644
> --- a/tools/perf/util/expr.l
> +++ b/tools/perf/util/expr.l
> @@ -79,10 +79,10 @@ symbol		{spec}*{sym}*{spec}*{sym}*
>  	{
>  		int start_token;
>  
> -		start_token = parse_events_get_extra(yyscanner);
> +		start_token = expr_get_extra(yyscanner);
>  
>  		if (start_token) {
> -			parse_events_set_extra(NULL, yyscanner);
> +			expr_set_extra(NULL, yyscanner);
>  			return start_token;
>  		}
>  	}
> -- 
> 2.24.1
> 

-- 

- Arnaldo
