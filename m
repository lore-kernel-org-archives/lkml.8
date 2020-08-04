Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609A9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B48622BED
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B9eGnGTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgHDVib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgHDVia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:38:30 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7057DC061756
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 14:38:30 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id v6so20946780ota.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 14:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ltGWhVbBQmoMJQxXzeUdQQN1MfVzQ7ab4b8nH39r8L0=;
        b=B9eGnGTcjww04rHKTPDCcTONe4cq8snHL3pSdZOCwVy1vlvh9AVH8UPknxhUOl+J4b
         5PE0tmI9oWfn0+O+CDKoM6HFoD8EOHbHn7I1KH6zNLvoRvaFTnPG0JVJinKcLuXr7lay
         2JeaBaXqqwE1JBIodxMnkLmgCeMSHIQQEB4vphbnPkp2lX14N6qJm7FW1lSjPDxIzLv4
         wz4Nm49vaPQ4EoGsau1/fn8iHg4FWY91uw5XT31aq4pezYHcAkqDg/iirJ8fugSOowLH
         V0CLuGCqREbAFCGbXq3b03XucmMJL2Re1syLku+bJuLYwiCKRhLzNlapAGY0ngGN2Yjy
         O0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ltGWhVbBQmoMJQxXzeUdQQN1MfVzQ7ab4b8nH39r8L0=;
        b=DOTn8oOiBjK+oTZPYTa/YVQEg9tdZX+w9SsJ5x2r8ZwyqyKw2sQQAnjOExLOYfiF4Y
         ANlY7Trh9D1bZkojSlDBVvztkND/zONCqDyZdxBWYfcPIOrTlmTzTgQMopKw0ne+W9ql
         aQzT5zelsvHJXAv01pbHSWT7bURC/yQFb09EaIXFuxd+6waPaBw6xqom2sIuSYVLu5Vp
         bM0GXU7TyXkMTDKeNSgbdNPdco+/YvYxqLXuvailTncIVhUY7ggX8BBGmVx7JLYKSiDh
         8r0cIuFbYJ7dfkUP4ndgST0vo7pVZrbZDKSiQNoeWDFv3VjWXOF+gJI1EsK+4GXvezeu
         7/Uw==
X-Gm-Message-State: AOAM532bLmoieyBdqyxMu+geDgBrgIBBkXj56NB4AOhJ6qcWBmPcJKnA
        MdnSCIIpeuHh52ofg/EkIr2P2o/5J4Nc08YC5nXwPw==
X-Google-Smtp-Source: ABdhPJz94pvA7KXC3a6ccaxQ/g1lxKtRWKR7xfxabIEVOdCrrJeT+1+32hIwUzPt6U5xruhbBC5UqyCmlkYppx2GAac=
X-Received: by 2002:a9d:5504:: with SMTP id l4mr59096oth.221.1596577109734;
 Tue, 04 Aug 2020 14:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200318024215.5270-1-po-hsu.lin@canonical.com>
In-Reply-To: <20200318024215.5270-1-po-hsu.lin@canonical.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 4 Aug 2020 14:38:17 -0700
Message-ID: <CALAqxLVyjj23S2Wm2XFAvCJph58_rVb4iteq3TFC14jYR_88Gw@mail.gmail.com>
Subject: Re: [PATCHv3] selftests/timers: Turn off timeout setting
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, joe.lawrence@redhat.com,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 7:42 PM Po-Hsu Lin <po-hsu.lin@canonical.com> wrote:
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

Apologies for missing this before.  I've not tested with this, but it
sounds sane to me. A number of the timekeeping tests do take a while
to run.

Acked-by: John Stultz <john.stultz@linaro.org>

thanks
-john
