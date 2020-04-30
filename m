Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5875DC8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3333820787
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZvDzBMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgD3JEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 05:04:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42464 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726420AbgD3JEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 05:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588237474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K5VA5nptcg85tchI7teO0oY9ADEbHwiXdXDYuDNBW5A=;
        b=gZvDzBMptJfgQvNI63/AqAEm7KOjKtNvre910/TzX6MsDwXCHJa0ke+5GIrg0ycKomh0Eo
        uRBic7PiAsY7IufVdUT1nVVbW5KNj4VJfhRZFV6fM7z6SMdhy/a+5B9e3FsI9Voc2KwoiZ
        s/YZs4kACfJ2FFymOtcNhemuI39Ii9o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-u5POqqToMiujtPHEqmEwRw-1; Thu, 30 Apr 2020 05:04:30 -0400
X-MC-Unique: u5POqqToMiujtPHEqmEwRw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 364558014D5;
        Thu, 30 Apr 2020 09:04:29 +0000 (UTC)
Received: from krava (unknown [10.40.192.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 979E610013BD;
        Thu, 30 Apr 2020 09:04:26 +0000 (UTC)
Date:   Thu, 30 Apr 2020 11:04:23 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
Message-ID: <20200430090423.GD1681583@krava>
References: <20200429131106.27974-1-acme@kernel.org>
 <20200429131106.27974-4-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429131106.27974-4-acme@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 10:11:01AM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> -int perf_evlist__add_sb_event(struct evlist **evlist,
> +int perf_evlist__add_sb_event(struct evlist *evlist,
>  			      struct perf_event_attr *attr,
>  			      perf_evsel__sb_cb_t cb,
>  			      void *data)
>  {
>  	struct evsel *evsel;
> -	bool new_evlist = (*evlist) == NULL;
> -
> -	if (*evlist == NULL)
> -		*evlist = evlist__new();
> -	if (*evlist == NULL)
> -		return -1;
>  
>  	if (!attr->sample_id_all) {
>  		pr_warning("enabling sample_id_all for all side band events\n");
>  		attr->sample_id_all = 1;
>  	}
>  
> -	evsel = perf_evsel__new_idx(attr, (*evlist)->core.nr_entries);
> +	evsel = perf_evsel__new_idx(attr, evlist->core.nr_entries);
>  	if (!evsel)
>  		goto out_err;

we can return -1 right here

jirka

>  
>  	evsel->side_band.cb = cb;
>  	evsel->side_band.data = data;
> -	evlist__add(*evlist, evsel);
> +	evlist__add(evlist, evsel);
>  	return 0;
> -
>  out_err:
> -	if (new_evlist) {
> -		evlist__delete(*evlist);
> -		*evlist = NULL;
> -	}
>  	return -1;
>  }
>  
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index f5bd5c386df1..0f02408fff3e 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -107,7 +107,7 @@ int __perf_evlist__add_default_attrs(struct evlist *evlist,
>  
>  int perf_evlist__add_dummy(struct evlist *evlist);
>  
> -int perf_evlist__add_sb_event(struct evlist **evlist,
> +int perf_evlist__add_sb_event(struct evlist *evlist,
>  			      struct perf_event_attr *attr,
>  			      perf_evsel__sb_cb_t cb,
>  			      void *data);
> -- 
> 2.21.1
> 

