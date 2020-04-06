Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B696C2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 06:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B66206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 06:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgDFGZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 02:25:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48601 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgDFGZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 02:25:01 -0400
Received: from mail-lf1-f69.google.com ([209.85.167.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1jLLBr-0008Fb-2N
        for linux-kernel@vger.kernel.org; Mon, 06 Apr 2020 06:24:59 +0000
Received: by mail-lf1-f69.google.com with SMTP id b16so4916544lfb.19
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 23:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ise8WB4LRl+1spcOs3F4DjReORuX4aKlSFdb77NCTb4=;
        b=oWWfTKezTgYaPbQUlQ/VQu3P63BcSNMl8eNYntccpFhhhHDp+xh9lorf95tQ96eT0T
         6ij4N1CGXas2hAEuStOu5vNsf8g5Xvp0KAQG02kwT0maiRTm8bVoB4Maa1ivBt1oEJge
         NjnTyZITuTvweEy/QkfFaIq5V3dSN7u13NBvjzSGf0KP24OeLf0tBvQFMbMocBptJSSS
         Zjj9rTrhrcNiyr15sMvp549Lz7Wq1qQwf2zSFKmsqyyIrlkKLrFCifKsElOFlXqSChtZ
         eEGNW7/ZGl9V2fyoj1ZDFAoRUYQfF65DZ0wfeJDjk/DirWpqNopLk1Qj3Arx0a06mzWA
         6iDw==
X-Gm-Message-State: AGi0Pub0IrNaljRvzgCl13fNHWCGT+wx+sBrQB5VMsKUNS6o+sEkKHBV
        Q/0D8DAOpjr5SnDhGcWU5h+OvNiAIaaGoF+mSbdqra4T9HryZ7gdrMeD+tPYTspsiquCBEhc43O
        ai6jObLHlZGiS8a3CMbcrnF6Kc6/n6s0TNnUdbtG+wEy1DNK4lf9echXX
X-Received: by 2002:a2e:b5b2:: with SMTP id f18mr10630834ljn.136.1586154298524;
        Sun, 05 Apr 2020 23:24:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypLknrn4eH27Rcgb0jVh8EDXWocACeNuBZt1r2IrlCa/6rD5lG/hFhrhEnjD0tVOq1ce+J+HhjD+4A8KeoX660c=
X-Received: by 2002:a2e:b5b2:: with SMTP id f18mr10630818ljn.136.1586154298241;
 Sun, 05 Apr 2020 23:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200225165749.6399-1-po-hsu.lin@canonical.com> <6e13759d-370f-6cd3-34a7-08f2a9b6c0f0@kernel.org>
In-Reply-To: <6e13759d-370f-6cd3-34a7-08f2a9b6c0f0@kernel.org>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Mon, 6 Apr 2020 14:24:46 +0800
Message-ID: <CAMy_GT_kAeMX51N_Ujh8nRB44KNG99xMx0mpRXt1Lj0gkLQR-A@mail.gmail.com>
Subject: Re: [PATCHv2] selftests/timers: Turn off timeout setting
To:     shuah <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, sboyd@kernel.org,
        tglx@linutronix.de, John Stultz <john.stultz@linaro.org>,
        joe.lawrence@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch V3 re-submitted, thanks!
https://lore.kernel.org/linux-kselftest/20200318024215.5270-1-po-hsu.lin@canonical.com/T/#u

On Sat, Mar 14, 2020 at 1:41 AM shuah <shuah@kernel.org> wrote:
>
> On 2/25/20 9:57 AM, Po-Hsu Lin wrote:
> > The following 4 tests in timers can take longer than the default 45
> > seconds that added in commit 852c8cbf (selftests/kselftest/runner.sh:
> > Add 45 second timeout per test) to run:
>
> Please use the commit format:
>
> commit 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second
> timeout per test")
>
> >    * nsleep-lat - 2m7.350s
> >    * set-timer-lat - 2m0.66s
> >    * inconsistency-check - 1m45.074s
> >    * raw_skew - 2m0.013s
> >
> > Thus they will be marked as failed with the current 45s setting:
> >    not ok 3 selftests: timers: nsleep-lat # TIMEOUT
> >    not ok 4 selftests: timers: set-timer-lat # TIMEOUT
> >    not ok 6 selftests: timers: inconsistency-check # TIMEOUT
> >    not ok 7 selftests: timers: raw_skew # TIMEOUT
> >
> > Disable the timeout setting for timers can make these tests finish
> > properly:
> >    ok 3 selftests: timers: nsleep-lat
> >    ok 4 selftests: timers: set-timer-lat
> >    ok 6 selftests: timers: inconsistency-check
> >    ok 7 selftests: timers: raw_skew
> >
> > https://bugs.launchpad.net/bugs/1864626
> Please add Fixes tag with commit 852c8cbf34d3
> ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
> > Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> > ---
> >   tools/testing/selftests/timers/Makefile | 1 +
> >   tools/testing/selftests/timers/settings | 1 +
> >   2 files changed, 2 insertions(+)
> >   create mode 100644 tools/testing/selftests/timers/settings
> >
> > diff --git a/tools/testing/selftests/timers/Makefile b/tools/testing/selftests/timers/Makefile
> > index 7656c7c..0e73a16 100644
> > --- a/tools/testing/selftests/timers/Makefile
> > +++ b/tools/testing/selftests/timers/Makefile
> > @@ -13,6 +13,7 @@ DESTRUCTIVE_TESTS = alarmtimer-suspend valid-adjtimex adjtick change_skew \
> >
> >   TEST_GEN_PROGS_EXTENDED = $(DESTRUCTIVE_TESTS)
> >
> > +TEST_FILES := settings
> >
> >   include ../lib.mk
> >
> > diff --git a/tools/testing/selftests/timers/settings b/tools/testing/selftests/timers/settings
> > new file mode 100644
> > index 0000000..e7b9417
> > --- /dev/null
> > +++ b/tools/testing/selftests/timers/settings
> > @@ -0,0 +1 @@
> > +timeout=0
> >
>
> thanks,
> -- Shuah
