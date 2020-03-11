Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4A2C18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A9D204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbgCKObn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:31:43 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:43183 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729719AbgCKObn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:31:43 -0400
Received: from mail-qv1-f51.google.com ([209.85.219.51]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MXpM2-1iop5V2Doy-00Y7pz; Wed, 11 Mar 2020 15:31:41 +0100
Received: by mail-qv1-f51.google.com with SMTP id l17so951015qvu.4;
        Wed, 11 Mar 2020 07:31:41 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0nb0jq9k7IMpYf08xQ+SH5299hnUKxYLLXj3/69SriKK/tNsXC
        Fcm+OJWKHCA8ppinDQXhE7YRn4sCsk7Cu+nO93M=
X-Google-Smtp-Source: ADFU+vs7vsHRRk5DF+sIH0AM5qI2NZuKa/my/Rqt4Fil9rQRSzu8NXrbadx7Co2qeP3BJvqRxzROzp3/R4yRw9+b1xg=
X-Received: by 2002:ad4:52eb:: with SMTP id p11mr2880124qvu.211.1583937100255;
 Wed, 11 Mar 2020 07:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200311112120.30890-1-zhang.lyra@gmail.com>
In-Reply-To: <20200311112120.30890-1-zhang.lyra@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 Mar 2020 15:31:24 +0100
X-Gmail-Original-Message-ID: <CAK8P3a12iN4HzN3HsRSBJPLpwJzdVwhrK7Mje0V6eW3Lvd77iw@mail.gmail.com>
Message-ID: <CAK8P3a12iN4HzN3HsRSBJPLpwJzdVwhrK7Mje0V6eW3Lvd77iw@mail.gmail.com>
Subject: Re: [RESEND PATCH] arm64: dts: specify console via command line
To:     Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: <soc.lore.kernel.org>
Cc:     SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:CLt4UGhYEFuPuQIoW/xfHJnWHUF1vh0zPPhR4y6r6NbTUEGmV5V
 QLW9hYN9gDzNQV/Wu/cJtDhyP2/ljICttwKTgusnrim6lFYY9rvJfrIai8uevx8B/bSs/bt
 eOxvC03C25dU8QvO2zeix7G602ro0VZkwwx3Ps6Oczh9hUZyagJIUWPfwwnn7tJJCvL6aXD
 78H8pb9nRwls4SGXSRvdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+t3kxDfZUqE=:PY7qPIJNe78YFLzEC/WUWm
 SqI6fl1r3EydEtOj4vQNOcDBzFrkUeJ1rNzS2iILUFo8ngrQyQ1Lxchglbh5IK0VGodjJxvms
 5dAyeO/NktaE29+8RLONAyeJEoKzVbegL78sIeEjMPYeK3DFhboSaZWxQCx+V5uHHQ0oQUXTk
 pDWdbYdg8qalRE5d42VG3u04ZGPO4vUp49Mi+tqyKdbdziI9gis+GZrCqNIKxBPHnOcXzj3Lg
 Bl8K2bGCwUEUR1VqGVC1HoL3PbZbZpgp51jTHfRNo2RugvXmZjWrGtgX3QIF5/IWuMp67mnPF
 CKni6tFCkpsaE42L2DQi1llQKu/pvK0TUh7VEy+YgLYwljpwYEOE58IoZ2nDBPFeCTJFRNsg/
 wSWuNCNyXJD7LIDbtXmeqznxj+eDHpnHI6woVCvDBFb2tzK92qiOBFZOaL800C8aIa2DiI0up
 dm+VcMvYS2fwDfbfwh96MC9DzT22IGFZByET9a0H32seTB5MBjVSl/NnDxBXlfPn4PINTqaVV
 /ZFsJCprS2n9AUbkkMi75avJXDWUF2nLa30oE7GQSYlU2YG3qjMw7XAuNy1W07L0j2HmqJLj/
 MvLFJPfPhWUXwW1ysP/Jwz626XppZwVekyIFK8xY/5MJGCQHiDwsmBkh3pawqh7ObhO/e0aDQ
 xKUrQZT9IhQ6ZWTegn/E01wqoME/vKo40gfO0ck2A2twSjl/Ima68NQ1otbhLxfGwwh1jW+vT
 WNbwXMO0uEpYxjNXHtW9C69b2J0VuEPs0Y8EoZOCmRXPGJ7wisnYVr6v/xAyieSOIxG5hEHXD
 UtrSmnYnhAceAhwZNqUTzcobE2OSf9FbeHcf8BV2E/DBucW9Qo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 12:21 PM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>

> diff --git a/arch/arm64/boot/dts/sprd/sp9863a-1h10.dts b/arch/arm64/boot/dts/sprd/sp9863a-1h10.dts
> index 2047f7a74265..510f65f4d8b8 100644
> --- a/arch/arm64/boot/dts/sprd/sp9863a-1h10.dts
> +++ b/arch/arm64/boot/dts/sprd/sp9863a-1h10.dts
> @@ -28,7 +28,7 @@
>
>         chosen {
>                 stdout-path = "serial1:115200n8";
> -               bootargs = "earlycon";
> +               bootargs = "earlycon console=ttyS1";
>         };
>  };

Hi Chunyan,

I would expect that you need to either specify the stdout-path, or the console=
kernel parameter, but not both.

If earlycon was used, shouldn't the driver know which port is the console?

      Arnd
