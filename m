Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9670CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DFBC20723
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZ8vpC5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732941AbgFWO4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:56:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23282 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732738AbgFWO4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592924161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BfQUOymlgV5QqOOKcP07LKEPi7cgFXRcrD9qQkSmg40=;
        b=PZ8vpC5WkmQrMkKmR29147iLxXnPTZbxcdHAr+ZxRx7uhENXTWc19EBvaloEBfu7vYN6at
        Zc6mTDN7oCbWkwWyWnM6ljDw2zFBP8QrnIGs4M/2ZzkgkzLMjz8kQFIHIAzE02z+VWUPnw
        RIeaFzO96SQeOI6KfMI/c4qGkMpmONE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-6uWunx31MQOANetogtvrFQ-1; Tue, 23 Jun 2020 10:55:57 -0400
X-MC-Unique: 6uWunx31MQOANetogtvrFQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AC02107ACF2;
        Tue, 23 Jun 2020 14:55:56 +0000 (UTC)
Received: from krava (unknown [10.40.192.77])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4D80478F0A;
        Tue, 23 Jun 2020 14:54:59 +0000 (UTC)
Date:   Tue, 23 Jun 2020 16:54:58 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 09/13] perf stat: implement control commands handling
Message-ID: <20200623145458.GG2619137@krava>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
 <5ed69a1e-052a-9790-7642-cb9c9a53d786@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ed69a1e-052a-9790-7642-cb9c9a53d786@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 11:41:30AM +0300, Alexey Budankov wrote:
> 
> Implement handling of 'enable' and 'disable' control commands
> coming from control file descriptor. process_evlist() function
> checks for events on control fds and makes required operations.
> If poll event splits initiated timeout interval then the reminder
> is calculated and still waited in the following poll() syscall.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/builtin-stat.c | 67 +++++++++++++++++++++++++++++----------
>  1 file changed, 50 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index f88d5ee55022..cc56d71a3ed5 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -492,6 +492,31 @@ static bool process_timeout(int timeout, unsigned int interval, int *times)
>  	return print_interval(interval, times);
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
> +			stop = print_interval(interval, times);

why is interval printed in here?

> +			break;
> +		case EVLIST_CTL_CMD_DISABLE:
> +			stop = print_interval(interval, times);

and here?

it should be called from the main loop when the interval time is elapsed no?

jirka

