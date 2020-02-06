Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653ACC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3598720838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDIxyA9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgBFS6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 13:58:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31171 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726990AbgBFS6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 13:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581015486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1qy1ehuMKKCWm1G1WSfmQro5ZwGTCo11Wuc7b8opMu4=;
        b=LDIxyA9z3XGKk+dVZfjdzHqAn6GVZ50O0yj5FUkjQe9eHNHtJ8A22KrLMWDou20tAJtQW8
        22I6tyT9Wn/FCnXnBL1woPTD0s0qxG0MkRbUHPqtvD/KkNRBCED0nrGP7LlLDpRqgxomdS
        r29UNPH11rSsEoT8xUw74OLSB5pbeEY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-z-VIY5E5Oa6JUmf70H_-SQ-1; Thu, 06 Feb 2020 13:58:02 -0500
X-MC-Unique: z-VIY5E5Oa6JUmf70H_-SQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E7F5184AEAB;
        Thu,  6 Feb 2020 18:58:01 +0000 (UTC)
Received: from krava (ovpn-204-87.brq.redhat.com [10.40.204.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A9725DA7D;
        Thu,  6 Feb 2020 18:57:57 +0000 (UTC)
Date:   Thu, 6 Feb 2020 19:57:54 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Sam Lunt <samueljlunt@gmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        trivial@kernel.org
Subject: Re: [PATCH] perf: Support Python 3.8+ in Makefile
Message-ID: <20200206185754.GB1669706@krava>
References: <20200131181123.tmamivhq4b7uqasr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131181123.tmamivhq4b7uqasr@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 12:11:23PM -0600, Sam Lunt wrote:
> Python 3.8 changed the output of 'python-config --ldflags' to no longer
> include the '-lpythonX.Y' flag (this apparently fixed an issue loading
> modules with a statically linked Python executable).  The libpython
> feature check in linux/build/feature fails if the Python library is not
> included in FEATURE_CHECK_LDFLAGS-libpython variable.
> 
> This adds a check in the Makefile to determine if PYTHON_CONFIG accepts
> the '--embed' flag and passes that flag alongside '--ldflags' if so.
> 
> tools/perf is the only place the libpython feature check is used.
> 
> Signed-off-by: Sam Lunt <samuel.j.lunt@gmail.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/Makefile.config | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index c90f4146e5a2..ccf99351f058 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -228,8 +228,17 @@ strip-libs  = $(filter-out -l%,$(1))
> 
>  PYTHON_CONFIG_SQ := $(call shell-sq,$(PYTHON_CONFIG))
> 
> +# Python 3.8 changed the output of `python-config --ldflags` to not include the
> +# '-lpythonX.Y' flag unless '--embed' is also passed. The feature check for
> +# libpython fails if that flag is not included in LDFLAGS
> +ifeq ($(shell $(PYTHON_CONFIG_SQ) --ldflags --embed 2>&1 1>/dev/null; echo $$?), 0)
> +  PYTHON_CONFIG_LDFLAGS := --ldflags --embed
> +else
> +  PYTHON_CONFIG_LDFLAGS := --ldflags
> +endif
> +
>  ifdef PYTHON_CONFIG
> -  PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ) --ldflags 2>/dev/null)
> +  PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ) $(PYTHON_CONFIG_LDFLAGS) 2>/dev/null)
>    PYTHON_EMBED_LDFLAGS := $(call strip-libs,$(PYTHON_EMBED_LDOPTS))
>    PYTHON_EMBED_LIBADD := $(call grep-libs,$(PYTHON_EMBED_LDOPTS)) -lutil
>    PYTHON_EMBED_CCOPTS := $(shell $(PYTHON_CONFIG_SQ) --includes 2>/dev/null)
> 
> base-commit: d5d359b0ac3ffc319ca93c46a4cfd87093759ad6
> -- 
> 2.25.0
> 

