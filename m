Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A30BC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD74206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZqgvKfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgDGRMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 13:12:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48180 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726365AbgDGRL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 13:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586279518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZSBF7tOzRxO10YjbPU7Bv3EEE5LpjgBIjIXBe6C/0FY=;
        b=KZqgvKfC8lb5HEewES+q35ZpMMlnw05r4IBD23L6SbrySs2I3C/d+xnv642ggtEvhZcBpN
        69RqCsdfja0qvkD+4OdhWVpl9U1lMhXPp5wjYD1yhJX1zBLgh5m1cArvBE9GLw/6OuZbMg
        GhJ50sZE+Vq5eNz0Xuc/JgHhzzX/mPU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-98bY3pZFPEO54TQ9QULGGA-1; Tue, 07 Apr 2020 13:11:55 -0400
X-MC-Unique: 98bY3pZFPEO54TQ9QULGGA-1
Received: by mail-qv1-f70.google.com with SMTP id j7so3510712qvy.22
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 10:11:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZSBF7tOzRxO10YjbPU7Bv3EEE5LpjgBIjIXBe6C/0FY=;
        b=EH0YNrJ9QcGf6hDHA8AatFEcAbDm4BtZ0fg1FyNiU9EYNUWogcmqcMqhIozJXPaTza
         DJS9YEQIRDxbGgoeBLBMqKxdp6B4xAJk7GzL5CyVnqClPmcENGGobFy1nrgJ1pmHB6Um
         f1WAoCWug3PXWdv/SVj3qybxzRyNI8Iz5za0dV+uyT+yzgxWQLg06P0lt0SoM0M7XwVe
         cDZpzOMr3qejvTN/OA+MuMNRx/pYet2dYxoMbV5VxB24tie7tfrXDY/F0gDwcr7Z/PHR
         P43n88dF2IUVAeE+gUkuoXNtBMDfCYQ5t6FpkILf00wY+GDaU1oNvr2BhasSoQgCcJro
         RfOw==
X-Gm-Message-State: AGi0PuaeFn4ZuYRnA2PNBaujypl+e5v8XyN1uPyli2GwHCClAOrJ5CrG
        sRcCLaP1PcuSnpfISodDBBY6YuLHshrwEDv8Ib+j6jRDNIEUEz55/5LNq8K3ZPnoQjokX4p869N
        80W434cjtCvDVV/jDcGXeU3cj
X-Received: by 2002:ac8:568b:: with SMTP id h11mr3359566qta.197.1586279514843;
        Tue, 07 Apr 2020 10:11:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypIsBxCQ0i4lAaOo4Y9HTrwWWzimzTlOgDesSissOnAZYNWvh++MU+caahFIR6ZOUThlrc/XRg==
X-Received: by 2002:ac8:568b:: with SMTP id h11mr3359535qta.197.1586279514431;
        Tue, 07 Apr 2020 10:11:54 -0700 (PDT)
Received: from dev.jcline.org ([136.56.87.133])
        by smtp.gmail.com with ESMTPSA id c40sm18290923qtk.18.2020.04.07.10.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 10:11:53 -0700 (PDT)
Date:   Tue, 7 Apr 2020 13:11:52 -0400
From:   Jeremy Cline <jcline@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: add dummy toolchains to enable all cc-option
 etc. in Kconfig
