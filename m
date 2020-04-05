Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE76C2BA1B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A28F20672
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zsqx3ZRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgDEOdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 10:33:50 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46288 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgDEOdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 10:33:50 -0400
Received: by mail-io1-f67.google.com with SMTP id i3so12853483ioo.13;
        Sun, 05 Apr 2020 07:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=JePDQgBdQH33JrWs9bGy0UWdrzs7I8dGLAKTSz+7a7Y=;
        b=Zsqx3ZRfL1HezoMYoyXXp4KQe+WID5F4GINY6bNiukGoSPcxJVEQW02w9AhN4/wphx
         RZr8+mA/NmenUTtWTumjg64JwWAC1n9Nk9ABGCesqEZPcGjB0qamk0RDeBYJJPYjbzlg
         jSp8bToh/IKQNbsvymAYy76niDqv5RyWJVq/BfeFfBKQM/3Ls7d82oXa6trKqo3PxJkw
         xDaOTi2fQiAuA96FLZF+F5QQd6TLu2uXvlT2L3O03r0PZk7BmMru6UBANW6+PIdGes/t
         xLwUUHtyAOhfeN1U8pOJ4xSnzNaBA5RAKWVhLWwHqSleP2nsCTJHEjEQq/4bT6t2Npr5
         2+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=JePDQgBdQH33JrWs9bGy0UWdrzs7I8dGLAKTSz+7a7Y=;
        b=GQmHvYMWn54AMyuy25aAkt4h00nPx3W3Gj2mtwboEyRQL4jCwG/l+kLZsjgdpB+y2L
         79ltrd19sK211YOvtodHgheaLvE/Af8iPemZmXz+iQJ4rQD7o+ax2Aajvz28e1MZtn4x
         yXnIQTYMSma/ewZoLEROPezWXf0BSBElg1CmZjwiAsJNT3pLTL1nZR5BSQrpdjxtnp/M
         O4qwnlEhnHiCoI6ClG4nvqiMpc0XzwE2jTCRQT653IMXbWl2pj12TY6eZiVdPz9YGVQ+
         YxwkUcz3uMJ2IsY2O6w6O/Yh7F6rk2wSDPPYBtmhtGyZil76KsnAxZjiXGqqJOQo5ms7
         xVJA==
X-Gm-Message-State: AGi0PuaEN1Gfz4itfCQ1AsZQpiSB38RPqguMMu3ja3iywtripniqeJpy
        WaV6OOLcQqjJKVZx7/wkfdhm/ZdtAahTQR+GYzo=
X-Google-Smtp-Source: APiQypL3uqmHGooNnyDi0IND+otfVS3s95cae1ByIEV9XnSffNZGHqr+ArBkfkTwaDQokAGnnL6k7QOqHc195B+FL3s=
X-Received: by 2002:a5d:91ca:: with SMTP id k10mr3421128ior.36.1586097229049;
 Sun, 05 Apr 2020 07:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200405104913.22806-1-peron.clem@gmail.com> <20200405115138.vrrvv7spnv6ifm6x@core.my.home>
In-Reply-To: <20200405115138.vrrvv7spnv6ifm6x@core.my.home>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 5 Apr 2020 16:33:37 +0200
Message-ID: <CAJiuCcfAKCs5ZLi_O21eyx-ZraC2Sb_ugQSmOEYm5+eVkQ7ZSw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 0/7] Add support for Allwinner H6 DVFS
To:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ond=C5=99ej,

On Sun, 5 Apr 2020 at 13:51, Ond=C5=99ej Jirman <megous@megous.com> wrote:
>
> Hello Cl=C3=A9ment,
>
> On Sun, Apr 05, 2020 at 12:49:06PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi Sunxi maintainers and members,
> >
> > Now that required drivers are merged we can contibute on DVFS support f=
or
> > Allwinner H6.
> >
> > This serie is based on Yangtao Li serie[0] and Megous works[1].
> >
> > Most of the OPP tables are taken from original vendor kernel[2].
> > Plus there is a new CPU frequency @1.8GHz.
> >
> > I wrote a simple script to randomly set a frequency during a random tim=
e[3].
> > With this script and using stress-ng during a day I didn't see any issu=
e.
> > Moreover I have tested specifically the 1.8GHz on my Beelink GS1, max t=
hermal
> > 80=C2=B0C is reached after ~10min and then the SoC oscillates quickly b=
etween 1.5
> > and 1.8GHz.
>
> Thank you for working on this. :) I wonder what SoC bin you tested this o=
n.
>
> I have a patch to print it here:
>
>   https://megous.com/git/linux/commit/?h=3Dths-5.7&id=3Dc5ddd2a45c7e04dce=
c31619b58de7c798ad6594c
My SoC bin is :
[    0.584553] sun50i_cpufreq_nvmem: Using CPU speed bin speed0
>
> > I also test that that offlining CPU0 and doing DVFS on other CPUs works=
.
> > As CPU regulator is only set for CPU0.
> >
> > But maybe it doesn't cost much to set the regulator for all the CPUs?
> >
> > Jernej test the GPU devfreq on several H6 board particulary the Tanix T=
X6 which
> > doesn't have a proper dedicated PMIC and doesn't had any trouble with i=
t.
> >
> > Do you think I can enable GPU OPP for all H6 Boards?
> >
> > Also Yangtao Li enable DVFS for OrangePi and Pine64, as I can't test th=
em I
> > didn't reenable these boards. Please, let me know if you want me to add=
 these
