Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B314C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 343F7206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TAgdeUO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415785AbgDOQZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:25:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29819 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1415766AbgDOQZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586967934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=Xpd90H8d2yeXTr/rhsB+k3mtd2C28vWEIlnqEeKiNkU=;
        b=TAgdeUO/QivRF79aEmNQq8+TDsHX3hP6KxXEEBV9aDCOnAPD7sk2qIKuo84xIJYgTpjDwD
        17gubJITV+461bVwxCEK8BiKV3VqbJnQzi7HrVN7VWsl616CdCAP2f7l8JNm+6ukc11nEl
        LVNrReQxzCEPWam2//zSM9s8hyeDjsE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-eRXajeUcNn-oesQ-Sg9xbA-1; Wed, 15 Apr 2020 12:25:29 -0400
X-MC-Unique: eRXajeUcNn-oesQ-Sg9xbA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78B54107ACC4;
        Wed, 15 Apr 2020 16:25:26 +0000 (UTC)
Received: from krava (ovpn-112-109.ams2.redhat.com [10.36.112.109])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 40ADE99E03;
        Wed, 15 Apr 2020 16:25:23 +0000 (UTC)
Date:   Wed, 15 Apr 2020 18:25:19 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Konstantin Kharlamov <hi-angel@yandex.ru>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, yuzhoujian@didichuxing.com
Subject: Re: [PATCH] perf stat: Honour --timeout for forked workloads
Message-ID: <20200415162519.GB284534@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415153803.GB20324@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 12:38:03PM -0300, Arnaldo Carvalho de Melo wrote:
> Hi guys,
> 
> 	Please take a look and give this your acks, Tested-by, etc.
> 
> Thanks,
> 
> - Arnaldo
> 
> ----
> 
> When --timeout is used and a workload is specified to be started by
> 'perf stat', i.e.
> 
>   $ perf stat --timeout 1000 sleep 1h
> 
> The --timeout wasn't being honoured, i.e. the workload, 'sleep 1h' in
> the above example, should be terminated after 1000ms, but it wasn't,
> 'perf stat' was waiting for it to finish.
> 
> Fix it by sending a SIGTERM when the timeout expires.
> 
> Now it works:
> 
>   # perf stat -e cycles --timeout 1234 sleep 1h
>   sleep: Terminated
> 
>    Performance counter stats for 'sleep 1h':
> 
>            1,066,692      cycles
> 
>          1.234314838 seconds time elapsed
> 
>          0.000750000 seconds user
>          0.000000000 seconds sys
> 
>   #
> 
> Reported-by: Konstantin Kharlamov <hi-angel@yandex.ru>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207243
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked/Tested-by: Jiri Olsa <jolsa@redhat.com>

cc-ing yuzhoujian, author of the --timeout

jirka

> ---
>  tools/perf/builtin-stat.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index ec053dc1e35c..9207b6c45475 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -686,8 +686,11 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  					break;
>  			}
>  		}
> -		if (child_pid != -1)
> +		if (child_pid != -1) {
> +			if (timeout)
> +				kill(child_pid, SIGTERM);
>  			wait4(child_pid, &status, 0, &stat_config.ru_data);
> +		}
>  
>  		if (workload_exec_errno) {
>  			const char *emsg = str_error_r(workload_exec_errno, msg, sizeof(msg));
> -- 
> 2.25.2
> 

