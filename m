Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DC3C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 494AC20781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dT9sTplG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgDWMEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 08:04:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36493 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgDWMEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 08:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587643442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=th6AxKoTCfO0iA5vCPuzT5zetLWmthfeuCbadO7Iw+A=;
        b=dT9sTplGWdnRBdJYh8vAUmSHdEavSsI/bCC5GYI1m86LwolXdVBzYIDoyyX/h7dTiDrCUj
        PHDsvFRwHNTNzFZszlIakTF8npeM55eOQRcPieP+Fqx4nWj0e0iw58j0mKNG01pnMnWrCI
        ivpA+7ewxrUhiaStGqxOTSOzd5EFX7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-3pUoS6cxOMyeRRNAnsibWA-1; Thu, 23 Apr 2020 08:03:59 -0400
X-MC-Unique: 3pUoS6cxOMyeRRNAnsibWA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47D6618C8C0D;
        Thu, 23 Apr 2020 12:03:57 +0000 (UTC)
Received: from krava (ovpn-115-157.ams2.redhat.com [10.36.115.157])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B39D35D710;
        Thu, 23 Apr 2020 12:03:54 +0000 (UTC)
Date:   Thu, 23 Apr 2020 14:03:51 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3] perf record: add dummy event during system wide
 synthesis
Message-ID: <20200423120318.GK1136647@krava>
References: <20200422173615.59436-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422173615.59436-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 10:36:15AM -0700, Ian Rogers wrote:
> During the processing of /proc during event synthesis new processes may
> start. Add a dummy event if /proc is to be processed, to capture mmaps
> for starting processes. This reuses the existing logic for
> initial-delay.
> 
> v3 fixes the attr test of test-record-C0

SNIP

> +config2=0
> +branch_sample_type=0
> +sample_regs_user=0
> +sample_stack_user=0
> diff --git a/tools/perf/tests/attr/test-record-C0 b/tools/perf/tests/attr/test-record-C0
> index 93818054ae20..317730b906dd 100644
> --- a/tools/perf/tests/attr/test-record-C0
> +++ b/tools/perf/tests/attr/test-record-C0
> @@ -9,6 +9,14 @@ cpu=0
>  # no enable on exec for CPU attached
>  enable_on_exec=0
>  
> -# PERF_SAMPLE_IP | PERF_SAMPLE_TID PERF_SAMPLE_TIME | # PERF_SAMPLE_PERIOD
> +# PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
> +# PERF_SAMPLE_ID | PERF_SAMPLE_PERIOD
>  # + PERF_SAMPLE_CPU added by -C 0
> -sample_type=391
> +sample_type=455

aah, so because now there's 2 events now, so PERF_SAMPLE_ID was added

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

