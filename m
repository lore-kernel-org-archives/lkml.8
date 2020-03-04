Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0B7C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA46C20870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yev9FXld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbgCDKwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 05:52:46 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45876 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgCDKwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:52:46 -0500
Received: by mail-lf1-f67.google.com with SMTP id b13so1090660lfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 02:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Dw8YXGE2I3jTmAJ66a5mJGk/pXkO5jiL6BxX0YlOF4A=;
        b=yev9FXldw7OF5QP1G/bgbhJF2dehFneq2luy5DcahhSoCsqjqCvbHLylb5nebRRUIb
         Q/zK2merHFYgvVuY4Moz2OVfTr+uvviniCiYviLhSlceL2IXf9sL4dwqfOX0OzqxbDtH
         U6bFqUE0tAiVizqSi/Y9mO2LCATsSNaJkuvmF0NuvEN+ahH4DfjluGlDdgZ6OkPpevuX
         auBnnUdeO0hGYmMgclX5uAZVf3N9C7JxxCAebctT+qSBUcIY86bq6vodeSasoq/a6AHh
         W+oGlC6ejs/XlesP8xaNTq8SpoFD9GxH9h2ZgEnSu4bj6y1bIVgOaua+gdtd5KPsvN6N
         oYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Dw8YXGE2I3jTmAJ66a5mJGk/pXkO5jiL6BxX0YlOF4A=;
        b=k2Adwv4KQFDaVINOwq9o3nVs9cGcaG/dks7P7SHKfGsliYV753SfORVfQ5MEHn98wI
         t/zf7QVcGBaOxYPpZu6k94Z0Nad7qgfK+cwxFzIyRwN+wXcPmg4YPtAUctnGomK5lmEB
         w4aA93oQoNmE/LLztxXHRD9IBECLQtOPx6D7BiyfdX/o8JTJzshgim3yK5Cf0ZtaXdtK
         8Jzs7gFWdSxNVPnocmvrxz6qaV0taP3g0TDE/hJUWlbkuEIRsKySkcOpUpRS8rnZHAtX
         //NlHEsWxDUskxrHidumGSx9PC6Vp5wQZVFVSgzpNzZPRkMzfz0Esc5MUo0OVzhi6XxR
         Wywg==
X-Gm-Message-State: ANhLgQ0EHYeJLHJnvMem55iWyPT5pWxY8uZzbS4V/yyUVr3T0QNaeFLa
        x41iXS9sjU7EYkK3RAjsy9h/ibDkBi2ICAnBd8MT3w==
X-Google-Smtp-Source: ADFU+vs1yTijjyYdGtS8Q2UjYj8BrBUEgqLpP48PqmtXx1x2dl3X+u7OOLrgj99qwdC9vizbdMbmK9kjT2iH1RBqisY=
X-Received: by 2002:a05:6512:3e5:: with SMTP id n5mr1658913lfq.55.1583319161751;
 Wed, 04 Mar 2020 02:52:41 -0800 (PST)
MIME-Version: 1.0
References: <20200303174304.593872177@linuxfoundation.org> <CA+G9fYtNKXBOQKE_AD6qLoRo4TeaBYOc9Ce3kBxdLap1av4v=Q@mail.gmail.com>
 <20200304081128.GC1401372@kroah.com> <20200304084702.GA1416015@kroah.com> <20200304084946.GB1416015@kroah.com>
In-Reply-To: <20200304084946.GB1416015@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 4 Mar 2020 16:22:30 +0530
Message-ID: <CA+G9fYuTXB03s5YSn=NL0dtF-Kzj0YHUu6NwqSh6m9Hco59DPw@mail.gmail.com>
Subject: Re: [PATCH 5.5 000/176] 5.5.8-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020 at 14:19, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Mar 04, 2020 at 09:47:02AM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Mar 04, 2020 at 09:11:28AM +0100, Greg Kroah-Hartman wrote:
> > > On Wed, Mar 04, 2020 at 12:43:42PM +0530, Naresh Kamboju wrote:
> > > > On Tue, 3 Mar 2020 at 23:16, Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > This is the start of the stable review cycle for the 5.5.8 releas=
e.
> > > > > There are 176 patches in this series, all will be posted as a res=
ponse
> > > > > to this one.  If anyone has any issues with these being applied, =
please
> > > > > let me know.
> > > > >
> > > > > Responses should be made by Thu, 05 Mar 2020 17:42:06 +0000.
> > > > > Anything received after that time might be too late.
> > > > >
> > > > > The whole patch series can be found in one patch at:
> > > > >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-revie=
w/patch-5.5.8-rc1.gz
> > > > > or in the git tree and branch at:
> > > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linu=
x-stable-rc.git linux-5.5.y
> > > > > and the diffstat can be found below.
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
> > > > >
> > > >
> > > > Results from Linaro=E2=80=99s test farm.
> > > > Regressions detected on x86_64 and i386.
> > > >
> > > > Test failure output:
> > > > CVE-2017-5715: VULN (IBRS+IBPB or retpoline+IBPB+RSB filling, is
> > > > needed to mitigate the vulnerability)
> > > >
> > > > Test description:
> > > > CVE-2017-5715 branch target injection (Spectre Variant 2)
> > > >
> > > > Impact: Kernel
> > > > Mitigation 1: new opcode via microcode update that should be used b=
y
> > > > up to date compilers to protect the BTB (by flushing indirect branc=
h
> > > > predictors)
> > > > Mitigation 2: introducing "retpoline" into compilers, and recompile
> > > > software/OS with it
> > > > Performance impact of the mitigation: high for mitigation 1, medium
> > > > for mitigation 2, depending on your CPU
> > >
> > > So these are regressions or just new tests?
> > >
> > > If regressions, can you do 'git bisect' to find the offending commit?
> > >
> > > Also, are you sure you have an updated microcode on these machines an=
d a
> > > proper compiler for retpoline?
> >
> > As an example of just how crazy that script is, here's the output of my
> > machine for that first CVE issue:
> >
> > CVE-2017-5715 aka 'Spectre Variant 2, branch target injection'
> > * Mitigated according to the /sys interface:  YES  (Mitigation: Full ge=
neric retpoline, IBPB: conditional, IBRS_FW, STIBP: conditional, RSB fillin=
g)
> > * Mitigation 1
> >   * Kernel is compiled with IBRS support:  YES
> >     * IBRS enabled and active:  YES  (for firmware code only)
> >   * Kernel is compiled with IBPB support:  YES
> >     * IBPB enabled and active:  YES
> > * Mitigation 2
> >   * Kernel has branch predictor hardening (arm):  NO
> >   * Kernel compiled with retpoline option:  YES
> >     * Kernel compiled with a retpoline-aware compiler:  YES  (kernel re=
ports full retpoline compilation)
> >   * Kernel supports RSB filling:  UNKNOWN  (couldn't check (couldn't fi=
nd your kernel image in /boot, if you used netboot, this is normal))
> > > STATUS:  VULNERABLE  (IBRS+IBPB or retpoline+IBPB+RSB filling, is nee=
ded to mitigate
> >
> > So why is this "Vulnerable"?  Because it didn't think it could find my
> > kernel image for some odd reason, despite it really being in /boot/ (I
> > don't use netboot)

Now I know the real reason why this test failed.
With this note we can conclude this is not a regression.

No regressions on arm64, arm, x86_64, and i386 for 4.19, 5.4 and 5.5 branch=
es.

Sorry for the noise.

--=20
Linaro LKFT
https://lkft.linaro.org
