Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA24C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDFC20873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyIvZNio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgCKNZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 09:25:54 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:34615 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729408AbgCKNZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 09:25:54 -0400
Received: by mail-qv1-f68.google.com with SMTP id o18so842778qvf.1;
        Wed, 11 Mar 2020 06:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=608UGPjQxMJ+t19p3V9TY1lai0zCnjMBtkdpOWI2Q18=;
        b=jyIvZNioHmCuXgYIimQZ85RIPvniBSYqjHUK7fgpepAhhcH12BMPl3GnCNj6qSJtKr
         qgVdEuMZgBUFB/N+l5vFCjfNER47/t/Zb211CNvlRrwPPmh0C1mu3594XPB3skICmsBo
         dG2fjiUnlmPr9ZrA+X54mWhv8ahZqoyV5VpIQs0Y7HJWRu1wnKEoAYgVQS8Xsf9De77u
         MVfWOvu84Wo8zmIfU5LB3doifmedVx8cdSLWlukpaV5du1tYce18sKK81Vo1sgICuHaa
         bDQSNQm0lf204DNL3BulRWQCZrN+2PE8j1s+OxOTjnB/tbjdcHGx4wugZA3H16OAHhPs
         OL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=608UGPjQxMJ+t19p3V9TY1lai0zCnjMBtkdpOWI2Q18=;
        b=eqIaBdFipnour4M60JRs6oyoCmu93Cj+AEgkIPFnEgyX3xh6FnR7xu4CASjAygeTQs
         2x5SXsAlpu3owCErN4p4uFYuxaDKtKGr5tR2SdA80Db7infIHuJrlvH6RcFaVcmY9Yi0
         PepBhHq67n4GuhEVj4Bp05l4Lms/U880Uitz6Aci0xBGGQG0Rp8JVoy2DV2tk6AU2NQA
         BZqJ4+MVx+o5DqwGX1f+HE5s/IwdA+ijJpFvzSL0wzcQx/1hb9zDJC3BjimLPDDUXrE4
         jqRvPhWuVK8sA4cwg+ai2DE88WO/A9O5P3WvhmRhErNIJSf5rX65f+KAIF6OJ96nAcCM
         ijkQ==
X-Gm-Message-State: ANhLgQ2y12lw1cC327Rz1FiSu2YG8MeklUKb83V6+dDR9v/t3sgnLbdQ
        hYYSLEanMRdWuxF3ZU2qk4o=
X-Google-Smtp-Source: ADFU+vuCTEKFWw1P+Hna1qOz8XGvd2i2fUMP/TT3VwdW0Vx55tgcseUM+m3/H7VQW8T7u90//turyA==
X-Received: by 2002:ad4:4527:: with SMTP id l7mr2794953qvu.221.1583933152695;
        Wed, 11 Mar 2020 06:25:52 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id a23sm25455599qko.77.2020.03.11.06.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 06:25:52 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7D51540009; Wed, 11 Mar 2020 10:25:49 -0300 (-03)
Date:   Wed, 11 Mar 2020 10:25:49 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Masanari Iida <standby24x7@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf doc: Set man page date to last git commit
Message-ID: <20200311132549.GB19277@kernel.org>
References: <20200311052110.23132-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311052110.23132-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 10, 2020 at 10:21:10PM -0700, Ian Rogers escreveu:
> Currently the man page dates reflect the date the man pages were built.
> This patch adjusts the date so that the date is when then man page
> last had a commit against it. The date is generated using 'git log'.

Thanks, applied,

Please consider changing the Makefile to make it be a dependency of the
man pages, so that when we change it we rebuild the man pages, I had to
go fresh to see the results :-)

I.e. had to do this:

Committer testing:

  $ git log -1 --pretty="format:%cd" --date=short tools/perf/Documentation/perf-top.txt
  2020-01-14

Before:

  rm -rf /tmp/build/perf
  mkdir -p /tmp/build/perf
  make -C tools/perf O=/tmp/build/perf/ install
  $ date
  Wed 11 Mar 2020 10:21:19 AM -03
  $ man perf-top | tail -1
  perf                    03/11/2020           PERF-TOP(1)
  $

After:

  rm -rf /tmp/build/perf
  mkdir -p /tmp/build/perf
  make -C tools/perf O=/tmp/build/perf/ install
  $ date
  $ date
  Wed 11 Mar 2020 10:24:06 AM -03
  $ man perf-top | tail -1
  perf                    2020-01-14           PERF-TOP(1)
  $


- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Documentation/Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
> index adc5a7e44b98..31824d5269cc 100644
> --- a/tools/perf/Documentation/Makefile
> +++ b/tools/perf/Documentation/Makefile
> @@ -295,7 +295,10 @@ $(OUTPUT)%.1 $(OUTPUT)%.5 $(OUTPUT)%.7 : $(OUTPUT)%.xml
>  $(OUTPUT)%.xml : %.txt
>  	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
>  	$(ASCIIDOC) -b docbook -d manpage \
> -		$(ASCIIDOC_EXTRA) -aperf_version=$(PERF_VERSION) -o $@+ $< && \
> +		$(ASCIIDOC_EXTRA) -aperf_version=$(PERF_VERSION) \
> +		-aperf_date=$(shell git log -1 --pretty="format:%cd" \
> +				--date=short $<) \
> +		-o $@+ $< && \
>  	mv $@+ $@
>  
>  XSLT = docbook.xsl
> -- 
> 2.25.1.481.gfbce0eb801-goog
> 

-- 

- Arnaldo
