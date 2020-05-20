Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C925BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CC7D20829
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gi2Xic4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgETMio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 08:38:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48740 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726224AbgETMim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589978321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2MlUtTBM258JSDDScGhdzvcXFtXQzEpZxJXvQGtScek=;
        b=gi2Xic4mAnjdzlQS/I4KPxcE4EXcatPFloV4t/YTzqAFIXrMxdfnsR0wylIA4L3SSrLUQA
        mmP4Y663vx4OYry8TBvcI7uHGKWjrmn5sLcPcpsAE2wApFVRj/r2x586jMINml7bXdZH7c
        t/JAVB4guafdJLC2tM5Fy2RUsChfACk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-UzLicTX9PmODLDdEQI7HYg-1; Wed, 20 May 2020 08:38:37 -0400
X-MC-Unique: UzLicTX9PmODLDdEQI7HYg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EA9C8064D9;
        Wed, 20 May 2020 12:38:36 +0000 (UTC)
Received: from krava (unknown [10.40.193.10])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5454560C84;
        Wed, 20 May 2020 12:38:34 +0000 (UTC)
Date:   Wed, 20 May 2020 14:38:33 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 8/9] perf record: implement control commands handling
Message-ID: <20200520123833.GG157452@krava>
References: <eb38e9e5-754f-d410-1d9b-e26b702d51b7@linux.intel.com>
 <25f98682-5ef2-4257-f302-93b29da707a9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25f98682-5ef2-4257-f302-93b29da707a9@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 11:04:25AM +0300, Alexey Budankov wrote:
> 
> Implement handling of 'enable' and 'disable' control commands
> coming from control file descriptor.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 50dc2fe626e5..72f388623364 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1505,6 +1505,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  	bool disabled = false, draining = false;
>  	int fd;
>  	float ratio = 0;
> +	enum evlist_ctl_cmd cmd = EVLIST_CTL_CMD_UNSUPPORTED;
>  
>  	atexit(record__sig_exit);
>  	signal(SIGCHLD, sig_handler);
> @@ -1802,8 +1803,23 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  			 * Propagate error, only if there's any. Ignore positive
>  			 * number of returned events and interrupt error.
>  			 */
> -			if (err > 0 || (err < 0 && errno == EINTR))
> +			if (err > 0 || (err < 0 && errno == EINTR)) {
>  				err = 0;
> +				if (evlist__ctlfd_process(rec->evlist, &cmd) > 0) {
> +					switch (cmd) {
> +					case EVLIST_CTL_CMD_ENABLE:
> +						pr_info(EVLIST_ENABLED_MSG);
> +						break;
> +					case EVLIST_CTL_CMD_DISABLE:
> +						pr_info(EVLIST_DISABLED_MSG);
> +						break;
> +					case EVLIST_CTL_CMD_ACK:
> +					case EVLIST_CTL_CMD_UNSUPPORTED:
> +					default:
> +						break;
> +					}
> +				}
> +			}

so this will be processed only when:

	if (hits == rec->samples) {

what if there's always somethign in the buffer? will this stall?

>  			waking++;
>  
>  			if (evlist__filter_pollfd(rec->evlist, POLLERR | POLLHUP) == 0)

evlist__filter_pollfd will trigger draining if all the maps are closed,
but there's one more fd in pollfd now, will this prevent draining?

I wonder this would fit better to the sideband thread (util/sideband_evlist.c)
so we don't disturb the main thread with another check

jirka

> -- 
> 2.24.1
> 
> 

