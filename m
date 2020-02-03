Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B06C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 12:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD84E2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 12:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580732336;
	bh=qihcrtRGqMh+9MIyah++7BzSnSVo6/hnfHFm/pbGO9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F4G8ZyT0vWUYlHcE2N/GEd1xQ4Q3Y6yJscTcr9VzSM0biuJBGDmQxveMeSRblT7Ej
	 e+VL7PnVVMX+9/PDJY/diIoIemwdCAHs+mM7VpvaK7SxY/xiZJPxzxVyWIbzPJVE0d
	 kGFkQ3JSs29o55NqZDjVerUOSHRgX0Vwppt9POtw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgBCMSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 07:18:55 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38838 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbgBCMSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 07:18:54 -0500
Received: by mail-wm1-f68.google.com with SMTP id a9so16735955wmj.3;
        Mon, 03 Feb 2020 04:18:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T5cRAPd7w9hBIUYF0g5UbUKoG1I95bGivsP9WxcVBFE=;
        b=to2+5hwT3E3/wTgaUdZ7yjm5bY1CB5XV2qn4MZCaPbxp79iCWpkwTqhl8ARIwnVsNa
         iLHcyPV5P9DK4y3oHeoJvqEngceOgztPs5bcEWLrbNCiT5uYazo6DA6gbiH54APAtrTz
         HClhJyEIPLnkOyt9TOQ1Wl+vwyL5e9LZlk4TS+bNJ7sK5FZ0Ri3g8BknQCrXGSUNiQYS
         TR8DX1VzwDVf/G9ZO4Qqu/kShM0Z3Zcyo6V51tPIyBCQlKAP0JKvSvnAadJGe46BhXTF
         MSJ6RWRyubK5+Ywy6bwq6HBWYI+EZcTVyMw5eCWL9Hcbd7Ksz1kDU9j8vFetN2yTSp55
         5VtA==
X-Gm-Message-State: APjAAAWQu73zQUQkb/uskddnPe0VfyqClzuCm6IWGqvBmKRVxbVGLjDm
        PMLRZ3kjD8kweOdTEWQTag==
X-Google-Smtp-Source: APXvYqzbOsuXf/ZMwWy6PpgIYTf+5yaeFPhm9fvA6cLOjgOMxCW2XC9WKpmj+sdABuD1nBKMOCwqZg==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr30971369wmj.117.1580732331073;
        Mon, 03 Feb 2020 04:18:51 -0800 (PST)
Received: from rob-hp-laptop ([212.187.182.163])
        by smtp.gmail.com with ESMTPSA id o15sm25365728wra.83.2020.02.03.04.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 04:18:50 -0800 (PST)
Received: (nullmailer pid 18049 invoked by uid 1000);
        Mon, 03 Feb 2020 12:18:49 -0000
Date:   Mon, 3 Feb 2020 12:18:49 +0000
From:   Rob Herring <robh@kernel.org>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     devicetree@vger.kernel.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, mark.rutland@arm.com, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        linux-kernel@vger.kernel.org, helen.koike@collabora.com,
        ezequiel@collabora.com, kernel@collabora.com, dafna3@gmail.com
Subject: Re: [PATCH] dt-bindings: convert extcon-usbc-cros-ec.txt
 extcon-usbc-cros-ec.yaml
Message-ID: <20200203121849.GA8196@bogus>
References: <20200122151313.11782-1-dafna.hirschfeld@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122151313.11782-1-dafna.hirschfeld@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 04:13:13PM +0100, Dafna Hirschfeld wrote:
> convert the binding file extcon-usbc-cros-ec.txt to yaml format
> This was tested and verified on ARM with:
> make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
> make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
> 
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> ---
>  .../bindings/extcon/extcon-usbc-cros-ec.txt   | 24 -----------
>  .../bindings/extcon/extcon-usbc-cros-ec.yaml  | 42 +++++++++++++++++++
>  2 files changed, 42 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
>  create mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
> 
> diff --git a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
> deleted file mode 100644
> index 8e8625c00dfa..000000000000
> --- a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -ChromeOS EC USB Type-C cable and accessories detection
> -
> -On ChromeOS systems with USB Type C ports, the ChromeOS Embedded Controller is
> -able to detect the state of external accessories such as display adapters
> -or USB devices when said accessories are attached or detached.
> -
> -The node for this device must be under a cros-ec node like google,cros-ec-spi
> -or google,cros-ec-i2c.
> -
> -Required properties:
> -- compatible:		Should be "google,extcon-usbc-cros-ec".
> -- google,usb-port-id:	Specifies the USB port ID to use.
> -
> -Example:
> -	cros-ec@0 {
> -		compatible = "google,cros-ec-i2c";
> -
> -		...
> -
> -		extcon {
> -			compatible = "google,extcon-usbc-cros-ec";
> -			google,usb-port-id = <0>;
> -		};
> -	}
> diff --git a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
> new file mode 100644
> index 000000000000..78779831282a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: GPL-2.0

Surely Google is the only copyright holder on the old file and would be 
okay with dual licensing here?

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/extcon/extcon-usbc-cros-ec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ChromeOS EC USB Type-C cable and accessories detection
> +
> +maintainers:
> +  - MyungJoo Ham <myungjoo.ham@samsung.com>
> +  - Chanwoo Choi <cw00.choi@samsung.com>

Usually this is someone that knows the h/w, not who applies the patch. 
I'd expect a Google person.

> +
> +description: |
> +  On ChromeOS systems with USB Type C ports, the ChromeOS Embedded Controller is
> +  able to detect the state of external accessories such as display adapters
> +  or USB devices when said accessories are attached or detached.
> +  The node for this device must be under a cros-ec node like google,cros-ec-spi
> +  or google,cros-ec-i2c.
> +
> +properties:
> +  compatible:
> +    const: google,extcon-usbc-cros-ec
> +
> +  google,usb-port-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      the port id

Any range of values allowed? ~0 is okay?

> +required:
> +  - compatible
> +  - google,usb-port-id
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    cros-ec@0 {
> +        compatible = "google,cros-ec-i2c";
> +        extcon {
> +            compatible = "google,extcon-usbc-cros-ec";
> +            google,usb-port-id = <0>;
> +        };
> +    };
> -- 
> 2.17.1
> 
