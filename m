Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C73C433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 07:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 328E120786
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 07:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZYUgITlC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgGEHBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 03:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgGEHBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 03:01:12 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228ECC08C5DE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 00:01:12 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e8so16970971pgc.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 00:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nTHtSjVLQHeLSy0uqm8S4L9uEdI8s7cHTYuNr/RgjU4=;
        b=ZYUgITlCyYLwvoccNm5Op0BVJOu48KNGbkGelaKJSplcATNZjAyMv4yUD22K4JLAvF
         o2jccECA9kTPkAwq7NQRm0+nLKYroBEYw0LeqKIm8/nf8ZQv4OUdVSrg/qhCpyP71Qtt
         xuHPXc519c8Svisi7KdcUBxlw0dchUydJkCgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nTHtSjVLQHeLSy0uqm8S4L9uEdI8s7cHTYuNr/RgjU4=;
        b=KCJUZTWPKGoWs5/EBWW8R5VJNchwEHYVqNcYaATVOfajgfB4vasnttNbgvqOxralQ6
         BdH+/fKRiLq22YVZ4mI0CDAZtXG9lVpYuX7rZ+gcbu0aoFyWdlcqecgR77sVGdutyY3m
         9CdPmgxjkzjhT+m5XWk6hOOzc1XmHxlKxiiBC5Ey7DQ8hF/ABli058S9OCc+gEQYO3s3
         r7EEI8/Gdj/AAdxt9EAzl1CLGw/EJnmFOpoMZ2YHE0Uh5ohX4/OBuz4ZKSI5nA+Nqhd9
         +RUcbjRGr2u8OUu2qmcKfJRcdOgBpTg7S9aS6yVUA1kEeb4aqr60+Kua0f7twdzDbAeD
         vupQ==
X-Gm-Message-State: AOAM530MJW3tXcoHeeejrzBPVubjmaoNiAqSflP8d3CefpvvR68YtDnV
        9LIiCkXsm/clDnC1RwvO0yaXmg==
X-Google-Smtp-Source: ABdhPJyEd3dqAnjdX5X0B1CLAKee5RybaEyD8kgsnX6V5YlPld+U/ysl/B0SAcaccskQ2/uMT+wjbg==
X-Received: by 2002:a62:7650:: with SMTP id r77mr28964787pfc.235.1593932471622;
        Sun, 05 Jul 2020 00:01:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j16sm15909514pfr.100.2020.07.05.00.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 00:01:10 -0700 (PDT)
Date:   Sun, 5 Jul 2020 00:01:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests/seccomp: Check ENOSYS under tracing
Message-ID: <202007050000.40DCED12@keescook>
References: <20200705061232.4151319-1-keescook@chromium.org>
 <20200705061232.4151319-4-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200705061232.4151319-4-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 04, 2020 at 11:12:32PM -0700, Kees Cook wrote:
> There should be no difference between -1 and other negative syscalls
> while tracing.
> 
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Will Drewry <wad@chromium.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Keno Fischer <keno@juliacomputing.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 966dec340ea8..bf6aa06c435c 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -1973,6 +1973,32 @@ FIXTURE_TEARDOWN(TRACE_syscall)
>  	teardown_trace_fixture(_metadata, self->tracer);
>  }
>  
> +TEST(negative_ENOSYS)
> +{
> +	/* Untraced negative syscalls should return ENOSYS. */
> +	errno = 0;
> +	EXPECT_EQ(-1, syscall(-1));
> +	EXPECT_EQ(errno, ENOSYS);
> +	errno = 0;
> +	EXPECT_EQ(-1, syscall(-101));
> +	EXPECT_EQ(errno, ENOSYS);
> +}
> +
> +TEST_F(TRACE_syscall, negative_ENOSYS)
> +{
> +	/*
> +	 * There should be no difference between an "internal" skip
> +	 * and userspace asking for syscall "-1".
> +	 */
> +	errno = 0;
> +	EXPECT_EQ(-1, syscall(-1));
> +	EXPECT_EQ(errno, ENOSYS);
> +	/* And no difference for "still not valid but not -1". */
> +	errno = 0;
> +	EXPECT_EQ(-1, syscall(-101));
> +	EXPECT_EQ(errno, ENOSYS);
> +}
> +

I realized after sending this that the second function could just be:

+TEST_F(TRACE_syscall, negative_ENOSYS)
+{
+	negative_ENOSYS(_metadata);
+}

:)

>  TEST_F(TRACE_syscall, syscall_allowed)
>  {
>  	/* getppid works as expected (no changes). */
> -- 
> 2.25.1
> 

-- 
Kees Cook