> > boards in this serie.
>
> Feel free to add these OPPs also to OrangePi 3 dts, I've been running min=
e with
> this OPP table for at least a year already (I have the worst SoC bin).
>
> Though I'll run a bit more comprehensive test for more frequencies, like =
you
> did, just to be sure.
>
> One thing I wonder about is if there should not be some small ramp delay =
on the
> CPU regulator node, because voltage change probably takes some small time=
 to
> apply, compared to changing the PLL frequency. And I have no idea if the =
CPU
> is not running for some very small time out of spec during transitions.
>
> I didn't find timing information in the PMIC datasheet, but I suppose bas=
ed
> on the DCDCA frequency of 3MHz that it will adapt to the new voltage in t=
he
> range of 1s-10s of microseconds.
>
> In datasheet of the similar PMIC (AXP813) there is this note:
>
>   DVM (Dynamic Voltage scaling Management) ramp rate: 2.5mV/us at buck fr=
equency 3MHz

Good point, this information should be added for both CPU and GPU regulator=
.
This could be nice to confirm this point with a scope.

Also I remark that Allwinner user higher temperature than what we set :
alarm_low_temp =3D <105000>;
alarm_high_temp =3D <110000>;
alarm_temp_hysteresis =3D <15000>;
shut_temp=3D <115000>;
https://github.com/orangepi-xunlong/OrangePiH6_Linux4_9/blob/master/arch/ar=
m64/boot/dts/sunxi/sun50iw6p1.dtsi#L1924

Don't you think that we can push a bit higher the temperature it's
actually at 80=C2=B0C ?

Thanks for the review,
Clement

>
> I think it will be simiar with AXP805.
>
> regards,
>         o.
>
> > Thanks,
> > Cl=C3=A9ment
> >
> > 0: https://patchwork.kernel.org/cover/10815117/
> > 1: https://megous.com/git/linux/log/?h=3Dths-5.7
> > 2: https://github.com/orangepi-xunlong/OrangePiH6_Linux4_9/blob/master/=
arch/arm64/boot/dts/sunxi/sun50iw6p1.dtsi#L345-L517
> > 3: https://gist.github.com/clementperon/55a055dae3f13bbd14fb39c0069fe2e=
2
> >
> > Cl=C3=A9ment P=C3=A9ron (4):
> >   arm64: dts: allwinner: h6: set thermal polling time
> >   arm64: dts: allwinner: h6: Add GPU Operating Performance Points table
> >   arm64: configs: Enable sun50i cpufreq nvmem
> >   arm64: dts: allwinner: h6: Enable CPU and GPU opp tables for Beelink
> >     GS1
> >
> > Ondrej Jirman (2):
> >   arm64: dts: allwinner: h6: Add thermal trip points/cooling map
> >   arm64: dts: allwinner: h6: Add CPU Operating Performance Points table
> >
> > Yangtao Li (1):
> >   arm64: dts: allwinner: h6: Add clock to CPU cores
> >
> >  .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  10 +-
> >  .../boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi | 103 ++++++++++++++++++
> >  .../boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi |  74 +++++++++++++
> >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  44 +++++++-
> >  arch/arm64/configs/defconfig                  |   1 +
> >  5 files changed, 226 insertions(+), 6 deletions(-)
> >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dts=
i
> >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dts=
i
> >
> > --
> > 2.20.1
> >
> > --
> > You received this message because you are subscribed to the Google Grou=
ps "linux-sunxi" group.
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to linux-sunxi+unsubscribe@googlegroups.com.
> > To view this discussion on the web, visit https://groups.google.com/d/m=
sgid/linux-sunxi/20200405104913.22806-1-peron.clem%40gmail.com.
