Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F47C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 606612082F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QRslQp5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgFRM7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:59:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53165 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729896AbgFRM7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592485184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9kfbmCWwu8HqyhmfzJ7ZMxjZwh/zqehSiDKnoKkUP7M=;
        b=QRslQp5wtxLJqy0HCUpsmHZxDm+ccR76WBFmi0ZIknPdaIEZRDk1Mnb6lTQvrvL9bj4OEr
        bOuU6omxPgLCjNC/AxrFyXvI9Fh90y5XTbXIVg0VMKLZhEpurcTdezvaytEnNezUB4SWtw
        2BPIA7GNXe8ysX6XZnwa8HN12QcaFXA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-3u_2rEKzOR6SeI_wK34wLA-1; Thu, 18 Jun 2020 08:59:42 -0400
X-MC-Unique: 3u_2rEKzOR6SeI_wK34wLA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AB4C8DFFEB;
        Thu, 18 Jun 2020 12:57:56 +0000 (UTC)
Received: from krava (unknown [10.40.194.92])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7B71F1010404;
        Thu, 18 Jun 2020 12:57:46 +0000 (UTC)
Date:   Thu, 18 Jun 2020 14:57:46 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH v4] perf tools: Check libasan and libubsan in
 Makefile.config
Message-ID: <20200618125746.GD2369163@krava>
References: <1592445961-28044-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592445961-28044-1-git-send-email-yangtiezhu@loongson.cn>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 10:06:01AM +0800, Tiezhu Yang wrote:
> When build perf with ASan or UBSan, if libasan or libubsan can not find,
> the feature-glibc is 0 and there exists the following error log which is
> wrong, because we can find gnu/libc-version.h in /usr/include, glibc-devel
> is also installed.
> 
> [yangtiezhu@linux perf]$ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=address'
>   BUILD:   Doing 'make -j4' parallel build
>   HOSTCC   fixdep.o
>   HOSTLD   fixdep-in.o
>   LINK     fixdep
> <stdin>:1:0: warning: -fsanitize=address and -fsanitize=kernel-address are not supported for this target
> <stdin>:1:0: warning: -fsanitize=address not supported for this target
> 
> Auto-detecting system features:
> ...                         dwarf: [ OFF ]
> ...            dwarf_getlocations: [ OFF ]
> ...                         glibc: [ OFF ]
> ...                          gtk2: [ OFF ]
> ...                      libaudit: [ OFF ]
> ...                        libbfd: [ OFF ]
> ...                        libcap: [ OFF ]
> ...                        libelf: [ OFF ]
> ...                       libnuma: [ OFF ]
> ...        numa_num_possible_cpus: [ OFF ]
> ...                       libperl: [ OFF ]
> ...                     libpython: [ OFF ]
> ...                     libcrypto: [ OFF ]
> ...                     libunwind: [ OFF ]
> ...            libdw-dwarf-unwind: [ OFF ]
> ...                          zlib: [ OFF ]
> ...                          lzma: [ OFF ]
> ...                     get_cpuid: [ OFF ]
> ...                           bpf: [ OFF ]
> ...                        libaio: [ OFF ]
> ...                       libzstd: [ OFF ]
> ...        disassembler-four-args: [ OFF ]
> 
> Makefile.config:393: *** No gnu/libc-version.h found, please install glibc-dev[el].  Stop.
> Makefile.perf:224: recipe for target 'sub-make' failed
> make[1]: *** [sub-make] Error 2
> Makefile:69: recipe for target 'all' failed
> make: *** [all] Error 2
> [yangtiezhu@linux perf]$ ls /usr/include/gnu/libc-version.h
> /usr/include/gnu/libc-version.h
> 
> After install libasan and libubsan, the feature-glibc is 1 and the build
> process is success, so the cause is related with libasan or libubsan, we
> should check them and print an error log to reflect the reality.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
> 
> v2:
>   - Check libasan and libubsan in tools/build/Makefile.feature
>   - Modify the patch subject
> 
> v3:
>   - Check EXTRA_CFLAGS first
> 
> v4:
>   - Check libasan and libubsan in tools/perf/Makefile.config
>   - Modify the patch subject

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

