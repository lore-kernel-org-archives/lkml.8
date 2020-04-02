Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FDAC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3F5206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7zM//w4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389319AbgDBPhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:37:54 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:41698 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389203AbgDBPhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:37:53 -0400
Received: by mail-qv1-f67.google.com with SMTP id t4so1858188qvz.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 08:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c1IMGa5odcEs6iH+DRKmZjwfW2HU6v9Nd5/CbJ1j98s=;
        b=e7zM//w48pfQuT16rWDwKq0eEFBNJ7sS0f9yxGfPL42cm1JrY9DaF1Qk37/9HEdffr
         wBMGI02S97ehMRTwJflLYWsIcqHnjrxWkyk3GCq7Q9CAME7qRJgXun5I21uSGMksj5dt
         aYVen4j+kOZvVrxpZjfAk0M76f/ikfmOQN4dCqgBZjh5NeUVOdYm6eB78RAwFAW3Rf4X
         7T0A4FHhT2O3Ib+DBLilS48Z0NOiQGMUjQLCs6yz4WYpdyfoQqOSDBJYBrMr+TXvnus5
         2gFrSAk7mrvDaB6KYCHtNj4pypLNcXhgv+H2bNcAh+p3VjXG7DYaJbkTFwdTQap2GBa0
         o24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c1IMGa5odcEs6iH+DRKmZjwfW2HU6v9Nd5/CbJ1j98s=;
        b=L7p+W+zt7edfwfg4xBKXuTOV1fUrYpdVt+LmRFwBENR1exbGUbEjypu05SsFWcsXxN
         HAMYxyC1/sOJE+MNx13w5KE1ew6zNF3q2UYi9cS/qIsaXMTXVlov8gPF8OFErfyyix6U
         nZ/H7NyMk9+NBI+2Nngaw7iWlKqwsBCdWA4O90xaABFWB8AIFj4yT8PDbBCUMTNI/h5i
         VT4QtGZtdU+g6su+EBTqDhpr2r6fUSdAVmItIWrau8vY8yZCz+ui0iurmcUCAVtoAHzk
         gyiEaZoqqCr1HxMPvglrS/jp4WbHVukLEvFpEr89v/JOFUD0MMcXCQfLZuSWVL83JafD
         A11A==
X-Gm-Message-State: AGi0PuaII809bukS84RYn8eN/GUrGFDdYN7J2CIx3QBIZFukbE7Gby/k
        4yvBS2D/75F2gDdvNMz3NC8=
X-Google-Smtp-Source: APiQypIPbMBeoJQURPRk5shdJW51vC2vE0vl/EpCXskxNihdeoYGYThr15A9Sm1+WToMx4ka28cxUQ==
X-Received: by 2002:a0c:ed4c:: with SMTP id v12mr3977304qvq.120.1585841872390;
        Thu, 02 Apr 2020 08:37:52 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id o16sm3600335qki.110.2020.04.02.08.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 08:37:51 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C0234409A3; Thu,  2 Apr 2020 12:37:48 -0300 (-03)
Date:   Thu, 2 Apr 2020 12:37:48 -0300
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf tools: Add file-handle feature test
Message-ID: <20200402153748.GC8736@kernel.org>
References: <CAM9d7cgtEXGZL+GZeLy1RmoU=jB4BfLApbsV9F=iDx6cqMh_5A@mail.gmail.com>
 <20200402015249.3800462-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402015249.3800462-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 02, 2020 at 10:52:49AM +0900, Namhyung Kim escreveu:
> The file handle (FHANDLE) support is configurable so some systems might
> not have it.  So add a config feature item to check it on build time
> and reject cgroup tracking based on that.

Ok, I'll break this patch in two, add the feature test first, then fold
the usage of HAVE_FILE_HANDLE with the patch that uses it, so that we
keep the codebase bisectable,

Thanks!

