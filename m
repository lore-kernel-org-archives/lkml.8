Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F761C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39E1F20770
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNnndJOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbgIJI7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:59:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33999 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728626AbgIJI7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599728375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2a/EJ89FfsuwaDD7HE+E0f+GMRTiKlf5IsOp1OnZBa4=;
        b=YNnndJOIOrHtwDXIs0XPVDBcZH4nx76P/5G4jTUiTiLLGvB3E6G5T73nDBDmrBiqRrjbOR
        THyAMyiyDg8COenXJziDiZn/c0EibpdPpn0xVlsLzMCfChO1FH34/2yPwAZUggP99qER6s
        7QngAxqIms/aQCSADz1BwjswWosWYcA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-SlM1TaA1PcuzPgnmpyZtBw-1; Thu, 10 Sep 2020 04:59:31 -0400
X-MC-Unique: SlM1TaA1PcuzPgnmpyZtBw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 482021882FA8;
        Thu, 10 Sep 2020 08:59:30 +0000 (UTC)
Received: from krava (unknown [10.40.192.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id 71A8483562;
        Thu, 10 Sep 2020 08:59:27 +0000 (UTC)
Date:   Thu, 10 Sep 2020 10:59:26 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 1/4] perf evsel: Add evsel__clone() function
Message-ID: <20200910085926.GC1627030@krava>
References: <20200908044228.61197-1-namhyung@kernel.org>
 <20200908044228.61197-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908044228.61197-2-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 01:42:25PM +0900, Namhyung Kim wrote:
> The evsel__clone() is to create an exactly same evsel from same
> attributes.  Note that metric events will be handled by later patch.
> 
> It will be used by perf stat to generate separate events for each
> cgroup.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/evsel.c | 57 +++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/evsel.h |  1 +
>  2 files changed, 58 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index fd865002cbbd..4f50f9499973 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -331,6 +331,63 @@ struct evsel *evsel__new_cycles(bool precise)
>  	goto out;
>  }
>  
> +/**
> + * evsel__clone - create a new evsel copied from @orig
> + * @orig: original evsel
> + *
> + * The assumption is that @orig is not configured nor opened yet.
> + * So we only care about the attributes that can be set while it's parsed.
> + */
> +struct evsel *evsel__clone(struct evsel *orig)
> +{
> +	struct evsel *evsel;
> +	struct evsel_config_term *pos, *tmp;
> +
> +	BUG_ON(orig->core.fd);
> +
> +	evsel = evsel__new(&orig->core.attr);
> +	if (evsel == NULL)
> +		return NULL;
> +
> +	*evsel = *orig;

this seems wild ;-) I saw that assumption above,
but I wonder we could add some check or zero/init
the rest of the fields fields

jirka

