Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF12C3F2D8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05882146E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwn7De6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgCEOtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 09:49:50 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37229 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgCEOts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 09:49:48 -0500
Received: by mail-qv1-f68.google.com with SMTP id c19so2524142qvv.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 06:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SwhhEvZC8ISuj8BzMi7OAT03/sqD5YiHVmOJxZpeUc0=;
        b=kwn7De6DXFSmNPiKMSYDdKClyFam7AxPe9nwxhpxbZjEW/7KPvChLZ2gb8UTEjVX2e
         E1HtsyJP9sAdp4OrkOz+DIsO4ZQlY52ExmpE4hG16oRhJudMT5BxXkE0HoqqqCwy5Hxp
         ur6q6pFG+CeJXfUzVZsmV48/SSswlljBs1IzcWiTpjFfigtA3dNaLDrTvOahZbbmNcFb
         KSauIXXfs8e39qicjbYwuj8U5gVrBTNiHDb9rF9D5/TbIV8Aq3zS6W/4VxJbVGRAc2fh
         A7wVFA/aoIzC84FatA42q9NvM/B5sU/pKubj/J13t5p1Hg9I+Ph52HVgF3DAGRDCvJ2Q
         qsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SwhhEvZC8ISuj8BzMi7OAT03/sqD5YiHVmOJxZpeUc0=;
        b=icEYT9xO0hLW/3/lETFWlaoYlSpXzBD+FtJmAxWi8cEj15RpPM9eRJtNrMHVv7mUdG
         TiI/hxttv8w+fmuAkT0hJNOEY4a8eK3I85AeUCJMPo10CvDRdqIqivcSBpcFOlQTUw7C
         uPbmFzJQoC+ClCAXSqP0uErm5a4Bfuzij1QW0YJQJ2x+xC8xcc0QtIpv9rr4a+M0Lg9G
         pL3g53H4iRgCvm+Pl95PMLJ6KZiBnMzk3phxmwkBgIgIVcrSw4BQ05sn/MchskVSCpES
         boXobtgC0jo2d/u6bERhpxWEPAzT5qw6Aj4Na2daBSr45t7OQS9sxra1aofM867OKUof
         M+7g==
X-Gm-Message-State: ANhLgQ1aFDHjmjY5G320s/g2GbbgWKqtcdFiaNM7cTvs6TSjU79sg3p+
        PMq1jotbsHdo0pbRSM/QgkI=
X-Google-Smtp-Source: ADFU+vvRvwmhzZr9w0IPcVus8AMKk7bQmsJOZtj1su/2VaP1qN+jwwHQEqfc8s+3X0EcK7bEM0QuTg==
X-Received: by 2002:ad4:47aa:: with SMTP id a10mr6515928qvz.230.1583419787021;
        Thu, 05 Mar 2020 06:49:47 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id s56sm221196qtk.9.2020.03.05.06.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 06:49:46 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EC0DE403AD; Thu,  5 Mar 2020 11:49:43 -0300 (-03)
Date:   Thu, 5 Mar 2020 11:49:43 -0300
To:     Tommi Rantala <tommi.t.rantala@nokia.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] perf top: Fix stdio interface input handling with
 glibc 2.28+
Message-ID: <20200305144943.GA7895@kernel.org>
References: <20200305083714.9381-1-tommi.t.rantala@nokia.com>
 <20200305083714.9381-2-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305083714.9381-2-tommi.t.rantala@nokia.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 05, 2020 at 10:37:12AM +0200, Tommi Rantala escreveu:
> Since glibc 2.28 when running 'perf top --stdio', input handling no
> longer works, but hitting any key always just prints the "Mapped keys"
> help text.
> 
> To fix it, call clearerr() in the display_thread() loop to clear any EOF
> sticky errors, as instructed in the glibc NEWS file
> (https://sourceware.org/git/?p=glibc.git;a=blob;f=NEWS):
> 
>  * All stdio functions now treat end-of-file as a sticky condition.  If you
>    read from a file until EOF, and then the file is enlarged by another
>    process, you must call clearerr or another function with the same effect
>    (e.g. fseek, rewind) before you can read the additional data.  This
>    corrects a longstanding C99 conformance bug.  It is most likely to affect
>    programs that use stdio to read interactive input from a terminal.
>    (Bug #1190.)

Thanks for fixing this, I had stumbled on it at some point, but since I
mostly use the TUI interface, it fell thru the cracks.

Do you prefer it over the TUI one?

Thanks, tested and applied.

- Arnaldo
 
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
> ---
>  tools/perf/builtin-top.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index f6dd1a63f159e..d2539b793f9d4 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -684,7 +684,9 @@ static void *display_thread(void *arg)
>  	delay_msecs = top->delay_secs * MSEC_PER_SEC;
>  	set_term_quiet_input(&save);
>  	/* trash return*/
> -	getc(stdin);
> +	clearerr(stdin);
> +	if (poll(&stdin_poll, 1, 0) > 0)
> +		getc(stdin);
>  
>  	while (!done) {
>  		perf_top__print_sym_table(top);
> -- 
> 2.21.1
> 

-- 

- Arnaldo
