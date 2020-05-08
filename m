Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F163C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D9242070B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kmYgXVI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgEHNiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726908AbgEHNit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:38:49 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07CDC05BD09
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 06:38:48 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a21so1678563ljj.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 06:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YGH0w9TVaOWqDIaSfqpleryTBeA2F/fshFr7VRnCChI=;
        b=kmYgXVI6+XJwUkL8R8L3doGNNECXw/NtW5fZkeveUBsOjZUCCkcRQVbqnJmxevMIAU
         1d81S5o0cLFoh+JmwFqUvEUCJah0iL+0SAMZxzvLVm7HsdvBDEj2nwcfmbRTEAVxde91
         7MpQm33XiVSPIfu3niZYIFWqlUzv33fEr6wTBGdqXDArUk5c8cgltvfBld/rAorzVoVo
         WfqorZleMODdcUBosuM68Nda+nWgx7AuAhCnYVXewQpLg5b+MBsS+dctklFVvAGQKLXw
         CZlroXJqtsDL9dQq2GHu5G8wIUPf6+Y2Pv3lo/rmcasJBkkZtfHm1EO+dGz0S0iTKjcd
         1p5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YGH0w9TVaOWqDIaSfqpleryTBeA2F/fshFr7VRnCChI=;
        b=otPMsg5R8wzHj45LWq4o4uDy7WIpBNyVErZOEVwzdWNOImfk+Gb220aZoNihpRmhW2
         OPs1R+nB6LSML00jfoYrQsyJpaa/SzPu230iE7gAZr/84MMzBI8OeC/4BS+ol4SOQ+bo
         HJmQnLW43EjRV7tKdK7WzVrH122Use8F8iP9rGHtuiFackmZnmEofbIgut35GRDx8R17
         5fd+uYLc3PcIeopw4qlgx4vYZpPE14m9zVj8l62/f6ybMxMSkfrQIAeygdvPCNnlSjwP
         vUKlX2zuOX2aLaogG5U1hej2j0ipwdjagkVxYI+uQGmo6N//6B015vbybuXxNQ3NGo+V
         C/aw==
X-Gm-Message-State: AOAM530RgBLGSKa2Dlq0PmoY70C1GcTIuAQ6bazWldkwj5fsecGM6lhe
        cdqHtg064Ty6P7KgA2l2IGBEvaBfhhH8OZV3tTyldA==
X-Google-Smtp-Source: ABdhPJwoyTaSawRn23dS+1HqGc9NdrLZPReQECMG3DoqsQhjQbk8HiWxwm3eJOxQ/NzzMus8jX2h7FYS2FwKjpnhwEk=
X-Received: by 2002:a2e:8912:: with SMTP id d18mr1785367lji.123.1588945127136;
 Fri, 08 May 2020 06:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200508123124.574959822@linuxfoundation.org>
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 8 May 2020 19:08:35 +0530
Message-ID: <CA+G9fYu5XMh+gkA9MBkg+yKAvHUEZBvRww-PbeiTnJYaYsN5ag@mail.gmail.com>
Subject: Re: [PATCH 4.4 000/312] 4.4.223-rc1 review
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

On Fri, 8 May 2020 at 18:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.223 release.
> There are 312 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 10 May 2020 12:29:44 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.223-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
<trim>
> Addy Ke <addy.ke@rock-chips.com>
>     spi: rockchip: modify DMA max burst to 1

While building kernel Image for arm architecture the following error notice=
d
on stable-rc 4.4 kernel branch

 # make -sk KBUILD_BUILD_USER=3DTuxBuild -C/linux -j16 ARCH=3Darm
CROSS_COMPILE=3Darm-linux-gnueabihf- HOSTCC=3Dgcc CC=3D"sccache
arm-linux-gnueabihf-gcc" O=3Dbuild zImage
 #
 #
 # make -sk KBUILD_BUILD_USER=3DTuxBuild -C/linux -j16 ARCH=3Darm
CROSS_COMPILE=3Darm-linux-gnueabihf- HOSTCC=3Dgcc CC=3D"sccache
arm-linux-gnueabihf-gcc" O=3Dbuild modules
 #
 ../drivers/spi/spi-rockchip.c: In function =E2=80=98rockchip_spi_prepare_d=
ma=E2=80=99:
 ../drivers/spi/spi-rockchip.c:461:19: error: =E2=80=98struct dma_slave_cap=
s=E2=80=99
has no member named =E2=80=98max_burst=E2=80=99
   461 |   if (rs->dma_caps.max_burst > 4)
       |                   ^
 ../drivers/spi/spi-rockchip.c:481:19: error: =E2=80=98struct dma_slave_cap=
s=E2=80=99
has no member named =E2=80=98max_burst=E2=80=99
   481 |   if (rs->dma_caps.max_burst > 4)
       |                   ^

full build log,
https://gitlab.com/Linaro/lkft/kernel-runs/-/jobs/544289003

--=20
Linaro LKFT
https://lkft.linaro.org
