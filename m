Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F749C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AAE420857
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+i6t1/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgFVICB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgFVICA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:02:00 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A32C061794;
        Mon, 22 Jun 2020 01:01:59 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id q19so17048198eja.7;
        Mon, 22 Jun 2020 01:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tKnwQ2j5y2YnX+5ChVTcEKkT8J5oqo183ugfqdKtiFU=;
        b=Q+i6t1/pBmJYoAYXknPPUbsP7Gy8oILmPOEmswYxSjFEaxZqDsOKjmozOoQTgynN6b
         paKDI+3sHmZ8zH52xHgmW1pqmjkc6zbSLaLrMEYV5RnaCgk634Orxiu5370t9JwjCEX5
         2Jjr5tIfA6VLKvNlekfFXJk12+LNAGDKBgv+Ji1Gf7jUsamDkys+KUF2qHshW5F3/vWv
         eRPCjgw76pUVd6v+VxrxgejTQ/+l8oJYQFnd7yZpRzC09Qpb0Kaw5A6koT7+k33TQqT0
         o037n1YslzBWjJ9BXW4/vakgMRQ7nE1EU+wLqOCWNUQhGX/EA5ibz26hAc41bFcPOppS
         92Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tKnwQ2j5y2YnX+5ChVTcEKkT8J5oqo183ugfqdKtiFU=;
        b=nuNNLTcwIycHdKC/0mp04qCZ3VRYL2bCh0aDqiK4STkZF6wMPgoNAfzMWeCnOPkTVE
         nbpDunvvlYQ8J6SCflhdp0dLoPTI8ui2RsXJQaZf/aZYbEgyb9qMzwb924x+F2oRRxkj
         Vh6lqEqnPWHStGkCRI25L8X/IpRCogOVuqlY3My4EXTvzG3xaJ+wFCxs8aig3OMD5nYV
         e5/STzbTdGbas2hKuCR4CZ+rwMl6ZNoMKn1sjz1OSKZMR78BM1y/wcu7Yc4TuNnwbuM/
         0mOtycDL3AHYiWr7nhDqXECH2Irf+2VMI1mxwO0SsffLOg9B4EEjAwwTRFo4EkpVFphD
         W5Ag==
X-Gm-Message-State: AOAM5324gYj0xg+MznXulWj5MGQ8e9e6ZfEUxCqDIws3QOQ3ropBIk5b
        b1Yq57+f6Ma8WSq/VP2DTq4=
X-Google-Smtp-Source: ABdhPJz6SmpQuenHDeJHMJ69tuqstcUiABOB/m9suNbzl2/EHGLfiDnSQA10vdY5oa4JuBHTtaTSPw==
X-Received: by 2002:a17:906:2304:: with SMTP id l4mr14284250eja.104.1592812917634;
        Mon, 22 Jun 2020 01:01:57 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id p9sm5921335ejd.50.2020.06.22.01.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 01:01:57 -0700 (PDT)
Subject: Re: [RFC PATCH v1 0/2] rk3318 A95X Z2 board
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, frank.wang@rock-chips.com
References: <20200620134659.4592-1-jbx6244@gmail.com>
Message-ID: <c421ed14-3b1d-7aca-d106-5e312a38840f@gmail.com>
Date:   Mon, 22 Jun 2020 10:01:55 +0200
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

BUG report 1:
About phy-rockchip-inno-usb2.c and rk3318.

Goal is to use ttyUSB0 as console in combination with agetty as long as
we don't have a working HDMI signal on a DVI monitor.
Boot with rk3318 starts normal on emmc with U-boot OK. It then loads the
kernel
and initrd on SD card. Log view on ttyS2 works.
At the end of the init process extcon0 sends 2 events sortly after each
other.
usb2 crashes if extcon0 event reports 'USB=0' and 'DCP=1'.
It looks like there's no consistant init (delay?) in the driver or hardware.

Boot only possible with busybox + initrd with no scripts that delay
event handling.
(Un)plug events are unrelayable. Getty only becomes active
if usb cable connected direct to the board(without usb hub).
With systemd only a kernel log scroll, but never able to use ttyUSB0 as
login.

mdev.conf line to catch the events:

extcon[0-9]+    root:root 666 */bin/cat /sys/class/extcon/extcon0/state
> /dev/kmsg

In extlinux.conf clk and pm must be ignored in the kernel command line
to prevent a crash.

label kernel
    kernel /Image
    fdt /rk3318-a95x-z2.dtb
    initrd /rootfs.cpio
    append console=ttyUSB0,115200n8
           console=ttyS2,1500000n8
           pd_ignore_unused
           clk_ignore_unused
           initcall_debug=1
           debug
           drm.debug=0xe
           video=HDMI-A-1:1280x720@60
           earlycon=uart8250,mmio32,0xff130000,keep
           swiotlb=1
           kpti=0
           no_console_suspend=1
           consoleblank=0
           rootwait

Question:
Does anyone have a solution for usb2 or
was there previous discussion/info about this?

Why has rk3328.dtsi incomplete (see TRM) power-domains and qos? Does
that work?
Was rk3318 VOP+HDMI, gmac2phy tested in Linux mainline before?

Kind regards,

Johan

Kernel log with usb2 OK:

[    0.959594] Run /init as init process
[    0.959937]   with arguments:
[    0.960210]     /init
[    0.960416]   with environment:
[    0.960703]     HOME=/
[    0.960917]     TERM=linux
[    0.961562] process '/bin/busybox' started with executable stack
[    0.967474] usb 1-1: new full-speed USB device number 2 using dwc2

[..]

[    6.785160] USB=1
[    6.785160] USB-HOST=0
[    6.785160] SDP=1
[    6.785160] CDP=0
[    6.785160] DCP=0
[    6.785160] SLOW-CHARGER=0
[    6.785165] USB=1
[    6.785165] USB-HOST=0
[    6.785165] SDP=1
[    6.785165] CDP=0
[    6.785165] DCP=0
[    6.785165] SLOW-CHARGER=0
[   13.729625] random: crng init done
[   31.715450] vcc_host_vbus: disabling

Kernel log with usb2 crash:

[    0.940666] Run /init as init process
[    0.941005]   with arguments:
[    0.941280]     /init
[    0.941490]   with environment:
[    0.941781]     HOME=/
[    0.941999]     TERM=linux
[    0.942536] process '/bin/busybox' started with executable stack
[    0.967442] usb 1-1: new full-speed USB device number 2 using dwc2

[..]

[    7.300792] USB=0
[    7.300792] USB-HOST=0
[    7.300792] SDP=0
[    7.300792] CDP=0
[    7.300792] DCP=1
[    7.300792] SLOW-CHARGER=0

