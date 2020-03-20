Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F28BC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E43420784
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CGLZ8zoq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgCTLX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 07:23:28 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45656 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgCTLX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 07:23:27 -0400
Received: by mail-lf1-f68.google.com with SMTP id v4so522727lfo.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 04:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RyO6wpDkpqa/Bvf9xBtsqNy8UMTl30kf8fGvN0AJPgw=;
        b=CGLZ8zoqX0Z1P2EkaPJuaGSc4SikQ2cY1uw004V2rRhKterjx9ZQzlhXr0/n2zz+W/
         YXYtkpX9oMbC9OyKFZJ8ptEk8zO+JoM2TEM0LDeq+/3bwCAL9ch4SRp2dKbJPvtCaSQp
         VrCRPUdB6Rf6aWnlTw8xMpADxN/JKHGpkYULKSbpzRCGi0S7TZJsPY7QNdFzhps+LwQr
         xjDLrs4NjUYvGyj1zriLbnJJakayGNAdeDtGawLwBf5TET+SPawfXPAnZ37u4EYFZTGL
         lEoKQw9hAiWR4jOj7nFqoZa8UPQiNvZzz2oFX5JUmKSPEBB4xFUBcr5FcoJiWo/FbZQV
         ULCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RyO6wpDkpqa/Bvf9xBtsqNy8UMTl30kf8fGvN0AJPgw=;
        b=E0/GUMoF984QQbSuTuqGMsozijZ/I8m/kAEvzDVNOV0sYu4ipUdGTcOSj9itJfHEUY
         t8LpY8bT02DB4enIkne3ZobJOCNARvuMpGRDXwkq/FPvoZwfEGpq4uMYickqV+XBShqz
         xgNOYhsKlRikk5AdbNvoVknFDZB2atZW3adV4NcxQfMRqpCCN3yuitoAKQvTqnX0NN6v
         x6+6ftLxej2G7UxQCnEnT21cRf8EZfY7Lk4n4ISVqTusEN3b/B7dsrxbI/tpBzCSsuvm
         r6V0VEphFug2A77klP5bBXkPuD9K3wXup6gUJO8rqa8dVxPOqbf6XPdm5AgR+0mFBZMl
         3VMg==
X-Gm-Message-State: ANhLgQ1VxQUC6LTkw26o4YRM3srQe3HB1EStgPD6vUnaZrG9BFhRvMk7
        Hwcat+Q4mAUfcAtg/GiNwOfoNBo14TIawFRyxJe6Ww==
X-Google-Smtp-Source: ADFU+vvjULrrifr8Vmppymxm2q6G3j9FXMWUFm6gl5hjIboH5TFPkxW9A9lq4tDC1vHuxKexLNIkRHiq08D+GUpKa00=
X-Received: by 2002:ac2:43a8:: with SMTP id t8mr5021557lfl.82.1584703406038;
 Fri, 20 Mar 2020 04:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200319123919.441695203@linuxfoundation.org> <bfdce3ef-5fe9-8dab-1695-be3d33727529@roeck-us.net>
 <20200320105513.GA450546@kroah.com>
In-Reply-To: <20200320105513.GA450546@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 20 Mar 2020 16:53:14 +0530
Message-ID: <CA+G9fYtR4eynoMt6r313FHgEhftDobn2SE9PFiDR=7_wZNfSTQ@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/60] 5.4.27-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Mar 2020 at 16:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Mar 19, 2020 at 04:55:20PM -0700, Guenter Roeck wrote:
> > On 3/19/20 6:03 AM, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 5.4.27 release.
> > > There are 60 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >
> > > Responses should be made by Sat, 21 Mar 2020 12:37:04 +0000.
> > > Anything received after that time might be too late.
> > >
> >
> > Build results:
> >       total: 158 pass: 158 fail: 0
> > Qemu test results:
> >       total: 427 pass: 425 fail: 2
> > Failed tests:
> >       mipsel64:64r6el_defconfig:notests:smp:ide:hd
> >       mipsel64:64r6el_defconfig:notests:smp:ide:cd
> >
> > Building mipsel64:64r6el_defconfig:notests:smp:ide:hd ... failed
> > ------------
> > Error log:
> > arch/mips/vdso/vdso.so.dbg.raw: PIC 'jalr t9' calls are not supported
> >
> > I was unable to figure out why I only see this problem in v5.4.y.
> > The build error is easy to reproduce with gcc 9.2.0 and "64r6el_defconf=
ig".
>
> I've dropped a bunch of mips vdso patches from 5.5 and 5.4 queues now
> and will push out new -rcs with those in them to hopefully resolve these
> issues.

amr64 and arm build failed on stable-rc 5.4 and 5.5

 # make -sk KBUILD_BUILD_USER=3DTuxBuild -C/linux -j16 ARCH=3Darm64
CROSS_COMPILE=3Daarch64-linux-gnu- HOSTCC=3Dgcc CC=3D"sccache
aarch64-linux-gnu-gcc" O=3Dbuild Image
 #
 ../drivers/mmc/host/sdhci-tegra.c: In function =E2=80=98sdhci_tegra_probe=
=E2=80=99:
 ../drivers/mmc/host/sdhci-tegra.c:1556:21: error:
=E2=80=98MMC_CAP_NEED_RSP_BUSY=E2=80=99 undeclared (first use in this funct=
ion); did
you mean =E2=80=98MMC_CAP_NEEDS_POLL=E2=80=99?
  1556 | host->mmc->caps |=3D MMC_CAP_NEED_RSP_BUSY;
  | ^~~~~~~~~~~~~~~~~~~~~
  | MMC_CAP_NEEDS_POLL
