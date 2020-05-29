Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5F5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BEC6207F9
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7R6m9wb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgE2SHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 14:07:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57055 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727000AbgE2SHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 14:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590775648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=czEdY+XGz5LqFpm62jaCPb/A59YOV2vdcF74WufIJLA=;
        b=Q7R6m9wbNhZi9E3rz6g3XjjbX6ExN7GMgQERHgjJ9swJv+HZDwNlJqVosL4meiuE4xpTPP
        yMRQZZvZEynZovbbP7NX6vLI0o0G18Xdd16sSeQ94G0W/pozKtDoXB2L2hPDy8AEdICnJ8
        yfFTO00TkXesLkS/9p7C+iBjqtcchKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-pJhQuBDeOwmkcW3QZI6X1w-1; Fri, 29 May 2020 14:07:22 -0400
X-MC-Unique: pJhQuBDeOwmkcW3QZI6X1w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 509BB1800D42;
        Fri, 29 May 2020 18:07:21 +0000 (UTC)
Received: from krava (unknown [10.40.192.29])
        by smtp.corp.redhat.com (Postfix) with SMTP id CFE8460BF1;
        Fri, 29 May 2020 18:07:18 +0000 (UTC)
Date:   Fri, 29 May 2020 20:07:17 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] perf build: Allow explicitely disabling the
 NO_SYSCALL_TABLE variable
Message-ID: <20200529180717.GF506785@krava>
References: <20200529155552.463-1-acme@kernel.org>
 <20200529155552.463-3-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529155552.463-3-acme@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 12:55:52PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> This is useful to see if, on x86, the legacy libaudit still works, as it
> is used in architectures that don't have the SYSCALL_TABLE logic and we
> want to have it tested in 'make -C tools/perf/ build-test'.
> 
> E.g.:
> 
> Without having audit-libs-devel installed:
> 
>   $ make NO_SYSCALL_TABLE=1 O=/tmp/build/perf -C tools/perf install-bin
>   make: Entering directory '/home/acme/git/perf/tools/perf'
>     BUILD:   Doing 'make -j12' parallel build
>   <SNIP>
>   Auto-detecting system features:
>   <SNIP>
>   ...                      libaudit: [ OFF ]
>   ...                        libbfd: [ on  ]
>   ...                        libcap: [ on  ]
>   <SNIP>
>   Makefile.config:664: No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev
>   <SNIP>
> 
> After installing it:
> 
>   $ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf
>   $ time make NO_SYSCALL_TABLE=1 O=/tmp/build/perf  -C tools/perf install-bin ; perf test python

heya,
seems ok, perhaps also put it in comment to Makefile.perf
among other NO_* stuff and to tests/make

jirka

>   make: Entering directory '/home/acme/git/perf/tools/perf'
>     BUILD:   Doing 'make -j12' parallel build
>     HOSTCC   /tmp/build/perf/fixdep.o
>     HOSTLD   /tmp/build/perf/fixdep-in.o
>     LINK     /tmp/build/perf/fixdep
>   Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs from latest version at 'arch/x86/include/asm/msr-index.h'
>   diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
>   Warning: Kernel ABI header at 'tools/perf/util/hashmap.h' differs from latest version at 'tools/lib/bpf/hashmap.h'
>   diff -u tools/perf/util/hashmap.h tools/lib/bpf/hashmap.h
>   Warning: Kernel ABI header at 'tools/perf/util/hashmap.c' differs from latest version at 'tools/lib/bpf/hashmap.c'
>   diff -u tools/perf/util/hashmap.c tools/lib/bpf/hashmap.c
> 
>   Auto-detecting system features:
>   <SNIP>
>   ...                      libaudit: [ on  ]
>   ...                        libbfd: [ on  ]
>   ...                        libcap: [ on  ]
>   <SNIP>
>   $ ldd ~/bin/perf | grep audit
>   	libaudit.so.1 => /lib64/libaudit.so.1 (0x00007fc18978e000)
>   $
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/Makefile.config | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 93fb7510a9a9..6bc9251f1634 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -24,20 +24,22 @@ $(call detected_var,SRCARCH)
>  
>  NO_PERF_REGS := 1
>  
> -NO_SYSCALL_TABLE := 1
> +ifneq ($(NO_SYSCALL_TABLE),1)
> +  NO_SYSCALL_TABLE := 1
>  
> -ifeq ($(SRCARCH),x86)
> -  ifeq (${IS_64_BIT}, 1)
> -    NO_SYSCALL_TABLE := 0
> -  endif
> -else
> -  ifneq ($(SRCARCH),$(filter $(SRCARCH),powerpc arm64 s390))
> -    NO_SYSCALL_TABLE := 0
> +  ifeq ($(SRCARCH),x86)
> +    ifeq (${IS_64_BIT}, 1)
> +      NO_SYSCALL_TABLE := 0
> +    endif
> +  else
> +    ifneq ($(SRCARCH),$(filter $(SRCARCH),powerpc arm64 s390))
> +      NO_SYSCALL_TABLE := 0
> +    endif
>    endif
> -endif
>  
> -ifneq ($(NO_SYSCALL_TABLE),1)
> -  CFLAGS += -DHAVE_SYSCALL_TABLE_SUPPORT
> +  ifneq ($(NO_SYSCALL_TABLE),1)
> +    CFLAGS += -DHAVE_SYSCALL_TABLE_SUPPORT
> +  endif
>  endif
>  
>  # Additional ARCH settings for ppc
> -- 
> 2.25.3
> 