Message-ID: <20200407171152.GC196945@dev.jcline.org>
References: <20200407155352.16617-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407155352.16617-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 12:53:52AM +0900, Masahiro Yamada wrote:
> Staring v4.18, Kconfig evaluates compiler capabilities, and hides CONFIG
> options your compiler does not support. This works well if you configure
> and build the kernel on the same host machine.
> 
> It is inconvenient if you prepare the .config that is carried to a
> different build environment (typically this happens when you package
> the kernel for distros) because using a different compiler potentially
> produces different CONFIG options than the real build environment.
> So, you probably want to make as many options visible as possible.
> In other words, you need to create a super-set of CONFIG options that
> cover any build environment. If some of the CONFIG options turned out
> to be unsupported on the build machine, they are automatically disabled
> by the nature of Kconfig.
> 
> However, it is not feasible to get a full-featured compiler for every
> arch.
> 
> This issue was discussed here:
> 
>   https://lkml.org/lkml/2019/12/9/620
> 
> Other than distros, savedefconfig is also a problem. Some arch sub-systems
> periodically resync defconfig files. If you use a less-capable compiler
> for savedefconfig, options that do not meet 'depends on $(cc-option,...)'
> will be forcibly disabled. So, 'make defconfig && make savedefconfig'
> may silently change the behavior.
> 
> This commit adds a set of dummy toolchains that pretend to support any
> feature.
> 
> Most of compiler features are tested by cc-option, which simply checks
> the exit code of $(CC). The dummy tools are shell scripts that always
> exit with 0. So, $(cc-option, ...) is evaluated as 'y'.
> 
> There are more complicated checks such as:
> 
>   scripts/gcc-x86_{32,64}-has-stack-protector.sh
>   scripts/gcc-plugin.sh
>   scripts/tools-support-relr.sh
> 
> scripts/dummy-tools/gcc passes all checks.
> 
> From the top directory of the source tree, you can do:
> 
>    $ make CROSS_COMPILE=scripts/dummy-tools/ oldconfig
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Philipp Rudo <prudo@linux.ibm.com>
> ---
> 
> Changes in v2:
>   - support --version and -v for ld, objdump, nm

Great, "make ARCH=powerpc CROSS_COMPILE=scripts/dummy-tools/ help" no
longer spits out "/bin/sh: line 0: [: -ge: unary operator expected" and
everything looks to work as expected.

Tested-by: Jeremy Cline <jcline@redhat.com>

