Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B347EC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 09:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9E820CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 09:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zg2A/YEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgA1JlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 04:41:09 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21674 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725271AbgA1JlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 04:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580204467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HyHj6wEpcggoztr9yX8CSRYIm8IDLyH4N1pq6Mhge5U=;
        b=Zg2A/YEoDirW1pRF+g6Pe3QPFhZsve8HzZZt88ECQ8MwNWRaNph7dGtHmZ9OVb4D81PmCt
        9qmXr8Yg2sKqpE1VmQVIJpGxiY3PXzU38HywkaMTPb+0oF8L606+q1AiJqcKSEb7sNnsiC
        Y5S2DcQYfvdumMlDoZ4fRbzWmqNjblU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-VDJ1zWcaMPWk1WJIPYeESQ-1; Tue, 28 Jan 2020 04:41:03 -0500
X-MC-Unique: VDJ1zWcaMPWk1WJIPYeESQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6914A8017CC;
        Tue, 28 Jan 2020 09:41:00 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 71C94863DE;
        Tue, 28 Jan 2020 09:40:59 +0000 (UTC)
Date:   Tue, 28 Jan 2020 10:40:57 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] tools lib api fs: Move cgroupsfs__mountpoint()
Message-ID: <20200128094057.GC1209308@krava>
References: <20200127162222.GG1114818@krava>
 <20200128004940.1590044-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128004940.1590044-1-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 09:49:40AM +0900, Namhyung Kim wrote:
