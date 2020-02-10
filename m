Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D77EC35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5251320715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAQIdJsb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgBJThw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 14:37:52 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:46286 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJThw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 14:37:52 -0500
Received: by mail-qv1-f67.google.com with SMTP id y2so3743999qvu.13;
        Mon, 10 Feb 2020 11:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fDDElh08OPy0rkBGhdHvlzeEmpxwVxRR3rEiNMbYJPY=;
        b=NAQIdJsb7wx+G2kBR1lk+dvKdUvAkCmpxREIxWWI2JgNMjmdsr8U2sVyGcuHxj+2WO
         zBlFXtmIPzyEQ5XIwHuv2G2bjf+iAbRE4O7ELmIEEJ7o/9BlrFT92KrtrxHaXit8siHk
         Y1JbX7JoMerZlKO4VsvyOlS+S7Rt5SrNji5Zyf5ZIuEuHb8pcC8qHvSRWb3FBDIjji8J
         ApY73nzQ58fwFa684kPmBHFN0WtfFvvgWZ0S5I1qTl6VFIJ+yl0TNsnyGbdSWX94YEdl
         XVUA7lY6+ZSZC3AlqkFoEc7BxvHl/dLruabG91qR3O6rtAbea6n9UhOvMyfXaZlTl43V
         lvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fDDElh08OPy0rkBGhdHvlzeEmpxwVxRR3rEiNMbYJPY=;
        b=jw4zXZX0xqiChyDl8iKn39jMQGsUx0Z0M7itF6qFYNZgFaugIO9aqDJ+j+a8kTPZ49
         0VMF5eWLUMtoNgl13Frq7NztlrUvhRAlqX9XRQIhYsmMUvXODk/oR/OagtZxS3HNjtBe
         Z5YAfcgaABbJxQe7b7p+zG2QuxI5XFl4xQsFwHXweMJHKWEtKZn5ugBZD3bNTykdniAa
         k22qMshnv5Wd7v8qW/YT2tRW0t6y6uZl4Y3hChyAlQKOQvJioQPu9K/wJaMh5eE0oDzM
         JdMS8GrfpHzeIpC8nRb7s3IM0YI5gbvuzLZI5QCycm3cYo6OgDmF2K7SR3QFObgM7f7L
         Jxbw==
X-Gm-Message-State: APjAAAUf8kVWkTTwkp3F0DSuZ4nFcFIpM8ZhH6NlbqfYhSWolDkqaKvy
        L0H/YX2DfQwucIzMsp5+G8c=
X-Google-Smtp-Source: APXvYqxnRJKWtMCMUsW9XQIvH5Sh1Bzl3cUG4aP2Ukcs+1+rpYEN0BHkRg4wyyhaNqde0/LRaU1QeQ==
X-Received: by 2002:a05:6214:8c3:: with SMTP id da3mr10998779qvb.249.1581363470657;
        Mon, 10 Feb 2020 11:37:50 -0800 (PST)
Received: from quaco.ghostprotocols.net ([177.195.209.0])
        by smtp.gmail.com with ESMTPSA id c8sm628121qkk.37.2020.02.10.11.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 11:37:50 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 93DD140A7D; Mon, 10 Feb 2020 16:37:43 -0300 (-03)
Date:   Mon, 10 Feb 2020 16:37:43 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] tools lib api fs: Move cgroupsfs__mountpoint()
Message-ID: <20200210193743.GE3416@kernel.org>
References: <20200127162222.GG1114818@krava>
 <20200128004940.1590044-1-namhyung@kernel.org>
 <20200128094057.GC1209308@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128094057.GC1209308@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 28, 2020 at 10:40:57AM +0100, Jiri Olsa escreveu:
> On Tue, Jan 28, 2020 at 09:49:40AM +0900, Namhyung Kim wrote:
> > Move it from tools/perf/util/cgroup.c as it can be used by other places.
> > Note that cgroup filesystem is different from others since it's usually
> > mounted separately (in v1) for each subsystem.
> > 
> > I just copied the code with a little modification to pass a name of
> > subsystem and renamed it to follow other APIs.
> > 
> > Suggested-by: Jiri Olsa <jolsa@redhat.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied to perf/core.

