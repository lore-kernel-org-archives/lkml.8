Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A631C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D1DF206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AmHtlZqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbgEEOZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:25:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23315 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729310AbgEEOZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588688732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R/RnmMbtijw8ZbUyd1j10r/h3bObkmAw7Kj+dcw1zco=;
        b=AmHtlZqiYCQ7jWz9C72LtsW7jKg9HIEungZ5bU30ExsoRDvoo/RlNH6PUI0J+ks4As1D3+
        JN6MikOQi4w0Ye6cHPOCOR+q32JgjXLPE683ng9FnHpPva07N0cvgrFQ0kr9vosIh7qw2k
        cBGqoh8ehseunDvEXT9BMrv0wq/nCz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-AVBGfe0KO4GE2JRzzYMbXw-1; Tue, 05 May 2020 10:25:28 -0400
X-MC-Unique: AVBGfe0KO4GE2JRzzYMbXw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94920100CCC5;
        Tue,  5 May 2020 14:25:26 +0000 (UTC)
Received: from krava (unknown [10.40.192.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 50D475C1B2;
        Tue,  5 May 2020 14:25:24 +0000 (UTC)
Date:   Tue, 5 May 2020 16:25:21 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 2/3] lib kallsyms: parse using io api
Message-ID: <20200505142521.GD2041406@krava>
References: <20200501221315.54715-1-irogers@google.com>
 <20200501221315.54715-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501221315.54715-3-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 03:13:14PM -0700, Ian Rogers wrote:

SNIP

> diff --git a/tools/lib/symbol/kallsyms.c b/tools/lib/symbol/kallsyms.c
> index 1a7a9f877095..e335ac2b9e19 100644
> --- a/tools/lib/symbol/kallsyms.c
> +++ b/tools/lib/symbol/kallsyms.c
> @@ -1,7 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include "symbol/kallsyms.h"
> +#include "api/io.h"
>  #include <stdio.h>
> -#include <stdlib.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
>  
>  u8 kallsyms2elf_type(char type)
>  {
> @@ -15,74 +17,62 @@ bool kallsyms__is_function(char symbol_type)
>  	return symbol_type == 'T' || symbol_type == 'W';
>  }
>  
> -/*
> - * While we find nice hex chars, build a long_val.
> - * Return number of chars processed.
> - */
> -int hex2u64(const char *ptr, u64 *long_val)

hi,
when you remove in here hex2u64, you'll break the compile:

	  LINK     perf
	/usr/bin/ld: perf-in.o: in function `modules__parse':
	/home/jolsa/linux-perf/tools/perf/util/symbol.c:607: undefined reference to `hex2u64'
	/usr/bin/ld: /home/jolsa/linux-perf/tools/perf/util/symbol.c:607: undefined reference to `hex2u64'
	/usr/bin/ld: perf-in.o: in function `dso__load_perf_map':
	/home/jolsa/linux-perf/tools/perf/util/symbol.c:1477: undefined reference to `hex2u64'
	/usr/bin/ld: /home/jolsa/linux-perf/tools/perf/util/symbol.c:1483: undefined reference to `hex2u64'
	collect2: error: ld returned 1 exit status
	make[2]: *** [Makefile.perf:629: perf] Error 1
	make[1]: *** [Makefile.perf:225: sub-make] Error 2
	make: *** [Makefile:70: all] Error 2

that hex2u64 move needs to come before this change

jirka

