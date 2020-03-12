Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54225C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 06:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A91B20578
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 06:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388005AbgCLGxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 02:53:39 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35823 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387831AbgCLGxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 02:53:38 -0400
Received: by mail-ed1-f65.google.com with SMTP id a20so6091980edj.2;
        Wed, 11 Mar 2020 23:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mW8xss9H22fzIee7URs3Gpv51mQ0flSesCTeqbgcUjo=;
        b=Kq4MF3bS4F4b1Cb7gOFm54k929cd/R5LOBwUA5h+pQnYBuC0ra3owaKLK6woIudVDW
         zNQdCJg77MaAilMmJLsbnwG0/NPDCGDYuYdbEznzSbmBgyRRHyZ5EDbBTv+WQHrJwanT
         fyyARv9Rx4taB81fEtwKtJuB9uvZ0p9vRmQyEPnEtoVTuoRRqfEDzG2/MweICwiZBxyL
         vcyjAphioHSTmrOENzjbzDtxZ3KCIx/wbx8+Kwpck1yEa9gGmxx0E/ExKR+05IVPKZyi
         7x2Fm5JpG5IaEeaPltzE0+upnVqD3prhcM1BnP57I3jwSu6cEtI32amfX/zCKXFaSC1q
         Nypg==
X-Gm-Message-State: ANhLgQ2clzA9cA1NZYM7wy/2BoAf8lMmcfFl9Yc5Kc6M2rIf+sXrIKYI
        xEH8qWiicfYjdhDRk8lwWLfFdo9fp80=
X-Google-Smtp-Source: ADFU+vsfjSdNhKiUmRBEZe8umI+ZxH+6mLWoCYnX+6YZFdTf8jxIxdPbHk0Cdu+KgiveBId6SPRrZQ==
X-Received: by 2002:a17:906:538a:: with SMTP id g10mr5284740ejo.133.1583996016294;
        Wed, 11 Mar 2020 23:53:36 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id dc18sm59657edb.20.2020.03.11.23.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 23:53:35 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id x3so4797220wmj.1;
        Wed, 11 Mar 2020 23:53:35 -0700 (PDT)
X-Received: by 2002:a7b:c118:: with SMTP id w24mr3120653wmi.77.1583996015562;
 Wed, 11 Mar 2020 23:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200309204326.27403-1-thirtythreeforty@gmail.com> <20200309204326.27403-2-thirtythreeforty@gmail.com>
In-Reply-To: <20200309204326.27403-2-thirtythreeforty@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 12 Mar 2020 14:53:23 +0800
X-Gmail-Original-Message-ID: <CAGb2v64mKxOSKkjXPwmwjRKin-Y0Q6zrKqmkNCSoz_siqTks7Q@mail.gmail.com>
Message-ID: <CAGb2v64mKxOSKkjXPwmwjRKin-Y0Q6zrKqmkNCSoz_siqTks7Q@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/5] dt-bindings: Add new F1C100s compatible
 strings for USB
To:     George Hilliard <thirtythreeforty@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 4:43 AM George Hilliard
<thirtythreeforty@gmail.com> wrote:
>
> This chip contains variants of the already-supported peripherals present
> on other Allwinner parts.  Add a new compatible line for them.
>
> Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>


> ---
>  .../devicetree/bindings/phy/allwinner,sun4i-a10-usb-phy.yaml     | 1 +
>  .../devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml        | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun4i-a10-usb-phy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun4i-a10-usb-phy.yaml
> index 020ef9e4c411..1762a302c594 100644
> --- a/Documentation/devicetree/bindings/phy/allwinner,sun4i-a10-usb-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/allwinner,sun4i-a10-usb-phy.yaml
> @@ -18,6 +18,7 @@ properties:
>      enum:
>        - allwinner,sun4i-a10-usb-phy
>        - allwinner,sun7i-a20-usb-phy
> +      - allwinner,suniv-f1c100s-usb-phy
>
>    reg:
>      items:
> diff --git a/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml b/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
> index d9207bf9d894..d2eea0003b99 100644
> --- a/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
> +++ b/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
> @@ -17,6 +17,7 @@ properties:
>        - const: allwinner,sun6i-a31-musb
>        - const: allwinner,sun8i-a33-musb
>        - const: allwinner,sun8i-h3-musb
> +      - const: allwinner,suniv-f1c100s-musb
>        - items:
>            - enum:
>                - allwinner,sun8i-a83t-musb
> --
> 2.25.0
>
