Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A9FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4085F20702
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AIYwRD6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgFZPug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgFZPuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:50:35 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC671C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:50:35 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s1so10873045ljo.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gk7pt4o52R1i8UxPya9K/JTWryM486pinPKkTZZgiYo=;
        b=AIYwRD6MrE8AA7Ha12CddBuKx+00cURYa3xqNdHtCTmTW6RwVBMoR2saeKN//BMwdd
         1xn80jwdYnoAmfgvlsGrSChT0+xcx79vwYvma+GGVruZ/zYG9sb7D+R1o3oieOJoxHdG
         +kG1ZfV+LyJF56gGqqXi19Y57JW1r1QXW+VynSq89mzSz/YtugCUI3qUnEDKUaH3RAcl
         m6dNKfNHus0xeiqMTgRMganFy1wOYQJzHS/qCZ6nkY/pLph6RXjPCxWfFuAARtLTCZen
         JxsBSnD7V3y43vppubOalQ1RJoFHfRqSHxI7WiVGbSFYt4GHYllGuk01AnBqWKNuh0wE
         YWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gk7pt4o52R1i8UxPya9K/JTWryM486pinPKkTZZgiYo=;
        b=eyArJTBpZVzsZpKHmO5ozpjnXuwLX7VIcCzSYDYlMpjMFNCgC5eZyzdmCiPcysIznT
         CtBcmHCjb/G6CAqAoyLwHTKaldou+ZC08bafpf2FxFAw0o/loO+Vntx8Bx58pTfQsOIY
         C29NfZXCAzko8A2RW0kcs6nvXgNNUAWkI+syExuDwNRFYhbGSJ2+xUWKC5ZaaFYSI3D3
         MqdAQ/C1lXSlbH6nXcYMIjDJgbyO+aQTX+5AWqorWMZ5GgX4xTB9ME6Fn/64BBqTzZX8
         wIuywMPmDP9ULealSMPWUW/CF7xMqTinn7yxa+pU5NO8n/UL3dYQynk5KnYGx4fK5CAP
         JNBw==
X-Gm-Message-State: AOAM530lrX1UwFaWn1LPq45HHxi8VekI0hj7Hmdk+qgjfUJwrorJWauT
        hVg/GOtV9OJcMBdQiaj8cy9GzzaINd4AWMykaHpnuw==
X-Google-Smtp-Source: ABdhPJy007mkSDmCwqlRe0fuiCkW8krkuhDJ/3AKsVcjZLlDeZrfFysXPMdILGkTR9Zmd6tfShRU1ijZRDNdeUmnAwo=
X-Received: by 2002:a2e:9116:: with SMTP id m22mr1780104ljg.431.1593186634379;
 Fri, 26 Jun 2020 08:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200508065356.2493343-1-mpe@ellerman.id.au> <CA+G9fYtHP+Gg+BrR_GkBMxu2oOi-_e9pATtpb6TVRswv1G1r1Q@mail.gmail.com>
 <202006242312.8888AAFE@keescook>
In-Reply-To: <202006242312.8888AAFE@keescook>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 26 Jun 2020 21:20:22 +0530
Message-ID: <CA+G9fYtdF__9bGneXkuv3E7djg1rbhrQ=DCf6d7_t9hyBZRL2g@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests/lkdtm: Don't clear dmesg when running tests
To:     Kees Cook <keescook@chromium.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
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

On Thu, 25 Jun 2020 at 11:46, Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jun 22, 2020 at 02:21:38PM +0530, Naresh Kamboju wrote:
> > On Fri, 8 May 2020 at 12:23, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > >  # Record and dump the results
> > > -dmesg -c >"$LOG"
> > > +dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$DMESG" - > "$LOG" || true
> >
> > We are facing problems with the diff `=%>` part of the option.
> > This report is from the OpenEmbedded environment.
> > We have the same problem from livepatch_testcases.
>
> Does "comm" exists in those environments?
>
> dmesg | comm -13 "$DMESG" - > "$LOG" || true

"comm" works in our environment.

- Naresh
