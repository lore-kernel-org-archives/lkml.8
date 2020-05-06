Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251DAC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F19D9208DB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fh8E4r6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbgEFQR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729239AbgEFQR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:17:27 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C609C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 09:17:27 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id k81so2544123qke.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 09:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fGkPYRk8l8ktb7AayxCCEJ990sWSMDNqHa+b2P0mvdY=;
        b=fh8E4r6C0xtUupCSdzDPYomQSkHNWxSIVTwypdohgmzY7+jyAIJQVVbsmbW8pLlNTy
         8tln5F3NsfkSZMKyHlSLAF1moAVFy218cx3FEUpSpX2U8f+mx3S+Ac6hanD88feMdTcE
         Md0nU98NXPnGjpKNPXsM2BoepQr0aIHC6HlxwmL+tzyfW4+ym0ZPBsaEE5asNsx4/2Xk
         WxMfMvWDA3fFBCDpjzlR90g07jCGjb5K/SR30ggcMAUKEz6r2zNdknQqnwNaknfqZPtl
         oHY/R7YQMWbl9Mle9l2mUTC7mZFMPgxd93Bj1DtnS54jnfDhm+77/e4CvCr3kA89YwDQ
         NhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fGkPYRk8l8ktb7AayxCCEJ990sWSMDNqHa+b2P0mvdY=;
        b=DIHxGVDgcrONxnau3Wmb/iyuVIreADh5htxk5UpmaL0k6eRajo1j2T5CCWIlFUf7PQ
         2ZJSnzbgq92zqmvfLG6ninuVB7BKYfzlXun2Reb3FnTM9U88/Fg4pp6Otd827NC/m5dr
         Vtc/fWiONq2rJvODe6HhTzFOEK3h0aLBIpS9VBtk1QeSnFYsKcvzh00Uv2CX/YHkhJqe
         zm0Gd3IJNfcl0j+wGR91q7w11xv2cBT7iSFfLaj0jhBLBfxDEAYdAWoUMlVH+Wkvai4y
         8lPottEoDFFWCSQf3F8sas55S7yqjdC1ZaDK/DyyR6pm/Af47l7eOUDPYWEg7VffFRWN
         6sQA==
X-Gm-Message-State: AGi0PubJU3ThM5JLeaKNNbyGdK5cdPxJCgs2JqsigqqlVtNDa8jX+p86
        TU8RdvrfYlOohTwm3XzrPOs=
X-Google-Smtp-Source: APiQypLBRebhOnYrxSCbcCtAG/3mi4UZY/m8AmOx83yvnX99bF/u97ZquulgYxonkM96m0/tI20Zsw==
X-Received: by 2002:ae9:ebcb:: with SMTP id b194mr9395006qkg.391.1588781846644;
        Wed, 06 May 2020 09:17:26 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id c19sm1734851qtn.94.2020.05.06.09.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 09:17:25 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 23A77409A3; Wed,  6 May 2020 13:17:23 -0300 (-03)
Date:   Wed, 6 May 2020 13:17:23 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     yshuiv7@gmail.com, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf-probe: Accept the instance number of kretprobe event
Message-ID: <20200506161723.GA22183@kernel.org>
References: <158877535215.26469.1113127926699134067.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158877535215.26469.1113127926699134067.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 06, 2020 at 11:29:12PM +0900, Masami Hiramatsu escreveu:
> Since the commit 6a13a0d7b4d1 ("ftrace/kprobe: Show the
> maxactive number on kprobe_events") introduced to show the
> instance number of kretprobe events, the length of the 1st
> format of the kprobe event will not 1, but it can be longer.
> This caused a parser error in perf-probe.

Thanks for the quick fix!

I'll add this right after the Fixes tag:

Reported-by: yshuiv7@gmail.com
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207587

Ok?

yshuiv, can I have your name to add to that Reported-by tag? And if you
test it, please, I can add a Tested-by: tag as well, credits where
credits are due!

Thanks!

- Arnaldo
 
> Skip the length check the 1st format of the kprobe event
> to accept this instance number.
> 
> Without this fix:
> 
>   # perf probe -a vfs_read%return
>   Added new event:
>     probe:vfs_read__return (on vfs_read%return)
> 
>   You can now use it in all perf tools, such as:
> 
>   	perf record -e probe:vfs_read__return -aR sleep 1
> 
>   # perf probe -l
>   Semantic error :Failed to parse event name: r16:probe/vfs_read__return
>     Error: Failed to show event list.
> 
> And with this fixes:
> 
>   # perf probe -a vfs_read%return
>   ...
>   # perf probe -l
>     probe:vfs_read__return (on vfs_read%return)
> 
> 
> Fixes: 6a13a0d7b4d1 ("ftrace/kprobe: Show the maxactive number on kprobe_events")
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: stable@vger.kernel.org
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=207587
> ---
>  tools/perf/util/probe-event.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index eea132f512b0..c6bcf5709564 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -1765,8 +1765,7 @@ int parse_probe_trace_command(const char *cmd, struct probe_trace_event *tev)
>  	fmt1_str = strtok_r(argv0_str, ":", &fmt);
>  	fmt2_str = strtok_r(NULL, "/", &fmt);
>  	fmt3_str = strtok_r(NULL, " \t", &fmt);
> -	if (fmt1_str == NULL || strlen(fmt1_str) != 1 || fmt2_str == NULL
> -	    || fmt3_str == NULL) {
> +	if (fmt1_str == NULL || fmt2_str == NULL || fmt3_str == NULL) {
>  		semantic_error("Failed to parse event name: %s\n", argv[0]);
>  		ret = -EINVAL;
>  		goto out;
> 

-- 

- Arnaldo
