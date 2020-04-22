Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E1DC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B931220787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJcNplef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgDVN7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 09:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgDVN7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 09:59:55 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BEDC03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 06:59:53 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c23so1138023qtp.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 06:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aV+AgA0GvNfbzcgnYq8xI58MHJZQbhIiQHY4PH/6jNY=;
        b=DJcNplefZP5p78wuqJnVS067ltxM/QMqfUi4EnZISYcrbD+GsM5MiWIMWjqRaVX09z
         2wjJvAU0cY4RfMII2gEXMZJowilcx7SbBkxf2NPCm71CTX4NyTSTHZyBcdHn0o4wBALZ
         J3ze3JwpvdFGisWfIbcgZWkAlyNBtBIORtAkKHguZt8rJUYFutu31IZSl5RLuxqkAQyk
         lIHD1CjvxvTJqRBC5q2fFiyBn0gTDKgfRYRTNl5keM8SDbMP4GOWrNyNJ7m9eWLNeU2c
         4wLhGwMXbN2sUxEqFtOInnbA/qRKrjnsaLDD39OuefqW9mXeCsEOl9zWaEOsoRPRn+2r
         YhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aV+AgA0GvNfbzcgnYq8xI58MHJZQbhIiQHY4PH/6jNY=;
        b=jEte/dEcQIhqBVyy5bB4bvUmwqfjohOSsUAdNrroou7/56Ah5qN6QMPb0Q6MVBUCJN
         aiNuF9OudA/mML3rC6r+PHC5M/tNbQivGyXWwnu2IcU2AeM5G+MN9MfZSdjP8gJMTsv/
         nGnLI8y2+sV2QaUcQjNcQ8A4zkKzrpFCajGiRo7hpx9Y6ZxLCpxrTIt/EzeMT2ONmJLw
         zgP7GtowhzxnwlzYniK8uWNsBLdb6IJ0ngikJKcww/0+iIhKQjzzwObPN5jgIhTYAqG3
         HArpuwAOnaNf372yIHDDoW6jNyfe6N8f6ZEgzFDDwrySTjTjsOg98pKdFs13ZnjqON3c
         mq5A==
X-Gm-Message-State: AGi0PuZuzzCHHWmH6WNL5IwlM8PyZ5dd5Qs6S3A9PI4o2BQzL/8zmhxT
        ZuMPXs+Fzw/zTSkTF/onB94=
X-Google-Smtp-Source: APiQypISfKPENIg8sKUMW8H22gPhUCQT/izt3P/QtVyXHiyVK6Gjz3CC1ZBWoOWjj3qP8WzNyRDNQw==
X-Received: by 2002:aed:3e87:: with SMTP id n7mr27028696qtf.301.1587563992984;
        Wed, 22 Apr 2020 06:59:52 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id n124sm3948778qkn.136.2020.04.22.06.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 06:59:52 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 72906409A3; Wed, 22 Apr 2020 10:59:49 -0300 (-03)
Date:   Wed, 22 Apr 2020 10:59:49 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf script: avoid null dereference on symbol
Message-ID: <20200422135949.GD20647@kernel.org>
References: <20200421004329.43109-1-irogers@google.com>
 <20200422082016.GE962614@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422082016.GE962614@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 22, 2020 at 10:20:16AM +0200, Jiri Olsa escreveu:
> On Mon, Apr 20, 2020 at 05:43:29PM -0700, Ian Rogers wrote:
> > al->sym may be null given current if conditions and may cause a segv.
> > 
> > Fixes: cd2bedb7863e9 (perf script: Allow --symbol to accept hexadecimal addresses)
> 
> seems it's wrong commit number, I see it under d2bedb7863e9

Thanks, added your Acked-by, I noticed the wrong commit number, fixed it
up to the same you point above.

- Arnaldo
 
> 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/event.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> > index dc0e11214ae1..f581550a3015 100644
> > --- a/tools/perf/util/event.c
> > +++ b/tools/perf/util/event.c
> > @@ -626,7 +626,7 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
> >  			ret = strlist__has_entry(symbol_conf.sym_list,
> >  						al->sym->name);
> >  		}
> > -		if (!(ret && al->sym)) {
> > +		if (!ret && al->sym) {
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> thanks,
> jirka
> 
> >  			snprintf(al_addr_str, sz, "0x%"PRIx64,
> >  				al->map->unmap_ip(al->map, al->sym->start));
> >  			ret = strlist__has_entry(symbol_conf.sym_list,
> > -- 
> > 2.26.1.301.g55bc3eb7cb9-goog
> > 
> 

-- 

- Arnaldo
