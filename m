Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4ABC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F909208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0kVm37J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgFQK1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 06:27:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22056 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725554AbgFQK1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 06:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592389658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LXF7fTJru8h7pgEyfZIXazHv+wCxxWltNcswn5LLFbQ=;
        b=b0kVm37J1ptDyw/3FD44/Avjcbnow8uJLUGDqBOxQgzfqGDVqtk+4VxF4KyjMCaKn/BgQH
        Hy7P/iLP2f7Nv07ZpgNJndOegvqj3v/qWhpFumI5l1ntvF/c1Wp3Re45CqjR9EWTU3oMeA
        9bQmE4Gj7tVpkn2napvdIsku60L4Cow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-ZVpzVIsmNimK6YqvmMCAfg-1; Wed, 17 Jun 2020 06:27:34 -0400
X-MC-Unique: ZVpzVIsmNimK6YqvmMCAfg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2BF61015DA2;
        Wed, 17 Jun 2020 10:27:32 +0000 (UTC)
Received: from krava (unknown [10.40.193.76])
        by smtp.corp.redhat.com (Postfix) with SMTP id BF2357CAC1;
        Wed, 17 Jun 2020 10:27:30 +0000 (UTC)
Date:   Wed, 17 Jun 2020 12:27:29 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH v3] tools build: Check libasan and libubsan in
 Makefile.feature
Message-ID: <20200617102729.GC2210496@krava>
References: <1592360821-2323-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592360821-2323-1-git-send-email-yangtiezhu@loongson.cn>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 10:27:01AM +0800, Tiezhu Yang wrote:
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
>  tools/build/Makefile.feature | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index cb15237..bc28dc9 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -250,3 +250,15 @@ ifeq ($(feature_verbose),1)
>    $(foreach feat,$(TMP),$(call feature_print_status,$(feat),))
>    $(info )
>  endif
> +
> +ifneq ($(filter s% -fsanitize=address%,$(EXTRA_CFLAGS),),)
> +  ifneq ($(shell ldconfig -p | grep libasan >/dev/null 2>&1; echo $$?), 0)
> +    msg := $(error No libasan found, please install libasan);
> +  endif
> +endif
> +
> +ifneq ($(filter s% -fsanitize=undefined%,$(EXTRA_CFLAGS),),)
> +  ifneq ($(shell ldconfig -p | grep libubsan >/dev/null 2>&1; echo $$?), 0)
> +    msg := $(error No libubsan found, please install libubsan);
> +  endif
> +endif

sry, I made uninformed guess when I replied to your first patch,
I checked on libasan/libubsan and they don't have devel headers

so I think the check above should be in Makefile.config together
with the EXTRA_CFLAGS check for -fsanitize options as you have above

thanks,
jirka

