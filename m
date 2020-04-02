Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9ECC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05312064A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVarEG+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389795AbgDBShT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 14:37:19 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:36481 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388218AbgDBShT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 14:37:19 -0400
Received: by mail-qv1-f66.google.com with SMTP id z13so2262426qvw.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 11:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lmMCnIaWLMxPeNPdwy16aNNyDu6aJ69/b+gnwYoZieg=;
        b=BVarEG+RmPgBZkz3a9UHK6XvUgxLdCFACXHR56aRHxCZW9gRJ5TIRrg4PH6FkpeFGJ
         UjBF0opobDxERsNB0h7zZIGJP7VN/Lx9aewkXmSegY87IT1TlMBtguqWjqh5tm+NqIw+
         gwmXQD9n2lRycQsHPOcVy9idXaTaumJaukGLVKhK+9heEXrDqVjC61H4s1x6Q6PCCw4w
         9k1s/vWG5QmGC2M8KJyR0qopRBjuGOZcSjmfBjdq+9rNvtuFEH2ISPXIBHCS6xL3Oeou
         MCP3Y/2kBtY7x3ij8z2WNnxQ86LdLDRQGjuZA/TPwiMm7sKTKIbJrhL16iNxqF/LuHbl
         gkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lmMCnIaWLMxPeNPdwy16aNNyDu6aJ69/b+gnwYoZieg=;
        b=qJXWZxZ6VLvMWAgarAkUxs+OqMq73mJeN9AnPt3Y7YLEVbXir0pycO/TI+oS103Mg7
         3DAHWUKfQxLTv8HTX90loUNMuPjPweEsXlNqwJhiAq7GXQONyY2uygFuXuhdeRVCkNx1
         ifsi2Ahgh2nH1keN31j38CgcYirdHy1k0oym5kQbjvo8hzaZ6mJO6uu5bAr7U6AVmHNZ
         N1zt1JVxGR5HrcgL2dZB5cQmatCZO6/FfG739kSG99lbe1VwX9bVPT9IHvV56J5CfY+9
         ZiElb3JH9WpcNOcDC2mjiayFxubKBCZlN6EV3LbIxuD5XYLQdsGJhHTJoyEZNkEt0uLF
         0dIA==
X-Gm-Message-State: AGi0PuYnqyFw6tnB3yLFZnuUhN5cAU1F1J1lBf1KSTheV25qxK+OYX2R
        VOF+dzosjm2sLtuEmL28J6A=
X-Google-Smtp-Source: APiQypLeQWFGkC9i4V0W0AJZCpG4PndJIEUG/inUR78lCnnfJv/qAisPBogKlae5rDb1M/0rZAPQnA==
X-Received: by 2002:a05:6214:b0a:: with SMTP id u10mr4744990qvj.45.1585852638236;
        Thu, 02 Apr 2020 11:37:18 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id t53sm4244081qth.70.2020.04.02.11.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 11:37:17 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6880A409A3; Thu,  2 Apr 2020 15:37:15 -0300 (-03)
Date:   Thu, 2 Apr 2020 15:37:15 -0300
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf tools: Add file-handle feature test
Message-ID: <20200402183715.GF8736@kernel.org>
References: <CAM9d7cgtEXGZL+GZeLy1RmoU=jB4BfLApbsV9F=iDx6cqMh_5A@mail.gmail.com>
 <20200402015249.3800462-1-namhyung@kernel.org>
 <20200402153748.GC8736@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402153748.GC8736@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 02, 2020 at 12:37:48PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Apr 02, 2020 at 10:52:49AM +0900, Namhyung Kim escreveu:
> > The file handle (FHANDLE) support is configurable so some systems might
> > not have it.  So add a config feature item to check it on build time
> > and reject cgroup tracking based on that.
> 
> Ok, I'll break this patch in two, add the feature test first, then fold
> the usage of HAVE_FILE_HANDLE with the patch that uses it, so that we
> keep the codebase bisectable,

> > +++ b/tools/build/feature/test-file-handle.c
> > @@ -0,0 +1,14 @@
> > +#define _GNU_SOURCE
> > +#include <sys/types.h>
> > +#include <sys/stat.h>
> > +#include <fcntl.h>
> > +
> > +int main(void)
> > +{
> > +	struct file_handle fh;
> > +	int mount_id;
> > +
> > +	name_to_handle_at(AT_FDCWD, "/", &fh, &mount_id, 0);
> > +	return 0;

Also had to do it just like you use in your patches, see patch below, to
cover this case as well:

  CC       /tmp/build/perf/util/synthetic-events.o
  CC       /tmp/build/perf/util/data.o
  CC       /tmp/build/perf/util/tsc.o
  CC       /tmp/build/perf/util/cloexec.o
util/synthetic-events.c:428:22: error: field 'fh' with   CC       /tmp/build/perf/util/call-path.o
variable sized type 'struct file_handle' not at the end of a struct or class is a GNU
      extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
                struct file_handle fh;
                                   ^
1 error generated.
mv: can't rename '/tmp/build/perf/util/.synthetic-events.o.tmp': No such file or directory
make[4]: *** [/git/linux/tools/build/Makefile.build:97: /tmp/build/perf/util/synthetic-events.o] Error 1
make[4]: *** Waiting for unfinished jobs....


This is on Alpine Linux 3.11 onwards, musl libc.

- Arnaldo


diff --git a/tools/build/feature/test-file-handle.c b/tools/build/feature/test-file-handle.c
index e325b2a060ed..bed871e3978d 100644
--- a/tools/build/feature/test-file-handle.c
+++ b/tools/build/feature/test-file-handle.c
@@ -5,9 +5,12 @@
 
 int main(void)
 {
-	struct file_handle fh;
+        struct {
+                struct file_handle fh;
+                uint64_t cgroup_id;
+        } handle;
 	int mount_id;
 
-	name_to_handle_at(AT_FDCWD, "/", &fh, &mount_id, 0);
+	name_to_handle_at(AT_FDCWD, "/", &handle.fh, &mount_id, 0);
 	return 0;
 }
