Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EA9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D184320836
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTDqaZPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390857AbgFXMmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:42:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55308 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389197AbgFXMmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593002570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nejhpHIa27+I+N81kD1fZe2FhZEQndvCHobN1z/g+Sk=;
        b=jTDqaZPgtuZo9S7aKvQSljjSuQLUPBTFMTcmYsmlt8cVy2w7jFcF7xN4oNESZMK8ry9aHv
        4Cqa8AYFf11G8hwIlNbITzp/qWKLcb2P90AWhLVeQOZ/5jLz6gh3dJ/Q0ZV50cpsygzbQp
        8Zjzv7aNNed9r3w/f4ctcnkp+u0F4Zg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-la3_z9xpNomDC5SmP5Z2bQ-1; Wed, 24 Jun 2020 08:42:46 -0400
X-MC-Unique: la3_z9xpNomDC5SmP5Z2bQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABD4780400A;
        Wed, 24 Jun 2020 12:42:44 +0000 (UTC)
Received: from krava (unknown [10.40.193.204])
        by smtp.corp.redhat.com (Postfix) with SMTP id 496A951C50;
        Wed, 24 Jun 2020 12:42:42 +0000 (UTC)
Date:   Wed, 24 Jun 2020 14:42:41 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Gaurav Singh <gaurav1086@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Ian Rogers <irogers@google.com>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [perf] intel_pt_recording_options: Remove redundant
 intel_pt_evsel null check
Message-ID: <20200624124241.GA2719003@krava>
References: <20200623234905.18608-1-gaurav1086@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623234905.18608-1-gaurav1086@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 07:48:50PM -0400, Gaurav Singh wrote:
> intel_pt_evsel cannot be NULL here since its already being
> dereferenced above. Remove this redundant check.
> 
> Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
> ---
>  tools/perf/arch/x86/util/intel-pt.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> index 839ef52c1ac2..8cc87fd2dc6f 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -836,19 +836,17 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
>  		}
>  	}
>  

I wonder we sould put check before that above usage of intel_pt_evsel,
because there's no check for that.. but yes, if intel_pt_evsel is NULL
it will fail earlier.. Adrian?

thanks,
jirka

> -	if (intel_pt_evsel) {
> -		/*
> -		 * To obtain the auxtrace buffer file descriptor, the auxtrace
> -		 * event must come first.
> -		 */
> -		perf_evlist__to_front(evlist, intel_pt_evsel);
> -		/*
> -		 * In the case of per-cpu mmaps, we need the CPU on the
> -		 * AUX event.
> -		 */
> -		if (!perf_cpu_map__empty(cpus))
> -			evsel__set_sample_bit(intel_pt_evsel, CPU);
> -	}
> +	/*
> +	 * To obtain the auxtrace buffer file descriptor, the auxtrace
> +	 * event must come first.
> +	 */
> +	perf_evlist__to_front(evlist, intel_pt_evsel);
> +	/*
> +	 * In the case of per-cpu mmaps, we need the CPU on the
> +	 * AUX event.
> +	 */
> +	if (!perf_cpu_map__empty(cpus))
> +		evsel__set_sample_bit(intel_pt_evsel, CPU);
>  
>  	/* Add dummy event to keep tracking */
>  	if (opts->full_auxtrace) {
> -- 
> 2.17.1
> 