> Move it from tools/perf/util/cgroup.c as it can be used by other places.
> Note that cgroup filesystem is different from others since it's usually
> mounted separately (in v1) for each subsystem.
> 
> I just copied the code with a little modification to pass a name of
> subsystem and renamed it to follow other APIs.
> 
> Suggested-by: Jiri Olsa <jolsa@redhat.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
> * rename to cgroupfs__mountpoint()
> 
>  tools/lib/api/fs/Build    |  1 +
>  tools/lib/api/fs/cgroup.c | 67 +++++++++++++++++++++++++++++++++++++++
>  tools/lib/api/fs/fs.h     |  2 ++
>  tools/perf/util/cgroup.c  | 63 ++----------------------------------
>  4 files changed, 72 insertions(+), 61 deletions(-)
>  create mode 100644 tools/lib/api/fs/cgroup.c
> 
> diff --git a/tools/lib/api/fs/Build b/tools/lib/api/fs/Build
> index f4ed9629ae85..0f75b28654de 100644
> --- a/tools/lib/api/fs/Build
> +++ b/tools/lib/api/fs/Build
> @@ -1,2 +1,3 @@
>  libapi-y += fs.o
>  libapi-y += tracing_path.o
> +libapi-y += cgroup.o
> diff --git a/tools/lib/api/fs/cgroup.c b/tools/lib/api/fs/cgroup.c
> new file mode 100644
> index 000000000000..c7e1cdaa36e1
> --- /dev/null
> +++ b/tools/lib/api/fs/cgroup.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/stringify.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include "fs.h"
> +
> +int cgroupfs__mountpoint(char *buf, size_t maxlen, const char *subsys)
> +{
> +	FILE *fp;
> +	char mountpoint[PATH_MAX + 1], tokens[PATH_MAX + 1], type[PATH_MAX + 1];
> +	char path_v1[PATH_MAX + 1], path_v2[PATH_MAX + 2], *path;
> +	char *token, *saved_ptr = NULL;
> +
> +	fp = fopen("/proc/mounts", "r");
> +	if (!fp)
> +		return -1;
> +
> +	/*
> +	 * in order to handle split hierarchy, we need to scan /proc/mounts
> +	 * and inspect every cgroupfs mount point to find one that has
> +	 * perf_event subsystem
> +	 */
> +	path_v1[0] = '\0';
> +	path_v2[0] = '\0';
> +
> +	while (fscanf(fp, "%*s %"__stringify(PATH_MAX)"s %"__stringify(PATH_MAX)"s %"
> +				__stringify(PATH_MAX)"s %*d %*d\n",
> +				mountpoint, type, tokens) == 3) {
> +
> +		if (!path_v1[0] && !strcmp(type, "cgroup")) {
> +
> +			token = strtok_r(tokens, ",", &saved_ptr);
> +
> +			while (token != NULL) {
> +				if (subsys && !strcmp(token, subsys)) {
> +					strcpy(path_v1, mountpoint);
> +					break;
> +				}
> +				token = strtok_r(NULL, ",", &saved_ptr);
> +			}
> +		}
> +
> +		if (!path_v2[0] && !strcmp(type, "cgroup2"))
> +			strcpy(path_v2, mountpoint);
> +
> +		if (path_v1[0] && path_v2[0])
> +			break;
> +	}
> +	fclose(fp);
> +
> +	if (path_v1[0])
> +		path = path_v1;
> +	else if (path_v2[0])
> +		path = path_v2;
> +	else
> +		return -1;
> +
> +	if (strlen(path) < maxlen) {
> +		strcpy(buf, path);
> +		return 0;
> +	}
> +	return -1;
> +}
> diff --git a/tools/lib/api/fs/fs.h b/tools/lib/api/fs/fs.h
> index 92d03b8396b1..07591ecbe39f 100644
> --- a/tools/lib/api/fs/fs.h
> +++ b/tools/lib/api/fs/fs.h
> @@ -28,6 +28,8 @@ FS(bpf_fs)
>  #undef FS
>  
>  
> +int cgroupfs__mountpoint(char *buf, size_t maxlen, const char *subsys);
> +
>  int filename__read_int(const char *filename, int *value);
>  int filename__read_ull(const char *filename, unsigned long long *value);
>  int filename__read_xll(const char *filename, unsigned long long *value);
> diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> index 4881d4af3381..12e466d1ec3b 100644
> --- a/tools/perf/util/cgroup.c
> +++ b/tools/perf/util/cgroup.c
> @@ -3,75 +3,16 @@
>  #include "evsel.h"
>  #include "cgroup.h"
>  #include "evlist.h"
> -#include <linux/stringify.h>
>  #include <linux/zalloc.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <fcntl.h>
>  #include <stdlib.h>
>  #include <string.h>
> +#include <api/fs/fs.h>
>  
>  int nr_cgroups;
>  
> -static int
> -cgroupfs_find_mountpoint(char *buf, size_t maxlen)
> -{
> -	FILE *fp;
> -	char mountpoint[PATH_MAX + 1], tokens[PATH_MAX + 1], type[PATH_MAX + 1];
> -	char path_v1[PATH_MAX + 1], path_v2[PATH_MAX + 2], *path;
> -	char *token, *saved_ptr = NULL;
> -
> -	fp = fopen("/proc/mounts", "r");
> -	if (!fp)
> -		return -1;
> -
> -	/*
> -	 * in order to handle split hierarchy, we need to scan /proc/mounts
> -	 * and inspect every cgroupfs mount point to find one that has
> -	 * perf_event subsystem
> -	 */
> -	path_v1[0] = '\0';
> -	path_v2[0] = '\0';
> -
> -	while (fscanf(fp, "%*s %"__stringify(PATH_MAX)"s %"__stringify(PATH_MAX)"s %"
> -				__stringify(PATH_MAX)"s %*d %*d\n",
> -				mountpoint, type, tokens) == 3) {
> -
> -		if (!path_v1[0] && !strcmp(type, "cgroup")) {
> -
> -			token = strtok_r(tokens, ",", &saved_ptr);
> -
> -			while (token != NULL) {
> -				if (!strcmp(token, "perf_event")) {
> -					strcpy(path_v1, mountpoint);
> -					break;
> -				}
> -				token = strtok_r(NULL, ",", &saved_ptr);
> -			}
> -		}
> -
> -		if (!path_v2[0] && !strcmp(type, "cgroup2"))
> -			strcpy(path_v2, mountpoint);
> -
> -		if (path_v1[0] && path_v2[0])
> -			break;
> -	}
> -	fclose(fp);
> -
> -	if (path_v1[0])
> -		path = path_v1;
> -	else if (path_v2[0])
> -		path = path_v2;
> -	else
> -		return -1;
> -
> -	if (strlen(path) < maxlen) {
> -		strcpy(buf, path);
> -		return 0;
> -	}
> -	return -1;
> -}
> -
>  static int open_cgroup(const char *name)
>  {
>  	char path[PATH_MAX + 1];
> @@ -79,7 +20,7 @@ static int open_cgroup(const char *name)
>  	int fd;
>  
>  
> -	if (cgroupfs_find_mountpoint(mnt, PATH_MAX + 1))
> +	if (cgroupfs__mountpoint(mnt, PATH_MAX + 1, "perf_event"))
>  		return -1;
>  
>  	scnprintf(path, PATH_MAX, "%s/%s", mnt, name);
> -- 
> 2.25.0.341.g760bfbb309-goog
> 

