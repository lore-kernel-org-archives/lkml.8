Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6545C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 02:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC591222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 02:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579053719;
	bh=Yk2l+smHmslPMi9PrxyeXNImui4BouR9wa2W3jXsvbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XW9OQUuIbdWHayNzSutFbo8LDO/dlyZ2BM1fwH+X7rCrJOGpYY0Nwo2moulacluec
	 LcXVxpr2Wa14BXZNlGSwFw97FVRLxW94erDT7tg3qRyvmWeiwZHMcsvSB3+T/8812L
	 nG4SzKj+Le+DJqG0TnF9wKWnnBcjnQiG19t4dIrs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAOCB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 21:01:58 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36773 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbgAOCB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 21:01:58 -0500
Received: by mail-ot1-f65.google.com with SMTP id m2so9866328otq.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 18:01:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TXUKuJW35exIxCuuFGP0F9ChBxkOTZKYHQSXMibvkgw=;
        b=QrIRS+xMt2wRws/2OX5C84QZ/D0demVJVzlBo71FgVnXys1dy12TsQAkM2VcSOCaDA
         WqCS4v8zdw6iGvhbiCgxyJvqECo9GwA/gUe+igsnvu2wYyx7R/HM8xLj4KDDdhvFmTP4
         q4oahH40n7V6XtUY5BWDB4CQJOGoE+ycwgY/secRY2SMU5lD0b3v3XnVTCiVs5EdgA45
         2aWuwljnc8ZzFOzgWtqm/8HDCiXCqI6k5AgoPsXtKtMbvbxIQ2pDhy0Kx6422yIcGpTB
         3j7H2/M22sYEbwEMT7dqBZEAytKyHHfa+DdxLD+bpQMf08jBlL0gW2OdzJKxJJmlDUKu
         YOOQ==
X-Gm-Message-State: APjAAAUNHub7BZ+phiAQ2Xms2vvI/wHjTVumQCWJ69gxcM2ZeMV1KTNz
        0KlqDXJGTIM3/sE97AXOvKIFLBQ=
X-Google-Smtp-Source: APXvYqwBq7lheqCYy1CbJZncrAIW4lzIjQ3T/ssRjXzCjqXIJsgngh4Dwlwh/JPXKnxnCVtMYXKeqQ==
X-Received: by 2002:a9d:7590:: with SMTP id s16mr1007705otk.89.1579053717225;
        Tue, 14 Jan 2020 18:01:57 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 26sm5292530oij.9.2020.01.14.18.01.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 18:01:56 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220a2e
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Tue, 14 Jan 2020 20:01:55 -0600
Date:   Tue, 14 Jan 2020 20:01:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND 2/2] dt-bindings: power: supply: cw2015_battery: add
 device tree binding documentation
Message-ID: <20200115020155.GA7802@bogus>
References: <20200109113955.2882-1-t.schramm@manjaro.org>
 <20200109113955.2882-3-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109113955.2882-3-t.schramm@manjaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 12:39:55PM +0100, Tobias Schramm wrote:
> This patch adds the ds binding document for the cw2015 Fuel Gauge.

ds?

> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> ---
>  .../bindings/power/supply/cw2015_battery.txt  | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/cw2015_battery.txt

Please make this a DT schema. See 
Documentation/devicetree/writing-schema.rst.

> 
> diff --git a/Documentation/devicetree/bindings/power/supply/cw2015_battery.txt b/Documentation/devicetree/bindings/power/supply/cw2015_battery.txt
> new file mode 100644
> index 000000000000..e847391268f3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/cw2015_battery.txt
> @@ -0,0 +1,37 @@
> +cw2015_battery
> +~~~~~~~~~~~~~~~~
> +
> +The cellwise CW2015 is a shuntless single/multi-cell battery fuel gauge.
> +
> +Required properties :
> + - compatible : "cellwise,cw2015"
> + - cellwise,bat-config-info : Binary battery info blob
> +
> +Optional properties :
> + - cellwise,monitor-interval : Measurement interval in seconds

Use standard unit suffix.

> + - cellwise,voltage-divider : Voltage divider for multi-cell packs,
> +   specified as two integer values <high side>, <low side> in ohms.

Use standard unit suffix (-ohms).

> + - cellwise,virtual-power : Default to disconnected battery state (gauge in pack mode)
> + - cellwise,design-capacity : Design capacity of the battery cell in milliampere hours

I think we have a standard property for this. Properties of the battery 
should be in a battery node.

> + - cellwise,alert-level : Low battery alarm level in percent
> +
> +Example:
> +	cw2015@62 {
> +		status = "okay";

Don't show status in examples.

> +		compatible = "cellwise,cw201x";
> +		reg = <0x62>;
> +		cellwise,bat-config-info = <
> +			0x17 0x67 0x80 0x73 0x6E 0x6C 0x6B 0x63
> +			0x77 0x51 0x5C 0x58 0x50 0x4C 0x48 0x36
> +			0x15 0x0C 0x0C 0x19 0x5B 0x7D 0x6F 0x69
> +			0x69 0x5B 0x0C 0x29 0x20 0x40 0x52 0x59
> +			0x57 0x56 0x54 0x4F 0x3B 0x1F 0x7F 0x17
> +			0x06 0x1A 0x30 0x5A 0x85 0x93 0x96 0x2D
> +			0x48 0x77 0x9C 0xB3 0x80 0x52 0x94 0xCB
> +			0x2F 0x00 0x64 0xA5 0xB5 0x11 0xF0 0x11
> +		>;
> +		cellwise,monitor-interval = <5>;
> +		cellwise,virtual-power;
> +		cellwise,design-capacity = <9800>;
> +		power-supplies = <&mains_charger>, <&usb_charger>;

Not documented.

> +	}
> -- 
> 2.24.1
> 
