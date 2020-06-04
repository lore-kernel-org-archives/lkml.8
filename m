Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35639C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14612206DC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbgFDUqB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:46:01 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:50217 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729174AbgFDUqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:46:00 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MHoAg-1jn0lc3NCA-00EtjZ for <linux-kernel@vger.kernel.org>; Thu, 04 Jun
 2020 22:45:59 +0200
Received: by mail-qk1-f173.google.com with SMTP id s1so7587454qkf.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 13:45:58 -0700 (PDT)
X-Gm-Message-State: AOAM533XCja76ua4Ipr6b2Tg/zXA8YBSVl3x0j77/MeklNOAUXRzHxn2
        LVCxSbYnRv2p6nrCkvTPRiXGy0hojw40uSNXGQE=
X-Google-Smtp-Source: ABdhPJwXrpsH1XQ1mbch3JTIADbzQkHUa0jcasKEzjYWDTVYa/T04J6Her42Ynj0K0YbvgvP8cqAz+IVTyB8jyeYNyY=
X-Received: by 2002:a37:554:: with SMTP id 81mr6714160qkf.394.1591303557700;
 Thu, 04 Jun 2020 13:45:57 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Jun 2020 22:45:41 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1dmaiYR5Oxkc0CQcxTm=rAHSx6R+xtf4Wup29JqXNZsA@mail.gmail.com>
Message-ID: <CAK8P3a1dmaiYR5Oxkc0CQcxTm=rAHSx6R+xtf4Wup29JqXNZsA@mail.gmail.com>
Subject: [GIT PULL 0/4] ARM: SoC branches for v5.8
List-Id: <soc.lore.kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Marek Vasut <marex@denx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:vlipuS5WttkCO0e2XyZTN/IykZUMVY0OPY39cCiJftqXsVlQP7+
 BcDqHJOehDJgcNnwvmXUMQWY7j93wIsIgb4hIKfIO9tLUcRS3lIOxJSd1ageroBexYqz+qn
 LW19zWeXCl5tS6YlYuEitiwAWu1xwldPgoQbU/DjV5Qpb/BIZeAqGZBRDFzN8FrLYe3QOmc
 r0tckFkUD1TpIByQvDe1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DoW/2jqXGcE=:QiXwYKWoMWKezkBqtfxAlb
 8Er5qwww1W55mMHKN1guLJn22cSEXucJXaXHY+4Drwev+1nDGCpIDCfUB183yiB0Vk9dLsS4l
 KObPk8zcoi53vMoKc90AvGq+w7zO6tyCQUzypUk2yjbWyFCa1cnwYvzJ9WN9nMQ2WiqgReD2J
 5jQJnDSn/74QXy9kW+y1XX/lhQB/c6WVAYd2NxIVXFLNeVa+Ne2P9CZZpCn1/AHAlI2UBclz+
 7FQJq7Tc+lpYm5GvmchiMEEz3EiXVJxC0IT/5CoqwpWjBMCQg4AWTPTwx/f6dhxWkyTUgcICU
 GLuHY6PwbUz2bMOLvRDxJO0aPrBNalmVf0f8NM/8fmE+9Tlftgr7mDReiISKbVzR6rR0Hc7qR
 HjqaH95Upk86FqImRBlk/xGXt1VplsbrM0e8RNRD9pR4YCUewN6AQxJsf135lVtJblsbh727s
 P7pg/8knFUi1nESNBlg1gPNefNqyUI7L0Yp08BPdmJFz5MkHfXNsl8MCIqXUP1YaITQHrsS2o
 2sv5umRI72RSKPimsjavmY+5v07uumQ8iCinKPm8007c+Zcdf7sgllkC9HCVRGaB8/J/miKZL
 Pyv3BkT9j58k5a/4QDGYKkL/+INmVZj4QtghN6FlLbM6hEyXnkJzOHGFdxYhsNeMIkSk2PBor
 QdK/Ld5+NLw072JQLylll9BGURKPaav/NySIx0Db98vQQ/Mp5mgBhcHNVUzt5ZH91zgB6lLep
 cL2ltMl6NReSkat99NSL/8I0i1FhSKRTUWhbwwiosiaPAKGGHyNK6eCRAGL+XE01xJTrwmXyo
 2w2tvge+fJtnjwAiZbIBAdQvv44cisaUlyMRWDkVXXHS06OMN0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are the usual branches for arm-soc: five new SoC variants, 25
