Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA495C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6AF320735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTqudxhO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbgEEMhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 08:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728512AbgEEMhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 08:37:08 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0793CC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 05:37:07 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id fb4so865809qvb.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 05:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zkjd6vSA0iR8AbjQu55v+qS/P7GTPwD+mj650DHncy4=;
        b=LTqudxhO0AcqwHKhY2p6pnC/qie/QWbyv1GS1KSLYltoXtAf9HCZ6Xs1BGOBhu9jfQ
         eCxBO5/HtfZxDafwR38+ybHzhFDVneUDEgVZkmzCMMvu9V+GTOAhB1eeBRrSQT2SnieG
         kFMsI7s/8em0Ad/irqJ+mCmOXGUMiUkVQPhChmKdZSl21dk6Qrt1JuMiW4x9tCbtpLEo
         N9Laol9d7BqFsPTLNKtP2Wud31E5S5lbdOJClFSgP2iyfQylroUOUofvOMeEqW9fM66g
         stXCmDNh1o87cz0rLK0w8hKXK5tOGBvADxpugrKTtk215QTJs3JksUR4xGHWwCXXllhA
         drvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zkjd6vSA0iR8AbjQu55v+qS/P7GTPwD+mj650DHncy4=;
        b=M/Gq9ZU4aaCEcAoAGHJ39vyIHMntItlFFcIpotfEnrrRjo3AzAre9PdgWlSFyVUOLE
         cMonIs2+q8fnK7SpbqbbxU37lUCkWj2BWAOAPthpAM6mCJWJcYWCHqOdFgAfcg4q5wM/
         1A714dPnA5+Lv6iY/aDgQ9pcFoazah3kRJTn3347RJIa7u+zyGyixyQbwtwsbmVJmtl5
         aL3mOENYiuhh0p1PxHacJswF9t0t0KHgBrM2eDkK4GBodiUnjwWWYvNuQnG+nbLrcEPN
         ZWRJI8HGECiKGOODMOMLnUPTasdsW4FnYESzylBSKVsUx4k7hldZqk4rTO1qn55/djLK
         YJHA==
X-Gm-Message-State: AGi0PuadLbcaJIgcXPj7co9/uIjKszF2uyH6SRkTCI0EhywnRp/R4QiG
        Bc20urVNgGJThGebeiwgIQrXhW5zf2Y=
X-Google-Smtp-Source: APiQypJYh5Hx3TBjqgiOWIS8RhDdB3JJFYvQs1Tk5dQPJAns9IfcF0x5rCcmi/HQysEfQdnp1Ibmpw==
X-Received: by 2002:a0c:8262:: with SMTP id h89mr2358214qva.173.1588682226149;
        Tue, 05 May 2020 05:37:06 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id m25sm1671995qkg.83.2020.05.05.05.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 05:37:05 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A095B409A3; Tue,  5 May 2020 09:37:02 -0300 (-03)
Date:   Tue, 5 May 2020 09:37:02 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 2/3] lib kallsyms: parse using io api
Message-ID: <20200505123702.GS30487@kernel.org>
References: <20200501221315.54715-1-irogers@google.com>
 <20200501221315.54715-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501221315.54715-3-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 01, 2020 at 03:13:14PM -0700, Ian Rogers escreveu:
> Perf record will call kallsyms__parse 4 times during startup and process
> megabytes of data. This changes kallsyms__parse to use the io library
> rather than fgets to improve performance of the user code by over 8%.
> 
> Before:
>   Running 'internals/kallsyms-parse' benchmark:
>   Average kallsyms__parse took: 103.988 ms (+- 0.203 ms)
> After:
>   Running 'internals/kallsyms-parse' benchmark:
>   Average kallsyms__parse took: 95.571 ms (+- 0.006 ms)
> 
> For a workload like:
> $ perf record /bin/true
> Run under 'perf record -e cycles:u -g' the time goes from:
> Before
> 30.10%     1.67%  perf     perf                [.] kallsyms__parse
> After
> 25.55%    20.04%  perf     perf                [.] kallsyms__parse
> So a little under 5% of the start-up time is removed. A lot of what
> remains is on the kernel side, but caching kallsyms within perf would
> at least impact memory footprint.

