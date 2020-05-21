Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6BAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 22:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9F5E2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 22:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="hfbS9LZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbgEUWLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 18:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbgEUWLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 18:11:36 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D483C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 15:11:36 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id x13so3854986qvr.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 15:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kocdT4g9nbRMGVt+gTfNYp2kFlQFGidtfQ3ppE7WaVg=;
        b=hfbS9LZxNuVxrMISq4wh7Ug1AVYq3GcyUuxqpPgZe+0psXSTdVp+hZxiJcYim/L20y
         FyGDF/XORgfk0wedgq3Me5UlYbn6bsSS5BtMRneVTzudk75U2OsmVCTr5ayt7cMW+gtC
         Bt6pjgCsvge/l1ucZ6dy+28W1RANDAahJthttH52qvNh4rop53U9iSEB6Bs2J7bbLddP
         5V6AOMewfpkmnvbYzRhjH+smGHpX02aaOvf9gkUO9MvJKoH3IYkCV9WXmA6UuMw8pWO3
         UkVhUnhgeZyPvEwhPQJgf1iWxOggUI32xMXqWfn7Fp3biTqYEILnX+Y8qZhWqO+JSgQC
         9+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kocdT4g9nbRMGVt+gTfNYp2kFlQFGidtfQ3ppE7WaVg=;
        b=Lqpm+sNX/kjdQPv/PbE1MNRPA6TJ9y4F0hM0Wn7jM5wP5ubTAkPIVxuICgeB0sjbaj
         TyAgqfHICjbRp17GCgij3khODDEoFL8MSJUSZXmqnfuY8Gyqw8NnMm4sd1dQpfY8UKmc
         ZODAX3CN2w9m2xWY/hVmhKTTnnnLKSE5y2rQrgIGlU5USRJLaUD6RT510VdZSvguuhgB
         rz98HVE6P9kjUpfolqHMEP70axEXxw6lleiULuvP2Dn5hQC8wdYkFPb0SvGXDbr78UPU
         71ADcZ5frLBOTpifg+e3BFfFsQ849tq9ybgCUvY6B4uyEtVtvo8sM5KBmr42mewrVcrt
         +CAg==
X-Gm-Message-State: AOAM531tdoNmkCYJY9Gqr+pnW4GpZEbSmc1R5NGRUqD72YEVsFrSPXJO
        VGVei+r5x1ZllJRB2FMlqfgAog==
X-Google-Smtp-Source: ABdhPJxkv0CgkG+0XdVs3/A2kQrPQoeD0HZpl7Ppjz7uxnlsCzn6XthA905wsi6d8+hulHMWKc/rwg==
X-Received: by 2002:ad4:4145:: with SMTP id z5mr884054qvp.29.1590099095680;
        Thu, 21 May 2020 15:11:35 -0700 (PDT)
Received: from ovpn-112-192.phx2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id o18sm6452090qtb.7.2020.05.21.15.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 15:11:35 -0700 (PDT)
Date:   Thu, 21 May 2020 18:11:33 -0400
From:   Qian Cai <cai@lca.pw>
To:     Marco Elver <elver@google.com>
Cc:     dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        aryabinin@virtuozzo.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, kernel test robot <rong.a.chen@intel.com>
Subject: Re: [PATCH] kasan: Disable branch tracing for core runtime
Message-ID: <20200521221133.GD6367@ovpn-112-192.phx2.redhat.com>
References: <20200519182459.87166-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519182459.87166-1-elver@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 08:24:59PM +0200, 'Marco Elver' via kasan-dev wrote:
> During early boot, while KASAN is not yet initialized, it is possible to
> enter reporting code-path and end up in kasan_report(). While
> uninitialized, the branch there prevents generating any reports,
> however, under certain circumstances when branches are being traced
> (TRACE_BRANCH_PROFILING), we may recurse deep enough to cause kernel
> reboots without warning.
> 
> To prevent similar issues in future, we should disable branch tracing
> for the core runtime.
> 
> Link: https://lore.kernel.org/lkml/20200517011732.GE24705@shao2-debian/
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  mm/kasan/Makefile  | 16 ++++++++--------
>  mm/kasan/generic.c |  1 -
>  2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
> index 434d503a6525..de3121848ddf 100644
> --- a/mm/kasan/Makefile
> +++ b/mm/kasan/Makefile
> @@ -15,14 +15,14 @@ CFLAGS_REMOVE_tags_report.o = $(CC_FLAGS_FTRACE)
>  
>  # Function splitter causes unnecessary splits in __asan_load1/__asan_store1
>  # see: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63533
> -CFLAGS_common.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> -CFLAGS_generic.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> -CFLAGS_generic_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> -CFLAGS_init.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> -CFLAGS_quarantine.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> -CFLAGS_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> -CFLAGS_tags.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)

mm/kasan/tags.c:15:9: warning: 'DISABLE_BRANCH_PROFILING' macro redefined [-Wmacro-redefined]
#define DISABLE_BRANCH_PROFILING
        ^
<command line>:6:9: note: previous definition is here
#define DISABLE_BRANCH_PROFILING 1
        ^

This?

diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 25b7734e7013..8a959fdd30e3 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -12,7 +12,6 @@
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-#define DISABLE_BRANCH_PROFILING
 
 #include <linux/export.h>
 #include <linux/interrupt.h>

