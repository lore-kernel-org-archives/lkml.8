Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE40C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39EAA2075A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A/y/YbQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgHEUkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgHEUkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 16:40:18 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CB6C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 13:40:18 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id t11so20756549pfq.21
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 13:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=g0zLcPjjUpPWGBIkwFBQkzsGpvqT4KeB0aZcM7LEpSk=;
        b=A/y/YbQtCUUfPAMdDBbhqzHyx0/ZLv+jQwbLPf8SVVXgyLVRWdtvLir18Hnyz3Sg2Y
         t0f889clZXXBlnJXIs4Y2anSeE+7LuP98YTSlknvOBVxcgxONPaYlsYij5Or6YHFzWqa
         hpZFkyIiWGexCfLT2Zw0m2VzA1sr/GWCoW82Kz8gQIToT35tTH9Mm/gbDFvI7ZhPHOj0
         t1YK7El3dSHUOyR51mYogogwAxdf2YMPr0dhUUGT6qmTToUIfWD/CzwTATXjlK7Iu99g
         6tulkjdyKLIqvdU/ExgYOc4bYHR5QmuMYORH3fXnJQbf1OTAreDfSM6XutvmeI+ghPoc
         tl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=g0zLcPjjUpPWGBIkwFBQkzsGpvqT4KeB0aZcM7LEpSk=;
        b=ewJmU5qY1xcC+DLLbK7hm+/Zbx1Hk0Jtvv5nSdTaTT6CzcdM/Mz0f8Hmi3U0v8aMOY
         +kNEPcmZE3oRmbkfjI1W5SNfUSHaERlL5I/Ld82XqsZRjmN4SAsuwW5adyWwmncl1LAO
         uSmW4jtLz4hXRionaLzMLYtLfsa4um3pAhPKFs+0z6Ja/d4MLUexSzF9RJovhjy8aIEO
         uKn4nBNqvrjcLB8IMsfX8yP2zQgu/xo4N1qCCcnqWqFwUtPqSM8UYeywk6vkCjgHbheo
         VMSvku6thfT9P6IcOS5XZhQ7Tb/rzUD5D00hCPWuyxTAQDecYDPXiBjHfb6TXsh8R+k8
         Xm6Q==
X-Gm-Message-State: AOAM531Zqf1JyyRX7zw5V0rskmJgRyXyxg2FfBpGDC0HdfKHM62LHhee
        VuD0uO4G55v//VbHDpxH6yo3SxpuaGel
X-Google-Smtp-Source: ABdhPJzCEKGmfgHogxsqzR1mNow9fh0Atsi/jvOkuMPdYytaTgY2ZO9ZFy32GZqCo0Ycn97x2OZnH+iDHMMF
X-Received: by 2002:a17:902:b787:: with SMTP id e7mr4651752pls.227.1596660017673;
 Wed, 05 Aug 2020 13:40:17 -0700 (PDT)
Date:   Wed, 05 Aug 2020 13:40:15 -0700
In-Reply-To: <3d949545-a7f2-4057-1204-600eabfd8f28@linuxfoundation.org>
Message-Id: <xr93zh78bzdc.fsf@gthelen.svl.corp.google.com>
Mime-Version: 1.0
References: <20200728073241.3625015-1-gthelen@google.com> <CAHH2K0bU7w_rbKN_f0Fe_ZdGLtgBz_GVKS3eottTtm8P7QGoJA@mail.gmail.com>
 <3d949545-a7f2-4057-1204-600eabfd8f28@linuxfoundation.org>
Subject: Re: [PATCH] selftests: more general make nesting support
From:   Greg Thelen <gthelen@google.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 8/5/20 1:36 PM, Greg Thelen wrote:
>> On Tue, Jul 28, 2020 at 12:32 AM Greg Thelen <gthelen@google.com> wrote:
>>>
>>> selftests can be built from the toplevel kernel makefile (e.g. make
>>> kselftest-all) or directly (make -C tools/testing/selftests all).
>>>
>>> The toplevel kernel makefile explicitly disables implicit rules with
>>> "MAKEFLAGS +=3D -rR", which is passed to tools/testing/selftests.  Some
>>> selftest makefiles require implicit make rules, which is why
>>> commit 67d8712dcc70 ("selftests: Fix build failures when invoked from
>>> kselftest target") reenables implicit rules by clearing MAKEFLAGS if
>>> MAKELEVEL=3D1.
>>>
>>> So far so good.  However, if the toplevel makefile is called from an
>>> outer makefile then MAKELEVEL will be elevated, which breaks the
>>> MAKELEVEL equality test.
>>> Example wrapped makefile error:
>>>    $ cat ~/Makefile
>>>    all:
>>>          $(MAKE) defconfig
>>>          $(MAKE) kselftest-all
>>>    $ make -sf ~/Makefile
>>>      futex_wait_timeout.c /src/tools/testing/selftests/kselftest_harnes=
s.h   /src/tools/testing/selftests/kselftest.h ../include/futextest.h ../in=
clude/atomic.h ../include/logging.h -lpthread -lrt -o /src/tools/testing/se=
lftests/futex/functional/futex_wait_timeout
>>>    make[4]: futex_wait_timeout.c: Command not found
>>>
>>> Rather than checking $(MAKELEVEL), check for $(LINK.c), which is a more
>>> direct side effect of "make -R".  This enables arbitrary makefile
>>> nesting.
>>>
>>> Signed-off-by: Greg Thelen <gthelen@google.com>
>>> ---
>>>   tools/testing/selftests/Makefile | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests=
/Makefile
>>> index 1195bd85af38..289a2e4b3f6f 100644
>>> --- a/tools/testing/selftests/Makefile
>>> +++ b/tools/testing/selftests/Makefile
>>> @@ -84,10 +84,10 @@ endif
>>>   # of the targets gets built.
>>>   FORCE_TARGETS ?=3D
>>>
>>> -# Clear LDFLAGS and MAKEFLAGS if called from main
>>> -# Makefile to avoid test build failures when test
>>> -# Makefile doesn't have explicit build rules.
>>> -ifeq (1,$(MAKELEVEL))
>>> +# Clear LDFLAGS and MAKEFLAGS when implicit rules are missing.  This p=
rovides
>>> +# implicit rules to sub-test Makefiles which avoids build failures in =
test
>>> +# Makefile that don't have explicit build rules.
>>> +ifeq (,$(LINK.c))
>>>   override LDFLAGS =3D
>>>   override MAKEFLAGS =3D
>>>   endif
>>> --
>>> 2.28.0.rc0.142.g3c755180ce-goog
>>=20
>> Is there any feedback on this patch?  It's not high priority but somethi=
ng that
>> will help me make more use of selftests.
>>=20
>
> No issues with the patch. I will apply it once the merge window ends.
>
> thanks,
> -- Shuah

Great.  Thank you.
