Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF59C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68C8206B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjZF9ZWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgCMTYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:24:31 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44885 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgCMTYb (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:24:31 -0400
Received: by mail-qt1-f196.google.com with SMTP id h16so8535934qtr.11
        for <Linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 12:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wO9aQo6W+Np4rng5AWhTn53mTn5kowZTeKSKlWHOHoU=;
        b=YjZF9ZWg28t3TWkJF9JP49nLDaKDqZVxvTRLj53MMntQUClvuVPVKDteZ+AhbOv96s
         ZODAq1g419Ly07SzeRixMWmrTHGreg30HUtSdNsk5itcYyTlXuCC5fqyyE6Lr/xYp9M1
         SDHcCrG+cTlvHOyQD9MHhv8DDBuifmlg29+OIIcp9kfuWTYYb2xT27LcJyHs+u3hW6Ye
         Uj/qNf5+HgzMXB5ACxlSEARKMzkd5ORHjsWtJk98DLXExIYaI626vuyeS+4iIuyZKUvq
         +b9feYXBw4fYf9Me08wXtubef/8+i9og2B/AfhhrJazL/OWEzJYyIDrvY/SyGnwB1/z5
         yzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wO9aQo6W+Np4rng5AWhTn53mTn5kowZTeKSKlWHOHoU=;
        b=IRv7FhqfpjbTa+wD9a3bg76B6UhUUSlYGGL6bOAwi6TgnMGzvsVuyNoIBn2St9hlxC
         x0sB42ARvyVRw2PhIiqu6HUtIyXXzr9jGM2bzFy4H9qMqvs+SRYGvcHRcco/RNYYcZU6
         Ae91ws33oGUjg1fp92b4PkTQj/UWobIFvCnY/MnwfhITEYmVQr0cOhL/aDDMsEsEPQqQ
         RYptetrBmFgmZ9bXp3M3AqWtwuqhMwcBGTRBCzzvwaiVsVqcxeW7KJOhgLa5aUqdD/mp
         1VbMB5DwlWQYy/dENzrQKi2fQSkaKfO6F33itL1D7eCPTyD9R5CO0HdpIN8bLmb/2M9T
         y/og==
X-Gm-Message-State: ANhLgQ0u8rBjimkBJP3jA6E5lMvlTKEmJMzVqbO3qhLhqiN3w+nERrTx
        wyHD9gmQwObjg4RfPYk2BrrIuzNQ
X-Google-Smtp-Source: ADFU+vuneHjXK7wtXfjf+twAdodzR8Q9xJHeqh7qB9my97li1inyCprR9vXztidmZ/izep6GsGLtSQ==
X-Received: by 2002:ac8:6615:: with SMTP id c21mr8769428qtp.191.1584127469962;
        Fri, 13 Mar 2020 12:24:29 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id l45sm3502522qtb.8.2020.03.13.12.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 12:24:29 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8B2E140009; Fri, 13 Mar 2020 16:24:25 -0300 (-03)
Date:   Fri, 13 Mar 2020 16:24:25 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf report: Fix no branch type statistics report issue
Message-ID: <20200313192425.GD9917@kernel.org>
References: <20200313134607.12873-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313134607.12873-1-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 13, 2020 at 09:46:07PM +0800, Jin Yao escreveu:
> Previously we could get the report of branch type statistics.
> 
> For example,
> 
> perf record -j any,save_type ...
> perf report --stdio
> 
>   #
>   # Branch Statistics:
>   #
>   COND_FWD:  40.6%
>   COND_BWD:   4.1%
>   CROSS_4K:  24.7%
>   CROSS_2M:  12.3%
>       COND:  44.7%
>     UNCOND:   0.0%
>        IND:   6.1%
>       CALL:  24.5%
>        RET:  24.7%
> 
> But now for the recent perf, it can't report the branch type statistics.
> 
> It's a regression issue caused by commit 40c39e304641
> ("perf report: Fix a no annotate browser displayed issue"),
> which only counts the branch type statistics for browser mode.
> 
> This patch moves the branch_type_count() outside of ui__has_annotation()
> checking, then branch type statistics can work for stdio mode.
> 
> Fixes: 40c39e304641 ("perf report: Fix a no annotate browser displayed issue")

Thanks, tested before/after, matches description, applied.

- Arnaldo
 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/builtin-report.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index d7c905f7520f..5f4045df76f4 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -186,24 +186,23 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
>  {
>  	struct hist_entry *he = iter->he;
>  	struct report *rep = arg;
> -	struct branch_info *bi;
> +	struct branch_info *bi = he->branch_info;
>  	struct perf_sample *sample = iter->sample;
>  	struct evsel *evsel = iter->evsel;
>  	int err;
>  
> +	branch_type_count(&rep->brtype_stat, &bi->flags,
> +			  bi->from.addr, bi->to.addr);
> +
>  	if (!ui__has_annotation() && !rep->symbol_ipc)
>  		return 0;
>  
> -	bi = he->branch_info;
>  	err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
>  	if (err)
>  		goto out;
>  
>  	err = addr_map_symbol__inc_samples(&bi->to, sample, evsel);
>  
> -	branch_type_count(&rep->brtype_stat, &bi->flags,
> -			  bi->from.addr, bi->to.addr);
> -
>  out:
>  	return err;
>  }
> -- 
> 2.17.1
> 

-- 

- Arnaldo
