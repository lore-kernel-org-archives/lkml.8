Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3741AC3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082DF20728
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583443756;
	bh=oh2OwQ/0TeiUDxPSSCXzSpj5KXTo4xNzQh97uu6obDw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XFotlAxykKimMm/RxR/wZ0tXmhudPteS9EmkfWBpnZxhU3H4pVxXm6TtwGMlffTST
	 xCgA83ShseqsbUCT2mqIVfg7EM/NMCdnXjnHxgZwWYBwr7KNc3AGGonyd1Vtay/65A
	 MmO9KqFJI/A+JEBh8dmXU70C3AaJFStv7OR0Mf74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgCEV3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 16:29:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:38958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgCEV3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 16:29:14 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8060320728;
        Thu,  5 Mar 2020 21:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583443753;
        bh=oh2OwQ/0TeiUDxPSSCXzSpj5KXTo4xNzQh97uu6obDw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ShPPP/LC/9bbpx0NGMJcdAFDkRwBAzI7UfIQOCBK8FtcyFOSbnL/mhxhTlVpfidtd
         EvjOk7ZmKbTjpeiu0mssyqZbGbuNOyuZOarr3k45UTaN8MfINS7v78/9gFpPJjxGIp
         9halWgIRS2l82IX8m+dus45MdaiO013SnmlnTbag=
Received: by mail-qk1-f169.google.com with SMTP id j7so333177qkd.5;
        Thu, 05 Mar 2020 13:29:13 -0800 (PST)
X-Gm-Message-State: ANhLgQ37JJZhXZ8aPh05YSSI7QTZb/FNSLF6I/rIAiKMDjHF/vNC9g1K
        fo/I5zEjrJxrXmo7uxss0Mhfb+/18UR8nlBJIQ==
X-Google-Smtp-Source: ADFU+vtqjRJO6NbTISWxledTlH+SAy9WYo0Hq7+mzVvIuhn8GJMCac26m6QCpXzcrlt1I+k7z1Xm4kMe5NwmRP+Yero=
X-Received: by 2002:a37:393:: with SMTP id 141mr9930qkd.393.1583443752527;
 Thu, 05 Mar 2020 13:29:12 -0800 (PST)
MIME-Version: 1.0
References: <20200305030135.210675-1-pmalani@chromium.org>
In-Reply-To: <20200305030135.210675-1-pmalani@chromium.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 5 Mar 2020 15:29:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJcJf0JZVHEuY5y0eHLyw3e0Wr2ZDJvPs4=cZaSMWg97A@mail.gmail.com>
Message-ID: <CAL_JsqJcJf0JZVHEuY5y0eHLyw3e0Wr2ZDJvPs4=cZaSMWg97A@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: Convert usb-connector to YAML format.
To:     Prashant Malani <pmalani@chromium.org>
Cc:     devicetree@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 4, 2020 at 9:01 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> Convert the usb-connector.txt bindings file to YAML format. This allows
> it to be used in dt_bindings_check verification. This patch was
> born out of a patch series for the addition of a Type C connector
> class port driver[1].
>
> An attempt has been made to maintain the same documentation text and
> example structure as was in the .txt file, but wherever needed
> modifications have been made to satisfy dt_bindings_check.
>
> Also, update all references to usb-connector.txt to now use
> usb-connector.yaml.
>
> [1]: https://lkml.org/lkml/2020/2/19/1232
>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>
> Changes in v2:
> - Added type references for some properties.
> - Removed pinctrl properties.
> - Updated power-role, try-power-role and data-role properties to be in
>   valid schema format.
> - Added OF graph data bus binding property according to reviewer
>   suggestions.
>
>  .../connector/samsung,usb-connector-11pin.txt |   2 +-
>  .../bindings/connector/usb-connector.txt      | 135 ------------
>  .../bindings/connector/usb-connector.yaml     | 203 ++++++++++++++++++
>  .../devicetree/bindings/usb/fcs,fusb302.txt   |   2 +-
>  .../devicetree/bindings/usb/generic.txt       |   2 +-
>  .../devicetree/bindings/usb/mediatek,mtu3.txt |   2 +-
>  .../devicetree/bindings/usb/mediatek,musb.txt |   2 +-
>  .../bindings/usb/richtek,rt1711h.txt          |   2 +-
>  .../devicetree/bindings/usb/ti,hd3ss3220.txt  |   2 +-
>  .../devicetree/bindings/usb/typec-tcpci.txt   |   2 +-
>  .../devicetree/bindings/usb/usb-conn-gpio.txt |   4 +-
>  11 files changed, 213 insertions(+), 145 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt
>  create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.yaml


> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> new file mode 100644
> index 0000000000000..b386e2880405c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -0,0 +1,203 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/connector/usb-connector.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: USB Connector
> +
> +maintainers:
> +  - linux-usb@vger.kernel.org

Person please. You can put me if no one else.

> +description:
> +  A USB connector node represents a physical USB connector. It should be a child
> +  of a USB interface controller.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - usb-a-connector
> +      - usb-b-connector
> +      - usb-c-connector
> +
> +  label:
> +    description: Symbolic name for the connector.
> +
> +  type:
> +    description: Size of the connector, should be specified in case of USB-A,
> +      USB-B non-fullsize connectors.
> +    $ref: /schemas/types.yaml#definitions/string

Needs to be under an 'allOf' or the enum is ignored.

Rob
