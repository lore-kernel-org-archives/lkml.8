Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B50C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BDC020A8B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjyQydHx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgDTIzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:55:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46598 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726197AbgDTIzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587372910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u10dY+i6fBYekNaQ1esFv0ta173yepYyDxciiIeLxE4=;
        b=SjyQydHxsqkVLpWSr/nxQZ0jilH0LFoIqKdaIqQ9yVpIPoOm9K4lbkG1aocyh085yCR4VO
        Wm2gGZM0XfpCK/Sv7eO6KKVi7TJZ5w+AHBGBuXK0Wjf9nTjcuirOljltzb6gfPSkngsxIV
        05p5UspymbCK7Yx1+f7fzhtmibHzfjQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-bbEr7mmQNoWKDdCh7vvmxw-1; Mon, 20 Apr 2020 04:55:08 -0400
X-MC-Unique: bbEr7mmQNoWKDdCh7vvmxw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 933C1149C3;
        Mon, 20 Apr 2020 08:55:06 +0000 (UTC)
Received: from krava (unknown [10.40.192.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D5D75D9CD;
        Mon, 20 Apr 2020 08:54:50 +0000 (UTC)
Date:   Mon, 20 Apr 2020 10:54:48 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Tommi Rantala <tommi.t.rantala@nokia.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] perf tools: Move zstd_fini() to session deletion
Message-ID: <20200420084931.GD718574@krava>
References: <20200417132330.119407-1-tommi.t.rantala@nokia.com>
 <20200417132330.119407-2-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417132330.119407-2-tommi.t.rantala@nokia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 04:23:27PM +0300, Tommi Rantala wrote:
> Move zstd_fini() call to perf_session__delete(), so that we always
> cleanup the zstd state when deleting the session.

it shold be orthogonal with zstd_init calls, which
are not currently called within perf_session 

I guess  zstd_initcould moved to perf_session__new,
just need some nice way to pass rec->opts.comp_level

jirka

> 
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
> ---
>  tools/perf/builtin-inject.c | 1 -
>  tools/perf/builtin-record.c | 1 -
>  tools/perf/builtin-report.c | 1 -
>  tools/perf/util/session.c   | 1 +
>  4 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 7e124a7b8bfd..1ffb8393357a 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -836,7 +836,6 @@ int cmd_inject(int argc, const char **argv)
>  	ret = __cmd_inject(&inject);
>  
>  out_delete:
> -	zstd_fini(&(inject.session->zstd_data));
>  	perf_session__delete(inject.session);
>  	return ret;
>  }
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 1ab349abe904..8ed00de1ca29 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1827,7 +1827,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  	}
>  
>  out_delete_session:
> -	zstd_fini(&session->zstd_data);
>  	perf_session__delete(session);
>  
>  	if (!opts->no_bpf_event)
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 26d8fc27e427..e06e14980264 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1579,7 +1579,6 @@ int cmd_report(int argc, const char **argv)
>  		report.block_reports = NULL;
>  	}
>  
> -	zstd_fini(&(session->zstd_data));
>  	perf_session__delete(session);
>  	return ret;
>  }
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 0b0bfe5bef17..64e8b794b0bc 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -302,6 +302,7 @@ void perf_session__delete(struct perf_session *session)
>  	machines__exit(&session->machines);
>  	if (session->data)
>  		perf_data__close(session->data);
> +	zstd_fini(&session->zstd_data);
>  	free(session);
>  }
>  
> -- 
> 2.25.2
> 

