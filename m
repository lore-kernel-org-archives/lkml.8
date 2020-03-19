Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAA5C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E720A20768
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MT0Y8soJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgCSBIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 21:08:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40524 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgCSBIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 21:08:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id t24so251936pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 18:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=HOrVTVj94hEqYzP+BNYpSkqs29uiFE6WXOJ/uoI1nY0=;
        b=MT0Y8soJkEXXSdQVlOiuDB77ehUHT9j37xPgvUaPEAjUfLvnUxhWsASSZRDBU80+UE
         4Yvm727E1zUBc7xZdiND5J9r7CGnI47FLMRXA/TzwP0VJmbe4GjX95BHgnmtZ5gbpDnq
         YVcYCFBwG76DaaWPMx5qXkx/DqtnKFixVSljU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=HOrVTVj94hEqYzP+BNYpSkqs29uiFE6WXOJ/uoI1nY0=;
        b=nP2rz2CZKvqPm6NA0bjIokESOS5N7YrR4jTL8Tk+8+evMs1U3IKpsQ3OsJESXalsnd
         dRHAh9gT6J1qdjI81RWbCProH/orW+qi6jrSA3lNKFQW8c/Rdh4fjbpFsz/3Agpc2Ccy
         5724UVsvRqnxNp1ItfUWIVNTbUQXuspCjgbC0WtXOPXD4VzuL5qI5dbDi5UKpj1gS0dh
         CuecxtavPTQy+4ORsXqAPi5LFiQcohqS3ikrCvQEndnIo867+ozdw9RjwphIo5LtC86Z
         BktcJ/lFpVg+ym1G3895hesgKvGWFv3JrS9IEUVyAisObgHNO2P7tuLSc4lbOrwxgenp
         I+5Q==
X-Gm-Message-State: ANhLgQ08FTYhf/c7E3j5Vt+yUAVVYeGWaABgTI9JT481P+omtSthTF4D
        gLJcV1UXcZ7iDEs+KW9P6huIbA==
X-Google-Smtp-Source: ADFU+vuAWgIWajuJGpPlRJxuUxjrbJeZVY6ltZuXXUYT9Lo/14j2AaHjIDuHwCwpxd//vqXGygp/gA==
X-Received: by 2002:aa7:8bd1:: with SMTP id s17mr1130786pfd.225.1584580133274;
        Wed, 18 Mar 2020 18:08:53 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y15sm209863pfc.206.2020.03.18.18.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 18:08:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200311191501.8165-3-bryan.odonoghue@linaro.org>
References: <20200311191501.8165-1-bryan.odonoghue@linaro.org> <20200311191501.8165-3-bryan.odonoghue@linaro.org>
Subject: Re: [PATCH 2/7] dt-bindings: usb: dwc3: Add a gpio-usb-connector example
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, jackp@codeaurora.org, robh@kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Date:   Wed, 18 Mar 2020 18:08:51 -0700
Message-ID: <158458013177.152100.17920784952083533825@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bryan O'Donoghue (2020-03-11 12:14:56)
> A USB connector should be a child node of the USB controller
> connector/usb-connector.txt. This patch adds an example of how to do this
> to the dwc3 binding descriptions.

I read that as a child of the USB interface controller, which is not the
same as the USB controller. For example, we're talking about having the
usb connector be a child of the EC on ChromeOS devices because that
manages the connector

>=20
> It is necessary to declare a connector as a child-node of a USB controller
> for role-switching to work, so this example should be helpful to others
> implementing that.

Maybe it should be a virtual node at the root of the DT if it's GPIO
controlled? And then the phy can be connected to the usb connector
through the graph binding.

>=20
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-usb@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Felipe Balbi <balbi@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/dwc3.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentati=
on/devicetree/bindings/usb/dwc3.txt
> index 66780a47ad85..4e1e4afccee6 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> @@ -121,4 +121,12 @@ dwc3@4a030000 {
>         interrupts =3D <0 92 4>
>         usb-phy =3D <&usb2_phy>, <&usb3,phy>;

Weird that there's a comma here        ^

Not a problem with this patch, just noticing it while reading the diff.

>         snps,incr-burst-type-adjustment =3D <1>, <4>, <8>, <16>;
> +
> +       usb_con: connector {
> +               compatible =3D "gpio-usb-b-connector";
> +               id-gpios =3D <&tlmm 116 GPIO_ACTIVE_HIGH>;
> +               vbus-supply =3D <&usb3_vbus_reg>;
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&usb3_id_pin>, <&usb3_vbus_pin>;
> +       };
