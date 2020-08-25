Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82E5C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 794D220767
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ApI4LAKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgHYHOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:14:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25970 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729194AbgHYHOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 03:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598339691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7CGiZUpznt8czjyijhEZ2iwwf6+J+XWv1uneauIOwPc=;
        b=ApI4LAKWLLAIHQBBqtvFxBY96om16/EioGOaTkeyyleckh93b6ifUPcyEQPB1PDaAKriFG
        TZKKVlSQQw8aYH2BICToDV0dvKK8YSOV+l/saq52G7ZlkfA7XAsE34CBcrdvH8KIjrdHMx
        6Xwn9mkp/JyXCVgowKy2ZHuq4qHTqqo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-GHaOImuoP9ujey8EeJ-vqg-1; Tue, 25 Aug 2020 03:14:46 -0400
X-MC-Unique: GHaOImuoP9ujey8EeJ-vqg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D4341007467;
        Tue, 25 Aug 2020 07:14:45 +0000 (UTC)
Received: from krava (unknown [10.40.192.4])
        by smtp.corp.redhat.com (Postfix) with SMTP id A96575C1CF;
        Tue, 25 Aug 2020 07:14:43 +0000 (UTC)
Date:   Tue, 25 Aug 2020 09:14:42 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf stat: Fix s390x compile error on F32
 utils/stat-display.c
Message-ID: <20200825071442.GB631468@krava>
References: <20200825063304.77733-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825063304.77733-1-tmricht@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 08:33:04AM +0200, Thomas Richter wrote:

SNIP

> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 57d0706e1330..cbe836649f84 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -117,12 +117,11 @@ static void aggr_printout(struct perf_stat_config *config,
>  				cpu_map__id_to_die(id),
>  				config->csv_output ? 0 : -3,
>  				cpu_map__id_to_cpu(id), config->csv_sep);
> -		} else {
> +		} else if (id > -1)
>  			fprintf(config->output, "CPU%*d%s",
>  				config->csv_output ? 0 : -7,
>  				evsel__cpus(evsel)->map[id],
>  				config->csv_sep);
> -		}

I think we want multiple if lines within  { } but
scripts/checkpatch.pl does not scream about this,
so leaving this to Arnaldo ;-)

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

>  		break;
>  	case AGGR_THREAD:
>  		fprintf(config->output, "%*s-%*d%s",
> -- 
> 2.26.2
> 

