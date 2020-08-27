Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B322C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F4302087D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598543139;
	bh=eqyMLLIE6kyA51bhC2FJ8DP5oiJHdLVYqUGcsum4sX4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SpncaRKAf3YLQmG9LqqJBkrQclA+7N2saEKd1+VX/vaXvgH+/LevTfmvJBbXXAUC/
	 jIJ1zlsu6ymYL8SUiyXAFiQeBaAcNXe6DzOrjEZkbGH+8Rt95FRv7rZ5F7SDLHE31j
	 UxizLSSS8zHVV+0QlbHeolTsfgyRDue4JaD+I6JE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgH0Ppi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:45:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgH0Pph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:45:37 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3547C22BEA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 15:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598543136;
        bh=eqyMLLIE6kyA51bhC2FJ8DP5oiJHdLVYqUGcsum4sX4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ifRzaft039UAuM3khcciusxkwpXhFv/X7on+pB+TJdRBBN9pKAtYcHEkx3VgdQ9Rg
         xVNPgdJoXr59hjr48cT5j9EbfDy1yfro0MTlQT4JLck0VzSUA36Ob1x6VD4d6PggpC
         PVy7yzeKTy54rJgUqaRqLxlAW7CVBenVQU/VyPRo=
Received: by mail-ot1-f48.google.com with SMTP id 5so4732300otp.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 08:45:36 -0700 (PDT)
X-Gm-Message-State: AOAM531GDXoch0KBRga69mHZsoaCfOwijYutYWz7uPhTtqmXEJE8ogzB
        iJFgCkFH8Rm3oGsJEb5kE0ipsKAGF/F9u8wcBQ==
X-Google-Smtp-Source: ABdhPJzOTck9h18ABU9uk0fPmf0IzzeCR4jpdNhi3NW/eHBO7XvDF4IoUHzw515kIxAFcFaDUgPruF4uD/HowsUlA4I=
X-Received: by 2002:a05:6830:1d94:: with SMTP id y20mr6834595oti.129.1598543135457;
 Thu, 27 Aug 2020 08:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200818124815.11029-1-vaishnav@beagleboard.org> <20200818124815.11029-4-vaishnav@beagleboard.org>
In-Reply-To: <20200818124815.11029-4-vaishnav@beagleboard.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 27 Aug 2020 09:45:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJWgtO_5ToPGUs0RYg476HftULN7J1wNO6ztUxxk=n6_g@mail.gmail.com>
Message-ID: <CAL_JsqJWgtO_5ToPGUs0RYg476HftULN7J1wNO6ztUxxk=n6_g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] Add Device Tree Bindings for mikroBUS port
To:     Vaishnav M A <vaishnav@beagleboard.org>
Cc:     greybus-dev@lists.linaro.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Johan Hovold <johan@kernel.org>,
        elder@kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        David Miller <davem@davemloft.net>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>,
        robertcnelson@beagleboard.org, rajkovic@mikroe.com,
        chrisfriedt@gmail.com, zoran.stojsavljevic@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 6:48 AM Vaishnav M A <vaishnav@beagleboard.org> wrote:
>
> This patch adds device tree bindings for the mikroBUS port,
> device tree overlays for the mikrobus Port on the BeagleBoard.org
> PocketBeagle is available here :
> github.com/beagleboard/bb.org-overlays/blob/master/src/arm/PB-MIKROBUS-0.dts
>
> Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
> ---
>  .../bindings/misc/linux,mikrobus.txt          | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/linux,mikrobus.txt
>
> diff --git a/Documentation/devicetree/bindings/misc/linux,mikrobus.txt b/Documentation/devicetree/bindings/misc/linux,mikrobus.txt
> new file mode 100644
> index 000000000000..99f75caf5f35
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/linux,mikrobus.txt
> @@ -0,0 +1,81 @@
> +mikroBUS add-on board socket
> +
> +Required properties:
> +- compatible: Must be "linux,mikrobus"

mikrobus is only a Linux thing? Just 'mikrobus-connector' is fine.

Are there versions of mikrobus spec/connectors? If so, then should
probably include that into

> +- i2c-adapter:  phandle to the i2c adapter attached to the mikrobus socket.
> +- spi-master: spi bus number of the spi-master attached to the mikrobus socket.
> +- spi-cs: spi chip-select numbers corresponding to the chip-selects
> +         on the mikrobus socket(0 -> chip select corresponding to CS pin
> +         1 -> chip select corresponding to RST pin).

