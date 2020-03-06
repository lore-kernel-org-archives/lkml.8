Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDDFC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 11:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D742072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 11:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OI/ad56N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCFLk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 06:40:58 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33366 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgCFLk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 06:40:58 -0500
Received: by mail-qk1-f194.google.com with SMTP id p62so1983971qkb.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 03:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4pk90DW3tifrhVv5weuQmOO8XCqjEpeowZPJvyemYzw=;
        b=OI/ad56NrGTbNVtPro/NOPV6T8O4BQ3FHoaKgQMEfp7BTnjYlHSDkQ9xNSv6wi6BHZ
         s5oN1W/ZBCP5EsM2qWuPxNVOhkMB+yBBnsPfWPbwv0kpvHuxNC2PZI9KMAWTrv+Lvt8E
         vBoqPR2J2G/1EuqVr+2XVfs1m5SapJw2bf3D2EmwIYewER20b90pV+My0B6fqHVvxE2S
         7SNqw4TdlFgbHFQUjf4iItnB0/uHGcvZHf+/yNC4xkhGzcJBiNaUUl8QqpltXRl1puWJ
         6sCfiYthfaKnDf+Ufm0uoymDqmQzZy21CE6f+fThoQ/TOGFr1r1avwh4Kgp1mawMuqZT
         C/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4pk90DW3tifrhVv5weuQmOO8XCqjEpeowZPJvyemYzw=;
        b=GJg+4vxZhCaxxlX5eSdyF3nj9kqG3OUsK86lqKCG0v+40PMw2PBBYBJqX4coVyrsJd
         gxzoyH9ALkAHOU2AgsqvFO14n7t+xQtozX3tb0bwayrEPQcTwntymMOxRpoZBS94B832
         7MRc4JPIZf+lWkAAxrXtEzC4C5MPlM5e0tTCcu2nwbBTC7IPwwt/tc8kj/PFedmeazW6
         2xYB1i1gubl0BIeBr8FI0N/HdCWjigtx0FBK18SH4b8u6XokMaPvIIeSWGNd725Ux00j
         0RKcwgNlYAdeypf4SlWKyqDqD2S+cYZJZdSPbODF5K6JHD2BYM+2Ln86e6p/K2tjYj/U
         oxYg==
X-Gm-Message-State: ANhLgQ0aGyOI9+H0xFdrNW+WNQcIUju3Zysz5/MjFY3022rn77FP2XhL
        F2stcxt1QFlyeQgNKBy2x+Q=
X-Google-Smtp-Source: ADFU+vtxVHsqTQcTZCkMKjfbpmoSIP085wxEecOefgSlQA8ovx8aaD6kgf24X6hGTL2OnPcoVkHTKw==
X-Received: by 2002:a37:9c15:: with SMTP id f21mr2492466qke.414.1583494856985;
        Fri, 06 Mar 2020 03:40:56 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id m1sm9018732qkk.103.2020.03.06.03.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 03:40:56 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 82E0B403AD; Fri,  6 Mar 2020 08:40:54 -0300 (-03)
Date:   Fri, 6 Mar 2020 08:40:54 -0300
To:     Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Li <liwei391@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 3/3] tools/perf: build fixes for arch_errno_names.sh
Message-ID: <20200306114054.GB27494@kernel.org>
References: <20200306071110.130202-1-irogers@google.com>
 <20200306071110.130202-4-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306071110.130202-4-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 05, 2020 at 11:11:10PM -0800, Ian Rogers escreveu:
> Allow the CC compiler to accept a CFLAGS environment variable.
> Make the architecture test directory agree with the code comment.
> This doesn't change the code generated but makes it easier to integrate
> running the shell script in build systems like bazel.

Hendrik and Thomas, can you please take a look at this and provide a
Reviewed-by tag?

Thanks,

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/trace/beauty/arch_errno_names.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/trace/beauty/arch_errno_names.sh
> index 22c9fc900c84..9f9ea45cddc4 100755
> --- a/tools/perf/trace/beauty/arch_errno_names.sh
> +++ b/tools/perf/trace/beauty/arch_errno_names.sh
> @@ -57,7 +57,7 @@ process_arch()
>  	local arch="$1"
>  	local asm_errno=$(asm_errno_file "$arch")
>  
> -	$gcc $include_path -E -dM -x c $asm_errno \
> +	$gcc $CFLAGS $include_path -E -dM -x c $asm_errno \
>  		|grep -hE '^#define[[:blank:]]+(E[^[:blank:]]+)[[:blank:]]+([[:digit:]]+).*' \
>  		|awk '{ print $2","$3; }' \
>  		|sort -t, -k2 -nu \
> @@ -91,7 +91,7 @@ EoHEADER
>  # in tools/perf/arch
>  archlist=""
>  for arch in $(find $toolsdir/arch -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | grep -v x86 | sort); do
> -	test -d arch/$arch && archlist="$archlist $arch"
> +	test -d $toolsdir/perf/arch/$arch && archlist="$archlist $arch"
>  done
>  
>  for arch in x86 $archlist generic; do
> -- 
> 2.25.1.481.gfbce0eb801-goog
> 

-- 

- Arnaldo
