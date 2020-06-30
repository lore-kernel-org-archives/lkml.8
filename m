Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D5CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 22:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7F822072D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 22:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d9za7jNT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgF3WWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 18:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgF3WWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 18:22:38 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E062C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 15:22:38 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id g17so9054150plq.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 15:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LQqg1+PZ05kIBpTL59xr7DfetEZhJfx8+ch9+gI56hE=;
        b=d9za7jNTCujMATufanAoR3E/dGN4JlmvT8hTxlO3BqAzmpkcLMzyenbVFNE04cO5Eq
         V3DgKPCKI5KwKtKe/Lm6L4L/ke5Q1Y/bNin6Ta4aYPvb9AaDyLgHaKCQ7/bhBAiCY10J
         9Qtuq+KjVh4r1/3OeWVh3VEZtFTmImFJLF8MdDLDnxQcdIDSfkzSD2QUF1q5FRBXynKF
         chtp2UHDgw7EWxu56qD6JK+Wh1bOkY5o1Jz+mh76bbPcfik3Bh6qpYuwVzpDL+A70zpI
         0X2X1Agp2iaiaf2DoXiqE+EKqkqHPYLKjJw2dd7rDpioCCC36NnjhlW+gvz+y3oK0sju
         4qnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LQqg1+PZ05kIBpTL59xr7DfetEZhJfx8+ch9+gI56hE=;
        b=Mh8avfrfxR4xXdqXcyFqjaZrXrmJri1DF5xcd6vMmoinOgT67C9gi9mPcCd+DHyoXs
         wpFoKJL/pKfCzOafypPtRM5HdZK/uIQ/VwHyt400IGv70Zi0OPF0tC62RPypef38DEif
         xC/UXDpe3zNaXvCD4rriulDVuIXjKlTu20lkFoLlUgwv4aJ+vrVmd+tmpa+9P8Ew3DBC
         w5PjtJM3JT7lz8coFDsYkvmWHe+IU/9YdnEcSj96AoQX3nGdVI7HdklJljax/vKmtxhJ
         fTs0UKEd/U1luoULj0IqO0kwXsYbYdGLoTADkjNkXTWBHBsYIDUrjbfvEBtSdTWTBEdE
         Gf1A==
X-Gm-Message-State: AOAM530FXPOxu660CPzFxBKsxREw6bV1nD1aOccGLVv7gyOhOgLXk5NG
        vFkXYzqssyX4xsrGzHSgdB4ljxR1+vfA01y+EGo11A==
X-Google-Smtp-Source: ABdhPJxCBS34d/ACfckTMdJK3GubMe09aLA2YT2TUi4myE/v1ISodfMaY3nIq1O/4bK4VRpBoPPYs9LPzxwrE6TH1wo=
X-Received: by 2002:a17:90a:1e:: with SMTP id 30mr23028159pja.25.1593555757877;
 Tue, 30 Jun 2020 15:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200617010232.23222-1-natechancellor@gmail.com>
In-Reply-To: <20200617010232.23222-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 30 Jun 2020 15:22:25 -0700
Message-ID: <CAKwvOdkXfW0vncswB_OjLfVu4-dAqZXaotw44y6TZSVEezWW0Q@mail.gmail.com>
Subject: Re: [PATCH] ASoC: Intel: KeemBay: Fix header guard
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>
Cc:     Sia Jee Heng <jee.heng.sia@intel.com>, alsa-devel@alsa-project.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 6:02 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
>  In file included from sound/soc/intel/keembay/kmb_platform.c:14:
>  sound/soc/intel/keembay/kmb_platform.h:9:9: warning: 'KMB_PLATFORM_H_'
>  is used as a header guard here, followed by #define of a different
>  macro [-Wheader-guard]
>  #ifndef KMB_PLATFORM_H_
>          ^~~~~~~~~~~~~~~
>  sound/soc/intel/keembay/kmb_platform.h:10:9: note: 'KMB_PLATFORMP_H_'
>  is defined here; did you mean 'KMB_PLATFORM_H_'?
>  #define KMB_PLATFORMP_H_
>          ^~~~~~~~~~~~~~~~
>          KMB_PLATFORM_H_
>  1 warning generated.
>
> Fix the typo so that the header guard works as intended.
>
> Fixes: c5477e966728 ("ASoC: Intel: Add KeemBay platform driver")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1053
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  sound/soc/intel/keembay/kmb_platform.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/intel/keembay/kmb_platform.h b/sound/soc/intel/keembay/kmb_platform.h
> index 29600652d8f4..6bf221aa8fff 100644
> --- a/sound/soc/intel/keembay/kmb_platform.h
> +++ b/sound/soc/intel/keembay/kmb_platform.h
> @@ -7,7 +7,7 @@
>   */
>
>  #ifndef KMB_PLATFORM_H_
> -#define KMB_PLATFORMP_H_
> +#define KMB_PLATFORM_H_
>
>  #include <linux/bits.h>
>  #include <linux/bitfield.h>
>
> base-commit: 27f70ec4fa0e0f419031f1b8d61b1a788244e313
> --
> 2.27.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200617010232.23222-1-natechancellor%40gmail.com.



-- 
Thanks,
~Nick Desaulniers