Applied and added this to the commit log:

Committer notes:

The internal/kallsyms-parse bench is run using:

  [root@five ~]# perf bench internals kallsyms-parse
  # Running 'internals/kallsyms-parse' benchmark:
    Average kallsyms__parse took: 80.381 ms (+- 0.115 ms)
  [root@five ~]#

And this pre-existing test uses these routines to parse kallsyms and
then compare with the info obtained from the matching ELF symtab:

  [root@five ~]# perf test vmlinux
   1: vmlinux symtab matches kallsyms                       : Ok
  [root@five ~]#

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/api/io.h          |  3 ++
>  tools/lib/symbol/kallsyms.c | 86 ++++++++++++++++---------------------
>  2 files changed, 41 insertions(+), 48 deletions(-)
> 
> diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
> index b7e55b5f8a4a..777c20f6b604 100644
> --- a/tools/lib/api/io.h
> +++ b/tools/lib/api/io.h
> @@ -7,6 +7,9 @@
>  #ifndef __API_IO__
>  #define __API_IO__
>  
> +#include <stdlib.h>
> +#include <unistd.h>
> +
>  struct io {
>  	/* File descriptor being read/ */
>  	int fd;
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
> +static void read_to_eol(struct io *io)
>  {
> -	char *p;
> +	int ch;
>  
> -	*long_val = strtoull(ptr, &p, 16);
> -
> -	return p - ptr;
> +	for (;;) {
> +		ch = io__get_char(io);
> +		if (ch < 0 || ch == '\n')
> +			return;
> +	}
>  }
>  
>  int kallsyms__parse(const char *filename, void *arg,
>  		    int (*process_symbol)(void *arg, const char *name,
>  					  char type, u64 start))
>  {
> -	char *line = NULL;
> -	size_t n;
> -	int err = -1;
> -	FILE *file = fopen(filename, "r");
> -
> -	if (file == NULL)
> -		goto out_failure;
> -
> -	err = 0;
> +	struct io io;
> +	char bf[BUFSIZ];
> +	int err;
>  
> -	while (!feof(file)) {
> -		u64 start;
> -		int line_len, len;
> -		char symbol_type;
> -		char *symbol_name;
> +	io.fd = open(filename, O_RDONLY, 0);
>  
> -		line_len = getline(&line, &n, file);
> -		if (line_len < 0 || !line)
> -			break;
> +	if (io.fd < 0)
> +		return -1;
>  
> -		line[--line_len] = '\0'; /* \n */
> +	io__init(&io, io.fd, bf, sizeof(bf));
>  
> -		len = hex2u64(line, &start);
> +	err = 0;
> +	while (!io.eof) {
> +		__u64 start;
> +		int ch;
> +		size_t i;
> +		char symbol_type;
> +		char symbol_name[KSYM_NAME_LEN + 1];
>  
> -		/* Skip the line if we failed to parse the address. */
> -		if (!len)
> +		if (io__get_hex(&io, &start) != ' ') {
> +			read_to_eol(&io);
>  			continue;
> -
> -		len++;
> -		if (len + 2 >= line_len)
> +		}
> +		symbol_type = io__get_char(&io);
> +		if (io__get_char(&io) != ' ') {
> +			read_to_eol(&io);
>  			continue;
> -
> -		symbol_type = line[len];
> -		len += 2;
> -		symbol_name = line + len;
> -		len = line_len - len;
> -
> -		if (len >= KSYM_NAME_LEN) {
> -			err = -1;
> -			break;
>  		}
> +		for (i = 0; i < sizeof(symbol_name); i++) {
> +			ch = io__get_char(&io);
> +			if (ch < 0 || ch == '\n')
> +				break;
> +			symbol_name[i]  = ch;
> +		}
> +		symbol_name[i]  = '\0';
>  
>  		err = process_symbol(arg, symbol_name, symbol_type, start);
>  		if (err)
>  			break;
>  	}
>  
> -	free(line);
> -	fclose(file);
> +	close(io.fd);
>  	return err;
> -
> -out_failure:
> -	return -1;
>  }
> -- 
> 2.26.2.526.g744177e7f7-goog
> 

-- 

- Arnaldo
