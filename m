Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC71C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 00:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED8B320716
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 00:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LpO2iEgU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbgIDAfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 20:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgIDAe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 20:34:57 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690B0C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 17:34:57 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id np15so4420108pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 17:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CpwvyDrjGYgUDbl+Bp8t9Jov5btZTQ3cIg+XRZ1pAkU=;
        b=LpO2iEgUzvWOSV61/yN4RRvO3RDaR0CNlIx+QlntVO0Uu3B+S4WcOGnlIf3SlHZZYg
         L3usVyAHNv9kbK7mX52xLuTAMPXOQLRznt+EPIpqpMM1Gr1EminXHmc58uKZbIAQEt2R
         m04Ot7GgoNntVCFxZz2YjTbHGrNu+OBcmL5l9fpBcB0T6loU5bgLv0SodPPX5XtuaxUh
         03hYU8mKDHfqPq3u+n1jskJ4/qDGjkhH6MHdszuOANvywXDAVX7eZA/nPQ4SwKTNyGxX
         7k0fTjCYfTN9cgaDubateoZikNC6RWDlbFZzfSJjcfQ4EUjMb+lheYnl3zbK5NdsAm5F
         Sryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CpwvyDrjGYgUDbl+Bp8t9Jov5btZTQ3cIg+XRZ1pAkU=;
        b=BeIcbPkY4uv8TWMVPBIq3aPTFr3sBY0WdWaN4FhHLKf4iuBOLA+PCap5FtrXjvi0z5
         t6TlGVVkVO2R8pc3wYkA6QLzCtLCHLctqoZoK8bgixvrT5x6/+mxxwbbcHhetoyZa8qL
         GGMXfP8ax4MhqbgyF/1Bi9R2EHW+84DUIgM6e3CizyQ0DjrxY/u8S4LRyqBi21mxUbSt
         sTkOVdqfYtJ7DJkGJa/RGttyyCGRCjI7swwrazX+VkAgGN2PvmXKk0mwDyV8wkGG0UoX
         JAXhALpVO2nq+jfk7z5i3tRNB2GUAGwN9+hn+EPUqeXEHps68Uxjk1CQA7Ef/wSiwOjW
         pToQ==
X-Gm-Message-State: AOAM531DIaJOrcYrn9P3xu5x/vfvSCp0/FGmlXnA+hoL9ry31/BtinLA
        RG1P3je+/XW4iws0/WcCSnClUA==
X-Google-Smtp-Source: ABdhPJz2atB+WoP4JG3LS/zRZvJfK82y9Uf+9uB8J4PdN9ZNuik02MmBwC5QDpfF2JAQo6t5TkF9AQ==
X-Received: by 2002:a17:90b:80a:: with SMTP id bk10mr5541435pjb.53.1599179696808;
        Thu, 03 Sep 2020 17:34:56 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id i20sm4408135pfq.204.2020.09.03.17.34.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Sep 2020 17:34:56 -0700 (PDT)
Date:   Fri, 4 Sep 2020 08:34:47 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>, Al Grant <Al.Grant@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/14] perf mem: Introduce weak function
 perf_mem_events__ptr()
Message-ID: <20200904003447.GB5979@leoy-ThinkPad-X240s>
References: <20200901083815.13755-1-leo.yan@linaro.org>
 <20200901083815.13755-3-leo.yan@linaro.org>
 <20200903135054.GD713364@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903135054.GD713364@krava>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Thu, Sep 03, 2020 at 03:50:54PM +0200, Jiri Olsa wrote:
> On Tue, Sep 01, 2020 at 09:38:03AM +0100, Leo Yan wrote:
> 
> SNIP
> 
> > @@ -2941,30 +2942,38 @@ static int perf_c2c__record(int argc, const char **argv)
> >  	rec_argv[i++] = "record";
> >  
> >  	if (!event_set) {
> > -		perf_mem_events[PERF_MEM_EVENTS__LOAD].record  = true;
> > -		perf_mem_events[PERF_MEM_EVENTS__STORE].record = true;
> > +		e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
> > +		e->record = true;
> > +
> > +		e = perf_mem_events__ptr(PERF_MEM_EVENTS__STORE);
> > +		e->record = true;
> >  	}
> >  
> > -	if (perf_mem_events[PERF_MEM_EVENTS__LOAD].record)
> > +	e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
> > +	if (e->record)
> >  		rec_argv[i++] = "-W";
> >  
> >  	rec_argv[i++] = "-d";
> >  	rec_argv[i++] = "--phys-data";
> >  	rec_argv[i++] = "--sample-cpu";
> >  
> > -	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
> > -		if (!perf_mem_events[j].record)
> > +	j = 0;
> > +	while ((e = perf_mem_events__ptr(j)) != NULL) {
> > +		if (!e->record) {
> 
> you could keep the above 'for loop' in here, it seems better
> than taking care of j++

Actually in patch v1 I did this way :)  I followed James' suggestion to
encapsulate PERF_MEM_EVENTS__MAX into perf_mem_events__ptr(), thus
builtin-mem.c and buildin-c2c.c are not necessary to use
PERF_MEM_EVENTS__MAX in the loop and only needs to detect if the
pointer is NULL or not when return from perf_mem_events__ptr().

How about change as below?

        for (j = 0; (e = perf_mem_events__ptr(j)) != NULL; j++) {
                [...]
        }

If you still think this is not good, I will change back to the old
code style in next spin

Thanks for reviewing!

Leo

> > +			j++;
> >  			continue;
> > +		}
> >  
> > -		if (!perf_mem_events[j].supported) {
> > +		if (!e->supported) {
> >  			pr_err("failed: event '%s' not supported\n",
> > -			       perf_mem_events[j].name);
> > +			       perf_mem_events__name(j));
> >  			free(rec_argv);
> >  			return -1;
> >  		}
> >  
> >  		rec_argv[i++] = "-e";
> >  		rec_argv[i++] = perf_mem_events__name(j);
> > +		j++;
> >  	}
> >  
> >  	if (all_user)
> 
> SNIP
> 
> > @@ -100,11 +106,14 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
> >  	if (mem->phys_addr)
> >  		rec_argv[i++] = "--phys-data";
> >  
> > -	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
> > -		if (!perf_mem_events[j].record)
> > +	j = 0;
> > +	while ((e = perf_mem_events__ptr(j)) != NULL) {
> > +		if (!e->record) {
> 
> same here
> 
> thanks,
> jirka
> 
> > +			j++;
> >  			continue;
> > +		}
> >  
> > -		if (!perf_mem_events[j].supported) {
> > +		if (!e->supported) {
> >  			pr_err("failed: event '%s' not supported\n",
> >  			       perf_mem_events__name(j));
> >  			free(rec_argv);
> > @@ -113,6 +122,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
> >  
> >  		rec_argv[i++] = "-e";
> >  		rec_argv[i++] = perf_mem_events__name(j);
> > +		j++;
> 
> SNIP
> 
