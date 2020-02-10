Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6124EC35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2869820873
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAeAM/6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbgBJTc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 14:32:59 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:42196 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJTc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 14:32:59 -0500
Received: by mail-qv1-f66.google.com with SMTP id dc14so3741807qvb.9;
        Mon, 10 Feb 2020 11:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t63V+h6OJ78BD7qWX2BHn9RgCJNWfAO9DOQcCKN8N9U=;
        b=gAeAM/6m78QKGhuqnl6/Rw7bZEI9ja/iAOatsy5ec24TtlUZexdvKyTYiCx4YcaNpu
         mDzqB/HVG+hY4ng9Qp6PXUTslyIdu7ZaP7B0q4ALNi0LVjK5PFAQW03R/3irl3IQOwCX
         l2HCVy7VUu3vVqrzH8QGP9OOE0GiIdUXtxUOLWs31CepU1pwsTBoEQQdeprefLuat0LO
         ueUMNIw408C6+FsNdPcKeJeQiqihVcTMQRwln4Y76RfyosRgLLbCEuI7Wf4IwYRcyF9W
         d1oafMgVxC7wTlR7uzC7G0SuGmW6QY8ShRTrpe/wJXcsFg8+mVXhfo5lR05wsR1KxTbC
         sitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t63V+h6OJ78BD7qWX2BHn9RgCJNWfAO9DOQcCKN8N9U=;
        b=OEOoHTEQ/1vUvW1EaFy1vwKN9X3e6KrZXPwA2xB8J1LgYnCloj4nzkQeKpkGzBs0YS
         YeEVlToijRQR+b9w1HbLB4Zm7mr+22wKb4yEd7vlXhDfudr+9fPsr1xscGnfjWCDPcWd
         7Ik8j4iIDCs+noQVwBhIgvSDwysW91ppv4bSF5jGwjzG0/ONG8QLpkgztXd01zuw/dKH
         UWPVqz4T8sPVSrRsOVWFZyvc9r1xCDQzuIt/NSVdlcX0lzQlHlvqH0otK9BgNHjAib7r
         C8MXttAgK/Dpe71ARVjuSwg4e0C325guGpcODuUuRIdpvlFOm5aPwL95CO4bN2NxqF7/
         ZzkA==
X-Gm-Message-State: APjAAAVmYs0N9GxwLmWOXxSlaxUi4QwbcGuF0PCJTCIxhttht4J8miXs
        zfcsbmgtBYZlUnRbHaFDNhQ=
X-Google-Smtp-Source: APXvYqy5tjMY6RWeBToJqvR5SMv3S9p82i6MeWZjUaktimMqrnZFOqd+BRJMMNKDBZV0L5wA3WBApg==
X-Received: by 2002:ad4:46c3:: with SMTP id g3mr10962442qvw.60.1581363177359;
        Mon, 10 Feb 2020 11:32:57 -0800 (PST)
Received: from quaco.ghostprotocols.net ([177.195.209.0])
        by smtp.gmail.com with ESMTPSA id j58sm717031qtk.27.2020.02.10.11.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 11:32:56 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 92D4A40A7D; Mon, 10 Feb 2020 16:32:51 -0300 (-03)
Date:   Mon, 10 Feb 2020 16:32:51 -0300
To:     Song Liu <songliubraving@fb.com>
Cc:     Kim Phillips <kim.phillips@amd.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3 v2] perf symbols: convert symbol__is_idle to use
 strlist
Message-ID: <20200210193251.GD3416@kernel.org>
References: <20200207230613.26709-1-kim.phillips@amd.com>
 <20200210163147.25358-1-kim.phillips@amd.com>
 <4F6B8692-B1FE-4108-A6B3-44EEE5F92C97@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4F6B8692-B1FE-4108-A6B3-44EEE5F92C97@fb.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 10, 2020 at 06:51:53PM +0000, Song Liu escreveu:
> 
> 
> > On Feb 10, 2020, at 8:31 AM, Kim Phillips <kim.phillips@amd.com> wrote:
> > 
> > Use the more optimized strlist implementation to do the idle function
> > lookup.
> > 
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Cong Wang <xiyou.wangcong@gmail.com>
> > Cc: Jin Yao <yao.jin@linux.intel.com>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Kim Phillips <kim.phillips@amd.com>
> > Cc: Song Liu <songliubraving@fb.com>
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Cc: linux-perf-users@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> > ---
> > v2: new this series, based on Jiri's comment:
> > 
> > https://lore.kernel.org/lkml/20200120092844.GC608405@krava/
> > 
> > ...and this time with the Cc list intact.
> > 
> > tools/perf/util/symbol.c | 14 +++++++++-----
> > 1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index f3120c4f47ad..1077013d8ce2 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -654,13 +654,17 @@ static bool symbol__is_idle(const char *name)
> > 		NULL
> > 	};
> > 	int i;
> > +	static struct strlist *idle_symbols_list;
> 
> nit, probably just personal preference:
> 
> Maybe move idle_symbols_list out of the function and add the logic 
> to symbol__init()?
> 
> Other than this:
> 
> Acked-by: Song Liu <songliubraving@fb.com>

I applied it as is, improvements can be made on top of it.

- Arnaldo
 
> > 
> > -	for (i = 0; idle_symbols[i]; i++) {
> > -		if (!strcmp(idle_symbols[i], name))
> > -			return true;
> > -	}
> > +	if (idle_symbols_list)
> > +		return strlist__has_entry(idle_symbols_list, name);
> > 
> > -	return false;
> > +	idle_symbols_list = strlist__new(NULL, NULL);
> > +
> > +	for (i = 0; idle_symbols[i]; i++)
> > +		strlist__add(idle_symbols_list, idle_symbols[i]);
> > +
> > +	return strlist__has_entry(idle_symbols_list, name);
> > }
> > 
> > static int map__process_kallsym_symbol(void *arg, const char *name,
> > -- 
> > 2.25.0
> > 
> 

-- 

- Arnaldo
