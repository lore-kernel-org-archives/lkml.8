Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BB5C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF9D82082E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+pPcSsk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgD1RVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgD1RVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:21:39 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563A0C03C1AB;
        Tue, 28 Apr 2020 10:21:39 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id h26so17640368qtu.8;
        Tue, 28 Apr 2020 10:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OOISRMzVXkBTccG3AWhDfap2jg6mzOAD3VNHaaEgJEo=;
        b=u+pPcSskukoOuKKCbnzmTz9EuIPlGnB73UzTxPfs3FfPgVXou2gE+IQiOra+1za6KD
         RgZOJu7mQvpMGbdLvCadq0GpHkTOBCAHwiikhoM6Clxgri78ydhtfVEMxnk57T/OtKhI
         3phKYWQU0D8EJ8QQCpeln1Pn7eJCoCbzfPzSqQU22I0CTgGVv8d1q5+8zrpKfkiCC75v
         gmo4C7PfDj/o7+bgYWFC6Yilz3zBhcdKWPeVG+vYNdmUg3YmiObUMkdUjqiWN7twxesw
         sFde9R+uuuVh3VxN7MEiZeyrGxxaCU3E2NtTdATev2JS+gdKK6amm9Nfms45TTlYEBqs
         sQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OOISRMzVXkBTccG3AWhDfap2jg6mzOAD3VNHaaEgJEo=;
        b=hltWxjQxjw0MrdZcvuY8PrHTrWbm+6ulbbFhjX50vrqoMcH2NIUav8XWMd+I2HaFTg
         RuYM6zQ93CJqyYd81bkyFRBqWVSTDtJds3JoGc2WQpGpy4/bIhe9WIz6UzzqBCgwACrP
         +nYS2lsDNtMVwZcCPtgi1ZOUovSJbVsRBlRHLcTnu5rJ85flI2lmb8cFiEk8SE84Ghlj
         kZBbNYMDAz5kIc8KGW6yC9vhVhKeSSYw7NvKufxFG9OBk72Tboa03BVyj4b0v6rUNR4v
         Qk1/P1WypcIqpEmM284GOX04si1ULuR0tOu3GWrRA5TOVWRNL1O2P8qWqDT4lUr6Tblt
         lmZA==
X-Gm-Message-State: AGi0PubAsehpgDvzHgb6DIuBnWwpBCufKcgR6AaTGOnN+o7Fy1cOEcgR
        VodXWkZDIf+zeOWg5MLevoE=
X-Google-Smtp-Source: APiQypK1m8CAEfNPkais9yyOVgVTjwbfJvLb4WZwkgnksdwQSNPSyOAYgisA64wud24uy9rsiGNFEQ==
X-Received: by 2002:ac8:4e81:: with SMTP id 1mr29138170qtp.58.1588094498367;
        Tue, 28 Apr 2020 10:21:38 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id c68sm13562254qke.121.2020.04.28.10.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 10:21:37 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E8151409A3; Tue, 28 Apr 2020 14:21:34 -0300 (-03)
Date:   Tue, 28 Apr 2020 14:21:34 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH 4/7] perf bpf: Decouple creating the evlist from adding
 the SB event
Message-ID: <20200428172134.GA5460@kernel.org>
References: <20200427211935.25789-1-acme@kernel.org>
 <20200427211935.25789-5-acme@kernel.org>
 <20200428094851.GE1476763@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428094851.GE1476763@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 28, 2020 at 11:48:51AM +0200, Jiri Olsa escreveu:
> On Mon, Apr 27, 2020 at 06:19:32PM -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > Renaming bpf_event__add_sb_event() to evlist__add_sb_event() and
> > requiring that the evlist be allocated beforehand.
> 
> hum, this seems to be done in previous patch, maybe you
> need to squash this with the previous one?

Right, doing it now.
 
> jirka
> 
> > 
> > This will allow using the same side band thread and evlist to be used
> > for multiple purposes in addition to react to PERF_RECORD_BPF_EVENT soon
> > after they are generated.
> > 
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Song Liu <songliubraving@fb.com>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/bpf-event.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
> > index 2c7a50509659..68f315c3df5b 100644
> > --- a/tools/perf/util/bpf-event.h
> > +++ b/tools/perf/util/bpf-event.h
> > @@ -45,7 +45,7 @@ static inline int machine__process_bpf(struct machine *machine __maybe_unused,
> >  	return 0;
> >  }
> >  
> > -static inline int evlist__add_bpf_sb_event(struct evlist **evlist __maybe_unused,
> > +static inline int evlist__add_bpf_sb_event(struct evlist *evlist __maybe_unused,
> >  					   struct perf_env *env __maybe_unused)
> >  {
> >  	return 0;
> > -- 
> > 2.21.1
> > 
> 

-- 

- Arnaldo
