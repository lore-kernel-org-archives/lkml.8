Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DB4C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 11:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCEAF2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 11:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vG5bFN1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgA3LQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 06:16:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45860 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgA3LQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 06:16:58 -0500
Received: by mail-wr1-f66.google.com with SMTP id a6so3489665wrx.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 03:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ehUykenqKwV54i+OuegUUpgup9/eDyMdZ+/yEv9GMMw=;
        b=vG5bFN1/9xHpACXgC0EkEJb/J2QQY5za504PaQWFgrZQF6EkzWtJXNro2bziJD3dfq
         EFQnh4Vj7b0crjOP1Um4kTfgMCUnKTBCbvG84Lk49nkmlo0HHKYo1mHH/yH+VQ+3QxZR
         CsWaPzDG5owIDBR/xYMlM7GUNkBM82E56rtbhqq1U/K4oEvGZke76RYEINPqludVdGZG
         3M3u+CzGtaRV+6a0xC8t7jY5CPDeOWjP6syYJPz9W9w1mrOujIU2UYAdBOCIT4H6yEi3
         2Mp9M3kcriNpafWPD8fuT2BTl3dQ+7azxncr9SM3Fxmo8pUoUEvoo5AbXrJy8hosXlAy
         +p4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ehUykenqKwV54i+OuegUUpgup9/eDyMdZ+/yEv9GMMw=;
        b=SE0wFaOkdORnbHwSOoT0/Jn8ptz50WS0diETE34iWV1j9r+cZh4K6vDWlRFzkzcG3v
         ZLl21O0lW5vx+DeNzXyx5SvspFHDUuarto8kTBtLmlGF8z482Ic09Wyp24WftL4ZT+55
         xObsiIYHjVpQiHZC2XIk5C51AfhGHLUOKps/CdijXJk4aEtnI9bH3W3qJlToc+icdcSx
         2pBC/irJFpgfFpttpSUj+VlTJOm9fDEpBsZdzzYCV2g/c0Rbig8TXBQh5DIIokGk2baH
         ELNGbGqM8Uc0kQmlvMHMXDVj9TpKeHeOZKF8tUV4uZXdrqlQ8dBfLKCSdQKqww0IxDQp
         0rUw==
X-Gm-Message-State: APjAAAUu/Mp22bMnLSILLh2EYPnCQ3B4tZ0ZZ5NkCe3gu7cAbiTXd+pC
        3Uhfbl7U/NWyg4JA4R7ybXM=
X-Google-Smtp-Source: APXvYqwZ7cSB2OwLsICD0z2wkTN5YHywvBCvKQ8DeusS/mnI0it68o6aB2D5TLhSXAr/H5bTRKjWOw==
X-Received: by 2002:adf:dfc8:: with SMTP id q8mr299842wrn.135.1580383015625;
        Thu, 30 Jan 2020 03:16:55 -0800 (PST)
Received: from quaco.ghostprotocols.net (20014C4D19C29300C4AE62814D0D5430.dsl.pool.telekom.hu. [2001:4c4d:19c2:9300:c4ae:6281:4d0d:5430])
        by smtp.gmail.com with ESMTPSA id b16sm5835234wmj.39.2020.01.30.03.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 03:16:54 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DED8540A7D; Thu, 30 Jan 2020 12:16:53 +0100 (CET)
Date:   Thu, 30 Jan 2020 12:16:53 +0100
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     jolsa@redhat.com, namhyung@kernel.org, irogers@google.com,
        songliubraving@fb.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] perf annotate: Remove privsize from
 symbol__annotate() args
Message-ID: <20200130111653.GE3841@kernel.org>
References: <20200124080432.8065-1-ravi.bangoria@linux.ibm.com>
 <20200124080432.8065-2-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124080432.8065-2-ravi.bangoria@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 24, 2020 at 01:34:27PM +0530, Ravi Bangoria escreveu:
> privsize is passed as 0 from all the symbol__annotate() callers.
> Remove it from argument list.

Right, trying to figure out when was it that this became unnecessary to
see if this in fact is hiding some other problem...

It all starts in the following change, re-reading those patches...

- Arnaldo