- Arnaldo
 
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/build/Makefile.feature           |  3 ++-
>  tools/build/feature/Makefile           |  6 +++++-
>  tools/build/feature/test-file-handle.c | 14 ++++++++++++++
>  tools/perf/Makefile.config             |  4 ++++
>  tools/perf/builtin-record.c            |  8 +++++++-
>  tools/perf/builtin-top.c               |  8 +++++++-
>  tools/perf/util/synthetic-events.c     |  9 +++++++++
>  7 files changed, 48 insertions(+), 4 deletions(-)
>  create mode 100644 tools/build/feature/test-file-handle.c
> 
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 574c2e0b9d20..3e0c019ef297 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -72,7 +72,8 @@ FEATURE_TESTS_BASIC :=                  \
>          setns				\
>          libaio				\
>          libzstd				\
> -        disassembler-four-args
> +        disassembler-four-args		\
> +        file-handle
>  
>  # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
>  # of all feature tests
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 7ac0d8088565..621f528f7822 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -67,7 +67,8 @@ FILES=                                          \
>           test-llvm.bin				\
>           test-llvm-version.bin			\
>           test-libaio.bin			\
> -         test-libzstd.bin
> +         test-libzstd.bin			\
> +         test-file-handle.bin
>  
>  FILES := $(addprefix $(OUTPUT),$(FILES))
>  
> @@ -321,6 +322,9 @@ FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
>  $(OUTPUT)test-libzstd.bin:
>  	$(BUILD) -lzstd
>  
> +$(OUTPUT)test-file-handle.bin:
> +	$(BUILD)
> +
>  ###############################
>  
>  clean:
> diff --git a/tools/build/feature/test-file-handle.c b/tools/build/feature/test-file-handle.c
> new file mode 100644
> index 000000000000..5f8c16f8784f
> --- /dev/null
> +++ b/tools/build/feature/test-file-handle.c
> @@ -0,0 +1,14 @@
> +#define _GNU_SOURCE
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +
> +int main(void)
> +{
> +	struct file_handle fh;
> +	int mount_id;
> +
> +	name_to_handle_at(AT_FDCWD, "/", &fh, &mount_id, 0);
> +	return 0;
> +}
> +
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 80e55e796be9..eb95c0c0a169 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -348,6 +348,10 @@ ifeq ($(feature-gettid), 1)
>    CFLAGS += -DHAVE_GETTID
>  endif
>  
> +ifeq ($(feature-file-handle), 1)
> +  CFLAGS += -DHAVE_FILE_HANDLE
> +endif
> +
>  ifdef NO_LIBELF
>    NO_DWARF := 1
>    NO_DEMANGLE := 1
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 7d7912e121d6..1ab349abe904 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1433,8 +1433,14 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  	if (rec->opts.record_namespaces)
>  		tool->namespace_events = true;
>  
> -	if (rec->opts.record_cgroup)
> +	if (rec->opts.record_cgroup) {
> +#ifdef HAVE_FILE_HANDLE
>  		tool->cgroup_events = true;
> +#else
> +		pr_err("cgroup tracking is not supported\n");
> +		return -1;
> +#endif
> +	}
>  
>  	if (rec->opts.auxtrace_snapshot_mode || rec->switch_output.enabled) {
>  		signal(SIGUSR2, snapshot_sig_handler);
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 56b2dd0db88e..02ea2cf2a3d9 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1246,8 +1246,14 @@ static int __cmd_top(struct perf_top *top)
>  
>  	if (opts->record_namespaces)
>  		top->tool.namespace_events = true;
> -	if (opts->record_cgroup)
> +	if (opts->record_cgroup) {
> +#ifdef HAVE_FILE_HANDLE
>  		top->tool.cgroup_events = true;
> +#else
> +		pr_err("cgroup tracking is not supported.\n");
> +		return -1;
> +#endif
> +	}
>  
>  	ret = perf_event__synthesize_bpf_events(top->session, perf_event__process,
>  						&top->session->machines.host,
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 24975470ed5c..f96e84956d84 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -415,6 +415,7 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
>  	return rc;
>  }
>  
> +#ifdef HAVE_FILE_HANDLE
>  static int perf_event__synthesize_cgroup(struct perf_tool *tool,
>  					 union perf_event *event,
>  					 char *path, size_t mount_len,
> @@ -526,6 +527,14 @@ int perf_event__synthesize_cgroups(struct perf_tool *tool,
>  
>  	return 0;
>  }
> +#else
> +int perf_event__synthesize_cgroups(struct perf_tool *tool,
> +				   perf_event__handler_t process,
> +				   struct machine *machine)
> +{
> +	return -1;
> +}
> +#endif
>  
>  int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t process,
>  				   struct machine *machine)
> -- 
> 2.26.0.rc2.310.g2932bb562d-goog
> 

-- 

- Arnaldo
