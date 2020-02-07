Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9F0C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 19:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20CA21741
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 19:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SThYRxgu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgBGTOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 14:14:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33450 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgBGTOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 14:14:19 -0500
Received: by mail-wr1-f67.google.com with SMTP id u6so241268wrt.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 11:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7vk1aAjw8ZtladZlhG16b83EoOxZYSlkCdQBetmjBWM=;
        b=SThYRxgudG2HjC2XQPPAR7aYj87HC2rcbMw8NyyC39D7pclzWLzkNhmo+kQd0+An1X
         kTkRoMqZRizKNOC9wdnifiQZbEnh2FB0l+vSprHtp2v/Z10BTzhoagrl/8yVmwbIzi5V
         9sk6xwalJKggeMECSV1i+1vRKCUjhf7YnVMIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7vk1aAjw8ZtladZlhG16b83EoOxZYSlkCdQBetmjBWM=;
        b=DJBlTJT0klL8B/nCWhTWByetgreBh0a25D1zsKRvLvwm6nbQXL8LHXpkdsOkL7f+wz
         Hs3RPyJZ1yo6RpQd0gI00qvrn0Ug9QRMzKl/23N1fYC9UMKMPHEJpSBAhXwfAX62QBSw
         quAEbO0FlM87/6w6vdS2qJmqcvBA10MhqvzQ0N/uXwszhTaBUFlVBYYWIBAKm7zJmGkm
         924B26bacWuJTzLUomV+z1OmALpo5vJReC/j6rQrEuOGpxvJGunRVf4QhfB/8fJAdCm1
         yB0wFKSgtuR/Pwg5YJhfXQyWD66S/4dxjKqM+F9X6oZdRngruP60cRUKWcy+sWFnP/Lv
         Q6Uw==
X-Gm-Message-State: APjAAAW1QoFvCjIn6BolLXHuxIbc2e6UqwGnl9x4+/pBt3lAPCYhbZu5
        Iao1G0/0v+X0mJEndre8xX+khaJDENXUxg039XBozqbe
X-Google-Smtp-Source: APXvYqyZkIAZ4BXvFcG5Oq2N9Gzy4VxNWIabeIvUv/ObWa0bGX94f4+F/ifSy3djcWk9SISgHxgds+kWx+674IGfnzM=
X-Received: by 2002:adf:f586:: with SMTP id f6mr497161wro.46.1581102856853;
 Fri, 07 Feb 2020 11:14:16 -0800 (PST)
MIME-Version: 1.0
References: <CAOf5uwmPMRq4v9=5-Z=XLH7hATC-AhXQWthfy_uvYTXSo6V+CA@mail.gmail.com>
In-Reply-To: <CAOf5uwmPMRq4v9=5-Z=XLH7hATC-AhXQWthfy_uvYTXSo6V+CA@mail.gmail.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Fri, 7 Feb 2020 20:14:04 +0100
Message-ID: <CAOf5uwnRLn7tXFRxjPGASuCnmOwooA4Ytk28Zc+A0kp=UZDQWw@mail.gmail.com>
Subject: Re: siimple-framebuffer rockchip persistent logo
To:     Kever Yang <kever.yang@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Cc:     Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

I move a bit on this

On Sun, Jan 12, 2020 at 6:16 PM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Kever
>
> Trying to have a persistent banner from uboot to linux-kernel. I'm
> right now working on linux-rockchip kernel but I think that the
> problem is even on mainline
>
> +               framebuffer: framebuffer@7f800000 {
> +                       compatible = "rockchip,simple-framebuffer",
> +                                    "simple-framebuffer";
> +                       reg = <0x7f800000 (1920 * 1080 * 4)>;
> +                       width = <1920>;
> +                       height = <1080>;
> +                       stride = <(1920 * 4)>;
> +                       format = "a8b8g8r8";
> +                       clocks = <&cru  PCLK_HDMI_CTRL>, <&cru SCLK_HDMI_HDCP>,
> +                                <&cru SRST_LCDC0_AXI>, <&cru
> SRST_LCDC0_AHB>, <&cru SRST_LCDC0_DCLK>,
> +                                <&cru ACLK_VOP0>, <&cru HCLK_VOP0>;
> +                       status = "okay";
> +               };
>

Now I can allocate the parameter using the bootloader and create the
right mapping for the simple framebuffer. I don't even understand
how sunxi and meson can work if they don't create a reserved memory
using no-map. This is fixed on my side so the log is totally clean.
I have added the deregister of simple fb and handover to the drm

Now my boot parameters are:
Kernel command line: console=ttyS2,115200n8 root=/dev/mmcblk0p1
rootwait pd_ignore_unused clk_ignore_unused

Still I have display go off on tinker during boot. Any suggestion?

Michael


> Seems that it get off before I reach the drm registration
>
> [    2.077495] simple-framebuffer 7f800000.framebuffer: framebuffer at
> 0x7f800000, 0x7e9000 bytes, mapped to 0xf0900000
> [    2.077519] simple-framebuffer 7f800000.framebuffer:
> format=a8b8g8r8, mode=1920x1080x32, linelength=7680
> [    2.161225] simple-framebuffer 7f800000.framebuffer: fb0: simplefb
> registered!
> [    3.433847] fb: switching to rockchip-drm-fb from simple
>
> I don't find all the clocks and if those are the only think that I
> need to stay on. Any suggestion?
