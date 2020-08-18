Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69539C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 21:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3026420709
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 21:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="Hyz+O6ss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgHRVWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 17:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgHRVWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 17:22:16 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A76DC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 14:22:15 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id b16so22690210ioj.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 14:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tfpg0j9msjtaqhHYu5CZZK7lRbhujYrAuCaFMlNFg1s=;
        b=Hyz+O6ss5jtDb7GpQr25jzgWf60+gCbmxPe3ZosULh78GHGegHzjbc97NXQOiEaaqb
         syHZ2EEvwGSbRaKGwQjL+kqZehUadXPhYNL8x0nlEDEpk0qYIdJHD6hAuOuTanMm5FEr
         O/EfYK1XB1WTwMVvdlL9SOXXoOw+XlNh976wWke0Q6yz60ZtSP+skvnbVj9StbXbMbCQ
         atnhYWl+DH8ueBrxoaHuDVCOw6EJc5+ZEDmyn8F/NOnr3Bl79NwPuNf+LIRCr6HWiPnG
         xSPsHLhmW7MaN/xFKQEZ7YCqlFFiuyaBm6w4PC/DYuPUF6RnpAMUx/QIxiGCsloqGpYt
         kq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tfpg0j9msjtaqhHYu5CZZK7lRbhujYrAuCaFMlNFg1s=;
        b=DOo6iGPJ3+Qhned8PPPb2Vrebyf6UxQefW41Qpwq6cB1Ol73E6sEbF6RdZ391wo4qX
         SQyCynrhpbhPJ5qKCUft7EU6j7EtRi9bHMdGAtIJ1Ee9g9AJvVMiZT9nomijK56VGHLR
         hbVawTwVcR45AhgdrrxMWwDperYg5WyBDydIvt4I8VuDqel9DXau8sNLB4+jMItd+IW5
         3uy+uugg3j9HG31a2013DRK3XxvIKfxAkZuRzL2eXtuiPM/JvrVQ9KnSnJYyrKwFAe0S
         2oUF36KmlR/h93rggFpohxc7I8OPvCVBvGi0MwXYgfhcHlmLntnH1IIwaeOXQXZGShEj
         MJxA==
X-Gm-Message-State: AOAM532qmUTPCF7p4uqDmWZywUx9I9WnIP/aTTlRUkXFoM2RKfkyY5GI
        XJJ08S7ZED+uexFFzYKJk9H7jkFF4oieFxVSAwFNrwOm9g==
X-Google-Smtp-Source: ABdhPJxTNTmJ8MUGUBlIOoMey6xbnckktDJzaJBiq9RD0BXELG0xORAOe32lBj9PGc85fObsOS0Lg3PCSnvFuIG7snA=
X-Received: by 2002:a6b:3e04:: with SMTP id l4mr17590954ioa.206.1597785734410;
 Tue, 18 Aug 2020 14:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200818124815.11029-1-vaishnav@beagleboard.org>
 <20200818124815.11029-4-vaishnav@beagleboard.org> <20200818133525.GA9947@pendragon.ideasonboard.com>
In-Reply-To: <20200818133525.GA9947@pendragon.ideasonboard.com>
From:   Vaishnav M A <vaishnav@beagleboard.org>
Date:   Wed, 19 Aug 2020 02:52:03 +0530
Message-ID: <CALudOK7SPPihvXBxhZjs4hC3FziZM99vnDGnfbazyGLRdYSvYg@mail.gmail.com>
Subject: Re: [greybus-dev] [RFC PATCH v2 3/3] Add Device Tree Bindings for
 mikroBUS port
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, johan@kernel.org,
        elder@kernel.org,
        =?UTF-8?Q?Ivan_Rajkovi=C4=87?= <rajkovic@mikroe.com>,
        robh@kernel.org, mchehab+huawei@kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>, davem@davemloft.net,
        zoran.stojsavljevic@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 7:05 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Vaishnav,
>
> Thank you for the patch.
>
> On Tue, Aug 18, 2020 at 06:18:15PM +0530, Vaishnav M A wrote:
> > This patch adds device tree bindings for the mikroBUS port,
> > device tree overlays for the mikrobus Port on the BeagleBoard.org
> > PocketBeagle is available here :
> > github.com/beagleboard/bb.org-overlays/blob/master/src/arm/PB-MIKROBUS-0.dts
> >
> > Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
> > ---
> >  .../bindings/misc/linux,mikrobus.txt          | 81 +++++++++++++++++++
>
> Would you mind converting this binding document to YAML ? For new
> bindings we're trying to enforce usage of YAML, to avoid increasing the
> conversion backlog.
>
Hi Laurent,

