Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F403C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE6AF20715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lh9HtRu3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgGFMep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 08:34:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42562 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728414AbgGFMep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 08:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594038884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RiKTz+v2kag7qMrT+uqJwMDzN64G6flzJk2tP0Jck5I=;
        b=Lh9HtRu3DfwI8sSI09rgWfVaBhhMt20bqa4OTIhj7jDaLpEic+WO5t60dw6dBaIwhxxK5N
        N+opkhNbruZt5DwPwhErJd/BGukvimOAh9mjAIitkpDmSIKxHYPT1hrMS3iJl/3lGmWpZg
        608GCKLr3CsVmGtGbNsTSwusI0owTRI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-14HxfGLiOU2OpoThe5L4kg-1; Mon, 06 Jul 2020 08:34:40 -0400
X-MC-Unique: 14HxfGLiOU2OpoThe5L4kg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 275828015F5;
        Mon,  6 Jul 2020 12:34:39 +0000 (UTC)
Received: from krava (unknown [10.40.193.8])
        by smtp.corp.redhat.com (Postfix) with SMTP id 602AD5BAC5;
        Mon,  6 Jul 2020 12:34:37 +0000 (UTC)
Date:   Mon, 6 Jul 2020 14:34:36 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 11/15] perf stat: implement control commands handling
Message-ID: <20200706123436.GD3401866@krava>
References: <a4d5db4a-f25c-38dc-1c41-321a886cb122@linux.intel.com>
 <21669f5a-6220-df0a-09f1-b73b32487f23@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21669f5a-6220-df0a-09f1-b73b32487f23@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 10:47:22AM +0300, Alexey Budankov wrote:
> 
> Implement handling of 'enable' and 'disable' control commands
> coming from control file descriptor. process_evlist() function
> checks for events on control fds and makes required operations.
> If poll event splits initiated timeout interval then the reminder
> is calculated and still waited in the following poll() syscall.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/builtin-stat.c | 75 ++++++++++++++++++++++++++++-----------
>  1 file changed, 55 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 9e4288ecf2b8..5021f7286422 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -485,6 +485,31 @@ static bool handle_interval(unsigned int interval, int *times)
>  	return false;
>  }
>  
> +static bool process_evlist(struct evlist *evlist, unsigned int interval, int *times)
> +{
> +	bool stop = false;
> +	enum evlist_ctl_cmd cmd = EVLIST_CTL_CMD_UNSUPPORTED;
> +
> +	if (evlist__ctlfd_process(evlist, &cmd) > 0) {
> +		switch (cmd) {
> +		case EVLIST_CTL_CMD_ENABLE:
> +			pr_info(EVLIST_ENABLED_MSG);
> +			stop = handle_interval(interval, times);
> +			break;
> +		case EVLIST_CTL_CMD_DISABLE:
> +			stop = handle_interval(interval, times);

I still don't understand why you call handle_interval in here

I don't see it being necessary.. you enable events and handle_interval,
wil be called in the next iteration of dispatch_events, why complicate
this function with that?

thanks,
jirka

