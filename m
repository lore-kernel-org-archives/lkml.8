Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816ADC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 21:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541C0206F6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 21:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgDCVaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 17:30:06 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:47263 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgDCVaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 17:30:05 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M5gAG-1jQXME1X2Y-007ANh for <linux-kernel@vger.kernel.org>; Fri, 03 Apr
 2020 23:30:04 +0200
Received: by mail-qt1-f182.google.com with SMTP id b10so2114501qtt.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 14:30:04 -0700 (PDT)
X-Gm-Message-State: AGi0PubtLVcJbjZZQykud/ro3a24pjjWsPBlQRpErI9cw5AM04twbvoO
        oG2MQVtrWnoCWQ2X4zHMeOvqjM+twOUslMJCAG0=
X-Google-Smtp-Source: APiQypJMLJzUbCfNCO5Og6VWOIdmag7cpl+F823zhRpXudOQprChEBxAxNFcT3I6LC4tRLPW4oQaKmAvbHGoZunOufU=
X-Received: by 2002:ac8:7292:: with SMTP id v18mr10420071qto.304.1585949403150;
 Fri, 03 Apr 2020 14:30:03 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 3 Apr 2020 23:29:46 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1aO+LUu6KsW+s8aZMNWt2yz7kqe=LARY=ifMKOqT9uNQ@mail.gmail.com>
Message-ID: <CAK8P3a1aO+LUu6KsW+s8aZMNWt2yz7kqe=LARY=ifMKOqT9uNQ@mail.gmail.com>
Subject: [GIT PULL 0/4] ARM: SoC changes for v5.7
To:     Linus Torvalds <torvalds@linux-foundation.org>
List-Id: <soc.lore.kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:JqxCFDR/PQjD1nCRYpgYTy4Itt0NwKS/2YPjFf60Z3NHPfc5BU1
 8adV/hN6NgsBtylbE/VreoXnGWYJrpbFJUGa6ZZ91lziQH24005piRbtlAqshWNddmI/0G+
 g5UOr3uMyRYCTrqe5G9a+h8n5L/pKUUBiVQXfpUkm0hB0pBIXqCXzcjTr5Jjs4vmr61IDz8
 KNbw98TNpgeb/nUuOni3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hpu79LK/B7A=:ro+Z2s4AINaPiHYwnS8ry3
 JH4j8bujP//Zh/r7NWnc6+DGyQGpGYsJ33tNayV5EFKKyhERjaY+BS6SxI2ft1ldSzMheHGIJ
 +8Pt4lTJVpUmU6CaSs15ToviRedPZlTVrOV61iyeR8UwmZYxhcptWhjmj53CzY9KyHk9m5rCr
 g+rvhgc6po9tDkbCCpO72qHLYW6pFMSPdmRlKBEPtctwn4wOG/8KlvfC9waMgQPhvflRq1NNx
 vDswrtUllFhrXlxgqjJ51NwNProTy6oIBr+m+FQVd6fmUizOuADkysteaZYLvFql4fE0zO6vH
 ouAS/5AjNcxvHpRteu4NsJW3q6O3czyf0Ek5dd9XLgIUCob8yhUUZwqQczRIz6dUuQKWASOp9
 hEgp4EeWm65bQlKuf0QP3dnz+/cs/gIs51SnCP+WHjO58JsRWpU64nmKXZvIUJKlSL8Mj3Tqu
 e96OmaUSKnLnC64EkuInKEvbyAg7HuQUN9wd3Et4O4pP4LUqeYlJpjO+Ukr+OuPX/UAjVVP/3
 iA0R8PdhWla4Rw4whH/0OHqykgWXmzg7xqF7uMQiSGiBtR6U/0Txv0DAR6HamRrDKpoS/rLFp
 ILnF3CGD9r7Fd8kQvJESWOr01IHNub8wZszV4wGv+RGUNK08wuvO8jmip2KBBI5RHXKQOGV5q
 rcjTZRoFt6/d6EMdVNB2rq78FcBZ9P1SWSCWx9SYVf6r+6ktKClp1JMF9Aiyi1veb3ZmWAihC
 rukfNZ6YbKokTQoMGlwHm2hMX8KShrV+Cbo9CyZz5OK24y8KoNTT7dHb7blm/Y2oyy4LC/aJH
 unNGfAIqsFzDD2zSBJDcgKvghQjyxAqH2xFjK6lnWLkskS7g0o=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are four pull requests for the soc tree, more of the usual, with roughly
two thirds of the changes for devicetree files, and the rest split between
DT binding updates, SoC specific drivers and 32-bit ARM platform code.

I like how most of the added machines are for fairly new hardware, as
this shows hardware manufacturers caring about upstream support.
It's also nice to see new support for old hardware like the Samsung
GT-S7710 XCover 2 added by hobbyists.

By changed lines (DT and drivers), most of the changes are now clearly for
64-bit platforms, though the number of changesets and the number of newly
added machines is slightly higher for 32-bit this time.

Overall we have 180 individual contributors on 714 patches, with only 14
people contributing 10 or more patches.

=== Top contributors by number of non-merge changesets ===

     66 Tony Lindgren
     40 Anson Huang
     33 Johan Jonker
     22 Li Yang
     21 Geert Uytterhoeven
     20 Dmitry Osipenko
     13 Linus Walleij
     12 Bjorn Andersson
     11 Nagarjuna Kristam
     11 Marek Szyprowski
     11 Florian Fainelli
     10 Sowjanya Komatineni
     10 Michael Walle
     10 Jernej Skrabec

=== Dirstat ===

   1.5% Documentation/devicetree/bindings/arm/bcm/
   2.4% Documentation/devicetree/bindings/arm/tegra/
   4.0% Documentation/devicetree/bindings/arm/
   0.8% Documentation/devicetree/bindings/
  24.4% arch/arm/boot/dts/
   0.5% arch/arm/mach-at91/
   4.7% arch/arm/mach-omap2/
   1.9% arch/arm/mach-tegra/
   1.8% arch/arm/
   2.7% arch/arm64/boot/dts/allwinner/
   1.0% arch/arm64/boot/dts/amlogic/
  15.7% arch/arm64/boot/dts/freescale/
   5.6% arch/arm64/boot/dts/mediatek/
   1.3% arch/arm64/boot/dts/nvidia/
   6.9% arch/arm64/boot/dts/qcom/
   0.8% arch/arm64/boot/dts/renesas/
   3.4% arch/arm64/boot/dts/rockchip/
   0.5% arch/arm64/boot/dts/
   2.4% drivers/bus/
   1.0% drivers/cpuidle/
   2.2% drivers/firmware/arm_scmi/
   0.6% drivers/soc/amlogic/
   3.3% drivers/soc/fsl/dpio/
   3.5% drivers/soc/qcom/
   3.1% drivers/soc/tegra/
   0.8% drivers/soc/
   0.9% drivers/
   0.8% include/
 648 files changed, 25235 insertions(+), 6618 deletions(-)

       Arnd
