Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FF0C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15F4206ED
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvaG+hZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgBJPSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:18:03 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:37301 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729013AbgBJPSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:18:03 -0500
Received: by mail-qv1-f65.google.com with SMTP id m5so3329731qvv.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 07:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YkL/Zzz8Sbpu+hkQemcYp8z7AGEbyLCvoI4HhW6a6Wg=;
        b=pvaG+hZU1evkJOGYKLiWWQHtdzcdA0kcoI5SmQ8lUfrTz2C/Q4JoXL81ZvKzCeu0Jc
         xm77gW/GbhX+ZpMg15zmvs8EcijKDd/StHpt1hNztOE8I1M7cGVMh0EfIqYgc3KOlbP6
         Ftek0DtVtPXvXUyucC9BEvl/41nPtH39c4uosnGW8t5Ye/PsOmKYeKEhed70I92RpC6L
         tnRi/3CspHnuVG4I/9DgOsi6WSVrFW0QvMd4mix19M4iSletEysKUxR7ZAdCZDVF1+rQ
         +tZ2GQ/mEOb+dpUqfu/eIUkCicZkf6DdeRZ7P+VAAu5J6upnkkWmyNQ+pTKsejSZGln2
         9cwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YkL/Zzz8Sbpu+hkQemcYp8z7AGEbyLCvoI4HhW6a6Wg=;
        b=p53Ntc2dmheaftFMuXjyTeAMGFaIfUTsLFZnV+Aj+Pscml+hXNejRBzonw1Oeyo+EP
         O/8gzK5+wtb7XGQPLYWh5Pk04iDQNGirOxvuGlaS5jpWh6Iwkzmamp5nxABg0E6CcyZv
         dhY84Jo9JOZ+047jfhc/48rP3cg2LRtuzFMZoS7cDelmBcEOQQYtY5RFvS++6355BRKu
         TWDbyj3SA5wsQqmrpmKVxJQ0TmkW0W+DyhHp0s4wv1umcq5d08DekEeCf5barCcca+wB
         1dtB9R6qniSLNRk1gmd7cADy2Pc5VpqCqVNcw0//bxsrHoEWhqsuZhIQwOmNP4wfRFLm
         bAzg==
X-Gm-Message-State: APjAAAUbT1XUG7quCgRM7fHovaRCO+xdx3sX7KZIi73NJ60YSk5eQ8f8
        RWvLVCV5wnFfBugdFr8FcRMh8piaieQ=
X-Google-Smtp-Source: APXvYqzNiS02YhuiU+ldkAIVGg7JzkBmOLuFxM0y5ex2rp0SBw9cvWON3CrvmbNAE9iJv5hDMOZRfQ==
X-Received: by 2002:ad4:518d:: with SMTP id b13mr10210271qvp.141.1581347882283;
        Mon, 10 Feb 2020 07:18:02 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id y26sm315215qtc.94.2020.02.10.07.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 07:18:01 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C822A40A7D; Mon, 10 Feb 2020 12:17:59 -0300 (-03)
Date:   Mon, 10 Feb 2020 12:17:59 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 2/4] perf tools: Mark ksymbol dsos with kernel type
Message-ID: <20200210151759.GB25639@kernel.org>
References: <20200210143218.24948-1-jolsa@kernel.org>
 <20200210143218.24948-3-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210143218.24948-3-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 10, 2020 at 03:32:16PM +0100, Jiri Olsa escreveu:
> We add ksymbol map into machine->kmaps, so it needs to be
> created as 'struct kmap', which is dependent on its dso
> having kernel type.
> 
> Reported-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/machine.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index e3e5490f6de5..0a43dc83d7b2 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -727,8 +727,14 @@ static int machine__process_ksymbol_register(struct machine *machine,
>  	struct map *map = maps__find(&machine->kmaps, event->ksymbol.addr);
>  
>  	if (!map) {
> -		map = dso__new_map(event->ksymbol.name);
> -		if (!map)
> +		struct dso *dso = dso__new(event->ksymbol.name);
> +
> +		if (dso) {
> +			dso->kernel = DSO_TYPE_KERNEL;
> +			map = map__new2(0, dso);
> +		}
> +
> +		if (!dso || !map)

We leak dso if map creation fails?


- Arnaldo

>  			return -ENOMEM;
>  
>  		map->start = event->ksymbol.addr;
> -- 
> 2.24.1
> 

-- 

- Arnaldo