Sure, I will convert the device tree binding document to YAML in the
next version.
> >  1 file changed, 81 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/linux,mikrobus.txt
> >
> > diff --git a/Documentation/devicetree/bindings/misc/linux,mikrobus.txt b/Documentation/devicetree/bindings/misc/linux,mikrobus.txt
> > new file mode 100644
> > index 000000000000..99f75caf5f35
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/linux,mikrobus.txt
> > @@ -0,0 +1,81 @@
> > +mikroBUS add-on board socket
> > +
> > +Required properties:
> > +- compatible: Must be "linux,mikrobus"
> > +- i2c-adapter:  phandle to the i2c adapter attached to the mikrobus socket.
> > +- spi-master: spi bus number of the spi-master attached to the mikrobus socket.
> > +- spi-cs: spi chip-select numbers corresponding to the chip-selects
> > +       on the mikrobus socket(0 -> chip select corresponding to CS pin
> > +       1 -> chip select corresponding to RST pin).
> > +- serdev-controller:  phandle to the uart port attached to the mikrobus socket.
> > +- pwms: phandle to the pwm-controller corresponding to the mikroBUS PWM pin.
> > +- mikrobus-gpios: gpios array corresponding to GPIOs on the mikroBUS port,
> > +               for targets not supporting the AN pin on the mikroBUS port as
> > +               GPIO, the length of the gpios array can be 11, otherwise it
> > +               should be 12.
> > +- pinctrl-names: pinctrl state names to support additional pin usage/deviations
> > +              from mikroBUS socket standard usage, must be "default",
> > +              "pwm_default", "pwm_gpio", "uart_default", "uart_gpio",
> > +              "i2c_default", "i2c_gpio", "spi_default", "spi_gpio", these
> > +              pinctrl names should have corresponding pinctrl-N entries which
> > +              corresponds to the pinmux state for the pingroup, for example,
> > +              i2c_default corresponds to the state where the I2C pin group
> > +              (SCL,SDA) are configured in I2C mode and i2c_gpio mode corresponds
> > +              to the pinmux state where these pins are configured as GPIO.
> > +- pinctrl-N : pinctrl-(0-8) corresponds to the pinctrl states for the states described
> > +           above.
> > +
> > +Example:
> > +     mikrobus-0 {
> > +             compatible = "linux,mikrobus";
> > +             status = "okay";
> > +             pinctrl-names = "default", "pwm_default", "pwm_gpio",
> > +                             "uart_default", "uart_gpio", "i2c_default",
> > +                             "i2c_gpio", "spi_default", "spi_gpio";
> > +             pinctrl-0 = <
> > +                     &P2_03_gpio_input_pin
> > +                     &P1_04_gpio_pin
> > +                     &P1_02_gpio_pin
> > +             >;
> > +             pinctrl-1 = <&P2_01_pwm_pin>;
> > +             pinctrl-2 = <&P2_01_gpio_pin>;
> > +             pinctrl-3 = <
> > +                     &P2_05_uart_pin
> > +                     &P2_07_uart_pin
> > +             >;
> > +             pinctrl-4 = <
> > +                     &P2_05_gpio_pin
> > +                     &P2_07_gpio_pin
> > +             >;
> > +             pinctrl-5 = <
> > +                     &P2_09_i2c_pin
> > +                     &P2_11_i2c_pin
> > +             >;
> > +             pinctrl-6 = <
> > +                     &P2_09_gpio_pin
> > +                     &P2_11_gpio_pin
> > +             >;
> > +             pinctrl-7 = <
> > +                     &P1_12_spi_pin
> > +                     &P1_10_spi_pin
> > +                     &P1_08_spi_sclk_pin
> > +                     &P1_06_spi_cs_pin
> > +             >;
> > +             pinctrl-8 = <
> > +                     &P1_12_gpio_pin
> > +                     &P1_10_gpio_pin
> > +                     &P1_08_gpio_pin
> > +                     &P1_06_gpio_pin
> > +             >;
> > +             i2c-adapter = <&i2c1>;
> > +             spi-master = <0>;
> > +             spi-cs = <0 1>;
> > +             serdev-controller = <&uart4>;
> > +             pwms = <&ehrpwm1 0 500000 0>;
> > +             mikrobus-gpios = <&gpio1 18 0> , <&gpio0 23 0>,
> > +                                     <&gpio0 30 0> , <&gpio0 31 0>,
> > +                                     <&gpio0 15 0> , <&gpio0 14 0>,
> > +                                     <&gpio0 4 0> , <&gpio0 3 0>,
> > +                                     <&gpio0 2 0> , <&gpio0 5 0>,
> > +                                     <&gpio2 25 0>  , <&gpio2 3 0>;
> > +     };
> > \ No newline at end of file
>
> --
> Regards,
>
> Laurent Pinchart
Thanks and Regards,

Vaishnav
