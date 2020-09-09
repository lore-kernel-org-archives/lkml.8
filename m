Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A48CC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD55B21D7D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H0bHFQ3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbgIITtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729865AbgIITtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 15:49:12 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED28C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 12:49:11 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s2so1867390pjr.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 12:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oqhYmx0NFZNOAJE/eiypbxplY3MuONMIE6qhP6ssddY=;
        b=H0bHFQ3ASMEAVTRUPtHvl7e6oC+0uJShA88H73hKX19wZcyGfPYU3ObDK/Y4120mWt
         ybQL2m65jouKpt/NlMoDXLYE1qWA7pxMuoi0ztnpQ3V6o5/yX8ZXd/2s7TV3MF3ANKJX
         vFku7hYNnUG2uqMyhPP+wCL+4OMsefFwdXQmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oqhYmx0NFZNOAJE/eiypbxplY3MuONMIE6qhP6ssddY=;
        b=UxT47g/fwFOEb6txOjDTs/IC1yFoSpPCIcj0StiFZfVZssUnvkRTsecPgtzR9+LjLk
         0SDjquYa2NYqtO1Cb6WGgdC6Cgd0mbDE7MfbttsNOsOYUCqK0H6PqtW10aZsKAMJa+FC
         c3TCqSGTxCC4yNmh6WKhGcT27qt26J+XWSILvSVNHDtivcB6U0l3ph7O1rbu4MdeEroS
         sEcBNW/x3uyqlDgWwMl++z98dxb84ReVrqIU2XSAq+0u8icWssIhWf04E01XE4AmwvPj
         70RrRZa5vjAR0FMBlUEtnTYuMV4crUK4a79y7CYVojko2DN/hb1cJcCAx8dnffduoMEw
         3Ubw==
X-Gm-Message-State: AOAM533wFX48Mn1R4ycTqcpOW7qI7NLfACaQaqJnw1Zxf4v4z57y2oN5
        nngNzMvi9MYC6iro77h4y7X5yQ==
X-Google-Smtp-Source: ABdhPJxU9aNjxN137DFaJhJ9P+8qFGxNKraARUvOOUlchRyN5dF2XrloEu5kn+x5DFLgaSun59zKsA==
X-Received: by 2002:a17:90a:c83:: with SMTP id v3mr2067243pja.229.1599680951499;
        Wed, 09 Sep 2020 12:49:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f19sm3231001pfj.25.2020.09.09.12.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 12:49:10 -0700 (PDT)
Date:   Wed, 9 Sep 2020 12:49:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/lkdtm: Use "comm" instead of "diff" for dmesg
Message-ID: <202009091247.C10CDA60C@keescook>
References: <202006261358.3E8AA623A9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006261358.3E8AA623A9@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Jun 26, 2020 at 01:59:43PM -0700, Kees Cook wrote:
> Instead of full GNU diff (which smaller boot environments may not have),
> use "comm" which is more available.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Link: https://lore.kernel.org/lkml/CA+G9fYtHP+Gg+BrR_GkBMxu2oOi-_e9pATtpb6TVRswv1G1r1Q@mail.gmail.com
> Fixes: f131d9edc29d ("selftests/lkdtm: Don't clear dmesg when running tests")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Shuah, this really needs to land to fix lkdtm tests on busybox. Can
you add this to -next? (Or is it better to direct this to Greg for the
lkdtm tree?)

Thanks!

-Kees

> ---
>  tools/testing/selftests/lkdtm/run.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
> index 8383eb89d88a..5fe23009ae13 100755
> --- a/tools/testing/selftests/lkdtm/run.sh
> +++ b/tools/testing/selftests/lkdtm/run.sh
> @@ -82,7 +82,7 @@ dmesg > "$DMESG"
>  ($SHELL -c 'cat <(echo '"$test"') >'"$TRIGGER" 2>/dev/null) || true
>  
>  # Record and dump the results
> -dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$DMESG" - > "$LOG" || true
> +dmesg | comm -13 "$DMESG" - > "$LOG" || true
>  
>  cat "$LOG"
>  # Check for expected output
> -- 
> 2.25.1
> 
> 
> -- 
> Kees Cook

-- 
Kees Cook
