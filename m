Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01268C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1C5E20857
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTn33Gxy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgDWMKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 08:10:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43817 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726060AbgDWMKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 08:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587643811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=up3g5MZh+s9M/SFVIVKv3W11NlmAp6eB6Bue+zmoh7I=;
        b=iTn33Gxy/+0qvT1rwXl6l3JlL/PRhG6cPJsX+Ys1nNdnwNxFfphBSNiOUtZ7kcWPPVM3rW
        Hj9NeyUt2rbaTO3+6prrEoemOo7+SHWPFJuf4j0nK5iIYXp+EH9ZifgTG8n3WeR9usKisy
        aczYS6f259V0ZiPxbXD0A62+/yjYU9U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-ZSfrvvq7OmqYjVz6jCJsVg-1; Thu, 23 Apr 2020 08:10:06 -0400
X-MC-Unique: ZSfrvvq7OmqYjVz6jCJsVg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F0FB80B70D;
        Thu, 23 Apr 2020 12:10:04 +0000 (UTC)
Received: from krava (ovpn-115-157.ams2.redhat.com [10.36.115.157])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AFC261001920;
        Thu, 23 Apr 2020 12:10:00 +0000 (UTC)
Date:   Thu, 23 Apr 2020 14:09:57 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Tony Jones <tonyj@suse.de>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3] perf/record: add num-synthesize-threads option
Message-ID: <20200423120957.GL1136647@krava>
References: <20200422155038.9380-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422155038.9380-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 08:50:38AM -0700, Ian Rogers wrote:
> From: Stephane Eranian <eranian@google.com>
> 

SNIP

> That is the processing is 1.49% of execution time and there is plenty to
> make parallel. This is shown in the benchmark in this patch:
> https://lore.kernel.org/lkml/20200415054050.31645-2-irogers@google.com/
> Computing performance of multi threaded perf event synthesis by
> synthesizing events on CPU 0:
>  Number of synthesis threads: 1
>    Average synthesis took: 127729.000 usec (+- 3372.880 usec)
>    Average num. events: 21548.600 (+- 0.306)
>    Average time per event 5.927 usec
>  Number of synthesis threads: 2
>    Average synthesis took: 88863.500 usec (+- 385.168 usec)
>    Average num. events: 21552.800 (+- 0.327)
>    Average time per event 4.123 usec
>  Number of synthesis threads: 3
>    Average synthesis took: 83257.400 usec (+- 348.617 usec)
>    Average num. events: 21553.200 (+- 0.327)
>    Average time per event 3.863 usec
>  Number of synthesis threads: 4
>    Average synthesis took: 75093.000 usec (+- 422.978 usec)
>    Average num. events: 21554.200 (+- 0.200)
>    Average time per event 3.484 usec
>  Number of synthesis threads: 5
>    Average synthesis took: 64896.600 usec (+- 353.348 usec)
>    Average num. events: 21558.000 (+- 0.000)
>    Average time per event 3.010 usec
>  Number of synthesis threads: 6
>    Average synthesis took: 59210.200 usec (+- 342.890 usec)
>    Average num. events: 21560.000 (+- 0.000)
>    Average time per event 2.746 usec
>  Number of synthesis threads: 7
>    Average synthesis took: 54093.900 usec (+- 306.247 usec)
>    Average num. events: 21562.000 (+- 0.000)
>    Average time per event 2.509 usec
>  Number of synthesis threads: 8
>    Average synthesis took: 48938.700 usec (+- 341.732 usec)
>    Average num. events: 21564.000 (+- 0.000)
>    Average time per event 2.269 usec
> 
> Where average time per synthesized event goes from 5.927 usec with 1
> thread to 2.269 usec with 8. This isn't a linear speed up as not all of
> synthesize code has been made parallel. If the synthesis time was about
> 10 seconds then using 8 threads may bring this down to less than 4.

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

