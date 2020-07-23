Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D09C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10BD62071A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgGWJCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 05:02:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41665 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgGWJCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 05:02:04 -0400
Received: from mail-lf1-f69.google.com ([209.85.167.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1jyX73-0001S0-IY
        for linux-kernel@vger.kernel.org; Thu, 23 Jul 2020 09:02:01 +0000
Received: by mail-lf1-f69.google.com with SMTP id j5so1282755lfc.15
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 02:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U+wT4uWfBoeVxuv9M2M1SsHXGOIE2eDw5GOYNjnOws0=;
        b=KQI7abAsu+HRnDIAEQQotJaHfFsbijjKtFbOIgD+xv1B4h40j2GHtLSGeLmQRW8flh
         dEe6U9xPz+EkZ4+DdgbtV4xxI31yoWfOv7a1p9BBuIzv3DjA0yqLqkBURS6B+J9BwePl
         A3bJcNo09AWg4DhwAwqBMh9ERQZU+6oVOTnThx/QdFI+VQiXuNqFRAz5uXcp0hjtS7Iu
         y9AWOemZXQJeaIa7zFaacyf/4nhgRGfU8LcbJjZcsbpQO/YNRqe6ld1kimTrUJr4oMac
         0+T02rvheaE6X981BPFI7frQxQ2TrVJeUIE7TKwW15jfNwK/rDnOT7KjOCmT/1WQtnCz
         CF7A==
X-Gm-Message-State: AOAM532PkudQcJA1bXibznXzyRt6ATTWEysm8dJwhWOXVXrBZb+480tB
        RJFemo6yh03nDZbVKAKUN0QkCG+ruKUAOzUZ1IGF8QsvRV/7GNeZ8YAsKUXSIWTLKHUBYMUMoc0
        CKthTjlTh+KvNXF+/yNWa9m4gLuMMid4jyBoTHFGoclxEgKoK3AVuCK2G
X-Received: by 2002:a2e:9d86:: with SMTP id c6mr1497765ljj.418.1595494920939;
        Thu, 23 Jul 2020 02:02:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJd3/VfgnjFYGCdo/JmUiXjd56BUIkYcecDQxaWSkFheEj5HUm6LObhj/XQNcciCiYaWu+tCWJIVdHgz99xd0=
X-Received: by 2002:a2e:9d86:: with SMTP id c6mr1497750ljj.418.1595494920649;
 Thu, 23 Jul 2020 02:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200318024215.5270-1-po-hsu.lin@canonical.com>
In-Reply-To: <20200318024215.5270-1-po-hsu.lin@canonical.com>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Thu, 23 Jul 2020 17:01:49 +0800
Message-ID: <CAMy_GT9g48Xf=U==FeFd-8CaFM97u4WMkDBT013uzfjeqKMcfw@mail.gmail.com>
Subject: Re: [PATCHv3] selftests/timers: Turn off timeout setting
To:     linux-kselftest@vger.kernel.org
Cc:     shuah <shuah@kernel.org>, sboyd@kernel.org, tglx@linutronix.de,
        John Stultz <john.stultz@linaro.org>, joe.lawrence@redhat.com,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Adding Shuah's linuxfoundation mail)
Hello,
do you need more changes / tests for this test?

Thanks!
Po-Hsu

On Wed, Mar 18, 2020 at 10:42 AM Po-Hsu Lin <po-hsu.lin@canonical.com> wrote:
>
> The following 4 tests in timers can take longer than the default 45
> seconds that added in commit 852c8cbf34d3 ("selftests/kselftest/runner.sh:
> Add 45 second timeout per test") to run:
>   * nsleep-lat - 2m7.350s
>   * set-timer-lat - 2m0.66s
>   * inconsistency-check - 1m45.074s
>   * raw_skew - 2m0.013s
>
> Thus they will be marked as failed with the current 45s setting:
>   not ok 3 selftests: timers: nsleep-lat # TIMEOUT
>   not ok 4 selftests: timers: set-timer-lat # TIMEOUT
>   not ok 6 selftests: timers: inconsistency-check # TIMEOUT
>   not ok 7 selftests: timers: raw_skew # TIMEOUT
>
> Disable the timeout setting for timers can make these tests finish
> properly:
>   ok 3 selftests: timers: nsleep-lat
>   ok 4 selftests: timers: set-timer-lat
>   ok 6 selftests: timers: inconsistency-check
>   ok 7 selftests: timers: raw_skew
>
> https://bugs.launchpad.net/bugs/1864626
> Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> ---
>  tools/testing/selftests/timers/Makefile | 1 +
>  tools/testing/selftests/timers/settings | 1 +
>  2 files changed, 2 insertions(+)
>  create mode 100644 tools/testing/selftests/timers/settings
>
> diff --git a/tools/testing/selftests/timers/Makefile b/tools/testing/selftests/timers/Makefile
> index 7656c7c..0e73a16 100644
> --- a/tools/testing/selftests/timers/Makefile
> +++ b/tools/testing/selftests/timers/Makefile
> @@ -13,6 +13,7 @@ DESTRUCTIVE_TESTS = alarmtimer-suspend valid-adjtimex adjtick change_skew \
>
>  TEST_GEN_PROGS_EXTENDED = $(DESTRUCTIVE_TESTS)
>
> +TEST_FILES := settings
>
>  include ../lib.mk
>
> diff --git a/tools/testing/selftests/timers/settings b/tools/testing/selftests/timers/settings
> new file mode 100644
> index 0000000..e7b9417
> --- /dev/null
> +++ b/tools/testing/selftests/timers/settings
> @@ -0,0 +1 @@
> +timeout=0
> --
> 2.7.4
>
