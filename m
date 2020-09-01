Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24ACC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E11B206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMsAx4YO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgIAEzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 00:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgIAEzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 00:55:20 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF19C061290
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 21:55:19 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id k18so23524qtm.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 21:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SBabfCNAUI4ewVyTSFqp+WOZnMi5DObO4PTNnRnBepI=;
        b=VMsAx4YOSZSFLiZj4BM1qc6bCLpioURbUupXMxUp4JblyfBx/wtPRRbNs6oOvsQXlj
         PvM67C+dyyeWhEK8FE5U587/urx+VDKgxXaIfk29PoAPkAMuTSrZ4jjrvjOepIY4qpxH
         lgDgLpbu1QWZEHGA4IK62ClhldH4CS/eITESuUtJTimUF3aKB/lvb8cQbjNZrWVjdMVU
         2XhPkulLhHpFAvc7CruHfEYZY1iC7v1XUdKxEe9lqJblUomrCeNG8Z/HGOk+jROkDTsj
         RzVdlgUqIA3LZI3aQ4ti7m5Rxvy0EwFxEm2aPOnT5twebTd+R1+B24wQuBV85kzdKmY7
         iisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SBabfCNAUI4ewVyTSFqp+WOZnMi5DObO4PTNnRnBepI=;
        b=qrR7Bk9vuR0dxWO0Hx1YPaoEUKRpZmL9wHTN/zU5ouTJfIPmSoWGvmq008XpJjn9NE
         qrWBSLQHSswEApw0K38VppJ6TX+P0hoMo8cuA6Ux1YnNl07FIArIlWojeUC45PtDSO1Q
         tmghGa7jU7T0s/mPTf/7Z66uDHFBrSFpq8wKhvRFG3QDTlzE4EbZeC/aQzDLtYlKOLVg
         6d2bcZt+chbi3sTldriDSpuHnTq/ef9lfmpKfKdWtXR3E7ordooiP1v3YpoQBgDIM21n
         jwLNQNH3VzEs2I9IL2O2mo4tXhgMaoi3FKy5DUkz05NrQXmnzKnIykwPOl31ZiNyJ+4T
         5GBQ==
X-Gm-Message-State: AOAM530c8r58hiarPGWaPEjUPeO9qs8TAD+Q6HYh56E2GD9mzE36NYu9
        BKITFW9lLMs2LUMcmLvyCGK8Y7g9UyetEQ==
X-Google-Smtp-Source: ABdhPJyT2yCNMt6NHs5ifJtgW1JAWbPDwmf7Ju9mqPYUY56w729JAvN/HBxzVP1RXYy8Qpvx2WYPCQ==
X-Received: by 2002:ac8:6e99:: with SMTP id c25mr4782540qtv.324.1598936118715;
        Mon, 31 Aug 2020 21:55:18 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id g4sm8567152qth.30.2020.08.31.21.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 21:55:17 -0700 (PDT)
Date:   Mon, 31 Aug 2020 21:55:16 -0700
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
Subject: Re: [PATCH v2 2/7] Revert "kbuild: disable clang's default use of
 -fmerge-all-constants"
Message-ID: <20200901045516.GA1561318@ubuntu-n2-xlarge-x86>
References: <20200901002326.1137289-1-ndesaulniers@google.com>
 <20200901002326.1137289-3-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901002326.1137289-3-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 05:23:21PM -0700, Nick Desaulniers wrote:
> This reverts commit 87e0d4f0f37fb0c8c4aeeac46fff5e957738df79.
> 
> This was fixed in clang-6; the minimum supported version of clang in the
> kernel is clang-10 (10.0.1).
> 
> Link: https://reviews.llvm.org/rL329300.
> Link: https://github.com/ClangBuiltLinux/linux/issues/9
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  Makefile | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 37739ee53f27..144ac6a073ff 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -932,15 +932,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning, maybe-uninitialized)
>  # disable invalid "can't wrap" optimizations for signed / pointers
>  KBUILD_CFLAGS	+= $(call cc-option,-fno-strict-overflow)
>  
> -# clang sets -fmerge-all-constants by default as optimization, but this
> -# is non-conforming behavior for C and in fact breaks the kernel, so we
> -# need to disable it here generally.
> -KBUILD_CFLAGS	+= $(call cc-option,-fno-merge-all-constants)
> -
> -# for gcc -fno-merge-all-constants disables everything, but it is fine
> -# to have actual conforming behavior enabled.
> -KBUILD_CFLAGS	+= $(call cc-option,-fmerge-constants)
> -
>  # Make sure -fstack-check isn't enabled (like gentoo apparently did)
>  KBUILD_CFLAGS  += $(call cc-option,-fno-stack-check,)
>  
> -- 
> 2.28.0.402.g5ffc5be6b7-goog
> 
