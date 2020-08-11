Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D2EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 12:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C082206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 12:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597148556;
	bh=kmUJH2BigcAC4dcBoqp5/zGq8P1LDQpVAX+VdGsMKak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1DUvWFf73NcbiIs8GNtPazr2GjQhL1ZmtkFDEqLPSiJNbZELKpPCAuR6rcq7D7KLz
	 Q1ufwEkE5V3EmCXHNmsV3rConWjRcSkWpy+RKbD+7gi4sePZ1t3CosbTbCpN1LxMUu
	 obHLz4hrLxajIGyRzpQuXix4an+0UtGapeW1D+Vo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgHKMWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 08:22:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728691AbgHKMVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 08:21:19 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5F9A206C3;
        Tue, 11 Aug 2020 12:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597148472;
        bh=kmUJH2BigcAC4dcBoqp5/zGq8P1LDQpVAX+VdGsMKak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RFtL7ecWChnXfKaHeuWjfotFW4bSoItFdSrL7GIV1PxB634hcCW3537i+Q7u/VUEV
         +LkT8cy2Fb3ISPz93x1bPAJM0q6kbeE9ZX1GaNjsRa6nS4xo7rl0x4sgxvZc/JsijZ
         dqXHMkuHWZ+iV0dRDolS0V+Iaaci7Kd/7w39gfiA=
Date:   Tue, 11 Aug 2020 14:21:06 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [RFC][PATCH v3 11/11] misc: hisi_hikey_usb: Driver to support
 usb functionality of Hikey960
Message-ID: <20200811142106.3dba2f9f@coco.lan>
In-Reply-To: <CALAqxLUu76m=Q_tDht4DmtgXYmL7Ma1zVJZzvhcsHn2hMAgpLA@mail.gmail.com>
References: <20191016033340.1288-1-john.stultz@linaro.org>
        <20191016033340.1288-12-john.stultz@linaro.org>
        <20200810183503.3e8bae80@coco.lan>
        <CALAqxLUu76m=Q_tDht4DmtgXYmL7Ma1zVJZzvhcsHn2hMAgpLA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 10 Aug 2020 21:36:58 -0700
John Stultz <john.stultz@linaro.org> escreveu:

> On Mon, Aug 10, 2020 at 9:35 AM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> > Em Wed, 16 Oct 2019 03:33:40 +0000
> > John Stultz <john.stultz@linaro.org> escreveu:
> >  
> > > From: Yu Chen <chenyu56@huawei.com>
> > >
> > > The HiKey960 has a fairly complex USB configuration due to it
> > > needing to support a USB-C port for host/device mode and multiple
> > > USB-A ports in host mode using a single USB controller.
> > >
> > > See schematics here:
> > >   https://github.com/96boards/documentation/raw/master/consumer/hikey/hikey960/hardware-docs/HiKey960_Schematics.pdf
> > >
> > > This driver acts as a usb-role-switch intermediary, intercepting
> > > the role switch notifications from the tcpm code, and passing
> > > them on to the dwc3 core.
> > >
> > > In doing so, it also controls the onboard hub and power gpios in
> > > order to properly route the data lines between the USB-C port
> > > and the onboard hub to the USB-A ports.
> > >
> > > NOTE: It was noted that controlling the TYPEC_VBUS_POWER_OFF and
> > > TYPEC_VBUS_POWER_ON values here is not reccomended. I'm looking
> > > for a way to remove that bit from the logic here, but wanted to
> > > still get feedback on this approach.  
> >
> > Let me somewhat hijack this thread. I'm trying to add support here
> > for the Hikey 970 driver. Maybe you might help me finding the remaing
> > issues over there ;-)  
> 
> So.. just as a heads up, this is a fairly old version of this patch. I
> have the current version here:
>   https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/hikey960-mainline-WIP&id=1155346a06472177b8a7e7918de052549916f06f
> 
> So you may want to rework ontop of that.

Yeah, I used the version from your tree.

> 
> That said, the last time I submitted the hub/mux driver, Rob pushed
> back suggesting that the vbus, switch and hub power should probably be
> DT describable:
>   https://lore.kernel.org/lkml/20191218163738.GA12358@bogus/

Yeah, makes sense. After USB starts working, I'll try to write a
patch on the top of yours in order to use the schema he proposed.

For now, I'm trying to understand why the only two devices found
are the hub ones. Maybe the device is still in budget mode.

> I'm at the point where I probably don't have additional cycles to
> spend to rework all the supporting drivers to support such a DT
> binding, so I'm not very optimistic this patch will go upstream (its
> much easier to float the current hub/mux driver).  So you may want to
> focus on Rob's feedback there rather than any of my feedback here. :)

I have some cycles to spend on this. Just got a 960 board on my hands.
I guess I'll try to test your patches on the top of it.

