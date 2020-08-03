Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61C6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F38A0207DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgHCVev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:34:51 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:54761 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCVev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:34:51 -0400
Received: from mail-qv1-f52.google.com ([209.85.219.52]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N1x2P-1kikzp2B7R-012E1M for <linux-kernel@vger.kernel.org>; Mon, 03 Aug
 2020 23:34:48 +0200
Received: by mail-qv1-f52.google.com with SMTP id o2so18052527qvk.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 14:34:48 -0700 (PDT)
X-Gm-Message-State: AOAM530lp/h0F5ZlZFf4quKUjKiwL6dO/WGzYmnDS3uaGh6uSr7Whs5N
        TuQVtnhx3TGbvk08vUuI3N3g3G0UX3p9DrAqJ0M=
X-Google-Smtp-Source: ABdhPJxTK4tgrh4sU9VlUeWOoFabKel++ecPThRSQASrWl2eLcYmWgQ32PsUHYMdilpDwudoIeMcAkVBz70h5NieKA8=
X-Received: by 2002:ad4:450e:: with SMTP id k14mr17845004qvu.211.1596490487306;
 Mon, 03 Aug 2020 14:34:47 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 3 Aug 2020 23:34:31 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1vFJ+uUGPGifZGhECXvxA=2u745WrGNZb08s1nHkZQ9g@mail.gmail.com>
Message-ID: <CAK8P3a1vFJ+uUGPGifZGhECXvxA=2u745WrGNZb08s1nHkZQ9g@mail.gmail.com>
Subject: [GIT PULL 0/5] ARM: SoC: changes for v5.9
To:     Linus Torvalds <torvalds@linux-foundation.org>
List-Id: <soc.lore.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:nS5oN+30YK3+oYS+RJhdLvvUtdiSML9U+4IqAQjPEE+ymFpMJxg
 iNN6nOCvR5MAIz9wKt9e7qbafPUw7mU48kNbXBV0sxRuBw7biWJYTfua8l61MbCFDstVfSv
 2EPK4YqU04Jc23Nfm390dqb4YxMYQU99bpqAbNEfb1Y5T8fxN/5ukVfUdBujTf15gqo2lA/
 tDuE9e2RtTla8OLS0ZN6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AHkdtiTmKNw=:zaHEy4LUx8f2gXKRbIwAH6
 UdclTR7Jf7o4OJK0QlrtZLy0Am1RlLpo4JRvAmiIQ22pFE9e7MTjOBXtgGfU4K0aDIiyXw0bh
 2lGXZwnKlnm132775fLggVoCsNbDcMjI6p8dicJVGd2pvGP9BGOqorYhWfapBuYx2hF4icq1X
 YWiDa1Gvc5YbyOlHdlYH7FSxMkUwIud8+h6DOICy0AJineqJXAY0WovOFPGb5OsgVzmPgV5Wz
 WEsueAnLYh5zNpT/ytvei8C4ZpaZlELxcfz8g2Rtha5+XpYG/aCZ5GqwR7JNd8lS1dHV/qraa
 22F9de9qNMKlGOVXAa48RGcgZh9TzQY276Gxdz9A/7j8XJ/7TZMVn3S4KCk1o1CgyzPTK0oRJ
 +ginlZAk++V5ST88xHtiHRerNNPWfTkoDGTu/Pa2G3Dox08RfVTIntIEfSv3qLoPXrkzVxW1v
 HIIXQhI0hS0Wo20LRQtoFweXm1jpwS9YT6pzLMhf2Jod71NWCYXsJQDdM9tGvpm3TvM59Aj+s
 89sZQRsyUvlYlhxqIjH8xrnJ2CdVE6vYZDVJNKhM4GK6LwzLVuxSfh6kR67BUuVoboRHax+gp
 qWrp3k0ATZ5zYoI0tzCyUbIZk1O8r3Ra/cDptHkPgE9rhm2AyNxdEw37oPeibY+PvDLliwsg7
 NWa6/9/lEOoIrCGbwHpPDvFaE9M9jdcOKc1fRxXn1h4VN5Nj/VKnLBQTKrWk8J6vnAer+Tb5o
 DkC0vWb10HbusWcy6QlmT/kgvn6SdtaCzts3x5bqaRyBngrXybKbLeVHijCBSK2e5eQ7/WYIk
 rj6a847NCitd0SLgwFK/DRo9jeTUJWXH/C4gUgrVdaCsYU45N/hXWohVatj3xVRPkTt5ZVw
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is much of the usual this time, but there are also three parts
I find worth pointing out in particular:

1. We tend to add support for new SoCs every merge window, but
   usually these are all variations of those we already support.
   This time there are three newly added families of Arm SoCs:

   - Intel/Movidius Keem Bay
   - Microchip SparX5
   - Mediatek (Mstar) Infinity3/Mercury5

   There is a separate pull request for these three that has
   additional details.

2. In the past few merge windows we have seen an increase in (usually
   older) Android phones and tablets gaining mainline kernel support.
   This time we get a total of eight Snapdragon phones and two Tegra
   tablets. To me this indicates that we finally have sufficient driver
   support, in particular on the GPU side, to make this workable.
   It also shows the impact that a single hobbyist developer can have,
   as most of the new support was submitted by Konrad Dybcio who only
   started contributing kernel patches to mainline Linux for postmarketos
   earlier this year.

3. The memory controller subsystem in drivers/memory used to be handled
   mostly by having patches through the soc tree, but without proper
   review from someone who understands the details of memory
   controllers. Krzysztof Kozlowski has now taken over maintainership
   and sent a good set of drivers cleanups that are part of the
   soc drivers branch.

Overall we have a total of 864 non-merge changesets from 164 authors,
with most changes coming from these developers:

     90 Thierry Reding (Tegra)
     58 Krzysztof Kozlowski (drivers/memory, Samsung Exynos)
     39 Lad Prabhakar (Renesas)
     33 Konrad Dybcio (Snapdragon based phones)
     25 Daniel Palmer (Mstar SoC)
     22 Marian-Cristian Rotariu (Renesas)
     18 Benjamin Gaignard (STM32)
     15 Suman Anna (TI OMAP)
     15 Sudeep Holla (SCMI, soc-device)
     15 Peng Fan (i.MX8)
     14 Maxime Ripard (sunxi)
     14 Geert Uytterhoeven (Renesas)
     14 Anson Huang (i.MX)
     13 Lubomir Rintel (MMP2/3)
     13 Cristian Marussi (SCMI)
     12 Rajendra Nayak (Snapdragon)
     12 Bjorn Andersson (Snapdragon)
     11 Martin Blumenstingl (Meson)
     11 Jagan Teki (Rockchip)
     10 Grygorii Strashko (TI K3)
     10 Erwan Le Ray (STM32)
     10 Douglas Anderson (Snapdragon)
     10 Alexander A. Klimov (sed -i 's/http/https/g')

The overall dirstat shows most of the changes as usual being for
devicetree files, again split roughly 50:50 between 32-bit and
64-bit. Other changes are a Tegra driver update from Thierry,
and some owrk on the scmi firmware code.

   0.5% Documentation/devicetree/bindings/arm/
   0.4% Documentation/devicetree/bindings/reset/
   0.2% Documentation/devicetree/bindings/soc/qcom/
   0.3% Documentation/devicetree/bindings/soc/ti/
   0.3% Documentation/devicetree/bindings/
  36.1% arch/arm/boot/dts/
   0.2% arch/arm/mach-mstar/
   1.2% arch/arm/mach-omap2/
   0.4% arch/arm/mach-s3c24xx/
   1.2% arch/arm/
   0.4% arch/arm64/boot/dts/allwinner/
   0.6% arch/arm64/boot/dts/amazon/
   1.1% arch/arm64/boot/dts/amlogic/
   0.3% arch/arm64/boot/dts/exynos/
   1.0% arch/arm64/boot/dts/freescale/
   0.8% arch/arm64/boot/dts/hisilicon/
   0.3% arch/arm64/boot/dts/intel/
   1.5% arch/arm64/boot/dts/mediatek/
   0.8% arch/arm64/boot/dts/microchip/
   6.1% arch/arm64/boot/dts/nvidia/
  13.8% arch/arm64/boot/dts/qcom/
   6.0% arch/arm64/boot/dts/renesas/
   0.8% arch/arm64/boot/dts/rockchip/
   1.0% arch/arm64/boot/dts/ti/
   0.2% arch/arm64/
   4.2% drivers/firmware/arm_scmi/
   0.2% drivers/firmware/imx/
   0.2% drivers/firmware/smccc/
   0.5% drivers/firmware/tegra/
   0.2% drivers/firmware/
  10.4% drivers/memory/tegra/
   0.8% drivers/memory/
   0.4% drivers/soc/qcom/
   0.3% drivers/soc/samsung/
   0.3% drivers/soc/ti/
   0.2% drivers/soc/versatile/
   0.3% drivers/soc/
   0.5% drivers/spi/
   0.4% drivers/tty/serial/
   0.7% drivers/
   0.3% include/dt-bindings/
   0.5% include/linux/
   1.5% include/soc/tegra/
 918 files changed, 50867 insertions(+), 9369 deletions(-)

       Arnd
