Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F7BC433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 10:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F1292074B
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 10:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgIEKoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 06:44:23 -0400
Received: from mga17.intel.com ([192.55.52.151]:63247 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbgIEKoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 06:44:22 -0400
IronPort-SDR: lb8bsR65bNWjALm+QHGar4cIUnmuKS4zIdGsNp0owKUTiuoOXhghnntDA7JGzMIFE41YU7FOtp
 6WcHPtUKhC0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="137903333"
X-IronPort-AV: E=Sophos;i="5.76,393,1592895600"; 
   d="scan'208";a="137903333"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2020 03:44:21 -0700
IronPort-SDR: Px5SDbItv/z3eUH8kE8V+gnKaXytGKj0rfuCIb8KsHy4of2z/ffufTZASb1KsrTUTkl2d4Xj4Y
 qPGAdCcHKunw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,393,1592895600"; 
   d="scan'208";a="335303346"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 05 Sep 2020 03:44:20 -0700
Received: from [10.249.229.135] (abudanko-mobl.ccr.corp.intel.com [10.249.229.135])
        by linux.intel.com (Postfix) with ESMTP id 791AC580707;
        Sat,  5 Sep 2020 03:44:17 -0700 (PDT)
Subject: Re: [PATCH] tools feature: Add missing -lzstd to the fast path
 feature detection
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20200904202611.GJ3753976@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <2ddf68fc-3079-56eb-4214-e9176909f941@linux.intel.com>
Date:   Sat, 5 Sep 2020 13:44:16 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200904202611.GJ3753976@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.09.2020 23:26, Arnaldo Carvalho de Melo wrote:
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
> -	$(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -I/usr/include/slang -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma
> +	$(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -I/usr/include/slang -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma -lzstd
>  
>  $(OUTPUT)test-hello.bin:
>  	$(BUILD)
> 

Reviewed-by: Alexei Budankov <alexey.budankov@linux.intel.com>

Thanks!
Alexei
