Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36639C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 140432073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zRihzcG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgD2O1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726355AbgD2O13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:27:29 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684B4C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:27:29 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id t11so1838611lfe.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S3OuRgJa+ccEiACnQwqNkqz6tzb4iy9m82zj05Y1Dno=;
        b=zRihzcG37HawT9lTDQRJS9thu/ta/OQ3wuZ4jB4C4xVf0s9rIk8kL2GCkB5WlYLM5/
         Z4nuy9t2nO5YA2c5q93vIv+rbRgbKIuCvwqObx6sVDrwSeWIKa8jaObIHSr45ZevHLv4
         bT6+7GJ1HSn9wZl0UJ/kxNGm5ho83wt6BsvdyS7fAGUJc+YiZMhV/8fB5CR/a1rzggcn
         PfMcvt6iK7QJwUAkm2e9yZ7sSQE4nSlyFc7QtAF46fYnH/2SUrDivWz7SN4JImXP7QwD
         COq+W5Grt2dl/LqNPANJ9CMj/NMwxs2A7C9788jH4Y+gw01VbOtmWfyINRFrrIDcwjWO
         vjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S3OuRgJa+ccEiACnQwqNkqz6tzb4iy9m82zj05Y1Dno=;
        b=WAlafzOLltZjKWQizT8tMtnRIlbRa1jX2jA1aXre0LOsLsyxH+NwNXu+2abJRR7fTq
         hjruui0+tNZpu8YigeD1gA+Mvre+52QeNviXhFMrdmibNtkUa7PIC+wiDQoiFiI0AaC1
         ogNEBpyBXxv1RoKidJVqW/s3mADaz7y2JM/jaxhct4OsHQI8eSuVnYnrk/8sr3agz50M
         0ejLm3sMsokM0Gu9K25WcDke1hhnuDFNcNMW6Wz82lni0rz0h34BMxIZ0yljjpUh5wqV
         39yNjhsku1ZL4HTDcdss+rODLdLjf0FqaF8hvZr5c1cnApKENgrBiz1h6dmTRAp4Ckxw
         ufsA==
X-Gm-Message-State: AGi0Pua0poFgfF3MFFUR//h1So3gYoxCPFeV2JMRaa/7dC/AsjaQVn7D
        c8lBLJ1Tuxyx82TkA88T26xnsvxuKsWpaHPvKIwTYw==
X-Google-Smtp-Source: APiQypIGj7qoC6Z/jL7P2VJs5hDjBartert8jiHWlcz8YAv037yXEKtnAQ891eDr9aZWnhRokWjfTdGmQF7mbQEknUs=
X-Received: by 2002:a19:4883:: with SMTP id v125mr1623715lfa.95.1588170447731;
 Wed, 29 Apr 2020 07:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200428182225.451225420@linuxfoundation.org> <CA+G9fYvPhDsaHKJSGfxWLUPmrf_mRx7S3_RdXWmRzbg25SRRoQ@mail.gmail.com>
In-Reply-To: <CA+G9fYvPhDsaHKJSGfxWLUPmrf_mRx7S3_RdXWmRzbg25SRRoQ@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 29 Apr 2020 19:57:15 +0530
Message-ID: <CA+G9fYtEWDJ1TbW+fLs1rjWRC69Y_VqeKC9KauZ5b9+B-=AS5Q@mail.gmail.com>
Subject: Re: [PATCH 5.6 000/167] 5.6.8-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Andrei Vagin <avagin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "X.f. Ren" <xiaofeng.ren@nxp.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Apr 2020 at 14:38, Naresh Kamboju <naresh.kamboju@linaro.org> wr=
ote:
>
> On Tue, 28 Apr 2020 at 23:57, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.6.8 release.
> > There are 167 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 30 Apr 2020 18:20:42 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patc=
h-5.6.8-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git linux-5.6.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> Results from Linaro=E2=80=99s test farm.
> No regressions on arm64, arm, x86_64, and i386.
>
> NOTE:
> This kernel panic seems to be platform specific.
> However, I am sharing a few kernel panic logs here.
> While running LTP cve[1] and  libhugetlbfs[2] test suite on nxp ls2088
> device the kernel panic noticed with different kernel dump
> and unfortunately it is not easily reproducible.
> At this point it is unclear whether this problem
> started happening from this stable rc review or not.
> Because a different type of kernel panic noticed on Linus 's  mainline tr=
ee
> (5.7.0-rc2) version kernel while running LTP containers tests.

As per the initial investigation these kernel panic (s) noticed from a
single machine out of five machines under test.

- Naresh
