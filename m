Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024CDC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98182073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5ab7xC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbgC3NQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:16:46 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:58501 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730084AbgC3NQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 09:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585574205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0YeqbcWY5rs9BOtPIgSgEZxu69zBFMFNuupD/gLL6+8=;
        b=Z5ab7xC3n/kV+/2M2wK7GHuCV0T9+0e7AxgLZSk1iy3fbEe3IKmXRCAj2MZa9/QWGyBwtR
        wAk6SDyefePZrT1PSYsxEIzt7TCrMe6c8xJoAGxKgmGFJr1WXbF1QkGjZWtwoi+4G3A/VD
        JSzOsdm0n5jhE+QtmScaRcm7zkEKHfY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-lkaENwYCOSi15RMwAeldIQ-1; Mon, 30 Mar 2020 09:16:41 -0400
X-MC-Unique: lkaENwYCOSi15RMwAeldIQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 516F81005512;
        Mon, 30 Mar 2020 13:16:40 +0000 (UTC)
Received: from krava (unknown [10.40.192.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD5A4DA0E0;
        Mon, 30 Mar 2020 13:16:37 +0000 (UTC)
Date:   Mon, 30 Mar 2020 15:16:33 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf build-test: Honour JOBS to override detection of
Message-ID: <20200330131633.GD2361248@krava>
References: <20200330130301.GA31702@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330130301.GA31702@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 10:03:01AM -0300, Arnaldo Carvalho de Melo wrote:
> Jiri,
> 
> 	Ack?

yep ;-)

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> ----
> 
> When one does:
> 
>   $ make -C tools/perf build-test
> 
> The makefile in tools/perf/tests/ will, just like the main one, detect
> how many cores are in the system and use it with -j.
> 
> Sometimes we may need to override that, for instance, when using
> icecream or distcc to use multiple machines in the build process, then
> we need to, as with the main makefile, use:
> 
>   $ make JOBS=N -C tools/perf build-test
> 
> Fix the tests makefile to honour that.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/tests/make | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index c850d1664c56..5d0c3a9c47a1 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -28,9 +28,13 @@ endif
>  
>  PARALLEL_OPT=
>  ifeq ($(SET_PARALLEL),1)
> -  cores := $(shell (getconf _NPROCESSORS_ONLN || egrep -c '^processor|^CPU[0-9]' /proc/cpuinfo) 2>/dev/null)
> -  ifeq ($(cores),0)
> -    cores := 1
> +  ifeq ($(JOBS),)
> +    cores := $(shell (getconf _NPROCESSORS_ONLN || egrep -c '^processor|^CPU[0-9]' /proc/cpuinfo) 2>/dev/null)
> +    ifeq ($(cores),0)
> +      cores := 1
> +    endif
> +  else
> +    cores=$(JOBS)
>    endif
>    PARALLEL_OPT="-j$(cores)"
>  endif
> -- 
> 2.25.1
> 

