Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2F7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF09D206C1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g1brCWmw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgFVIvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgFVIvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:51:53 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754FAC061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 01:51:52 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id n23so18317608ljh.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 01:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5iSOzHwBaotY/UIRNioAEBuXDPVG7zu4qxXMNrK9fyc=;
        b=g1brCWmwJtbkSmFV9tqet1ryr9ApeCcCobA98O+cU+FVDj94qF4u9u0ipyjv7QP2qo
         21prTrr4rLVKagZO1Ra+ay+gNxNr917nLzNVLjeCbu4H8rSqpfyjR3kLirlWPjVNhK+T
         6QeOABhjPryupAkfoIxNCmCs1oKwrRJYxQQUcWvqw0So+1UGczY8TbVrX0AdRZxSHDUO
         UIR2+jQozywcAJJqc3Mlk6cLafjWJ1imBHjeftPy7Mr7Ml7HMaV+jqn/W2D4waHIkcom
         J1L6fq9amVsuNkhjxaOkV2BUbByvpCXBuzl8LU/7fNF4G3bmFcAly/3OtqShrxr7ehiG
         TyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5iSOzHwBaotY/UIRNioAEBuXDPVG7zu4qxXMNrK9fyc=;
        b=siuZT0UxidXTeoo9El6DK/e+Qzsn/ShO8JUi4+amnWl7kTvyZ1odp2oGSrB8TArudJ
         v6QtQ9W1BHhXFevkvfm9lvGLQxENu8Sl7CxYB5FHkBcCNMRWh9zKx1La+Omx9LqJ8cwI
         uafOyV5KDsmLdsjWre8JiI6HmHZwupbcBRrvnLvHJAbVmlmk74RD3CJOGSEdI2UVcYpv
         u2Ff7+M88xZvb+Fvv5WS9Odm+a55XU1bfSIwCa6HFtRYyV15EzJYKUl/F6ZPZZ58lymx
         /8WhX3ras02/rlugcVgBYkDW1XFlwsB19QS9Wo0nbDj+CaSUGgkiUSZrne0anpGk9urv
         hmBA==
X-Gm-Message-State: AOAM530jqEe7eNG0K6UKsWFu6fN206cSYEilpnBbhEXafV5L3iOhwmcZ
        y9ErayBfMlvkHMIC+4a56RdYG/IIN0/X4cH+j7zSkA==
X-Google-Smtp-Source: ABdhPJzPcxI7lreAQVQmWGeoQhl8ktN6/1zLDkgbhAhAe090FX+hV8+nsH6dFhqYb8sndBXmAohGrA73QF7C0Ox0Zno=
X-Received: by 2002:a05:651c:318:: with SMTP id a24mr7713808ljp.55.1592815910815;
 Mon, 22 Jun 2020 01:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200508065356.2493343-1-mpe@ellerman.id.au>
In-Reply-To: <20200508065356.2493343-1-mpe@ellerman.id.au>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 22 Jun 2020 14:21:38 +0530
Message-ID: <CA+G9fYtHP+Gg+BrR_GkBMxu2oOi-_e9pATtpb6TVRswv1G1r1Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests/lkdtm: Don't clear dmesg when running tests
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        Justin Cook <justin.cook@linaro.org>,
        lkft-triage@lists.linaro.org, Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 May 2020 at 12:23, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> It is Very Rude to clear dmesg in test scripts. That's because the
> script may be part of a larger test run, and clearing dmesg
> potentially destroys the output of other tests.
>
> We can avoid using dmesg -c by saving the content of dmesg before the
> test, and then using diff to compare that to the dmesg afterward,
> producing a log with just the added lines.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  tools/testing/selftests/lkdtm/run.sh | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
> index dadf819148a4..0b409e187c7b 100755
> --- a/tools/testing/selftests/lkdtm/run.sh
> +++ b/tools/testing/selftests/lkdtm/run.sh
> @@ -59,23 +59,25 @@ if [ -z "$expect" ]; then
>         expect="call trace:"
>  fi
>
> -# Clear out dmesg for output reporting
> -dmesg -c >/dev/null
> -
>  # Prepare log for report checking
> -LOG=$(mktemp --tmpdir -t lkdtm-XXXXXX)
> +LOG=$(mktemp --tmpdir -t lkdtm-log-XXXXXX)
> +DMESG=$(mktemp --tmpdir -t lkdtm-dmesg-XXXXXX)
>  cleanup() {
> -       rm -f "$LOG"
> +       rm -f "$LOG" "$DMESG"
>  }
>  trap cleanup EXIT
>
> +# Save existing dmesg so we can detect new content below
> +dmesg > "$DMESG"
> +
>  # Most shells yell about signals and we're expecting the "cat" process
>  # to usually be killed by the kernel. So we have to run it in a sub-shell
>  # and silence errors.
>  ($SHELL -c 'cat <(echo '"$test"') >'"$TRIGGER" 2>/dev/null) || true
>
>  # Record and dump the results
> -dmesg -c >"$LOG"
> +dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$DMESG" - > "$LOG" || true

We are facing problems with the diff `=%>` part of the option.
This report is from the OpenEmbedded environment.
We have the same problem from livepatch_testcases.

# selftests lkdtm BUG.sh
lkdtm: BUG.sh_ #
# diff unrecognized option '--changed-group-format=%>'
unrecognized: option_'--changed-group-format=%>' #
# BusyBox v1.27.2 (2020-03-30 164108 UTC) multi-call binary.
v1.27.2: (2020-03-30_164108 #
#
: _ #
# Usage diff [-abBdiNqrTstw] [-L LABEL] [-S FILE] [-U LINES] FILE1 FILE2
diff: [-abBdiNqrTstw]_[-L #
# BUG missing 'kernel BUG at' [FAIL]

Full test output log,
https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200621/testrun/2850083/suite/kselftest/test/lkdtm_BUG.sh/log

-- 
Linaro LKFT
https://lkft.linaro.org