> > The Hikey 970 has lots of things in common with Hikey 960, but
> > the USB hub uses a somewhat different approach (based on what I
> > saw at the Linaro's 4.9 official Hikey kernel tree).
> >
> > Basically, with the enclosed patch applied, the USB hub needs these
> > at the DT file:
> >
> >                 hikey_usbhub: hikey_usbhub {
> >                         compatible = "hisilicon,kirin970_hikey_usbhub";
> >
> >                         typec-vbus-gpios = <&gpio26 1 0>;
> >                         otg-switch-gpios = <&gpio4 2 0>;
> >                         hub_reset_en_gpio = <&gpio0 3 0>;
> >                         hub-vdd-supply = <&ldo17>;
> >                         usb-role-switch;
> > ...
> >                 }
> >
> > E.g. when compared with Hikey 960, the USB hub:
> >
> > - Hikey 970 uses a regulator instead of GPIO for powering on;  
> 
> So, it might not be too hard to rework the hikey960 hub power gpio to
> a gpio-regulator binding, and then both platforms can use the same
> code?

Good point. Yeah, it doesn't sound hard to do that.

> > - Hikey 970 has a reset pin controlled via GPIO.  
> 
> You might be able to put this reset pin under the dwc3 resets?

I'll try.

> > It should be simple to add support for it, as done by the
> > enclosed patch. With this, the phy driver for Hikey 970 and a new
> > small driver to properly set clocks and reset lines at dwg3[1],
> > I can now see the hub on my Hikey970:
> >
> >         $ lsusb
> >         Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> >         Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> >
> > Still, I'm missing something to make it work, as, besides the hub,
> > right now, it doesn't detect the keyboard/mouse, which are
> > attached at the USB hub.
> >
> > Do you have any ideas?  
> 
> Not sure about the hub keyboard mouse issue. I worry that may be an
> issue with the hub power not being on?
> Make sure the mux driver is in the expected state when you boot up and
> switch modes.

No, it is not power. The power supply for LDO17 (used on Hikey 970) is
enabled before this driver gets called (as there's a logic handling
EPROBE_DEFER on my patch).

It is starting to work, after a couple of hacks:

[    1.503038] JDB: dwc3_core_init DWC3_DSTS: 0xd3037c
[    1.560131] JDB: dwc3_core_init_mode  dr_mode: 3
[    1.583522] dwc3 ff100000.dwc3: JDB: dwc3_drd_init: dwc3_get_extcon returned 0
[    1.595804] JDB: dwc3_set_mode  desired role: 1
[    1.769184] dwc3 ff100000.dwc3: JDB: dwc3_drd_init: dwc3_setup_role_switch returned 0
[    1.777110] JDB: __dwc3_set_mode dr_mode: 3
[    1.781343] JDB: dwc3_set_prtcap  current_dr_role set to: 1
[    1.781348] JDB: dwc3_probe init mode returned 0
...
[    3.829930] platform ldo17: Adding to iommu group 52
...
[    4.760428] JDB: hisi_hikey_usb_probe: usb_role_switch_get returned 0
[    4.766867] JDB: hisi_hikey_usb_probe: initializing USB role switch 
[    4.773252] JDB: hisi_hikey_usb_probe complete!
[    4.848182] usb 2-1: new SuperSpeed Gen 1 USB device number 2 using xhci-hcd
[    4.908727] hub 2-1:1.0: USB hub found
[    4.912551] hub 2-1:1.0: 4 ports detected
[    5.004136] usb 1-1: new high-speed USB device number 2 using xhci-hcd
[    5.556147] usb 1-1.1: new low-speed USB device number 3 using xhci-hcd
[    5.710919] input: PixArt Dell MS116 USB Optical Mouse as /devices/platform/soc/ff100000.dwc3/xhci-hcd.0.auto/usb1/1-1/1-1.1/1-1.1:1.0/0003:413C:301A.0001/input/input0
[    5.732353] hid-generic 0003:413C:301A.0001: input: USB HID v1.11 Mouse [PixArt Dell MS116 USB Optical Mouse] on usb-xhci-hcd.0.auto-1.1/input0
[    5.832141] usb 1-1.2: new low-speed USB device number 4 using xhci-hcd
[    6.032760] input: Dell KB216 Wired Keyboard as /devices/platform/soc/ff100000.dwc3/xhci-hcd.0.auto/usb1/1-1/1-1.2/1-1.2:1.0/0003:413C:2113.0002/input/input1
[    6.104393] hid-generic 0003:413C:2113.0002: input: USB HID v1.11 Keyboard [Dell KB216 Wired Keyboard] on usb-xhci-hcd.0.auto-1.2/input0
[    6.122554] input: Dell KB216 Wired Keyboard System Control as /devices/platform/soc/ff100000.dwc3/xhci-hcd.0.auto/usb1/1-1/1-1.2/1-1.2:1.1/0003:413C:2113.0003/input/input2
[    6.200460] input: Dell KB216 Wired Keyboard Consumer Control as /devices/platform/soc/ff100000.dwc3/xhci-hcd.0.auto/usb1/1-1/1-1.2/1-1.2:1.1/0003:413C:2113.0003/input/input3
[    6.216611] hid-generic 0003:413C:2113.0003: input: USB HID v1.11 Device [Dell KB216 Wired Keyboard] on usb-xhci-hcd.0.auto-1.2/input1

However, when rt1711 is probed, the USB switches to role "none":

[    6.690237] JDB: rt1711h_probe
[    6.740208] JDB: tcpm_init
[    6.744181] JDB: tcpci_init
[    6.744365] JDB: rt1711h_init
[    6.757570] JDB: tcpm_reset_port
[    6.760415] JDB: tcpm_typec_disconnect
[    6.770065] JDB: tcpci_set_vconn
[    6.780626] JDB: rt1711h_set_vconn
[    6.789456] JDB: tcpci_set_polarity
[    6.805052] JDB: tcpm_mux_set
[    6.818989] JDB: hub_usb_role_switch_set role: none!
[    6.958528] JDB: relay_set_role_switch role: none!
[    6.960157] JDB: tcpci_set_roles
[    6.960698] JDB: tcpci_get_vbus
[    6.961116] JDB: tcpm_set_state
[    6.961444] JDB: tcpm_set_state
[    6.961475] JDB: tcpm_reset_port
[    6.961477] JDB: tcpm_typec_disconnect
[    6.961792] pl061_gpio fff10000.gpio: line 5: IRQ on LOW level
[    6.961829] JDB: tcpci_set_vconn
[    6.961831] JDB: rt1711h_set_vconn
[    6.962069] JDB: tcpci_set_polarity
[    6.962402] JDB: tcpm_mux_set
[    6.962514] JDB: hub_usb_role_switch_set role: none!
[    6.968554] JDB: hub_power_ctrl value: 0 (0000000000000000)
[    6.968557] JDB: usb_switch_ctrl value: 0 ((____ptrval____))
[    6.968563] JDB: usb_typec_power_ctrl value: 1 ((____ptrval____))
[    6.978721] JDB: dwc3_set_mode  desired role: 1
[    6.978740] JDB: tcpci_set_roles
[    6.978755] JDB: relay_set_role_switch role: host!
[    6.978759] JDB: hub_power_ctrl value: 0 (0000000000000000)
[    6.978761] JDB: usb_switch_ctrl value: 0 ((____ptrval____))
[    6.978763] JDB: usb_typec_power_ctrl value: 1 ((____ptrval____))
[    6.978766] JDB: dwc3_set_mode  desired role: 1
[    6.978779] JDB: __dwc3_set_mode dr_mode: 3
[    6.986650] JDB: rt1711h_irq
[    6.986836] JDB: tcpci_irq
[    6.987197] JDB: tcpm_set_state
[    7.004582] JDB: tcpm_vbus_change
[    7.012256] JDB: tcpm_pd_event_handler
[    7.012260] JDB: tcpci_get_vbus

And the USB devices got disconnected afterwards:

[    7.020689] usb 1-1.1: reset low-speed USB device number 3 using xhci-hcd
[    7.020695] usb 1-1.1: hub failed to enable device, error -22
[    7.020765] usb 1-1.1: USB disconnect, device number 3
[    7.288840] usb 1-1.2: USB disconnect, device number 4

I tried force it to switch to host mode with:

	sudo su -c 'echo "device" > /sys/kernel/debug/usb/ff100000.dwc3/mode'
	sudo su -c 'echo "host" > /sys/kernel/debug/usb/ff100000.dwc3/mode'

But didn't work. What's weird is that the usb_role_switch_desc->set() ops 
is only called once, just after the USB hub driver is probed. 

Switching the mode later between host/device mode doesn't make any calls to
the USB hub driver.

> 
> > [1] Right now, this is needed:
> >         https://github.com/96boards-hikey/linux/blob/hikey970-v4.9/drivers/usb/dwc3/dwc3-hisi.c
> >
> >     Placing dwc3 directly under soc at DT causes some weird NMI, with
> >     either produce an OOPS or hangs the machine at boot time.  
> 
> I suspect you can drop the dwc3-hisi glue code once you move the clks
> and resets to the dwc3 node directly, as we did for hikey960.
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/hisilicon/hi3660.dtsi?id=4bcf69e57063c9b1b15df1a293c969e80a1c97e6#n1169

I was able to drop it, but I had to add this at dwc3 settings:

	regulator-on-in-suspend;

As otherwise the device seems to stop a few seconds after the dwc3
driver gets started.

I suspect it could be related to those calls at the dwg3 driver:

	pm_runtime_use_autosuspend(dev);
	pm_runtime_set_autosuspend_delay(dev, DWC3_DEFAULT_AUTOSUSPEND_DELAY);

As this seems to be the only difference between what the dwc3 core
does and the dwc3-hisi doesn't do.

Thanks,
Mauro
