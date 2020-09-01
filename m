Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32649C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03084206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnwJlH6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgIAEzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 00:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgIAEzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 00:55:47 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20254C061290
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 21:55:47 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id p65so37892qtd.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 21:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bDCzgE7PpxJKYkZFw4L83L4c22jArf+LVGBAv9O8ML8=;
        b=RnwJlH6USeG0XKyTf8I3XJJU0kold/BgryjlADWJeuf1Wn4fcHHokvifJOAiMCluEV
         3APT7bW+7YF+hNxSrw/S0ibjJM5kVcKHELNnt92n5VUI+B2r6WySQ62+H66RDE9c+J+5
         fcRmu3O2KsLtDrm6ZBpRfAHMEGDHFaNogS4WvMCesg5srJ0cwakl4U0UAfS2K536Ovuv
         W1oIWIR8zYpME/iM++yKGPqaeRkXwLVU/zC7Qh+SxLM9HHjuaw+s4gCxRYU3d/eafEGh
         M/waFnaUUkOBbw/86Y1nT3WjrXstbAwt1efgFzbUB+3+hC/NcdO/oKQg9OCuKYCBX1bW
         Pocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bDCzgE7PpxJKYkZFw4L83L4c22jArf+LVGBAv9O8ML8=;
        b=DU60vZiAHtYx6J5HeLooC/otdzNpEE3+oFKHP2znOWCpwfSc3ckkGe550HVZYxGv7y
         8gE4L49wuzQFqxDNfzXH8Vo3zF0z2dwMmOlZEbH4Mi2Jas+ntxSNCYZjs+TkAPQ5UJCz
         lsNnMmDHTZxL3nmTTnNSTiO5qtmbrVszhpb1PoNNFy1AbiGaa0hfl0AsULwKV+qvmB2m
         nKtBj0GkeJgAjTUbdQpyBB6/HUyrZOIaZBm7nPD9dq0Hk/+ETM01z8eS6hp4R87uitGW
         OhPHwh+zs2kNUAyVpSgXpVFhGbTnnFzdLu7Jxs5l+NvK1k+p7v2zYUybtWXXAJRoOocV
         8dfQ==
X-Gm-Message-State: AOAM531YOhN7Ms6BWngeKWEZow55PNzfOS5q67NDnHV+z64rBNEyEA9G
        pozGlEDT59WZ+WbFeJEnNzA=
X-Google-Smtp-Source: ABdhPJznsM52fTaMN0BLVVYqwVkpASC1saxb4ikUXdx3WU9lQWAtCiqnLL5+25/IPMIxnO7BVBygoQ==
X-Received: by 2002:ac8:3568:: with SMTP id z37mr4694456qtb.59.1598936146344;
        Mon, 31 Aug 2020 21:55:46 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id r195sm218598qke.74.2020.08.31.21.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 21:55:45 -0700 (PDT)
Date:   Mon, 31 Aug 2020 21:55:44 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux@googlegroups.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] Revert "arm64: bti: Require clang >= 10.0.1 for
 in-kernel BTI support"
Message-ID: <20200901045544.GB1561318@ubuntu-n2-xlarge-x86>
References: <20200901002326.1137289-1-ndesaulniers@google.com>
 <20200901002326.1137289-4-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901002326.1137289-4-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 05:23:22PM -0700, Nick Desaulniers wrote:
> This reverts commit b9249cba25a5dce5de87e5404503a5e11832c2dd.
> 
> The minimum supported version of clang is now 10.0.1.
> 
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  arch/arm64/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 6d232837cbee..2a70b85b1a61 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1630,8 +1630,6 @@ config ARM64_BTI_KERNEL
>  	depends on CC_HAS_BRANCH_PROT_PAC_RET_BTI
>  	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94697
>  	depends on !CC_IS_GCC || GCC_VERSION >= 100100
> -	# https://reviews.llvm.org/rGb8ae3fdfa579dbf366b1bb1cbfdbf8c51db7fa55
> -	depends on !CC_IS_CLANG || CLANG_VERSION >= 100001
>  	depends on !(CC_IS_CLANG && GCOV_KERNEL)
>  	depends on (!FUNCTION_GRAPH_TRACER || DYNAMIC_FTRACE_WITH_REGS)
>  	help
> -- 
> 2.28.0.402.g5ffc5be6b7-goog
> 
