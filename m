Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B371C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0121920775
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgGQPCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 11:02:42 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:50375 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgGQPCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 11:02:41 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MGzDv-1k14aZ0OaR-00E6Xh for <linux-kernel@vger.kernel.org>; Fri, 17 Jul
 2020 17:02:40 +0200
Received: by mail-qt1-f176.google.com with SMTP id e12so7815476qtr.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 08:02:39 -0700 (PDT)
X-Gm-Message-State: AOAM532iyuImKZX857atyFegtO1MrRtaHw6AA1Yr02pZ9N1IimyVfFCX
        B7Md45MnXNZMcmRIMTEoO+43oSqnkv8ezW70CM8=
X-Google-Smtp-Source: ABdhPJw+jkR1ZAGgh1sSuYoVe+8dXEsose3NhqP/U1dCU10EClW25qkMiRJSVIWA6aavZw99V6ZYfa5rPBfJ9wvOxMI=
X-Received: by 2002:ac8:33d7:: with SMTP id d23mr10888281qtb.204.1594998158869;
 Fri, 17 Jul 2020 08:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200716223627.253936-1-daniel.gutson@eclypsium.com>
 <20200717062841.GA3238569@kroah.com> <CAK8P3a1yy7YyeJH5k40yAXb23y9siBnfuqixb76t3BK9Xh=uXQ@mail.gmail.com>
 <CAFmMkTFLm9mw5-8Dj_7rhP2KBcLUoJ1WcQCJv5_k+QRsmJPxjg@mail.gmail.com>
In-Reply-To: <CAFmMkTFLm9mw5-8Dj_7rhP2KBcLUoJ1WcQCJv5_k+QRsmJPxjg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Jul 2020 17:02:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Y0vy5WaPvVBQDqBb67pyZ0yPdYhEKA9=rgb80k5JyDQ@mail.gmail.com>
Message-ID: <CAK8P3a2Y0vy5WaPvVBQDqBb67pyZ0yPdYhEKA9=rgb80k5JyDQ@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] Firmware security information in SYSFS
To:     Daniel Gutson <daniel@eclypsium.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:f/7ltY2DqhHT/+2nLnkzL9ERro1mcgzAf7S9QV6xnfMAG+iI34x
 E2bJQlUed347gH9W8fNQB4ddJ2SP8IifthdZjBS46WUlXlK+RDZWxh6xa4EDnupODaMB7pb
 pfLPXgqC8iKtCmr3wlUTz74nS20i/pVwGwY6b0NGQH7JbfN6pzcM8OXWMXr+8UCMFl9AXaV
 9/yeH3d40t7W4EP3A1nTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gQP+mDqQXCU=:1/WpNEMfS54zPvvWM4S21M
 zkwmmjCIkWNsF229L9wREIuDudwLRIsP+XWJf/tJLSdEGBK0G7DmiB8BJU8+yMjpM/c0OXx49
 ZNsNC81MnMlBzZlSrR9o4vRbvkVgn8VzSa+nK94GTxAQRZJSK8EZfXHWIouSA/MEao66Dcrav
 72iXgxzMAV6Xp5ut7ng7ctdZM8J5JCcIkPlT48mLMP7W7yanpd2ZIo1m7ll054Qzgqnxqr3tN
 VAB5fCQ26LG2IzsfhSHfiRMKQMSoXWakhdie4uxhuOOoi2hNvJ/rno/wFXZFvPa7lpJQXNII2
 eLc3ViF84J+WC+eHDbZPq3p9GwYpikumr+maxYjSIkaLKl5UgPG8Q7/9HrXAqsICIBIeCu4Vw
 v8jcyTbxOhcfF3jvZ4omioEuwVOB10iqq8qtkCNRPAqRMHYtaCdwCde3XdQO8Rf0QVCwSKeuA
 h+kKmxW1hQTHSfxnuNefn9FDgcw56i5xW1a0c3mNNpt2gUVfoxKiV0hffOE6rjuW6IgQ11aA3
 jowbMQ8ENqxf+gVflFBu4lHinaF/ceZOcmcwtglrUoAN7xzSux9xtiUtug2ggd63czZVYe9ql
 mU9gYZeTZQ7odFzlXkJbli5NRfYSPBXtEwqTixzoLEpDrKsoAMaNVrGQg8kOkhXCuIogfzwzT
 u7GGoEl51QiddgTgmK5mUCT0P9XMz7s1Is2K/kzmZipeYAyIF/+hjVUlAeVOHRMf674ea+i89
 dNQNUN+w8lFT3JCjhgPRXTyopU/nwPlFB4sgjz3bvFm5yJQJPuP85hYm6dvm+nuGz6qv9xLsD
 IfMC8d6UlL1vvQs9l86Boat625xdvxi/65YfNMBcpFZOwxTi42HfF1YUrxhxRad1SLH5uV++9
 PxWZN/tyOx97QhzPgHDeHWInnHIaiytNlaAGbqGLOkV18Es3YvbbL/Nm754BYoHR6QGWayiDi
 1fj2zRn5SWc2VrOp2h3H2WoIMOsZ0eIHu0dwDKs2iqq6pwl2xPFRm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 4:46 PM Daniel Gutson <daniel@eclypsium.com> wrote:
> On Fri, Jul 17, 2020 at 11:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
>> > Also, this really is a _SPECIFIC_ type of firmware that supports these
>> > features, right?  Why not call that out too?  This is not generic by any
>> > means.
>>
>> As I suggested in my previous review, I wouldn't worry too much about
>> the user interface at the start, but instead first work out how the hardware
>> support fits in with the existing drivers and once that looks fine decide
>> on how to export it to user space.
>>
>> I agree the  /sys/kernel/firmware-security/bioswe sounds like the wrong
>> place, but I'm not sure if adding any other new directory in sysfs is
>> much better. I think the most promising would be to have it on the
>> sysfs directory for the device it refers to,
>
>
> My idea is to have all the firmware security information together in the same place; this information comes from many devices.
> This initial patch involves the SPI Controller, and I don't want to add more stuff until there
> is a consensus.
> So, do you have a suggestion where to put this information?
> /sys/devices/system/firmware-security?
> /sys/firmware/security?
> other?

I think it needs to be more specific than this. On a many machines
there may be a dozens of things described as "firmware" of some
sort, and even more things that relate to "security". You may also have
to consider the problem that there may be multiple devices that
want to register to this interface to export similar bits of information.

In the two drivers you have changed, there is a device node, so
the natural concept would be to either have attributes in that node,
or a child device under it with a fixed set of attributes, which can
then be referenced as a class device like

/sys/class/${NAME}/${NAME0} ->
../../devices/ci0000:00/0000:00:01.1/0000:01:00.2/${NAME}
/sys/devices/ci0000:00/0000:00:01.1/0000:01:00.2/${NAME}/${ATTRIBUTE}

This is easy to implement, and easy to access from user space,
if this works for you, the hardest part may be to decide on what to call it ;-)

     Arnd
