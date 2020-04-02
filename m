Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1A9C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B175520737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fg9Ly1QI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389491AbgDBPqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:46:55 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43647 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389123AbgDBPqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:46:55 -0400
Received: by mail-qt1-f194.google.com with SMTP id a5so3612663qtw.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 08:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZQCJKkBtjjZcXIeQzGPTP36EfGBb2AqAfw+zkAmjaLo=;
        b=Fg9Ly1QIKpR2ejh9uH1NUhBKtRpXOyTBB5AmAZv8l3COzuoYOuGpmn5PTpueoj8ZEY
         WtCwVJP6acRCzbtOfWSp/Lyduf6EwyMPuq0qbM0FuOL7Wn1DY0WFMNUa9EzDeSRoNNhG
         s5pGaOqAcLZMfwa3yhUQqNWK7Lni5P6YVnlRE9aiwqCMcPl/88X3MeKkfX98OevXg4iN
         wUznElMyIliukfv3lSRY7DGR7e3bkQYRvfDdJE8Y3r03iphpZOBRUUTUhgkWDtsTucXu
         KKtfrqLnsmNg/ifsRW1jZf0T3eE0RfFqGXHZHfHDfsbzu6uJaBsHb1mftvVmCT5HwaMQ
         99NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZQCJKkBtjjZcXIeQzGPTP36EfGBb2AqAfw+zkAmjaLo=;
        b=S+BpEuE5JmhaGf1Cr0AJpnsE5c/hC0MwJYCBzJqczdo6edN8MssCRUAR7tvwqrbqJB
         J0krjB8dHCis5JLyyO9HiB5Dk69dFdsOROhzGLU/xkMwBeq/4BYH+Now5v08ArLfCoYO
         BMhrJ/Mn0GD4lEaRvR0rtQma6VoDvmFaDkF0A5BqpPIH1SNcmZZzHInXGiIy5xCx0UJy
         UmW2MGCXPYLkLJ94jP6rQ4ao8u3weZAr0S1DH2YH+oGF936hIF2Zj8ufd9cxW4B/hsRy
         /x02vdEOXVbR68L6395ZV5P9UeHp+4Qpmw1S6yFQzLUxFvD6GlH440kKKzTFEyBILTp8
         udrw==
X-Gm-Message-State: AGi0PuYCWSe0pPCqdLZI/jZvrie2YGtRq6NqC/2rFtOltU/DRcdUzH6l
        d7AAYC8s901B5goTYtbcq0a5PWxitec=
X-Google-Smtp-Source: APiQypLTpSzuYNWFLn/yl5PXmkmcCJJXl5Ym6se2Y/CsIy0otN6jA8+IyBNzvH4iXpCIg/120aQxPA==
X-Received: by 2002:ac8:340d:: with SMTP id u13mr3563281qtb.235.1585842414037;
        Thu, 02 Apr 2020 08:46:54 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id f17sm3625801qkh.63.2020.04.02.08.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 08:46:53 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 645BB409A3; Thu,  2 Apr 2020 12:46:51 -0300 (-03)
Date:   Thu, 2 Apr 2020 12:46:51 -0300
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf tools: Add file-handle feature test
Message-ID: <20200402154651.GD8736@kernel.org>
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
> 
> Thanks!

Also had to do this here and in the other similar places:

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index f96e84956d84..a661b122d9d8 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -528,9 +528,9 @@ int perf_event__synthesize_cgroups(struct perf_tool *tool,
 	return 0;
 }
 #else
-int perf_event__synthesize_cgroups(struct perf_tool *tool,
-				   perf_event__handler_t process,
-				   struct machine *machine)
+int perf_event__synthesize_cgroups(struct perf_tool *tool __maybe_unused,
+				   perf_event__handler_t process __maybe_unused,
+				   struct machine *machine __maybe_unused)
 {
 	return -1;
 }
