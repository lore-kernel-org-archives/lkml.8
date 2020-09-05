Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAABC433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 03:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99F64207EA
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 03:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599276391;
	bh=01tIjTZuasEjJoIdOz5XD0XpaFwGQuC7wLSUcu7mhRA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GAV57CmNl5Loda4OngR5Tj+Y9YJWO8heUfORBJ4jVrW14VZqka1A2Q7NIzc0KMAKm
	 5Q8k+WzoydXh3zlec8eUfp4kn2R62Ju5vHSPfd9Dw2HR1s8GssxZOTonGwdBaxRjB0
	 wfnlqK33SVNJW5Jk5qJLnUXJ0shslh4Zw5AqBFlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgIED0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 23:26:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33758 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgIED01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 23:26:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id m6so9337131wrn.0;
        Fri, 04 Sep 2020 20:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cOkNEwPOi5SXJh6SoYsauM4+KcbahN2QQZ3aZqvPfME=;
        b=JSQy0ljHAt8+IUt7Xlscr2+xsfXpc7s4KLv1LEWQMgmBJbk7U9RCo/i2cnq5PwujHE
         fIpXMvtXcPqRU3tjpyLGuQSxNeUrYY88iNUSwwuEf+DSn837EwUWkfxZ8MfTfT1hJIVz
         br5ooN3LT/vyogWolYeh1vcTPozwhNr/l09JU7vPX7efVOJJ5XVI632DEFWaVhlq1nkD
         mr5nYoe4fAsEdqeEFf8n/pzaO4+3a0iHIR6OH68ES3pKp8tONvI32Oaaty5sD39uFc8I
         f1bMhAGFP9CnSvzAwV3JdOkODTDbDN5QCRC+Ig4eJov9TeHX8RI17hbt08mIFsTnStcv
         nTLw==
X-Gm-Message-State: AOAM533C3IQaOHNyAHIfY4Didw2jH9KOIK5sG34cldafsIVWHbe23218
        NV9E4BgKLLnpQ+ho0KJDVMCT3UKx6eX2UOVhrbUO5J47qfLQOQ==
X-Google-Smtp-Source: ABdhPJx+V4nRsHKMSu7Ubt3VS7tNWDf4i2Z/lEAWaB8C59mCt74wZZjIlgT+sXywraOBPqZRkCwTV9h/otyOwkJ7o5g=
X-Received: by 2002:adf:a3c9:: with SMTP id m9mr10411898wrb.80.1599276385714;
 Fri, 04 Sep 2020 20:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200904202611.GJ3753976@kernel.org>
In-Reply-To: <20200904202611.GJ3753976@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 5 Sep 2020 12:26:14 +0900
Message-ID: <CAM9d7cj0PpuFDTQ+iqAtaFS=SCRM+=1bmV=jC5+eKbTfne4Z_A@mail.gmail.com>
Subject: Re: [PATCH] tools feature: Add missing -lzstd to the fast path
 feature detection
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 5, 2020 at 5:26 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> We were failing that due to GTK2+ and then for the ZSTD test, which made
> test-all.c, the fast path feature detection file to fail and thus
> trigger building all of the feature tests, slowing down the test.
>
> Eventually the ZSTD test would be built and would succeed, since it had
> the needed -lzstd, avoiding:
>
>   $ cat /tmp/build/perf/feature/test-all.make.output
>   /usr/bin/ld: /tmp/ccRRJQ4u.o: in function `main_test_libzstd':
>   /home/acme/git/perf/tools/build/feature/test-libzstd.c:8: undefined reference to `ZSTD_createCStream'
>   /usr/bin/ld: /home/acme/git/perf/tools/build/feature/test-libzstd.c:9: undefined reference to `ZSTD_freeCStream'
>   collect2: error: ld returned 1 exit status
>   $
>
> Fix it by adding -lzstd to the test-all target.
>
> Now I need an entry to 'perf test' to make sure that
> /tmp/build/perf/feature/test-all.make.output is empty...
>
> Fixes: 3b1c5d9659718263 ("tools build: Implement libzstd feature check, LIBZSTD_DIR and NO_LIBZSTD defines")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung

>
> ---
>
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 977067e34dff064d..ec815ffc7777a02b 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -91,7 +91,7 @@ __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(
>  ###############################
>
>  $(OUTPUT)test-all.bin:
> -       $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -I/usr/include/slang -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma
> +       $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -I/usr/include/slang -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma -lzstd
>
>  $(OUTPUT)test-hello.bin:
>         $(BUILD)
