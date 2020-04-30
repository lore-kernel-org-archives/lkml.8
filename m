Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD63EC28CBC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B641F208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dH0ohiN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgD3Nji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgD3Njh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:39:37 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890CDC035495;
        Thu, 30 Apr 2020 06:39:37 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w29so4944330qtv.3;
        Thu, 30 Apr 2020 06:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mPNqJqx2NcbjYEL7qqv7Gf1VHMWSVslJcW6lHPqAdeI=;
        b=dH0ohiN4gDutcl/WAFXTVTpXsh014/4/yN+b+nbUrsr7xACoOInWw5CP3xIt5u9UTa
         BNRd8Yj1Fp0NlBqjnNWXDq/iSYYQlR7+guOyoelTd/44/kEwtY+uZs0wAqzP6xBdxIkI
         VzAjyX00X0Hdssm2Apc0X+efva6fCxXgwNlmeaw6C+AF+Xx3JC9Y2AqFhbZkJgV5UZhu
         SLSWbkP+nyKC0tmUQ5lYw9oN1dREayjf437SvMaFqEhUFLsP7RNQOGbXVMsVVt/253lg
         91vkK0OI+YgUCBHSV5QnlpfNQiQsfIOoA+0MO1UeG9sVfcL+9p5OHNRMZLgF0d6JA1Fb
         D6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mPNqJqx2NcbjYEL7qqv7Gf1VHMWSVslJcW6lHPqAdeI=;
        b=bacFU+q+U/CaFsxVBjO5HvvYx2WtFE8ZQQaLBm66yBqU+sycDwRC+foBXVe1eZLPDR
         vrcuS2nXHq8o7pFlw/UjPA38UH7i6fyigQblcO/Pa20sJlzybTtQCp56kZNFd1qFmVmm
         cV7xOjyYeO8Rih4ED3lPbg29CEAwDOYafO+FGouAlc5H69AhubaRQLUDq/YR9sXESkEW
         rr0LNw/TrR51SyzxCWHG6Txmje4TvtnDbTr44dLcPSKic/FuE3p1jJ126Z6B+g4FbKRX
         0wUQ2hUUNieDrg6+mCHya34UowbnEIwqSE6N7654tXNj8MDcLkiJw8DvAjI/NgRTj4Uh
         ev7g==
X-Gm-Message-State: AGi0Pua48f2fSRA5LVtSdiqGZehgzVohsVV1S2gcBu+dZmCCQedNsNSw
        9aNKTnUr4NGvH4Zp1nRfcX0=
X-Google-Smtp-Source: APiQypKDW94YPaDo8gOlOBQy3l0LxxQoHmNjnrmVcNnn0L0/QwX2Fmeaex2S+Sg51sVR7pv/YdN58g==
X-Received: by 2002:ac8:33d9:: with SMTP id d25mr3744934qtb.346.1588253976717;
        Thu, 30 Apr 2020 06:39:36 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id s28sm17615qks.49.2020.04.30.06.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 06:39:36 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1DF3E409A3; Thu, 30 Apr 2020 10:39:34 -0300 (-03)
Date:   Thu, 30 Apr 2020 10:39:34 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH 3/8] perf bpf: Decouple creating the evlist from adding
 the SB event
Message-ID: <20200430133934.GL30487@kernel.org>
References: <20200429131106.27974-1-acme@kernel.org>
 <20200429131106.27974-4-acme@kernel.org>
 <20200430090423.GD1681583@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430090423.GD1681583@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 30, 2020 at 11:04:23AM +0200, Jiri Olsa escreveu:
> On Wed, Apr 29, 2020 at 10:11:01AM -0300, Arnaldo Carvalho de Melo wrote:
> 
> SNIP
> 
> > -int perf_evlist__add_sb_event(struct evlist **evlist,
> > +int perf_evlist__add_sb_event(struct evlist *evlist,
> >  			      struct perf_event_attr *attr,
> >  			      perf_evsel__sb_cb_t cb,
> >  			      void *data)
> >  {
> >  	struct evsel *evsel;
> > -	bool new_evlist = (*evlist) == NULL;
> > -
> > -	if (*evlist == NULL)
> > -		*evlist = evlist__new();
> > -	if (*evlist == NULL)
> > -		return -1;
> >  
> >  	if (!attr->sample_id_all) {
> >  		pr_warning("enabling sample_id_all for all side band events\n");
> >  		attr->sample_id_all = 1;
> >  	}
> >  
> > -	evsel = perf_evsel__new_idx(attr, (*evlist)->core.nr_entries);
> > +	evsel = perf_evsel__new_idx(attr, evlist->core.nr_entries);
> >  	if (!evsel)
> >  		goto out_err;
> 
> we can return -1 right here

Yeah, I was just trying to keep the patch minimal, I'll remove the
out_err label and the goto to it and call return directly,

Thanks,

- Arnaldo
 
> jirka
> 
> >  
> >  	evsel->side_band.cb = cb;
> >  	evsel->side_band.data = data;
> > -	evlist__add(*evlist, evsel);
> > +	evlist__add(evlist, evsel);
> >  	return 0;
> > -
> >  out_err:
> > -	if (new_evlist) {
> > -		evlist__delete(*evlist);
> > -		*evlist = NULL;
> > -	}
> >  	return -1;
> >  }
> >  
> > diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> > index f5bd5c386df1..0f02408fff3e 100644
> > --- a/tools/perf/util/evlist.h
> > +++ b/tools/perf/util/evlist.h
> > @@ -107,7 +107,7 @@ int __perf_evlist__add_default_attrs(struct evlist *evlist,
> >  
> >  int perf_evlist__add_dummy(struct evlist *evlist);
> >  
> > -int perf_evlist__add_sb_event(struct evlist **evlist,
> > +int perf_evlist__add_sb_event(struct evlist *evlist,
> >  			      struct perf_event_attr *attr,
> >  			      perf_evsel__sb_cb_t cb,
> >  			      void *data);
> > -- 
> > 2.21.1
> > 
> 

-- 

- Arnaldo
