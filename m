Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C55DC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 19:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD85E2071B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 19:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YDStaEX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgC0TC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 15:02:29 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38961 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgC0TC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 15:02:29 -0400
Received: by mail-pj1-f66.google.com with SMTP id z3so3630636pjr.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 12:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gLHLJMBxOTqwCxIgz1nbKQaYKpREIN6QpIXiV+9902w=;
        b=YDStaEX6FW0zeNHrPj8m5tYTTJAFB0UA+l8BOnvVb0iWm3a2YpwQubFnKtxYdiX6wc
         rdc2I0NTNRFu9hkGqsPXL+f+i9piCA2FERCHSuuvGJefKvUhJcv9F0NLyIqWr80Ca13l
         opXmkVW4bQ0uyg0kgllCYZ2YxRazlzUna1Sf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gLHLJMBxOTqwCxIgz1nbKQaYKpREIN6QpIXiV+9902w=;
        b=NV96lCDTwkirFvBJicQZ2rHKB2dEksH7elFMgk4Gk9IkKyHcQ+O7LfccdVwyLPIB7y
         NNi48cKZg2joKCWVdgDo9DlPnz7w9MwHyxNnwRdzEAvfAKunuUt+MRcV37Nf9mHcIiXy
         FegrLLoxXj7BKRYSEyBnmH/00a7l6LQ39meKoeaAudkXU3UiXc6itiSwIRBPj7p4wR2N
         e790A5xLw8tk5YPKJXHuNxVsFmlh8IHlLrI0xIw3AnEhXKbXl1L5yb/FWO/nmMM7vNpU
         j5oh+PG6Idhj7Th52jB9NStk8uQ5/yEoqvKbIqITivbSaI84N0FK6m+FlZpQkiO8fYaI
         N37g==
X-Gm-Message-State: ANhLgQ1ETkg1CxLtqviOgUUze7SiGRJakHa7cMR0SEwaKJiOARonSVnJ
        jM884Nc6eYOXEYcq+OJnU15P1g==
X-Google-Smtp-Source: ADFU+vvwfXD92DVjRTRsBC244V6nBLBIIAKRK9iqmRYmCFZehEyPmSFv30qn1E9v5K5oldZejZ3zow==
X-Received: by 2002:a17:90a:2307:: with SMTP id f7mr926623pje.152.1585335746985;
        Fri, 27 Mar 2020 12:02:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f15sm4696400pfq.100.2020.03.27.12.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 12:02:26 -0700 (PDT)
Date:   Fri, 27 Mar 2020 12:02:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] selftests/harness: fix spelling mistake "SIGARLM"
 -> "SIGALRM"
Message-ID: <202003271202.123FD50@keescook>
References: <20200327090648.13387-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327090648.13387-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 09:06:48AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There a few identical spelling mistakes, fix these.

Argh, thanks Colin!

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  tools/testing/selftests/kselftest_harness.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 2902f6a78f8a..2bb8c81fc0b4 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -705,7 +705,7 @@ static void __timeout_handler(int sig, siginfo_t *info, void *ucontext)
>  	/* Sanity check handler execution environment. */
>  	if (!t) {
>  		fprintf(TH_LOG_STREAM,
> -			"no active test in SIGARLM handler!?\n");
> +			"no active test in SIGALRM handler!?\n");
>  		abort();
>  	}
>  	if (sig != SIGALRM || sig != info->si_signo) {
> @@ -731,7 +731,7 @@ void __wait_for_test(struct __test_metadata *t)
>  	if (sigaction(SIGALRM, &action, &saved_action)) {
>  		t->passed = 0;
>  		fprintf(TH_LOG_STREAM,
> -			"%s: unable to install SIGARLM handler\n",
> +			"%s: unable to install SIGALRM handler\n",
>  			t->name);
>  		return;
>  	}
> @@ -743,7 +743,7 @@ void __wait_for_test(struct __test_metadata *t)
>  	if (sigaction(SIGALRM, &saved_action, NULL)) {
>  		t->passed = 0;
>  		fprintf(TH_LOG_STREAM,
> -			"%s: unable to uninstall SIGARLM handler\n",
> +			"%s: unable to uninstall SIGALRM handler\n",
>  			t->name);
>  		return;
>  	}
> -- 
> 2.25.1
> 

-- 
Kees Cook