- Arnaldo
 
> thanks,
> jirka
> 
> > ---
> > * rename to cgroupfs__mountpoint()
> > 
> >  tools/lib/api/fs/Build    |  1 +
> >  tools/lib/api/fs/cgroup.c | 67 +++++++++++++++++++++++++++++++++++++++
> >  tools/lib/api/fs/fs.h     |  2 ++
> >  tools/perf/util/cgroup.c  | 63 ++----------------------------------
> >  4 files changed, 72 insertions(+), 61 deletions(-)
> >  create mode 100644 tools/lib/api/fs/cgroup.c
> > 
> > diff --git a/tools/lib/api/fs/Build b/tools/lib/api/fs/Build
> > index f4ed9629ae85..0f75b28654de 100644
> > --- a/tools/lib/api/fs/Build
> > +++ b/tools/lib/api/fs/Build
> > @@ -1,2 +1,3 @@
> >  libapi-y += fs.o
> >  libapi-y += tracing_path.o
> > +libapi-y += cgroup.o
> > diff --git a/tools/lib/api/fs/cgroup.c b/tools/lib/api/fs/cgroup.c
> > new file mode 100644
> > index 000000000000..c7e1cdaa36e1
> > --- /dev/null
> > +++ b/tools/lib/api/fs/cgroup.c
> > @@ -0,0 +1,67 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <linux/stringify.h>
> > +#include <sys/types.h>
> > +#include <sys/stat.h>
> > +#include <fcntl.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include "fs.h"
> > +
> > +int cgroupfs__mountpoint(char *buf, size_t maxlen, const char *subsys)
> > +{
> > +	FILE *fp;
> > +	char mountpoint[PATH_MAX + 1], tokens[PATH_MAX + 1], type[PATH_MAX + 1];
> > +	char path_v1[PATH_MAX + 1], path_v2[PATH_MAX + 2], *path;
> > +	char *token, *saved_ptr = NULL;
> > +
> > +	fp = fopen("/proc/mounts", "r");
> > +	if (!fp)
> > +		return -1;
> > +
> > +	/*
> > +	 * in order to handle split hierarchy, we need to scan /proc/mounts
> > +	 * and inspect every cgroupfs mount point to find one that has
> > +	 * perf_event subsystem
> > +	 */
> > +	path_v1[0] = '\0';
> > +	path_v2[0] = '\0';
> > +
> > +	while (fscanf(fp, "%*s %"__stringify(PATH_MAX)"s %"__stringify(PATH_MAX)"s %"
> > +				__stringify(PATH_MAX)"s %*d %*d\n",
> > +				mountpoint, type, tokens) == 3) {
> > +
> > +		if (!path_v1[0] && !strcmp(type, "cgroup")) {
> > +
> > +			token = strtok_r(tokens, ",", &saved_ptr);
> > +
> > +			while (token != NULL) {
> > +				if (subsys && !strcmp(token, subsys)) {
> > +					strcpy(path_v1, mountpoint);
> > +					break;
> > +				}
> > +				token = strtok_r(NULL, ",", &saved_ptr);
> > +			}
> > +		}
> > +
> > +		if (!path_v2[0] && !strcmp(type, "cgroup2"))
> > +			strcpy(path_v2, mountpoint);
> > +
> > +		if (path_v1[0] && path_v2[0])
> > +			break;
> > +	}
> > +	fclose(fp);
> > +
> > +	if (path_v1[0])
> > +		path = path_v1;
> > +	else if (path_v2[0])
> > +		path = path_v2;
> > +	else
> > +		return -1;
> > +
> > +	if (strlen(path) < maxlen) {
> > +		strcpy(buf, path);
> > +		return 0;
> > +	}
> > +	return -1;
> > +}
> > diff --git a/tools/lib/api/fs/fs.h b/tools/lib/api/fs/fs.h
> > index 92d03b8396b1..07591ecbe39f 100644
> > --- a/tools/lib/api/fs/fs.h
> > +++ b/tools/lib/api/fs/fs.h
> > @@ -28,6 +28,8 @@ FS(bpf_fs)
> >  #undef FS
> >  
> >  
> > +int cgroupfs__mountpoint(char *buf, size_t maxlen, const char *subsys);
> > +
> >  int filename__read_int(const char *filename, int *value);
> >  int filename__read_ull(const char *filename, unsigned long long *value);
> >  int filename__read_xll(const char *filename, unsigned long long *value);
> > diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> > index 4881d4af3381..12e466d1ec3b 100644
> > --- a/tools/perf/util/cgroup.c
> > +++ b/tools/perf/util/cgroup.c
> > @@ -3,75 +3,16 @@
> >  #include "evsel.h"
> >  #include "cgroup.h"
> >  #include "evlist.h"
> > -#include <linux/stringify.h>
> >  #include <linux/zalloc.h>
> >  #include <sys/types.h>
> >  #include <sys/stat.h>
> >  #include <fcntl.h>
> >  #include <stdlib.h>
> >  #include <string.h>
> > +#include <api/fs/fs.h>
> >  
> >  int nr_cgroups;
> >  
> > -static int
> > -cgroupfs_find_mountpoint(char *buf, size_t maxlen)
> > -{
> > -	FILE *fp;
> > -	char mountpoint[PATH_MAX + 1], tokens[PATH_MAX + 1], type[PATH_MAX + 1];
> > -	char path_v1[PATH_MAX + 1], path_v2[PATH_MAX + 2], *path;
> > -	char *token, *saved_ptr = NULL;
> > -
> > -	fp = fopen("/proc/mounts", "r");
> > -	if (!fp)
> > -		return -1;
> > -
> > -	/*
> > -	 * in order to handle split hierarchy, we need to scan /proc/mounts
> > -	 * and inspect every cgroupfs mount point to find one that has
> > -	 * perf_event subsystem
> > -	 */
> > -	path_v1[0] = '\0';
> > -	path_v2[0] = '\0';
> > -
> > -	while (fscanf(fp, "%*s %"__stringify(PATH_MAX)"s %"__stringify(PATH_MAX)"s %"
> > -				__stringify(PATH_MAX)"s %*d %*d\n",
> > -				mountpoint, type, tokens) == 3) {
> > -
> > -		if (!path_v1[0] && !strcmp(type, "cgroup")) {
> > -
> > -			token = strtok_r(tokens, ",", &saved_ptr);
> > -
> > -			while (token != NULL) {
> > -				if (!strcmp(token, "perf_event")) {
> > -					strcpy(path_v1, mountpoint);
> > -					break;
> > -				}
> > -				token = strtok_r(NULL, ",", &saved_ptr);
> > -			}
> > -		}
> > -
> > -		if (!path_v2[0] && !strcmp(type, "cgroup2"))
> > -			strcpy(path_v2, mountpoint);
> > -
> > -		if (path_v1[0] && path_v2[0])
> > -			break;
> > -	}
> > -	fclose(fp);
> > -
> > -	if (path_v1[0])
> > -		path = path_v1;
> > -	else if (path_v2[0])
> > -		path = path_v2;
> > -	else
> > -		return -1;
> > -
> > -	if (strlen(path) < maxlen) {
> > -		strcpy(buf, path);
> > -		return 0;
> > -	}
> > -	return -1;
> > -}
> > -
> >  static int open_cgroup(const char *name)
> >  {
> >  	char path[PATH_MAX + 1];
> > @@ -79,7 +20,7 @@ static int open_cgroup(const char *name)
> >  	int fd;
> >  
> >  
> > -	if (cgroupfs_find_mountpoint(mnt, PATH_MAX + 1))
> > +	if (cgroupfs__mountpoint(mnt, PATH_MAX + 1, "perf_event"))
> >  		return -1;
> >  
> >  	scnprintf(path, PATH_MAX, "%s/%s", mnt, name);
> > -- 
> > 2.25.0.341.g760bfbb309-goog
> > 
> 

-- 

- Arnaldo
