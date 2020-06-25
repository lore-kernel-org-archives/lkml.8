Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F77C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BADA0207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tX+4DN4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390745AbgFYIij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 04:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389830AbgFYIii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 04:38:38 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B37C061573;
        Thu, 25 Jun 2020 01:38:37 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id n24so5143927ejd.0;
        Thu, 25 Jun 2020 01:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PTxdbzLqI5NPY4frU0Yxsx5xreH6CLu/gFui4TmQzOE=;
        b=tX+4DN4OtzwshaAwLszExAyG2QT87xi7gho7QWvE4y6hcF9p+2zd0nlClpQ+dylksm
         RUPDDItfjcsJb0pHqpTyOvIi4LMNhpwyxSt2a6sY0jNADBSxtpruelLOrHIyf1VluvsY
         T3ku9esmsZ3uVRY+vAN5NBTzisyQMgm0h6R6JwH5YTkoh5jA9B1avNA/NA53tqCqt5TJ
         zn8CAgZcZae4v2QO8hHcbnROou2Bn4Lfg1EkziFAF10s/+2zuraBWbaY1++6ADfkCNaQ
         gbfQnkfNqggG2noZbnVW/AAPSTBp2eUUUfECw+DV4+JDGpu/eAjCIhKEs+tuHJoEjj4a
         7ycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PTxdbzLqI5NPY4frU0Yxsx5xreH6CLu/gFui4TmQzOE=;
        b=m1ozCKxxwwvSF3dy2YUh9y+d0r1GDG/Nc5szjWY/o3inPbvMGtF5MfheuNYlaS2AH3
         tiGAc82HQHwTDZsdPkFZ4mBcUODU52XxXv33r+3VUwE0HoxzxaFaPSu/OURUXsWvmZdi
         Z9chOw+c1cYNkHegYQicBBJhlbhbhuNBL5E/qnURhp3xBcTNNVYsK3A7lpJ2psLCfUiq
         Vorv3dY5cbPvh/B9+KshcSth3acy2N25LbbEoFNqNAL87/cuUdgyU6ffDAG5mPkRAnwH
         SeHpBR9zcKJ8WQnXZF5R4KlAHoT3kBeHwZCq9pB/9xj01/KmShKx/TndcaQNawGMPu8A
         dKNg==
X-Gm-Message-State: AOAM5318w/FFdMekPwWof0mwh93/MZuGmnK/TOQuEW0uj4xW/Io8835Z
        whROTgVvlL667xbPobJIkvUF4fd7AiI=
X-Google-Smtp-Source: ABdhPJwg4V/WS4PYVICa/W4Cq2Y1Dg4Rzf70Y+RrdZaFT7MfxeLlvmXs+0g7eKtlUCcBxragWtsk8w==
X-Received: by 2002:a17:906:e294:: with SMTP id gg20mr10632984ejb.521.1593074316139;
        Thu, 25 Jun 2020 01:38:36 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id d16sm8440908ejo.31.2020.06.25.01.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 01:38:35 -0700 (PDT)
Subject: Re: [RFC PATCH v1 0/2] rk3318 A95X Z2 board
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200620134659.4592-1-jbx6244@gmail.com>
Message-ID: <58daf826-1a7b-0c7d-5c55-50746af408ec@gmail.com>
Date:   Thu, 25 Jun 2020 10:38:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200620134659.4592-1-jbx6244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Status update.

On 6/20/20 3:46 PM, Johan Jonker wrote:
> status: EXPERIMENTAL

> What works:
>  uart2
>  mmc
>  emmc
>  sd card
>  usb2

///////////////////////////

USB2:

The usb2 port only works reliable with:

	dr_mode = "host";

Question for Heiko:
Should we change that in rk3328.dtsi or in rk3318-a95x-z2.dts?

///////////////////////////

USB3:

The usb3 port does work with the drivers phy-rockchip-inno-usb3.c and
dwc3-rockchip-inno.c. This work around however still gives a warning for
storage devices..

Disconnect a ttyUSB device gives this log:

[   25.215260] cp210x 4-1:1.0: cp210x converter detected
[   25.219970] usb 4-1: cp210x converter now attached to ttyUSB1

[..]

[   27.413766] usb 4-1: USB disconnect, device number 2
[   27.415492] cp210x ttyUSB1: cp210x converter now disconnected from
ttyUSB1
[   27.416517] cp210x 4-1:1.0: device disconnected

When we disconnect a USB Mass Storage device it give a warning about the
cable.

[   61.597606] usb 5-1: new SuperSpeed Gen 1 USB device number 2 using
xhci-hcd
[   61.622267] usb-storage 5-1:1.0: USB Mass Storage device detected
[   61.624285] scsi host0: usb-storage 5-1:1.0

[..]

[   81.238511] usb 5-1: USB disconnect, device number 2

[..]

[   83.737413] usb usb5-port1: Cannot enable. Maybe the USB cable is bad?
[   86.370725] usb usb5-port1: attempt power cycle

///////////////////////////

adc-key test OK with:

./evtest

///////////////////////////

ir test OK with:

./insmod  gpio-ir-recv.ko
./ir-keytable -w /usr/etc/rc-keymaps/protocols/a95x_z2.toml
./evtest

The remote control has 2 buttons for KEY_VOLUMEDOWN and KEY_VOLUMEUP.
The linux definitions have only definitions for 1 key set.

Question:

How can I differentiate between them?

a95x_z2.toml:

[[protocols]]
name = "a95_z2"
protocol = "nec"
variant = "nec"
[protocols.scancodes]
0xdf1c = "KEY_POWER"
0xdff1 = "KEY_POWER2"
0xdff2 = "KEY_VIDEO_NEXT"
0xdff3 = "KEY_MUTE"
0xdff4 = "KEY_VOLUMEDOWN"
0xdff5 = "KEY_VOLUMEUP"
0xdf4b = "KEY_PROG1"
0xdf4f = "KEY_PROG2"
0xdf01 = "KEY_PLAY"
0xdf5f = "KEY_HELP"
0xdf5c = "KEY_VOLUMEDOWN"
0xdf5d = "KEY_VOLUMEUP"
0xdf42 = "KEY_HOME"
0xdf0a = "KEY_BACK"
0xdf1a = "KEY_UP"
0xdf47 = "KEY_LEFT"
0xdf07 = "KEY_RIGHT"
0xdf48 = "KEY_DOWN"
0xdf06 = "KEY_OK"
0xdf03 = "KEY_REPLY"
0xdf18 = "KEY_MENU"
0xdf54 = "KEY_1"
0xdf16 = "KEY_2"
0xdf15 = "KEY_3"
0xdf50 = "KEY_4"
0xdf12 = "KEY_5"
0xdf11 = "KEY_6"
0xdf4c = "KEY_7"
0xdf0e = "KEY_8"
0xdf0d = "KEY_9"
0xdf41 = "KEY_FN"
0xdf0c = "KEY_0"
0xdf10 = "KEY_DELETE"

///////////////////////////
