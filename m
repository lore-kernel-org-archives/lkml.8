Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD5BC433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 00:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F37822078E
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 00:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599092911;
	bh=tRNolwm11qK3PhcEkLHV0fLq63wn3dwrAW+cnsP8cj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T6lE/gSlgj73KYdwOwpZuShl3rob30CXxF2vAL28uZmbnvSbutbgU4UuW0osjL/5F
	 u5hh1AFLRMZv0Ybht5BsFiKo9gqBYxbozZ117ubXTT63sxYD+ZXb837PxayuTRTyW4
	 Yf9iFrR2qoPJe0h5W3U2/PT8tkIMCh9RWVept54o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgICAZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 20:25:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgICAZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 20:25:23 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E96582078E;
        Thu,  3 Sep 2020 00:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599092722;
        bh=tRNolwm11qK3PhcEkLHV0fLq63wn3dwrAW+cnsP8cj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sasOEYhUhrf9FKb/tX+1h59+SW5Jv/hQCnuZxiKsMOd7z6iZ+NUoPjjLeAmt6Xa5Y
         7D8DEtbalEKu/YUJhVZG6yAZvXCozG71S6wY5OFlysuEhwxYGyHPhtaD3G/Bsj/0wJ
         qzZ919ZfI7bfKStX+4JQ4te7N1kEVlzgNgbdZMX0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E0BC540D3D; Wed,  2 Sep 2020 21:25:19 -0300 (-03)
Date:   Wed, 2 Sep 2020 21:25:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Remi Bernon <rbernon@codeweavers.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jacek Caban <jacek@codeweavers.com>
Subject: Re: [PATCH v3 1/3] perf dso: Use libbfd to read build_id and
 .gnu_debuglink section
Message-ID: <20200903002519.GA3487700@kernel.org>
References: <20200821165238.1340315-1-rbernon@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821165238.1340315-1-rbernon@codeweavers.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 21, 2020 at 06:52:36PM +0200, Remi Bernon escreveu:
> Wine generates PE binaries for most of its modules and perf is unable
> to parse these files to get build_id or .gnu_debuglink section.
> 
> Using libbfd when available, instead of libelf, makes it possible to
> resolve debug file location regardless of the dso binary format.
> 
> Signed-off-by: Remi Bernon <rbernon@codeweavers.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Jacek Caban <jacek@codeweavers.com>
> ---
> 
> v3: Rebase and small changes to PATCH 2/3 and and PATCH 3/3.
> 
>  tools/perf/util/symbol-elf.c | 80 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 77 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 8cc4b0059fb0..f7432c4a4154 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -50,6 +50,10 @@ typedef Elf64_Nhdr GElf_Nhdr;
>  #define DMGL_ANSI        (1 << 1)       /* Include const, volatile, etc */
>  #endif
>  
> +#ifdef HAVE_LIBBFD_SUPPORT

So, the feature test should also test for the buildid struct field, see
below:

> +#define PACKAGE 'perf'
> +#include <bfd.h>
> +#else
>  #ifdef HAVE_CPLUS_DEMANGLE_SUPPORT
>  extern char *cplus_demangle(const char *, int);
>  
> @@ -65,9 +69,7 @@ static inline char *bfd_demangle(void __maybe_unused *v,
>  {
>  	return NULL;
>  }
> -#else
> -#define PACKAGE 'perf'
> -#include <bfd.h>
> +#endif
>  #endif
>  #endif
>  
> @@ -530,6 +532,36 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
>  	return err;
>  }
>  
> +#ifdef HAVE_LIBBFD_SUPPORT
> +
> +int filename__read_build_id(const char *filename, void *bf, size_t size)
> +{
> +	int err = -1;
> +	bfd *abfd;
> +
> +	abfd = bfd_openr(filename, NULL);
> +	if (!abfd)
> +		return -1;
> +
> +	if (!bfd_check_format(abfd, bfd_object)) {
> +		pr_debug2("%s: cannot read %s bfd file.\n", __func__, filename);
> +		goto out_close;
> +	}
> +
> +	if (!abfd->build_id || abfd->build_id->size > size)
> +		goto out_close;

amazonlinux:1, centos:6, debian:8, mageia:5, oraclelinux:6, ubuntu:14.04
fail, its all old stuff, but adding a reference to abfd->build_id to the
feature test that ends up defining HAVE_LIBBFD_SUPPORT will solve that,
I'll do it tomorrow morning if you don't beat me to it.

util/symbol-elf.c: In function 'filename__read_build_id':
util/symbol-elf.c:551:11: error: 'bfd {aka struct bfd}' has no member named 'build_id'
  if (!abfd->build_id || abfd->build_id->size > size)
           ^~
util/symbol-elf.c:551:29: error: 'bfd {aka struct bfd}' has no member named 'build_id'
  if (!abfd->build_id || abfd->build_id->size > size)
                             ^~
util/symbol-elf.c:554:17: error: 'bfd {aka struct bfd}' has no member named 'build_id'
  memcpy(bf, abfd->build_id->data, abfd->build_id->size);
                 ^~
util/symbol-elf.c:554:39: error: 'bfd {aka struct bfd}' has no member named 'build_id'
  memcpy(bf, abfd->build_id->data, abfd->build_id->size);
                                       ^~
util/symbol-elf.c:555:18: error: 'bfd {aka struct bfd}' has no member named 'build_id'
  memset(bf + abfd->build_id->size, 0, size - abfd->build_id->size);
                  ^~
util/symbol-elf.c:555:50: error: 'bfd {aka struct bfd}' has no member named 'build_id'
  memset(bf + abfd->build_id->size, 0, size - abfd->build_id->size);
                                                  ^~
util/symbol-elf.c:556:12: error: 'bfd {aka struct bfd}' has no member named 'build_id'
  err = abfd->build_id->size;
            ^~
  CC       /tmp/build/perf/util/cap.o
make[4]: *** [/tmp/build/perf/util/symbol-elf.o] Error 1
make[4]: *** Waiting for unfinished jobs....
  LD       /tmp/build/perf/util/scripting-engines/perf-in.o
  LD       /tmp/build/perf/util/intel-pt-decoder/perf-in.o
make[3]: *** [util] Error 2
make[2]: *** [/tmp/build/perf/perf-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [sub-make] Error 2
make: *** [all] Error 2
make: Leaving directory `/git/linux/tools/perf'
+ exit 1
[perfbuilder@five ~]$
