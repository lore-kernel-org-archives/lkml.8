Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F688C3F68F
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 07:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFDB822B48
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 07:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="ZyPtJT1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgBHHAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 02:00:02 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:15787 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgBHHAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 02:00:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1581145200;
        s=strato-dkim-0002; d=xenosoft.de;
        h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=v1czFyXK2g0A10HYibevY4qX9AIYXqXeki2CibbFqRE=;
        b=ZyPtJT1lJT09xPvR7oaK80nNtKDrEyRs/TWjQX8j7Km5BCqXxSJOIhqBHuD9G5uAyF
        sYfcRgEVzhKaSUBPyhNiMNAORYJVRrVVKhpXzf9cw1dEeCY6rYQuKscmCoOcnRxcP1wD
        oLE1WHCdqp4PVBL1RXbv/iLv/1PUDBZCLX9Y3Ey5oWtVwXhmdjo/r/yfy98sEySp0St7
        qHsPxJz8lNPDG2RU5qudk9NCPd2KJ0SCOcT8BWd4rRx6i+BYdSrL4uBBOWRAtNP1Qy9T
        kdy2XP0E/qrNOT8Niie6ioJ5gVMOvLFJNdzwXWDlQslbZQz1m2scTdTqruYW+zoShLZd
        JO0g==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6Kxrf+5Dj7x4QgaM9fNtIXuaJFHtH13fftKpBh9vXvxFA66d+3MU"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:b49c:9840:730:839a]
        by smtp.strato.de (RZmta 46.1.12 AUTH)
        with ESMTPSA id 40bcf3w186xIhA7
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sat, 8 Feb 2020 07:59:18 +0100 (CET)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Mime-Version: 1.0 (1.0)
Subject: Re: Latest Git kernel: avahi-daemon[2410]: ioctl(): Inappropriate ioctl for device
Date:   Sat, 8 Feb 2020 07:59:17 +0100
Message-Id: <834D35CA-F0D5-43EC-97B2-2E97B4DA7703@xenosoft.de>
References: <CAK8P3a39L5i4aEbKe9CiW6unbioL=T8GqXC007mXxUu+_j84FA@mail.gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Jakub Kicinski <kuba@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        DTML <devicetree@vger.kernel.org>,
        Darren Stevens <darren@stevens-zone.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@ozlabs.org, "contact@a-eon.com" <contact@a-eon.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>, Christoph Hellwig <hch@lst.de>,
        mad skateman <madskateman@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Christian Zigotzky <info@xenosoft.de>
In-Reply-To: <CAK8P3a39L5i4aEbKe9CiW6unbioL=T8GqXC007mXxUu+_j84FA@mail.gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Mailer: iPhone Mail (17B111)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 7. Feb 2020, at 18:08, Arnd Bergmann <arnd@arndb.de> wrote:
>=20
> =EF=BB=BFOn Fri, Feb 7, 2020 at 3:34 PM Christian Zigotzky
> <chzigotzky@xenosoft.de> wrote:
>>=20
>> Hello Arnd,
>>=20
>> We regularly compile and test Linux kernels every day during the merge
>> window. Since Thursday last week we have very high CPU usage because of
>> the avahi daemon on our desktop Linux systems (Ubuntu, Debian etc). The
>> avahi daemon produces a lot of the following log message. This generates
>> high CPU usage.
>>=20
>> Error message: avahi-daemon[2410]: ioctl(): Inappropriate ioctl for devic=
e
>>=20
>> strace /usr/sbin/avahi-daemon:
>>=20
>=20
> Thanks a lot for the detailed analysis, with this I immediately saw
> what went wrong in my
> original commit and I sent you a fix. Please test to ensure that this
> correctly addresses
> the problem.
>=20
>        Arnd

Hi Arnd,

Thanks a lot for your patch! I will test it as soon as possible.

Cheers,
Christian=
