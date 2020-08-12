Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E984CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B606C207F7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597236448;
	bh=0U3PUvYpkmlSJofcYp0j/kO8yjVtrT2CBCUH8kxsM9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G9Jgphie2KDBcfninRw82Xl1DBYiU2/Jh6e0qCdI2qfqeNfySYSOhrvPiXZm8/AAB
	 kglyQYEVH9+STwJAnuxAOT3VmX1KTihDlqlvlHJcKMpGY6ylywvLlFUsl1RwWYwF46
	 8N+qNdF+gUwQ0vFu6+Zo3ZDZ+CI8UfSUTzx9OyYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgHLMr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:47:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbgHLMr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:47:27 -0400
Received: from quaco.ghostprotocols.net (179.176.8.134.dynamic.adsl.gvt.net.br [179.176.8.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B58B82065C;
        Wed, 12 Aug 2020 12:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597236446;
        bh=0U3PUvYpkmlSJofcYp0j/kO8yjVtrT2CBCUH8kxsM9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2q4CRA4NiEnjqOKd21mBpkRDyx8o2o9ERLQliHRDncguj97c/4XTud/t7FNGdaw+r
         Zepd+W1ePdYxaEQJ2qKBkeb3nFrlUCp5hAQ5Xo7c+ygafXCBwIazxf9leOA9Clh5uZ
         HvwaAB1Mf77CaY+mBX7m8F5IGEME+TjEjKzAB6W4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DD9244097F; Wed, 12 Aug 2020 09:47:24 -0300 (-03)
Date:   Wed, 12 Aug 2020 09:47:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add missing tools/lib/perf/ path to perf
 maintainers
Message-ID: <20200812124724.GL13995@kernel.org>
References: <20200807193225.3904108-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807193225.3904108-1-robh@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 07, 2020 at 01:32:25PM -0600, Rob Herring escreveu:
> Commit 3ce311afb558 ("libperf: Move to tools/lib/perf") moved libperf
> out of tools/perf/, but failed to update MAINTAINERS.

Thanks, applied.

- Arnaldo
 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
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

-- 

- Arnaldo
