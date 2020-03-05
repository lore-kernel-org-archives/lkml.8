Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F17C3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFD020828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XQhSxSzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgCEIWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 03:22:06 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39703 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgCEIWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 03:22:05 -0500
Received: by mail-wm1-f66.google.com with SMTP id j1so4658606wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 00:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:subject:in-reply-to:date:message-id
         :mime-version;
        bh=wy8PG+5094H0kwoE9azcIFtGBXe17DljDLj1gap6KjQ=;
        b=XQhSxSzu+98TQDBaQbX8qV6wCsTohykSPQpUarrD/+uUdM2OhBCJRgfHiQgAeL2bqG
         G87zQyeBW8INB88/a53JTOHfVNbpSp170zFo6ePYkoaYwrIkfClzdYU/ZE072Pq2MwIZ
         Gm1D0BQH7FmM5AiBCcb01izbcw1l1h42XG0YJgv8L9V0og6/XIQgYZ8AQ8mGWH/HAM3a
         cZHIb+VqXxsktjtO3C4zj7LMmWlcHd766DKDxx+7HwWMdGqV5C5Nfz3aJBhl9G60u4ZM
         iJ2Nzj+6dVprj7KACOhkfYoW0JHDsxB7scJbNkpoq+xbFn94AW9l5OBu7i1aWpIZEQv9
         PNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:subject
         :in-reply-to:date:message-id:mime-version;
        bh=wy8PG+5094H0kwoE9azcIFtGBXe17DljDLj1gap6KjQ=;
        b=mKRNPdXPrtIupADzq3ediT8yuBTd1CjV321uPgdYqT7s3w75zgSEEGPqyNT8XlCQMq
         MDW81ikfW19DkLSJGdtthrAfqWge7mJm0PbuzaMMl7onazSU/9bIzK2g+/Cp/8uVkqgk
         UfVbT0iC3ci6JcgS126TGlB7625CKeAGv86Zjwm2Xu++Uzo0K3PAnEWa29QCHsCO21qc
         2yNU/u0z1MnTbqgz5Vswi7jGxpCCceenSvB27DyRJXqiGrUSBuytrFT4X3imb8GSEard
         4nObiYi4WmdZPru45sC0+BaRhaif3vc3RVaiPjLw7n1/xuXv16iH5xsPSuuqmVS9337p
         LKQw==
X-Gm-Message-State: ANhLgQ3OnwyjJ2eMM0eSdqukYptFETQXECRkEwHqlRiGmKFjLOLSklSs
        4PhiPj2VY75NgkzPMPPN8qkHUQ==
X-Google-Smtp-Source: ADFU+vtQyU4UfDH9d2/TXDERF+INdtSbx2/ljMK+EMqmPS+JCjhE5+wuGnUWn9fPAey5YSeP3jbcRA==
X-Received: by 2002:a1c:dd45:: with SMTP id u66mr8644559wmg.154.1583396523188;
        Thu, 05 Mar 2020 00:22:03 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m16sm11943105wrs.67.2020.03.05.00.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 00:22:02 -0800 (PST)
References: <1582985353-83371-1-git-send-email-christianshewitt@gmail.com> <1582985353-83371-3-git-send-email-christianshewitt@gmail.com> <cc4c54c8-aa7f-8755-dc35-94e32d0019cd@baylibre.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: meson-g12b-gtking: add initial device-tree
In-reply-to: <cc4c54c8-aa7f-8755-dc35-94e32d0019cd@baylibre.com>
Date:   Thu, 05 Mar 2020 09:22:01 +0100
Message-ID: <1jftencity.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 03 Mar 2020 at 15:50, Neil Armstrong <narmstrong@baylibre.com> wrote:

> On 29/02/2020 15:09, Christian Hewitt wrote:
>> The Shenzen AZW (Beelink) GT-King is based on the Amlogic W400 reference
>> board with an S922X chip.
>> 
>> - 4GB LPDDR4 RAM
>> - 64GB eMMC storage
>> - 10/100/1000 Base-T Ethernet
>> - AP6356S Wireless (802.11 a/b/g/n/ac, BT 4.1)
>> - HDMI 2.1 video
>> - S/PDIF optical output
>> - Analogue audio output
>> - 1x USB 2.0 port
>> - 2x USB 3.0 ports
>> - IR receiver
>> - 1x micro SD card slot
>> 
>> The device-tree is largely based on meson-g12b-ugoos-am6.

largely indeed ... Would you mind pointing out why the am6 dts can't be
used and why this one is needed ?

Maybe I missed something but they look the same to me.

>> 
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/Makefile              |   1 +
>>  arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts | 557 ++++++++++++++++++++++
>>  2 files changed, 558 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
>> 
>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
>> index eef0045..1fd28e8 100644
>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>> @@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-axg-s400.dtb
>>  dtb-$(CONFIG_ARCH_MESON) += meson-g12a-sei510.dtb
>>  dtb-$(CONFIG_ARCH_MESON) += meson-g12a-u200.dtb
>>  dtb-$(CONFIG_ARCH_MESON) += meson-g12a-x96-max.dtb
>> +dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking.dtb
>>  dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-khadas-vim3.dtb
>>  dtb-$(CONFIG_ARCH_MESON) += meson-g12b-s922x-khadas-vim3.dtb
>>  dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2.dtb
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
>> new file mode 100644
>> index 0000000..819f208
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
>> @@ -0,0 +1,557 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2019 BayLibre, SAS
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + * Copyright (c) 2019 Christian Hewitt <christianshewitt@gmail.com>
>> + */
>> +

[...]

>> +
>> +&spdifout_b {
>> +	status = "okay";
>> +};
>> +

Again, not support by the HDMI controller and not used in the sound card.
