Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27372C2D0EE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DEC20732
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585584189;
	bh=lj6lk2Y9Wilw3U7preSl4MIXWR616TrbL/l1zLZqeRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gq09lz0KVg3CJ9krvY5/H1fKZPzLURy7k8LFAewXC+dTIqvHKoKXJ0YA5pSOnkYiM
	 BRWz6LXckzHzFs9yBB1rRDGf/LYhRCuz+wpI9wZYRE8pSCoreV6WjvJKbgkU7xWz9U
	 FzvysWwrJQ7vCfeH36QUOHbrej4bMHCvXmHvCU5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgC3QDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:03:08 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:33530 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgC3QDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 12:03:07 -0400
Received: by mail-il1-f193.google.com with SMTP id k29so16303272ilg.0;
        Mon, 30 Mar 2020 09:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kZgYXQbJLj89O4ta8azIBTnlwIyHbrjAjhucjQsGXzg=;
        b=CW4VJ0idMCYzjf62SQDyAQS/eEAnjC1kEdGz2YQkxxPfox9v+F35zixPk9l2BjFI+L
         +FF2772DsRLk1h9LAf63bldXL7m9BjvKXFpJjc3qLXQy5hWuQF49EgBUH2iEfO1LuLyb
         53UjY3RK9hjPx6pv6aedhvm5rZuVuEASC1imsEWD/r/RWVQODA/Xv4DptgSljyIYYh6n
         aBhz8cvJp23to/ymEAyyZL3Zg67Nf3sqKmF7kgvA0pAIXyzC69RGlX/r0savKaMGDaDf
         AcxVqov3wJlQKbJwyYk2BbvaMQV2VfOsi2wzve4DzPCkb/vjGcspghNQLhfKFTwrWNih
         DWfg==
X-Gm-Message-State: ANhLgQ2esMaUEA2MOIalWhk+U4Mf43sLBUYjgPpBNFnM/RqIDlB6UDfc
        v3y6JYP5ruvUJqgO6eDcHA==
X-Google-Smtp-Source: ADFU+vtt+io7ja0ZorBm8+7HKHTZRk2B4475TcYlAmG8/96ZwgpGsVKBksJefrlilE/q9BHX71F3wA==
X-Received: by 2002:a92:3ac4:: with SMTP id i65mr11307095ilf.247.1585584186563;
        Mon, 30 Mar 2020 09:03:06 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h29sm4989538ili.19.2020.03.30.09.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 09:03:05 -0700 (PDT)
Received: (nullmailer pid 26424 invoked by uid 1000);
        Mon, 30 Mar 2020 16:03:04 -0000
Date:   Mon, 30 Mar 2020 10:03:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Jones <rjones@gateworks.com>
Subject: Re: [PATCH v8 1/3] dt-bindings: mfd: Add Gateworks System Controller
 bindings
Message-ID: <20200330160304.GA24832@bogus>
References: <1585341214-25285-1-git-send-email-tharvey@gateworks.com>
 <1585341214-25285-2-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585341214-25285-2-git-send-email-tharvey@gateworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 01:33:32PM -0700, Tim Harvey wrote:
> This patch adds documentation of device-tree bindings for the
> Gateworks System Controller (GSC).
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v8:
>  - add register to fan-controller node name
> 
> v7:
>  - change divider from mili-ohms to ohms
>  - add constraints for voltage divider and offset
>  - remove unnecessary ref for offset
>  - renamed fan to fan-controller and changed base prop to reg
> 
> v6:
>  - fix typo
>  - drop invalid description from #interrupt-cells property
>  - fix adc pattern property
>  - add unit suffix
>  - replace hwmon/adc with adc/channel
>  - changed adc type to mode and enum int
>  - add unit suffix and drop ref for voltage-divider
>  - moved fan to its own subnode with base register
> 
> v5:
>  - resolve dt_binding_check issues
> 
> v4:
>  - move to using pwm<n>_auto_point<m>_{pwm,temp} for FAN PWM
>  - remove unncessary resolution/scaling properties for ADCs
>  - update to yaml
>  - remove watchdog
> 
> v3:
>  - replaced _ with -
>  - remove input bindings
>  - added full description of hwmon
>  - fix unit address of hwmon child nodes
> ---
>  .../devicetree/bindings/mfd/gateworks-gsc.yaml     | 194 +++++++++++++++++++++
>  1 file changed, 194 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