machines added, two machines removed, a few new drivers and the
usual amount of of cleanups and rework.

There are 835 patches from 196 contributors in total, with only
these contributing more than ten patches:

     36 Marek Vasut
     35 Andreas Färber
     27 Geert Uytterhoeven
     23 Rob Herring
     22 Anson Huang
     21 Douglas Anderson
     20 Tudor Ambarus
     20 Lad Prabhakar
     19 Johan Jonker
     17 Jonathan Bakker
     17 Andre Przywara
     16 Suman Anna
     15 Jerome Brunet
     14 Serge Semin
     14 Bjorn Andersson
     13 Tony Lindgren
     12 Lubomir Rintel
     12 Dmitry Osipenko
     11 Sudeep Holla
     11 Marek Szyprowski

The dirstat shows that as usual most changes are for device
tree files, this time slightly more 32-bit than 64-bit both in number
and size of the changes, while 60% of the newly added machines
are 64-bit.

   0.3% Documentation/devicetree/bindings/arm/
   0.6% Documentation/devicetree/bindings/bus/
   0.2% Documentation/devicetree/bindings/display/tegra/
   0.3% Documentation/devicetree/bindings/memory-controllers/
   0.5% Documentation/devicetree/bindings/
  31.9% arch/arm/boot/dts/
   0.7% arch/arm/configs/
   0.5% arch/arm/mach-imx/
   1.2% arch/arm/mach-integrator/
   3.2% arch/arm/mach-omap2/
   5.4% arch/arm/mach-pxa/
   0.5% arch/arm/
   0.6% arch/arm64/boot/dts/allwinner/
   4.0% arch/arm64/boot/dts/amlogic/
   1.5% arch/arm64/boot/dts/arm/
   2.4% arch/arm64/boot/dts/freescale/
   0.2% arch/arm64/boot/dts/hisilicon/
   5.2% arch/arm64/boot/dts/mediatek/
   0.4% arch/arm64/boot/dts/nvidia/
   7.6% arch/arm64/boot/dts/qcom/
   1.7% arch/arm64/boot/dts/realtek/
   2.0% arch/arm64/boot/dts/renesas/
   1.4% arch/arm64/boot/dts/rockchip/
   0.3% arch/arm64/boot/dts/socionext/
   0.4% arch/arm64/boot/dts/sprd/
   0.5% arch/arm64/boot/dts/ti/
   2.8% drivers/bus/
   0.9% drivers/clk/mediatek/
   0.4% drivers/clk/versatile/
   0.6% drivers/cpufreq/
   0.7% drivers/firmware/arm_scmi/
   0.2% drivers/firmware/
   1.1% drivers/gpu/drm/mediatek/
   0.6% drivers/memory/
   0.2% drivers/mfd/
   0.6% drivers/misc/
   0.4% drivers/reset/
   0.3% drivers/soc/amlogic/
   0.3% drivers/soc/imx/
   1.1% drivers/soc/mediatek/
   3.0% drivers/soc/qcom/
   0.2% drivers/soc/tegra/fuse/
   0.3% drivers/soc/ti/
   0.2% drivers/soc/
   7.8% drivers/staging/media/tegra-video/
   0.4% drivers/tee/
   0.2% include/dt-bindings/clock/
   0.2% include/dt-bindings/firmware/imx/
   0.6% include/dt-bindings/reset/
   0.3% include/linux/
   0.3% include/

The largest outlier are a few added drivers for the Tegra platform
and on MIPS SoC (Baikal-T1), for which I helped get some drivers
reviewed and merged. The changes for omap2 and pxa are
cleanups moving code out of the platform directory.

As of this morning, there were no merge conflicts against your tree.

     Arnd
