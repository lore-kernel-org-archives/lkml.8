Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0E8C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502E220733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="FgTcvQWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbgBJWXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:23:47 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40668 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgBJWXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 17:23:47 -0500
Received: by mail-qk1-f193.google.com with SMTP id b7so8238641qkl.7;
        Mon, 10 Feb 2020 14:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vtc2iHO5ssqdQWlZbYpNOYjs7NPN+OkfmGi7EwW4+Cw=;
        b=FgTcvQWWhvbFryDssRGO6xJWs5roRRi7pj6F2lGuCKhoWUJC2n4I/mNnRGIzEc6x2M
         MCO3afKZAmymUbSJ2kjINRtbtbNYPLzRMEdJr84duHUQVo5bbZdX2AUMkzTP62MUYXOs
         JNgdEotYxbmqZrmJZZVFIxEo1beFo2EvE52vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vtc2iHO5ssqdQWlZbYpNOYjs7NPN+OkfmGi7EwW4+Cw=;
        b=q6tgNJVeXgqLTnC2lHJD43SVtJ3h4tRJSXajgbwbOgLIka6RzrkxJCbUq26qBnaNlg
         tHLuxRawLcEwWXzVCRPfG+bScKuAhdMMX6FRPGBA1wiSp0vPyz2QcjNhJ4OrFmxP4chp
         OkgICTQ/vlv4g9eThCGauTHXBp87S8LWCgXNx4c3Nplh2Dec07lQzEGu8iDMWJkzLuzz
         gQO+IIdZshizPRgUs6NCmXXPIvBd9dLARPy5YtivjO/bfvY4Uo15wQf9K7yhXYantZxe
         89z0tTgpBslUTt/4RvCWWIo+quIK3txOB5F7AG1OQirwy0VTiKbwQrqpYn+vJjIomuoK
         LsGg==
X-Gm-Message-State: APjAAAUogSL+JOxsDB8H9LNLwA88UiCqp62FGKVoiSEbNKqEVuvpZREQ
        mxOeIuR3sG4feQAp9CFW22GLSGAcmoXRyD3RADQ=
X-Google-Smtp-Source: APXvYqyZdGpzcKUOEIzHRw7qYRL07DZQdkQJ0/5JSAwE0jE+HVmYKoptJ7wpd88HybHU1+QIrsDGwQWL0h/VjAghNpo=
X-Received: by 2002:a37:c07:: with SMTP id 7mr107082qkm.414.1581373426189;
 Mon, 10 Feb 2020 14:23:46 -0800 (PST)
MIME-Version: 1.0
References: <20200130214626.2863329-1-vijaykhemka@fb.com>
In-Reply-To: <20200130214626.2863329-1-vijaykhemka@fb.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 10 Feb 2020 22:23:34 +0000
Message-ID: <CACPK8Xfo1NcNmORHtpfDQzYQrLV0B=6+_nUtPftiHQoT6GrpPA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: aspeed: tiogapass: Add IPMB device
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Vijay Khemka <vijaykhemka@fb.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sai Dasari <sdasari@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, 30 Jan 2020 at 21:46, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Adding IPMB devices for facebook tiogapass platform.
>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> index fb7f034d5db2..1cb5b9bf468f 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> @@ -5,6 +5,7 @@
>
>  #include "aspeed-g5.dtsi"
>  #include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/i2c/i2c.h>
>
>  / {
>         model = "Facebook TiogaPass BMC";
> @@ -428,6 +429,12 @@
>  &i2c4 {
>         status = "okay";
>         // BMC Debug Header
> +       multi-master;
> +       ipmb0@10 {
> +               compatible = "ipmb-dev";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;

This causes dtc to warn:

../arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts:521.11-525.4:
Warning (i2c_bus_reg): /ahb/apb/bus@1e78a000/i2c-bus@380/ipmb0@10: I2C
bus unit address format error, expected "40000010"
../arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts:523.3-30:
Warning (i2c_bus_reg): /ahb/apb/bus@1e78a000/i2c-bus@380/ipmb0@10:reg:
I2C address must be less than 10-bits, got "0x40000010"

The bindings mention:

 Another flag is I2C_OWN_SLAVE_ADDRESS to mark addresses on which we listen to
be devices ourselves.

include/dt-bindings/i2c/i2c.h:#define I2C_OWN_SLAVE_ADDRESS     (1 << 30)

It appears dtc needs to be fixed to not warn when seeing this value in
an i2c reg node?

Cheers,

Joel



> +               i2c-protocol;
> +       };
>  };
>
>  &i2c5 {
> @@ -509,6 +516,12 @@
>  &i2c9 {
>         status = "okay";
>         //USB Debug Connector
> +       multi-master;
> +       ipmb0@10 {
> +               compatible = "ipmb-dev";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +               i2c-protocol;
> +       };
>  };
>
>  &pwm_tacho {
> --
> 2.17.1
>