commit c835e1914c4bcfdd41f43d270cafc6d8119d7782
Author: Jiri Olsa <jolsa@kernel.org>
Date:   Wed Oct 11 17:01:37 2017 +0200

    perf annotate: Add annotation_line__(new|delete) functions
    
    Changing the way the annotation lines are allocated and adding
    annotation_line__(new|delete) functions to deal with this.
    
    Before the allocation schema was as follows:
    
      -----------------------------------------------------------
      struct disasm_line | struct annotation_line | private space
      -----------------------------------------------------------
    
    Where the private space is used in TUI code to store computed
    annotation data for events. The stdio code computes the data
    on the fly.
    
    The goal is to compute and store annotation line's data directly
    in the struct annotation_line itself, so this patch changes the
    line allocation schema as follows:
    
      ------------------------------------------------------------
      privsize space | struct disasm_line | struct annotation_line
      ------------------------------------------------------------
    
    Moving struct annotation_line to the end, because in following
    changes we will move here the non-fixed length event's data.
 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  tools/perf/builtin-top.c     | 2 +-
>  tools/perf/ui/gtk/annotate.c | 2 +-
>  tools/perf/util/annotate.c   | 7 ++++---
>  tools/perf/util/annotate.h   | 2 +-
>  4 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 8affcab75604..3e37747364e0 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -143,7 +143,7 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
>  		return err;
>  	}
>  
> -	err = symbol__annotate(&he->ms, evsel, 0, &top->annotation_opts, NULL);
> +	err = symbol__annotate(&he->ms, evsel, &top->annotation_opts, NULL);
>  	if (err == 0) {
>  		top->sym_filter_entry = he;
>  	} else {
> diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
> index 22cc240f7371..35f9641bf670 100644
> --- a/tools/perf/ui/gtk/annotate.c
> +++ b/tools/perf/ui/gtk/annotate.c
> @@ -174,7 +174,7 @@ static int symbol__gtk_annotate(struct map_symbol *ms, struct evsel *evsel,
>  	if (ms->map->dso->annotate_warned)
>  		return -1;
>  
> -	err = symbol__annotate(ms, evsel, 0, &annotation__default_options, NULL);
> +	err = symbol__annotate(ms, evsel, &annotation__default_options, NULL);
>  	if (err) {
>  		char msg[BUFSIZ];
>  		symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index ca73fb74ad03..ea70bc050bce 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2149,9 +2149,10 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel)
>  	annotation__calc_percent(notes, evsel, symbol__size(sym));
>  }
>  
> -int symbol__annotate(struct map_symbol *ms, struct evsel *evsel, size_t privsize,
> +int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
>  		     struct annotation_options *options, struct arch **parch)
>  {
> +	size_t privsize = 0;
>  	struct symbol *sym = ms->sym;
>  	struct annotation *notes = symbol__annotation(sym);
>  	struct annotate_args args = {
> @@ -2790,7 +2791,7 @@ int symbol__tty_annotate(struct map_symbol *ms, struct evsel *evsel,
>  	struct symbol *sym = ms->sym;
>  	struct rb_root source_line = RB_ROOT;
>  
> -	if (symbol__annotate(ms, evsel, 0, opts, NULL) < 0)
> +	if (symbol__annotate(ms, evsel, opts, NULL) < 0)
>  		return -1;
>  
>  	symbol__calc_percent(sym, evsel);
> @@ -3070,7 +3071,7 @@ int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
>  	if (perf_evsel__is_group_event(evsel))
>  		nr_pcnt = evsel->core.nr_members;
>  
> -	err = symbol__annotate(ms, evsel, 0, options, parch);
> +	err = symbol__annotate(ms, evsel, options, parch);
>  	if (err)
>  		goto out_free_offsets;
>  
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 455403e8fede..dade64781670 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -352,7 +352,7 @@ struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists);
>  void symbol__annotate_zero_histograms(struct symbol *sym);
>  
>  int symbol__annotate(struct map_symbol *ms,
> -		     struct evsel *evsel, size_t privsize,
> +		     struct evsel *evsel,
>  		     struct annotation_options *options,
>  		     struct arch **parch);
>  int symbol__annotate2(struct map_symbol *ms,
> -- 
> 2.24.1
> 

-- 

- Arnaldo