SPI and I2C need a common way to remap from host bus/cs to connector
bus/cs including how to define the child devices and multiple
instances.

> +- serdev-controller:  phandle to the uart port attached to the mikrobus socket.

'serdev' is a Linuxism. This also needs to be defined how child
devices and multiple instances.

There's also a problem with the current serdev implementation that
assigning a serial port to serdev or tty is a one time decision as
probe time. So I don't think hotplug of a serial device will work
today. But that's a Linux problem independent of the binding.

> +- pwms: phandle to the pwm-controller corresponding to the mikroBUS PWM pin.

The PWM binding has a provider specific number of cells, so some
translation is needed. Probably can define a 'pwm-map' property like
gpio-map on this. More below.

> +- mikrobus-gpios: gpios array corresponding to GPIOs on the mikroBUS port,
> +                 for targets not supporting the AN pin on the mikroBUS port as
> +                 GPIO, the length of the gpios array can be 11, otherwise it
> +                 should be 12.

We have 'gpio-map' binding already (it's in the DT spec) created for
this purpose of remapping connector GPIO numbers to host GPIO numbers.


> +- pinctrl-names: pinctrl state names to support additional pin usage/deviations
> +                from mikroBUS socket standard usage, must be "default",
> +                "pwm_default", "pwm_gpio", "uart_default", "uart_gpio",
> +                "i2c_default", "i2c_gpio", "spi_default", "spi_gpio", these
> +                pinctrl names should have corresponding pinctrl-N entries which
> +                corresponds to the pinmux state for the pingroup, for example,
> +                i2c_default corresponds to the state where the I2C pin group
> +                (SCL,SDA) are configured in I2C mode and i2c_gpio mode corresponds
> +                to the pinmux state where these pins are configured as GPIO.
> +- pinctrl-N : pinctrl-(0-8) corresponds to the pinctrl states for the states described
> +             above.
> +
> +Example:
> +       mikrobus-0 {
> +               compatible = "linux,mikrobus";
> +               status = "okay";
> +               pinctrl-names = "default", "pwm_default", "pwm_gpio",
> +                               "uart_default", "uart_gpio", "i2c_default",
> +                               "i2c_gpio", "spi_default", "spi_gpio";
> +               pinctrl-0 = <
> +                       &P2_03_gpio_input_pin
> +                       &P1_04_gpio_pin
> +                       &P1_02_gpio_pin
> +               >;
> +               pinctrl-1 = <&P2_01_pwm_pin>;
> +               pinctrl-2 = <&P2_01_gpio_pin>;
> +               pinctrl-3 = <
> +                       &P2_05_uart_pin
> +                       &P2_07_uart_pin
> +               >;
> +               pinctrl-4 = <
> +                       &P2_05_gpio_pin
> +                       &P2_07_gpio_pin
> +               >;
> +               pinctrl-5 = <
> +                       &P2_09_i2c_pin
> +                       &P2_11_i2c_pin
> +               >;
> +               pinctrl-6 = <
> +                       &P2_09_gpio_pin
> +                       &P2_11_gpio_pin
> +               >;
> +               pinctrl-7 = <
> +                       &P1_12_spi_pin
> +                       &P1_10_spi_pin
> +                       &P1_08_spi_sclk_pin
> +                       &P1_06_spi_cs_pin
> +               >;
> +               pinctrl-8 = <
> +                       &P1_12_gpio_pin
> +                       &P1_10_gpio_pin
> +                       &P1_08_gpio_pin
> +                       &P1_06_gpio_pin
> +               >;
> +               i2c-adapter = <&i2c1>;
> +               spi-master = <0>;
> +               spi-cs = <0 1>;
> +               serdev-controller = <&uart4>;
> +               pwms = <&ehrpwm1 0 500000 0>;
> +               mikrobus-gpios = <&gpio1 18 0> , <&gpio0 23 0>,
> +                                       <&gpio0 30 0> , <&gpio0 31 0>,
> +                                       <&gpio0 15 0> , <&gpio0 14 0>,
> +                                       <&gpio0 4 0> , <&gpio0 3 0>,
> +                                       <&gpio0 2 0> , <&gpio0 5 0>,
> +                                       <&gpio2 25 0>  , <&gpio2 3 0>;
> +       };
> \ No newline at end of file
> --
> 2.25.1
>
