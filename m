Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56213C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29CB62086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7RRpcjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgHGTxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:53:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44524 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725893AbgHGTxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596830023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=liABq39nMYs4hDhPVIh/jaV6RMKb2l2jq9MhGsGdH5M=;
        b=f7RRpcjLG+vQsRQZOmsKSYI3ni/FzRCE2m9xu2LYuiA5ujaD3F3OghF4YIhG8355o3ulvO
        X2H1fAqyS8NvCEUrGIGtb4cZwsh+lWVxrLXItkF5MejvygXRad07t7wVLDfG9XBKf82X21
        f1VAChoz1RWTP9pcNEZ4CTW9jGzNSFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-0WtYOL1gOnaLESRxljU9vg-1; Fri, 07 Aug 2020 15:53:39 -0400
X-MC-Unique: 0WtYOL1gOnaLESRxljU9vg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F09082D0;
        Fri,  7 Aug 2020 19:53:37 +0000 (UTC)
Received: from krava (unknown [10.40.193.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 343A95D9D5;
        Fri,  7 Aug 2020 19:53:36 +0000 (UTC)
Date:   Fri, 7 Aug 2020 21:53:35 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add missing tools/lib/perf/ path to perf
 maintainers
Message-ID: <20200807195335.GD561444@krava>
References: <20200807193225.3904108-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807193225.3904108-1-robh@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 01:32:25PM -0600, Rob Herring wrote:
> Commit 3ce311afb558 ("libperf: Move to tools/lib/perf") moved libperf
> out of tools/perf/, but failed to update MAINTAINERS.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 496fd4eafb68..f29ddd97ec20 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13410,6 +13410,7 @@ F:	arch/*/kernel/perf_event*.c
>  F:	include/linux/perf_event.h
>  F:	include/uapi/linux/perf_event.h
>  F:	kernel/events/*
> +F:	tools/lib/perf/
>  F:	tools/perf/
>  
>  PERFORMANCE EVENTS SUBSYSTEM ARM64 PMU EVENTS
> -- 
> 2.25.1
> 

