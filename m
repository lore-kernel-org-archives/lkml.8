Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CB0C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8C52074D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LH9JP/lf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387547AbgCKW6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:58:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46569 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387529AbgCKW6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:58:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id n15so4884655wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 15:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=LhV+oD/2AhMqGMdaGE0+K30kltGWEYirtopneq14RXk=;
        b=LH9JP/lfNN5+Q63evppzWVWUDG5AxrPRN3YR8XWBwwxz1LM/GdgM+7dPf1dxGbEYBF
         R5zv1UEDFZsPrFF5dQF35lJteQ7ceVdzXr8t/A85VEhB8hMaOam/oGo3/+AzdikWxlVt
         W1+JURZoW/A0hN0ynxDi6xiRtpWckrkseBZ43f+2oe3SalY3G5jqrvGKAxGsV2wKGwki
         TdgGppX9g+0wjFRHU9p5lgl+/t/1NsQCTKwV2MencD2a5lHP1P5f6LKChT4e/2C0n0WA
         NuOpK+jKGqRir1kqn0jy/+y7OcqLPf0241phJ93V3wV7M2T67gAKpXQtmVvPlqyWYgx+
         dGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=LhV+oD/2AhMqGMdaGE0+K30kltGWEYirtopneq14RXk=;
        b=guFIhIgFC4dB+/5/oWqD0vsuhnLLO75s5o6C2bNRiM3eeykYcJ6KJ6iXa2TFkPB39G
         hFG3ilJWphx3575TYIPryMX2sbCyo4BqxOqu6JgApifSsLzYm4I5aOpj8GHkUOOxaf9P
         nyPhxHabsm9UbJzHTbfUivwlwQPbtDdik9Pj9pgK3r215PrmjNNh3kBSqvPb7c1gS/To
         XqGrhWm8v39BqsM9qYXBoDt0EuW8kroGs06Uwkn9+bUYApb5Wak1TSBf1EkLxNZ92AVP
         ALAjm2902F9zApPktpG/GtpF90rNs/l7llMYPrIq2Fvtm/+U1Eh4PnbuEDpnooEaxbBd
         cpQg==
X-Gm-Message-State: ANhLgQ3SCTdS7FQ511MHQwBVORrj9pXiNKthDlUmL/U0m2XuBKvV6zsk
        DJGNQ6Wvs7JfuCG2l0kP+r4t+A==
X-Google-Smtp-Source: ADFU+vuYCoeev32raDtVBQgFtQVnnks9GLKDxykXkz5bdn3zGW+CgiEt0eRHhuu9gT7ZP5zKLIS06w==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr6652319wrk.407.1583967510997;
        Wed, 11 Mar 2020 15:58:30 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id t6sm18576401wrr.49.2020.03.11.15.58.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Mar 2020 15:58:30 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, mpe@ellerman.id.au,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] selftests: Fix kselftest O=objdir build from cluttering top level objdir
In-Reply-To: <58d954867391c90fe0792d87e09a82bda26ba4fc.1583358715.git.skhan@linuxfoundation.org>
References: <cover.1583358715.git.skhan@linuxfoundation.org> <58d954867391c90fe0792d87e09a82bda26ba4fc.1583358715.git.skhan@linuxfoundation.org>
Date:   Wed, 11 Mar 2020 15:58:27 -0700
Message-ID: <7hwo7qijn0.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shuah Khan <skhan@linuxfoundation.org> writes:

> make kselftest-all O=objdir builds create generated objects in objdir.
> This clutters the top level directory with kselftest objects. Fix it
> to create sub-directory under objdir for kselftest objects.
>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Only somewhat related to this patch, another problem that wasn't in your
doci is that the current O= support doesn't support relative paths.

For example, using O=/tmp/build-arm64 works, but O=build-arm64 doesn't.
Try this:

$ make ARCH=arm64 HOSTCC=gcc CROSS_COMPILE=aarch64-linux-gnu- O=build-arm64 defconfig
$ make ARCH=arm64 HOSTCC=gcc CROSS_COMPILE=aarch64-linux-gnu- O=build-arm64 kselftest-all
make[1]: Entering directory '/work/kernel/linux/build-arm64'
make --no-builtin-rules INSTALL_HDR_PATH=$BUILD/usr \
	ARCH=arm64 -C ../../.. headers_install
make[4]: ../scripts/Makefile.build: No such file or directory
make[4]: *** No rule to make target '../scripts/Makefile.build'.  Stop.
Makefile:500: recipe for target 'scripts_basic' failed
make[3]: *** [scripts_basic] Error 2
Makefile:151: recipe for target 'khdr' failed
make[2]: *** [khdr] Error 2
/work/kernel/linux/Makefile:1220: recipe for target 'kselftest-all' failed
make[1]: *** [kselftest-all] Error 2
make[1]: Leaving directory '/work/kernel/linux/build-arm64'
Makefile:179: recipe for target 'sub-make' failed
make: *** [sub-make] Error 2  

Kevin

> ---
>  tools/testing/selftests/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 6ec503912bea..cd77df3e6bb8 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -91,7 +91,7 @@ override LDFLAGS =
>  override MAKEFLAGS =
>  endif
>  
> -# Append kselftest to KBUILD_OUTPUT to avoid cluttering
> +# Append kselftest to KBUILD_OUTPUT and O to avoid cluttering
>  # KBUILD_OUTPUT with selftest objects and headers installed
>  # by selftests Makefile or lib.mk.
>  ifdef building_out_of_srctree
> @@ -99,7 +99,7 @@ override LDFLAGS =
>  endif
>  
>  ifneq ($(O),)
> -	BUILD := $(O)
> +	BUILD := $(O)/kselftest
>  else
>  	ifneq ($(KBUILD_OUTPUT),)
>  		BUILD := $(KBUILD_OUTPUT)/kselftest
> -- 
> 2.20.1
