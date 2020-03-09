Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEABC10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D515721D56
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffYHLgbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgCIQUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:20:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38037 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgCIQUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:20:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id x7so4922939pgh.5;
        Mon, 09 Mar 2020 09:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wx4WOqxveYem6nIwkzhdk+8QkksLqOajFdO8bW3gOS8=;
        b=ffYHLgbtPxcz1gQ/nXn1T9k1IJ4Xp5SB5kzrsMX8YUhLlOgzYfcmd6FbdArflK5tR4
         9WpA1UgGwWcD3w3TuvLUkyr+4K1LOyozE+9Mn5zpUGQDndLXOwKcfXS+YwqsLkxP2TfF
         zw/YCkKwYdOisgT2PhcANTMP+CNBRS2CjccnY2wqIapSsDyf1fOnFWC1tcRv5OJzsyVY
         KrEffO5PfgsJMA2Ib57RAHUfNoRxf0n/kDIObv/Jr3YU5ghxDCaBIMnp1AxtLPbB7KEU
         D4XosSG2wbVhkRMc4FexPyYR6P/5ZMD+zcrGMXR0Dp8UOqeVNtXOZuwpNKCLeUWaYm9b
         aebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wx4WOqxveYem6nIwkzhdk+8QkksLqOajFdO8bW3gOS8=;
        b=EKQHpz3nbY97XdUGM24mp9L/wlRw2YM0pjMpezS7wWywaqPjb+1pNP61ilRYMN6LSW
         T7UBee8cYUwMGJrcjs2q1WOPzGagx7altgg6ILwe8Zc+ee/oFkGRPDigvnrjy/uSNOIm
         FTGKTlulBhPdaGLDcWWqv8c6+sJiPIXHd/7fja2ve4FybTGXcnt+fD5b9Q8b3CEdY5am
         +KwnGiqmcCHdcTzYTEzil7XCTK5+KHkgTbMruHioV3Ycz2v8PVjAUjM4ncFmZJip1heb
         ULf2v02OC3YLnkYvtZLvr7U1p96UrJYkp1DWDkM7DUZlCnqKtSO31rRK0/P1owQywuDK
         WnkQ==
X-Gm-Message-State: ANhLgQ3Fyb0Kd6Sw37PhKbqVUnse2H7y93t/sEqpbw/17bg05ksNMUB1
        MCcr7ioWTYFyw3DHixg/YJU=
X-Google-Smtp-Source: ADFU+vsZRunZgg1C43Thvz78Oy4eDP3nUrPjTZcILLH5TAqSftB/mTLWRL40rZmvuIWLU5mlCc/HGg==
X-Received: by 2002:a63:c00a:: with SMTP id h10mr16637410pgg.31.1583770851338;
        Mon, 09 Mar 2020 09:20:51 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 22sm30089906pfc.14.2020.03.09.09.20.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Mar 2020 09:20:50 -0700 (PDT)
Date:   Mon, 9 Mar 2020 09:20:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: Add bindings for ADM1266
Message-ID: <20200309162049.GB22193@roeck-us.net>
References: <20200309141422.10999-1-alexandru.tachici@analog.com>
 <20200309141422.10999-3-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309141422.10999-3-alexandru.tachici@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 04:14:22PM +0200, Alexandru Tachici wrote:
> Add bindings for the Analog Devices ADM1266 sequencer.
> 

Unless there are more bindings expected in the future, this could be
added as trivial device. If there _are_ more bindings expected in the
future, they should be part of this patch.

Thanks,
Guenter

> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  .../bindings/hwmon/adi,adm1266.yaml           | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
> new file mode 100644
> index 000000000000..1e83883a4661
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/pmbus/adi,adm1266.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADM1266 Cascadable Super Sequencer with Margin
> +Control and Fault Recording
> +
> +maintainers:
> +  - Alexandru Tachici <alexandru.tachici@analog.com>
> +
> +description: |
> +  Analog Devices ADM1266 Cascadable Super Sequencer with Margin
> +  Control and Fault Recording
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1266.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adm1266
> +
> +  reg:
> +    maxItems: 1
> +
> +  avcc-supply:
> +    description:
> +      Phandle to the Avcc power supply
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adm1266@40 {
> +                compatible = "adi,adm1266";
> +                reg = <0x40>;
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +        };
> +    };
> +...
> -- 
> 2.20.1
> 
