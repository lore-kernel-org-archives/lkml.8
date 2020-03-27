Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9E5C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 13:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25C2206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 13:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjM7MEdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgC0NYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 09:24:13 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:43562 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726275AbgC0NYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 09:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585315451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JSq3c7WLShp81KSs/TbLLBrH5NCFAOk3q6ZjSEUVQL4=;
        b=EjM7MEdYx852YiM/4xNSALzJt/hbz0GHxYXlMPwVVo9kvXRLx2wAP/RAdjlejrph/itOyV
        8BCC9vPTV8KbONAR98xOZq9yIsrRCwDUkiNrw83ubh01FfWSVcKoYMQgwLDC0WMb2tAu1i
        rX/iKkrD5JT8LWaK5O7C8qbAXrpIzxM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-yCHsG3NONTeOpZ9lTzC5Xw-1; Fri, 27 Mar 2020 09:24:10 -0400
X-MC-Unique: yCHsG3NONTeOpZ9lTzC5Xw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C319800D48;
        Fri, 27 Mar 2020 13:24:08 +0000 (UTC)
Received: from krava (unknown [10.40.196.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A3A5E5C1D4;
        Fri, 27 Mar 2020 13:24:02 +0000 (UTC)
Date:   Fri, 27 Mar 2020 14:23:58 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf synthetic-events: save 4kb from 2 stack frames
Message-ID: <20200327132358.GA2114302@krava>
References: <20200327063651.146969-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327063651.146969-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 11:36:51PM -0700, Ian Rogers wrote:
> Reduce the scope of PATH_MAX sized char buffers so that the compiler can
> overlap their usage.
> 
> perf_event__synthesize_mmap_events before 'sub $0x45b8,%rsp' after
> 'sub $0x35b8,%rsp'.
> 
> perf_event__get_comm_ids before 'sub $0x2028,%rsp' after 'sub $0x1028,%rsp'.

nice catch.. is this actualy problem somewhere? I thought
we don't need to care that much about this in user space

jirka

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/synthetic-events.c | 46 ++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 3f28af39f9c6..9ff54707bb30 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -70,7 +70,6 @@ int perf_tool__process_synth_event(struct perf_tool *tool,
>  static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
>  				    pid_t *tgid, pid_t *ppid)
>  {
> -	char filename[PATH_MAX];
>  	char bf[4096];
>  	int fd;
>  	size_t size = 0;
> @@ -80,12 +79,16 @@ static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
>  	*tgid = -1;
>  	*ppid = -1;
>  
> -	snprintf(filename, sizeof(filename), "/proc/%d/status", pid);
> +	{
> +		char filename[PATH_MAX];
>  
> -	fd = open(filename, O_RDONLY);
> -	if (fd < 0) {
> -		pr_debug("couldn't open %s\n", filename);
> -		return -1;
> +		snprintf(filename, sizeof(filename), "/proc/%d/status", pid);
> +
> +		fd = open(filename, O_RDONLY);
> +		if (fd < 0) {
> +			pr_debug("couldn't open %s\n", filename);
> +			return -1;
> +		}
>  	}
>  
>  	n = read(fd, bf, sizeof(bf) - 1);
> @@ -280,7 +283,6 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
>  				       struct machine *machine,
>  				       bool mmap_data)
>  {
> -	char filename[PATH_MAX];
>  	FILE *fp;
>  	unsigned long long t;
>  	bool truncation = false;
> @@ -292,18 +294,22 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
>  	if (machine__is_default_guest(machine))
>  		return 0;
>  
> -	snprintf(filename, sizeof(filename), "%s/proc/%d/task/%d/maps",
> -		 machine->root_dir, pid, pid);
> +#define FILENAME_FMT_STRING "%s/proc/%d/task/%d/maps"
> +	{
> +		char filename[PATH_MAX];
>  
> -	fp = fopen(filename, "r");
> -	if (fp == NULL) {
> -		/*
> -		 * We raced with a task exiting - just return:
> -		 */
> -		pr_debug("couldn't open %s\n", filename);
> -		return -1;
> -	}
> +		snprintf(filename, sizeof(filename), FILENAME_FMT_STRING,
> +			machine->root_dir, pid, pid);
>  
> +		fp = fopen(filename, "r");
> +		if (fp == NULL) {
> +			/*
> +			 * We raced with a task exiting - just return:
> +			 */
> +			pr_debug("couldn't open %s\n", filename);
> +			return -1;
> +		}
> +	}
>  	event->header.type = PERF_RECORD_MMAP2;
>  	t = rdclock();
>  
> @@ -320,10 +326,10 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
>  			break;
>  
>  		if ((rdclock() - t) > timeout) {
> -			pr_warning("Reading %s time out. "
> +			pr_warning("Reading " FILENAME_FMT_STRING " time out. "
>  				   "You may want to increase "
>  				   "the time limit by --proc-map-timeout\n",
> -				   filename);
> +				   machine->root_dir, pid, pid);
>  			truncation = true;
>  			goto out;
>  		}
> @@ -412,6 +418,8 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
>  
>  	fclose(fp);
>  	return rc;
> +
> +#undef FILENAME_FMT_STRING
>  }
>  
>  int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t process,
> -- 
> 2.25.1.696.g5e7596f4ac-goog
> 

