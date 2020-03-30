Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81874C2D0ED
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0432072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585596232;
	bh=6OlA2qF0ge60Y9qd4QRLz8Wg6xFIOo/oolkIEsWt7nQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d/n23C8X8dVYmyb6qz7G9wFb+WzA2cHnxcoRJoKdCrmaJob7bFcOBAXyyAZ8MZisD
	 jiAGZCYiVN4MX6R/VsAXKHU1r0qaBLm0rOA559azt6Ytkz80UCekrZLleWMTfmBjgv
	 Es/uSr9BqWfEJ/hTXDr1vi4h6wU4L3oARFxfspTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgC3TXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 15:23:51 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43691 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgC3TXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 15:23:51 -0400
Received: by mail-io1-f65.google.com with SMTP id x9so12633343iom.10;
        Mon, 30 Mar 2020 12:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MXO0cFSUgdRH+a4P/o/GAi4s4MndCf1pU3SuIpqOxH8=;
        b=b2WK8r2tG8huW8HYFFvjSGY0TfaCN7piJfb0Q6GCQr2a3D7F1WfwdHRz/eIsnRs86h
         y09f5qGv5o3X3V6sdlUdZ85G+LVyGsiVn2O6zaTDfR/dxWWFN4wS+IuLsuOghqSAS16q
         JY7WtgUBEVR8UhHPFnmpe7aEd6AyuRYuLGOUvZ9KWwCR+B+w0+GcrzPTDVzJ0vZ7bfwA
         0zSPfP/DNT2X+3VGFWso8z6aZa8wQ1yXJGxVB5OnNSQ08HeZK0RYyz7qEo/PQ+onL9kk
         plhszG505Bx2v9I6pFuUbqrnfCNukCl4Wy1rrPlN8SP0l3zdmzRFjFpFcET95+k7sKyF
         8tmA==
X-Gm-Message-State: ANhLgQ2L0jfR/zywO3xGCDo+Jo+oRoFsqB9+tnHPwhAgy5Z4YXYYXiGC
        /fynJzRe+bOxB9EsTf78WQ==
X-Google-Smtp-Source: ADFU+vul8Oe41tCjMTU3VB/Pazto4kKTIj+AVWhsXgGw9jz3HDJI0g0/B3oHxwfVXEbonu12CN0a1g==
X-Received: by 2002:a6b:b989:: with SMTP id j131mr12170677iof.6.1585596229713;
        Mon, 30 Mar 2020 12:23:49 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p189sm4307507iof.17.2020.03.30.12.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 12:23:49 -0700 (PDT)
Received: (nullmailer pid 22585 invoked by uid 1000);
        Mon, 30 Mar 2020 19:23:47 -0000
Date:   Mon, 30 Mar 2020 13:23:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     rentao.bupt@gmail.com
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Subject: Re: [PATCH v2 6/6] dt-bindings: usb: document aspeed vhub device
 ID/string properties
Message-ID: <20200330192347.GA6388@bogus>
References: <20200315191632.12536-1-rentao.bupt@gmail.com>
 <20200315191632.12536-7-rentao.bupt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315191632.12536-7-rentao.bupt@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 15, 2020 at 12:16:32PM -0700, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> Update device tree binding document for aspeed vhub's device IDs and
> string properties.
> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> ---
>  No change in v2:
>    - the patch is added into the series since v2.
> 
>  .../bindings/usb/aspeed,usb-vhub.yaml         | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> index 06399ba0d9e4..5b2e8d867219 100644
> --- a/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> +++ b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> @@ -52,6 +52,59 @@ properties:
>          minimum: 1
>          maximum: 21
>  
> +  vhub-vendor-id:
> +    description: vhub Vendor ID
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - maximum: 65535
> +
> +  vhub-product-id:
> +    description: vhub Product ID
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - maximum: 65535

There's already standard 'vendor-id' and 'device-id' properties. Use 
those.

> +
> +  vhub-device-revision:

Specific to USB, not vhub.

> +    description: vhub Device Revision in binary-coded decimal
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - maximum: 65535
> +
> +  vhub-strings:
> +    type: object
> +
> +    properties:
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
> +    patternProperties:
> +      '^string@[0-9a-f]+$':
> +        type: object
> +        description: string descriptors of the specific language
> +
> +        properties:
> +          reg:
> +            maxItems: 1
> +            description: 16-bit Language Identifier defined by USB-IF
> +
> +          manufacturer:
> +            description: vhub manufacturer
> +            allOf:
> +              - $ref: /schemas/types.yaml#/definitions/string
> +
> +          product:
> +            description: vhub product name
> +            allOf:
> +              - $ref: /schemas/types.yaml#/definitions/string
> +
> +          serial-number:
> +            description: vhub device serial number
> +            allOf:
> +              - $ref: /schemas/types.yaml#/definitions/string

For all of this, it's USB specific, not vhub specific. I'm not sure this 
is the right approach. It might be better to just define properties 
which are just raw USB descriptors rather than inventing some DT format 
that then has to be converted into USB descriptors.

Rob
