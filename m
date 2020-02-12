Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8CFC3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE03E20675
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="acclcE/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgBLLt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:49:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41065 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgBLLt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:49:26 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so1912999wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 03:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cmD9dIl/Cn0kv69K4stIs4I7W2zBHHJK55pAH/ZJ47c=;
        b=acclcE/sRMCwwwI3qfIXMIEYfQhDwFgFCHLPzR9bw0qstSofqRV0pf3FNFUCUOnvEw
         Fo4TIP/N8RDU/JMVYtDIo8IGMkICBw0+nH6cYwRz/WHCO7y85ywaYM5vPeCXUR2tdRmw
         Wb6XW1Sy4xkzhT7ij0woVvGwwK+tYs1yf6HRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cmD9dIl/Cn0kv69K4stIs4I7W2zBHHJK55pAH/ZJ47c=;
        b=RyegCPnY6bEjRmv7UJXWHDQ5RnCH8e8/gZd2bfxjW5rtX4Ob5CE/Y8azC4tt+awUnA
         7TRzFfMOh4KZ1g3EGUGSq8TjiR5NlBEjtOcPGBJ1ZfyZWYjXS3Ii2NtSH8A+1BZK4J7K
         2pC9lWIAD5lypbAkZvweiWkQyVpzghTp2Mdtx1TGsnlZOS0ZIxdhL73v6WULjMOcbjpz
         6bkbu/0KPSRb2RCTupC8yKPsmtSD/F27HPoyGaAUVaxo32b3bD7mYwhUlufKy+vki4mW
         R8N808vyooIvhGugDmyO2pA2lR1Rk+eKQn+6PaJgANb8nIoIEku1YgU4uyRismRzBQD2
         uf8w==
X-Gm-Message-State: APjAAAVoy6wopEK8aDGLhmzmNFEEErjdt04daxzCrPcX3SYxceB3Rdad
        WYjVxoVHt6ktWWNNzAS+m0o9x/Mo0zDFAGeNBmT65g==
X-Google-Smtp-Source: APXvYqzGbvkQN17/r8TFahQCuSW2Wlj9TKHmg3ifCvXdV/S5m70bJj2Ia346lmfK3hzvmpBnTFIOfgZmbL4XNZ8LvQU=
X-Received: by 2002:adf:b605:: with SMTP id f5mr14199856wre.383.1581508162663;
 Wed, 12 Feb 2020 03:49:22 -0800 (PST)
MIME-Version: 1.0
References: <CAOf5uwmPMRq4v9=5-Z=XLH7hATC-AhXQWthfy_uvYTXSo6V+CA@mail.gmail.com>
 <CAOf5uwnRLn7tXFRxjPGASuCnmOwooA4Ytk28Zc+A0kp=UZDQWw@mail.gmail.com>
In-Reply-To: <CAOf5uwnRLn7tXFRxjPGASuCnmOwooA4Ytk28Zc+A0kp=UZDQWw@mail.gmail.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Wed, 12 Feb 2020 12:49:11 +0100
Message-ID: <CAOf5uwnf6yF0sksjVRRzxLCD8xaMGhUhkOQ8CjwhYy85zcArLw@mail.gmail.com>
Subject: Re: siimple-framebuffer rockchip persistent logo
To:     Kever Yang <kever.yang@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko and Hans

I manage to have the persistent framebuffer but complete working video subsystem

THe problem is the follow

[    0.116514] rk_iommu ff930300.iommu: attaching to power domain 'pd_vio'
[    0.116539] rk_iommu ff930300.iommu: adding clock 'aclk_vop0' to
list of PM clocks
[    0.116561] rk_iommu ff930300.iommu: adding clock 'hclk_vop0' to
list of PM clocks
[    0.116989] rk_iommu ff940300.iommu: attaching to power domain 'pd_vio'
[    0.117013] rk_iommu ff940300.iommu: adding clock 'aclk_vop1' to
list of PM clocks
[    0.117032] rk_iommu ff940300.iommu: adding clock 'hclk_vop1' to
list of PM clocks
[    0.117335] rk_iommu ff9a0800.iommu: attaching to power domain 'pd_video'
[    0.117359] rk_iommu ff9a0800.iommu: adding clock 'aclk_vcodec' to
list of PM clocks
[    0.117377] rk_iommu ff9a0800.iommu: adding clock 'hclk_vcodec' to
list of PM clocks
[    0.117773] rockchip-pm-domain
ff730000.power-management:power-controller: Calling pd power off
[    0.117926] rockchip-pm-domain
ff730000.power-management:power-controller: Calling power domain off
[    0.117984] rockchip-pm-domain
ff730000.power-management:power-controller: Calling pd power off
[    0.118016] rockchip-pm-domain
ff730000.power-management:power-controller: Calling power domain off

As you can see the pd_vio domain are off even if simpleframe buffer
own them. The problem is that the
rk_iommu is registered before the simple framebuffer. When pd_io
domain is off everything is done on
hdmi side

