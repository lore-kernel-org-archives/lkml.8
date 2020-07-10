Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3275C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F1520578
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aU5vFsGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgGJNfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbgGJNfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:35:44 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75339C08C5CE;
        Fri, 10 Jul 2020 06:35:44 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a6so5972008wrm.4;
        Fri, 10 Jul 2020 06:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pcu0Eg7imOgQYQ8JN6mtpvtmf6u//VnM39M0xQJqGUU=;
        b=aU5vFsGNRzaaoc86acvShDE01Vi87Fv1TgnVd9GBWaJB0URfyEzvQYA4+zUAy46Gic
         sRP7IHHhL2VNfAfynJa32+onW70//VypAZAe5h3ph0VcE16f7zcdYzZ+Yz4f2lz3cIRt
         WjFCOYGpdb3V2qFvtar7M09pbsBo/B5d8v+8u9M8aJ6RbDQvqiDGdXtbWuaXM1GGWzJJ
         0x71DvnBt4WIO8KStt1b0qsDLp8xuhGIAZQohN4h8OcCBeRittgEoRxdr68knrBUeG4j
         EYaRgR0h8uLRL4iXlYqR+BJROYe7HUNGJIzDFmTzCq6GmMFw1aFRJmtEL0F3tIBtcHA8
         Jhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pcu0Eg7imOgQYQ8JN6mtpvtmf6u//VnM39M0xQJqGUU=;
        b=CgnV3JCbdd//f1UlyRIGN2Y2OYX154NPB8C+NHYUiubV33YRY1dMfUK1ZVGH5bNrB0
         4+uela/GfnHvnWPno6Dk9G8vIu6g6LqlSoxGGsYvE4N0GNjh9n02IFKb65HVSNAVX6mU
         TQb++5GltHpTBn9qy/PumqfoQvpv7e859D8qlM9P7KMeL5DGZE3Ef55eZBP+OcQTW3ih
         hkgSuhtNF9pn7REAnmWf/ZEtrEeDpG9Cjka/228okBOSheNu/y/3UFPBRJ+Ys1zDppsS
         1qeF7mQpN+3RUBXJotTINVmg0pN+TwSOn7I2VrOSs7qmDJK0IY/1jRtzQ170yTRhHrxE
         YCsA==
X-Gm-Message-State: AOAM533ZTRKpcB7SLUCWRMpRHzYqP/fNYlhjCzUwG4Nl7t14px8Nc+wK
        EeuH/QacNjn6xyFdm/+PNxo=
X-Google-Smtp-Source: ABdhPJyYDokQFADuzvB+3ohSsCn3hmF+qR7PKc2B+9jiNeNISA7L4M34l2vJL7aOR1Oxvz+Gbys+aw==
X-Received: by 2002:a5d:60c7:: with SMTP id x7mr63692271wrt.138.1594388143209;
        Fri, 10 Jul 2020 06:35:43 -0700 (PDT)
Received: from ziggy.stardust ([213.195.114.245])
        by smtp.gmail.com with ESMTPSA id w12sm11053704wrm.79.2020.07.10.06.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 06:35:42 -0700 (PDT)
Subject: Re: [PATCH v2 0/7] arm64: dts: mediatek: Add support for Lenovo
 IdeaPad Duet Chromebook
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, erwanaliasr1@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        Mars Cheng <mars.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20200625101757.101775-1-enric.balletbo@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <e748b9b4-fa5e-b80b-d76c-305cc53aed74@gmail.com>
Date:   Fri, 10 Jul 2020 15:35:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625101757.101775-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/06/2020 12:17, Enric Balletbo i Serra wrote:
> These series adds basic support for the Lenovo IdeaPad Duet Chromebook, a
> 2-in-1 detachable devices using the MediaTek MT8183 SoC. The first patch
> only adds the new compatible names in the mediatek binding. The second
> patch, adds the missing compatible to instantiate the PMIC regulators.
> The next patch adds missing devices to support better the board and fixes
> some warnings found running dtbs_check. And finally, the latest
> introduces support for the board itself.
> 
> All the patches has been tested on Lenovo IdeaPad Duet Chromebook with
> the patches applied on top of 5.8-rc1 and with serial console, booting
> without problems and being able to go to the login prompt.
> 
> Best regards,
>    Enric
> 
> Changes in v2:
> - Replace cluster-sleepX for cluster-sleep-x (Matthias Brugger)
> - [6/7] Move adding #phy-cells to this patch. (Matthias Brugger)
> - [7/7] Move adding #phy-cells out of this patch. (Matthias Brugger)
> 
> Enric Balletbo i Serra (7):
>    dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-krane-sku176
>    arm64: dts: mt6358: Add the compatible for the regulators
>    arm64: dts: mt8183: Add MediaTek's peripheral configuration controller
>    arm64: dts: mt8183: Fix unit name warnings
>    arm64: dts: mt8183-evb: Fix unit name warnings
>    arm64: dts: mt8183: Add USB3.0 support
>    arm64: dts: mt8183: Add krane-sku176 board
> 

Whole series applied to v5.8-next/dts64

Thanks!

>   .../devicetree/bindings/arm/mediatek.yaml     |   5 +
>   arch/arm64/boot/dts/mediatek/Makefile         |   1 +
>   arch/arm64/boot/dts/mediatek/mt6358.dtsi      |   2 +
>   arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |   4 +-
>   .../mediatek/mt8183-kukui-krane-sku176.dts    |  18 +
>   .../boot/dts/mediatek/mt8183-kukui-krane.dtsi | 343 ++++++++
>   .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 788 ++++++++++++++++++
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  68 +-
>   8 files changed, 1225 insertions(+), 4 deletions(-)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> 