> 
>  scripts/dummy-tools/gcc     | 91 +++++++++++++++++++++++++++++++++++++
>  scripts/dummy-tools/ld      | 30 ++++++++++++
>  scripts/dummy-tools/nm      |  1 +
>  scripts/dummy-tools/objcopy |  1 +
>  4 files changed, 123 insertions(+)
>  create mode 100755 scripts/dummy-tools/gcc
>  create mode 100755 scripts/dummy-tools/ld
>  create mode 120000 scripts/dummy-tools/nm
>  create mode 120000 scripts/dummy-tools/objcopy
> 
> diff --git a/scripts/dummy-tools/gcc b/scripts/dummy-tools/gcc
> new file mode 100755
> index 000000000000..33487e99d83e
> --- /dev/null
> +++ b/scripts/dummy-tools/gcc
> @@ -0,0 +1,91 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Staring v4.18, Kconfig evaluates compiler capabilities, and hides CONFIG
> +# options your compiler does not support. This works well if you configure and
> +# build the kernel on the same host machine.
> +#
> +# It is inconvenient if you prepare the .config that is carried to a different
> +# build environment (typically this happens when you package the kernel for
> +# distros) because using a different compiler potentially produces different
> +# CONFIG options than the real build environment. So, you probably want to make
> +# as many options visible as possible. In other words, you need to create a
> +# super-set of CONFIG options that cover any build environment. If some of the
> +# CONFIG options turned out to be unsupported on the build machine, they are
> +# automatically disabled by the nature of Kconfig.
> +#
> +# However, it is not feasible to get a full-featured compiler for every arch.
> +# Hence these dummy toolchains to make all compiler tests pass.
> +#
> +# Usage:
> +#
> +# From the top directory of the source tree, run
> +#
> +#   $ make CROSS_COMPILE=scripts/dummy-tools/ oldconfig
> +#
> +# Most of compiler features are tested by cc-option, which simply checks the
> +# exit code of $(CC). This script does nothing and just exits with 0 in most
> +# cases. So, $(cc-option, ...) is evaluated as 'y'.
> +#
> +# This scripts caters to more checks; handle --version and pre-process __GNUC__
> +# etc. to pretend to be GCC, and also do right things to satisfy some scripts.
> +
> +# Check if the first parameter appears in the rest. Succeeds if found.
> +# This helper is useful if a particular option was passed to this script.
> +# Typically used like this:
> +#   arg_contain <word-you-are-searching-for> "$@"
> +arg_contain ()
> +{
> +	search="$1"
> +	shift
> +
> +	while [ $# -gt 0 ]
> +	do
> +		if [ "$search" = "$1" ]; then
> +			return 0
> +		fi
> +		shift
> +	done
> +
> +	return 1
> +}
> +
> +# To set CONFIG_CC_IS_GCC=y
> +if arg_contain --version "$@"; then
> +	echo "gcc (scripts/dummy-tools/gcc)"
> +	exit 0
> +fi
> +
> +if arg_contain -E "$@"; then
> +	# For scripts/gcc-version.sh; This emulates GCC 20.0.0
> +	if arg_contain - "$@"; then
> +		sed 's/^__GNUC__$/20/; s/^__GNUC_MINOR__$/0/; s/^__GNUC_PATCHLEVEL__$/0/'
> +		exit 0
> +	else
> +		echo "no input files" >&2
> +		exit 1
> +	fi
> +fi
> +
> +if arg_contain -S "$@"; then
> +	# For scripts/gcc-x86-*-has-stack-protector.sh
> +	if arg_contain -fstack-protector "$@"; then
> +		echo "%gs"
> +		exit 0
> +	fi
> +fi
> +
> +# For scripts/gcc-plugin.sh
> +if arg_contain -print-file-name=plugin "$@"; then
> +	plugin_dir=$(mktemp -d)
> +
> +	sed -n 's/.*#include "\(.*\)"/\1/p' $(dirname $0)/../gcc-plugins/gcc-common.h |
> +	while read header
> +	do
> +		mkdir -p $plugin_dir/include/$(dirname $header)
> +		touch $plugin_dir/include/$header
> +	done
> +
> +	echo $plugin_dir
> +	exit 0
> +fi
> diff --git a/scripts/dummy-tools/ld b/scripts/dummy-tools/ld
> new file mode 100755
> index 000000000000..f68233050405
> --- /dev/null
> +++ b/scripts/dummy-tools/ld
> @@ -0,0 +1,30 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +# Dummy script that always succeeds.
> +
> +# Check if the first parameter appears in the rest. Succeeds if found.
> +# This helper is useful if a particular option was passed to this script.
> +# Typically used like this:
> +#   arg_contain <word-you-are-searching-for> "$@"
> +arg_contain ()
> +{
> +	search="$1"
> +	shift
> +
> +	while [ $# -gt 0 ]
> +	do
> +		if [ "$search" = "$1" ]; then
> +			return 0
> +		fi
> +		shift
> +	done
> +
> +	return 1
> +}
> +
> +if arg_contain --version "$@" || arg_contain -v "$@"; then
> +	progname=$(basename $0)
> +	echo "GNU $progname (scripts/dummy-tools/$progname) 2.50"
> +	exit 0
> +fi
> diff --git a/scripts/dummy-tools/nm b/scripts/dummy-tools/nm
> new file mode 120000
> index 000000000000..c0648b38dd42
> --- /dev/null
> +++ b/scripts/dummy-tools/nm
> @@ -0,0 +1 @@
> +ld
> \ No newline at end of file
> diff --git a/scripts/dummy-tools/objcopy b/scripts/dummy-tools/objcopy
> new file mode 120000
> index 000000000000..c0648b38dd42
> --- /dev/null
> +++ b/scripts/dummy-tools/objcopy
> @@ -0,0 +1 @@
> +ld
> \ No newline at end of file
> -- 
> 2.17.1
> 

