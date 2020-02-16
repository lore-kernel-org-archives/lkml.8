Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1745FC76199
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 22:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1192084E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 22:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccxpvO9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgBPWWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 17:22:42 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20881 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726020AbgBPWWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 17:22:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581891761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KCOnj8m9+FhlCYw67prMvZclYCf2vCk/0VLIzDQQhnM=;
        b=ccxpvO9d307K67+7OITLMlfuCa9FmYxvQeYiGzPVdgg+KmKGVS0v/YNpHxPP0ClN5BXLhS
        IehL6AHmr2VZHGTd2wI+5gF6nzY+48sVj7TyVAnBVbr/59ZOiwTnDTv8QRGbqwk95Otdyq
        DjPRXkbCNWENeb7K9BYM6xwA3fUELz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-pn0V47wPNiGBdvpPIqjs2g-1; Sun, 16 Feb 2020 17:22:33 -0500
X-MC-Unique: pn0V47wPNiGBdvpPIqjs2g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2273613E4;
        Sun, 16 Feb 2020 22:22:31 +0000 (UTC)
Received: from krava (ovpn-204-28.brq.redhat.com [10.40.204.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DCEAF19756;
        Sun, 16 Feb 2020 22:22:28 +0000 (UTC)
Date:   Sun, 16 Feb 2020 23:22:26 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     zhe.he@windriver.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        Sam Lunt <samueljlunt@gmail.com>
Subject: Re: [PATCH 1/2] perf: Be compatible with all python versions when
 fetching ldflags
Message-ID: <20200216222148.GA161771@krava>
References: <1581618066-187262-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581618066-187262-1-git-send-email-zhe.he@windriver.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 02:21:05AM +0800, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> Since Python v3.8.0, with the following commit
> 0a8e57248b91 ("bpo-36721: Add --embed option to python-config (GH-13500)"),

we got similar change recently.. might have not been picked up yet

  https://lore.kernel.org/lkml/20200131181123.tmamivhq4b7uqasr@gmail.com/

jirka

> --embed option must be passed to "python3-config --ldflags --embed" or
> "python3-config --libs --embed" to get "-lpython3.8".
> 
> To make it compatible with all Python versons, according to the suggestion
> in the commit log, we try with --embed first and then witout it if fails.
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
>  tools/perf/Makefile.config | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 80e55e7..b2eabcf 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -229,7 +229,7 @@ strip-libs  = $(filter-out -l%,$(1))
>  PYTHON_CONFIG_SQ := $(call shell-sq,$(PYTHON_CONFIG))
>  
>  ifdef PYTHON_CONFIG
> -  PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ) --ldflags 2>/dev/null)
> +  PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ) --ldflags --embed 2>/dev/null || $(PYTHON_CONFIG_SQ) --ldflags 2>/dev/null)
>    PYTHON_EMBED_LDFLAGS := $(call strip-libs,$(PYTHON_EMBED_LDOPTS))
>    PYTHON_EMBED_LIBADD := $(call grep-libs,$(PYTHON_EMBED_LDOPTS)) -lutil
>    PYTHON_EMBED_CCOPTS := $(shell $(PYTHON_CONFIG_SQ) --includes 2>/dev/null)
> -- 
> 2.7.4
> 

