Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF786C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A97CB20771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBOADVhr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgGGNfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 09:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgGGNfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 09:35:06 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06419C061755;
        Tue,  7 Jul 2020 06:35:06 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k71so14800912pje.0;
        Tue, 07 Jul 2020 06:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WcZ5qo7y9qUcKIeVIbnTxzfzPN7859vCpAHcM5CTAlc=;
        b=VBOADVhrVQaImFIIIylGi/N7xk7WGvoP2orasZftk1JuDxbX6szpmb7IwR0xaTsGvT
         N0QPz0zneW1MIUyYqDqIvlBjBx9T4W7235IEmX4FYc2yogqRZ45T2YZDzpBUETrUd28z
         R6L75o2jO1miJaOC/ymI66G9moZEYnVl6HXPwvFKeHzY6W8XpE20InU9fP6I4WSPFXVP
         de1Zqmt38o/Ex4PZ6DlBVItboWx2dK43VhKEkD6JfdMOtekoUyyeWOMLVSszdL2FHANv
         2lLIxTc8pbkpjhV+b/wmI6kA8OVOz6CvjARrCye5tEcmwoBWeqnPSU+sCFJyU29WcJlO
         BGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=WcZ5qo7y9qUcKIeVIbnTxzfzPN7859vCpAHcM5CTAlc=;
        b=ek3Kgx8ptPmpeBJGOawQ3Qi8t3VpkgKlYVvZDNwZGv6ct2jErHNXvdHE5Zcy6alsqp
         oIxH2yBa9iW1lIpEKbyXL8LHq3QdmTokOlQiXFfWcizJ6ZGtqEXGtD8arXlXlccG1LLP
         z9//J5mjdpgwwznskM0mDyLghtIIq4agLGkwopYXSdIfY/6kObFk2bR/PDqONQ3BwR1/
         NjdsVipKfUKq/uj5Yay8fpmHay4Df9VPWf+cfptdozWXng+BGj9AEo0pAP5BM9l2dyxD
         qezoP9X2GHTWhRFu1KonK9rdW9P0rU7UyxQPaqcJN8Je9CqpHk4AVFSnE/NSQ/8pI9IB
         HAFg==
X-Gm-Message-State: AOAM533980aZfTlcr2YMzOenbYEGWbHwMNdRaNtPMe7v0Dsf3rPpMbfk
        Os7zEATYu5H61H/jAaqwGjN/JaZILdI=
X-Google-Smtp-Source: ABdhPJyEu9Q1UlbUHSi5o70FjjCly+i1xLnaxD5bOouAPmNNhWS7+UiwW8G93d3L22USW2SQjxv7Jw==
X-Received: by 2002:a17:90b:8d0:: with SMTP id ds16mr4665898pjb.2.1594128905556;
        Tue, 07 Jul 2020 06:35:05 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g9sm21142608pfm.151.2020.07.07.06.35.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jul 2020 06:35:04 -0700 (PDT)
Date:   Tue, 7 Jul 2020 06:35:03 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Jack Lo <jack.lo@gtsys.com.hk>, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] devicetree: hwmon: shtc1: Add sensirion,shtc1.yaml
Message-ID: <20200707133503.GA217263@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 04:01:03PM +0800, Chris Ruehl wrote:
> Add documentation for the newly added DTS support in the shtc1 driver.
> To align with the drivers logic to have high precision by default
> a boolean sensirion,low_precision is used to switch to low precision.
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
>  .../bindings/hwmon/sensirion,shtc1.yaml       | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml b/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> new file mode 100644
> index 000000000000..bcccdcadd86b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/sensirion,shtc1.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sensirion SHTC1 Humidity and Temperature Sensor IC
> +
> +maintainers:
> +  - jdelvare@suse.com

Did Jean agree to maintain this file ?

> +
> +description: |
> +  The SHTC1, SHTW1 and SHTC3 are digital humidity and temperature sensor
> +  designed especially for battery-driven high-volume consumer electronics
> +  applications.
> +  For further information refere to Documentation/hwmon/shtc1.rst
> +
> +  This binding document describes the binding for the hardware monitor
> +  portion of the driver.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sensirion,shtc1
> +      - sensirion,shtw1
> +      - sensirion,shtc3
> +
> +  reg: I2C address 0x70
> +
> +Optional properties:
> +  sensirion,blocking_io: |
> +    bool, if set the i2c bus hold until measure finished
> +  sensirion,low_precision: |
> +    bool, if set aquire data with low precision (not recommend)

recommended

It might make sense to mention that the default is expected to be high precision
if not specified.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +Example:
> +  &i2c1 {
> +    status = "okay";
> +    clock-frequency = <400000>;
> +
> +    shtc3@70 {
> +      compatible = "sensirion,shtc3";
> +      reg = <0x70>
> +      sensirion,blocking_io;
> +      status = "okay";
> +    };
> +  };
> -- 
> 2.20.1
> 