+       chosen {
+               #address-cells = <2>;
+               #size-cells = <2>;
+               ranges;
+
+               simplefb_hdmi: framebuffer-lcd0-hdmi {
+                       compatible = "rockchip,simple-framebuffer",
+                                    "simple-framebuffer";
+                       rockchip,pipeline = "rockchip,dw_hdmi";
+                       clocks = <&cru PCLK_HDMI_CTRL>, <&cru
SCLK_HDMI_HDCP>, <&cru SCLK_HDMI_CEC>,
+                                <&cru ACLK_VOP0>, <&cru DCLK_VOP0>,
<&cru HCLK_VOP0>;
+                       power-domains = <&power RK3288_PD_VIO>;
+                       status = "disabled";
+               };
+       };

Memory area is automatic injected by the bootloader. Now rk iommu is
with runtime enable so basically if I understand
the >sync call will schedule a power off domain if they are not in use.

[    0.118064] vgaarb: loaded
[    0.118997] SCSI subsystem initialized
[    0.119213] libata version 3.00 loaded.
[    0.119499] usbcore: registered new interface driver usbfs
[    0.119552] usbcore: registered new interface driver hub
[    0.119617] usbcore: registered new device driver usb
[    0.121505] pps_core: LinuxPPS API ver. 1 registered
[    0.121515] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.121539] PTP clock support registered
[    0.121777] EDAC MC: Ver: 3.0.0
[    0.125046] clocksource: Switched to clocksource arch_sys_counter
[    0.930470] simple-framebuffer 7f800000.framebuffer: attaching to
power domain 'pd_vio'
[    0.930501] simple-framebuffer 7f800000.framebuffer: adding clock
'pclk_hdmi_ctrl' to list of PM clocks
[    0.930523] simple-framebuffer 7f800000.framebuffer: adding clock
'sclk_hdmi_hdcp' to list of PM clocks
[    0.930544] simple-framebuffer 7f800000.framebuffer: adding clock
'sclk_hdmi_cec' to list of PM clocks
[    0.930564] simple-framebuffer 7f800000.framebuffer: adding clock
'aclk_vop0' to list of PM clocks
[    0.930585] simple-framebuffer 7f800000.framebuffer: adding clock
'dclk_vop0' to list of PM clocks
[    0.930606] simple-framebuffer 7f800000.framebuffer: adding clock
'hclk_vop0' to list of PM clocks
[    0.930642] rockchip-pm-domain
ff730000.power-management:power-controller: Calling pd power on
[    0.930746] rockchip-pm-domain
ff730000.power-management:power-controller: Calling power domain on
[    0.931083] simple-framebuffer 7f800000.framebuffer: framebuffer at
0x7f800000, 0x7e9000 bytes, mapped to 0x(ptrval)
[    0.931101] simple-framebuffer 7f800000.framebuffer:
format=x8r8g8b8, mode=1920x1080x32, linelength=7680
[    0.931415] simple-framebuffer 7f800000.framebuffer: fb0: simplefb
registered!

Here when everything get registered by offcouse the screen went black already

Michael

On Fri, Feb 7, 2020 at 8:14 PM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi all
>
> I move a bit on this
>
> On Sun, Jan 12, 2020 at 6:16 PM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
> >
> > Hi Kever
> >
> > Trying to have a persistent banner from uboot to linux-kernel. I'm
> > right now working on linux-rockchip kernel but I think that the
> > problem is even on mainline
> >
> > +               framebuffer: framebuffer@7f800000 {
> > +                       compatible = "rockchip,simple-framebuffer",
> > +                                    "simple-framebuffer";
> > +                       reg = <0x7f800000 (1920 * 1080 * 4)>;
> > +                       width = <1920>;
> > +                       height = <1080>;
> > +                       stride = <(1920 * 4)>;
> > +                       format = "a8b8g8r8";
> > +                       clocks = <&cru  PCLK_HDMI_CTRL>, <&cru SCLK_HDMI_HDCP>,
> > +                                <&cru SRST_LCDC0_AXI>, <&cru
> > SRST_LCDC0_AHB>, <&cru SRST_LCDC0_DCLK>,
> > +                                <&cru ACLK_VOP0>, <&cru HCLK_VOP0>;
> > +                       status = "okay";
> > +               };
> >
>
> Now I can allocate the parameter using the bootloader and create the
> right mapping for the simple framebuffer. I don't even understand
> how sunxi and meson can work if they don't create a reserved memory
> using no-map. This is fixed on my side so the log is totally clean.
> I have added the deregister of simple fb and handover to the drm
>
> Now my boot parameters are:
> Kernel command line: console=ttyS2,115200n8 root=/dev/mmcblk0p1
> rootwait pd_ignore_unused clk_ignore_unused
>
> Still I have display go off on tinker during boot. Any suggestion?
>
> Michael
>
>
> > Seems that it get off before I reach the drm registration
> >
> > [    2.077495] simple-framebuffer 7f800000.framebuffer: framebuffer at
> > 0x7f800000, 0x7e9000 bytes, mapped to 0xf0900000
> > [    2.077519] simple-framebuffer 7f800000.framebuffer:
> > format=a8b8g8r8, mode=1920x1080x32, linelength=7680
> > [    2.161225] simple-framebuffer 7f800000.framebuffer: fb0: simplefb
> > registered!
> > [    3.433847] fb: switching to rockchip-drm-fb from simple
> >
> > I don't find all the clocks and if those are the only think that I
> > need to stay on. Any suggestion?



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
