Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F02CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB90C20734
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtLYiQNv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgENNKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 09:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726037AbgENNKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 09:10:36 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B21C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 06:10:34 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id 4so2749362qtb.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 06:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L3hKHnlsCcttbXQ2Cja7DwdXszoqAGcuUShjDJ8b2a4=;
        b=AtLYiQNv1DEysHFJjO4AE/VvjKevpPBCypEQwiPFNVjqFQ22w68L43Du/CffnxdPGA
         jvp/iaLZ/Z3/k1ikBXKLS55XSv06D34pA+FGiKJ4FydjyEIZ5q92iW+aetHq6h5+IWTD
         r51NM5Ibj7+6xYIkx07083lipNnY5lm310IR5hXy0ew4tZD6bS4aFfEmmG1Jkh6FrnoI
         JhOhBN7nljXG8KgUePS+fJOlNlvfj/PpiQpWt+vHcERDBBkpuw4Ll2zepwpRZWsnjmfK
         rrlAR8Fl6A8fDbUComhxxt14Gsy/26TURlGNI8CJvv9Tzp31eQmjm+F8YBOwfxLfhCtb
         MNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L3hKHnlsCcttbXQ2Cja7DwdXszoqAGcuUShjDJ8b2a4=;
        b=OETUOBLahBolb+2MbfhBl6EWyrLQYltnG5utEhr2uKUBa0ifIDSViQgU8CxjtQ9EUm
         UWdJx3X5er2rSQglCG5zIMf3pMXZCrnLFwefnQhvEPS69M+fLKsEmwJvDkVlmHvPhMeC
         IbrfyeqKq8paQTrTOEWt4NG1it8RrEe6OYOZz56Hv7GnjUwnFe7Mq7Exb7sNsZ5FGHNd
         tkD6K7S2xLVrTF8Gr/E4KZsd2WXp2lIOi52Dadhy4cvQofMWASIuifyfDYunLzchUXdS
         sWaKWkdAKeGVD/ukfU5P3W/1I8KfppPZRaWiV05S48S0/lS1nmgYYxH2Z5uMslePCdzm
         Uncw==
X-Gm-Message-State: AOAM532BaqVuAxUz6m6rtUhNvHKJ9EowWNft085nGMv5TZJvYkEWo7Sy
        jFItwWaY4QTH01MpeoYKiMc=
X-Google-Smtp-Source: ABdhPJwjIpiMj4d42nqTKB/DSAcGUqxCsVhuTFEt/CZUO1OA4or0sPqcC+kA1oroEDadbclZMtTAyg==
X-Received: by 2002:ac8:e8f:: with SMTP id v15mr4174645qti.391.1589461833957;
        Thu, 14 May 2020 06:10:33 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id k3sm2581889qkb.112.2020.05.14.06.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 06:10:33 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EEFB940AFD; Thu, 14 May 2020 10:10:30 -0300 (-03)
Date:   Thu, 14 May 2020 10:10:30 -0300
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH perf/core] perf intel-pt: Fix clang build failure in
 intel_pt_synth_pebs_sample
Message-ID: <20200514131030.GL5583@kernel.org>
References: <20200513234738.GA21211@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513234738.GA21211@embeddedor>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 13, 2020 at 06:47:38PM -0500, Gustavo A. R. Silva escreveu:
> Fix the following build failure generated with command 
> $ make CC=clang HOSTCC=clang -C tools/ perf:
> 
> util/intel-pt.c:1802:24: error: field 'br_stack' with variable sized type 'struct branch_stack' not at the end of a struct or class is a GNU extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
>                         struct branch_stack br_stack;
>                                             ^
> 1 error generated.
> 
> Fix this by reordering the members of struct br.

Yeah, I noticed that as far back as with ubuntu 16.04's clang:

clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)

util/intel-pt.c:1802:24: error: field 'br_stack' with variable sized type 'struct branch_stack' not at the end of a struct or class is a GNU
      extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
                        struct branch_stack br_stack;
                                            ^
1 error generated.


Will fold this with the bug introducing the problem to avoid bisection
problems.

 
> Clang version 11.0.0 was used.
> 
> Fixes: f283f293a60d ("perf tools: Replace zero-length array with flexible-array")
> Reported-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Here to fix what I break. :)
> 
>  tools/perf/util/intel-pt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index f17b1e769ae4..b34179e3926f 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -1799,8 +1799,8 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
>  
>  	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
>  		struct {
> -			struct branch_stack br_stack;
>  			struct branch_entry entries[LBRS_MAX];
> +			struct branch_stack br_stack;
>  		} br;
>  
>  		if (items->mask[INTEL_PT_LBR_0_POS] ||
> -- 
> 2.26.2
> 

-- 

- Arnaldo
