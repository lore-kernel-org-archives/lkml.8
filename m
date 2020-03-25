Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE3EC2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 23:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC02720714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 23:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T5Qtp5XY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbgCYX03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 19:26:29 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39853 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbgCYX03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 19:26:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id m1so1421334pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 16:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l+rxsfJdm0pMWVSL8Cwqx9YZjRtZV7LirGrxygW1T+I=;
        b=T5Qtp5XYn5CYWlMaK0R8K/DeiEM5Iuo3kdJcttk8CP+O5s3wuwr3dkgYe7hIUWV9ws
         kyoc8AsH+rLWAJmWxIIpL+oFFeBxMCmLOmdwmavFD623LYmjYcNHJybMgOXfzySt0Jrg
         A6HV7GwF+zd6CUsWG9D23gqWul7SMmwQP0UVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l+rxsfJdm0pMWVSL8Cwqx9YZjRtZV7LirGrxygW1T+I=;
        b=eZFOquD44l9zkXwiyc/uSZPmPg3mEskiQlUMy2OiUMQQxOpgYo7VEbg2j1XgaExyqR
         oJStF41WpvF7wER41J34nXH8jzTuMm94/eCpKwraTWSp/cNiOHBEvY543G921IMTCWjT
         6E1uE6JuhETS9eeqN6BBN3cZ6xyGjdB4mI1wQDTK+4ixgTDWk4G6wQrOE23rVnjACSMz
         0e0oUKv3csdkIdVfZmeVHlSJbx8DaJcTZBLpkPDGm5xFR/xyLAh4ZdkabAK95guxMTkb
         t1C/w9BCBzBoA5sVjsOKHRBgCskJKhqIPmgQ+a7LECD3OdoFSw7sKdTpYfr0p7CF5Vsq
         MKoQ==
X-Gm-Message-State: ANhLgQ0thXclw1rY9/6Cos9NNC7gzusnk/aiO+O2zRMr4avEO9yY955H
        fMMUGrQtnYpghLg1H9Hw7e/KRw==
X-Google-Smtp-Source: ADFU+vv6NVn42B5/CmzW/EHGOiTv5qi4qoLdQ4nsxPuo23Svqmn87kpZkw9gctTj5dnpzQY61Savlw==
X-Received: by 2002:a17:902:b198:: with SMTP id s24mr5318549plr.89.1585178787913;
        Wed, 25 Mar 2020 16:26:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d84sm182058pfd.197.2020.03.25.16.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 16:26:26 -0700 (PDT)
Date:   Wed, 25 Mar 2020 16:26:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     luto@amacapital.net, wad@chromium.org, shuah@kernel.org,
        mpe@ellerman.id.au, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] selftests: Fix seccomp to support relocatable build
 (O=objdir)
Message-ID: <202003251626.D47C4B3@keescook>
References: <20200325231602.12964-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325231602.12964-1-skhan@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 05:16:02PM -0600, Shuah Khan wrote:
> Fix seccomp relocatable builds. This is a simple fix to use the
> right lib.mk variable TEST_GEN_PROGS. Local header dependency
> is addressed in a change to lib.mk as a framework change that
> enforces the dependency without requiring changes to individual
> tests.
> 
> The following use-cases work with this change:
> 
> In seccomp directory:
> make all and make clean
> 
> From top level from main Makefile:
> make kselftest-install O=objdir ARCH=arm64 HOSTCC=gcc \
>  CROSS_COMPILE=aarch64-linux-gnu- TARGETS=seccomp
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks for getting this fixed. :)

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> Changes since v3:
> Simplified logic based on comments from Kees and Michael
> 
>  tools/testing/selftests/seccomp/Makefile | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
> index 1760b3e39730..0ebfe8b0e147 100644
> --- a/tools/testing/selftests/seccomp/Makefile
> +++ b/tools/testing/selftests/seccomp/Makefile
> @@ -1,17 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
> -all:
> -
> -include ../lib.mk
> -
> -.PHONY: all clean
> -
> -BINARIES := seccomp_bpf seccomp_benchmark
>  CFLAGS += -Wl,-no-as-needed -Wall
> +LDFLAGS += -lpthread
>  
> -seccomp_bpf: seccomp_bpf.c ../kselftest_harness.h
> -	$(CC) $(CFLAGS) $(LDFLAGS) $< -lpthread -o $@
> -
> -TEST_PROGS += $(BINARIES)
> -EXTRA_CLEAN := $(BINARIES)
> -
> -all: $(BINARIES)
> +TEST_GEN_PROGS := seccomp_bpf seccomp_benchmark
> +include ../lib.mk
> -- 
> 2.20.1
> 

-- 
Kees Cook
