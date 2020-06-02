Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0D4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38D2320757
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="deVr3fAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgFBOQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:16:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23632 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726112AbgFBOQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 10:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591107360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RGEMiVn12opt/g+WjyzDzTyT6jZrj0pfTX7zXxSALys=;
        b=deVr3fAWN+fOvpboH1hXXI9H+Dqod65fP/S5jB+d3ogirvWFsyPHuV1mA3fst9lo/4H7CN
        6GFGB+xjfwyUNPpPTIw0T8hQK4yJ/keJ23jnKeImmghuNaKU6PwWrk+q3IYjojQ8fj6y4+
        MNS9ZVniey7JDtroWalZk8XR7hHZkuE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-1qZgDf03Pqau7TvT-SLC_A-1; Tue, 02 Jun 2020 10:15:58 -0400
X-MC-Unique: 1qZgDf03Pqau7TvT-SLC_A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C607480058E;
        Tue,  2 Jun 2020 14:15:56 +0000 (UTC)
Received: from krava (unknown [10.40.192.188])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3E61D49F6;
        Tue,  2 Jun 2020 14:15:52 +0000 (UTC)
Date:   Tue, 2 Jun 2020 16:15:51 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH 1/2] perf tools: check libasan and libubsan in
 Makefile.config
Message-ID: <20200602141551.GC1169993@krava>
References: <1591071304-19338-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591071304-19338-1-git-send-email-yangtiezhu@loongson.cn>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 12:15:03PM +0800, Tiezhu Yang wrote:
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
>  tools/perf/Makefile.config | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 12a8204..b699d21 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -387,6 +387,12 @@ else
>        NO_LIBBPF := 1
>        NO_JVMTI := 1
>      else
> +      ifneq ($(shell ldconfig -p | grep libasan >/dev/null 2>&1; echo $$?), 0)
> +        msg := $(error No libasan found, please install libasan);
> +      endif
> +      ifneq ($(shell ldconfig -p | grep libubsan >/dev/null 2>&1; echo $$?), 0)
> +        msg := $(error No libubsan found, please install libubsan);
> +      endif

hum, would it be better to have check for this in tools/build/features?

jirka

>        ifneq ($(filter s% -static%,$(LDFLAGS),),)
>          msg := $(error No static glibc found, please install glibc-static);
>        else
> -- 
> 2.1.0
> 

