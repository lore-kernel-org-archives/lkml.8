Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47ED7C47254
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27CA5206D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588605314;
	bh=5Yi6sD4kXCyHEvHQC8xe5qp9xZ1wfoODAUheiqjGCOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OIrnk9tCGh4jT2SX6wtuqFS0oFbi6kGT8lUVV9TIeVBdAlAxjFRvN+2ak7/OCaKRY
	 8JACtPGX8t4mrL3DHshTx0IFK3Z7mkpRzB7Bf+pLU8HaRWZfGbX/KT9tIxzj/KdSMb
	 KjYAtWUs3WIQqEpiPDo1bMIrvwLDjqCpVaVB/b/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgEDPPN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:15:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35083 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgEDPPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:15:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id a8so13846076edv.2;
        Mon, 04 May 2020 08:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LCc+eYdO3tX3LkVF95rDTpEk+HBT/KELfuXGkU4VVhM=;
        b=p604soKS+8HyOzeDutcUjBGXG/4TW8PCYxm8/RbCdYKZARwQ3H1/LDcbJqu26/8Bij
         DZhbYmG1kmloHI9mhAA1o11sEHyl8yoD9GYUcz8T1nT0vPKY9bweMBC6LIO5qJcR60qv
         fuPzni36o4tuyA7qPThu/xAZ8fomrym1Mb1VQpohSF0Sk5GnVWZP4dn56a7uu5FUY9Xi
         Tnqmvd/2rvS4m+Bi/Pmr43W/MqIAFs020zP8RqIz0KzGFQGmSRJ1SCjGTgsHiYBxLvO3
         GqiaYAdOhH08z9DrallzIo/D4/koS+fCeYC1xP/qaxUZw/GdtcisiP6hTTt5isU00mcx
         Q32A==
X-Gm-Message-State: AGi0PuZnZSR1ryp56Feia1H74AyZxpCxbX1SCq3MOT6lfBgsCQitXjHC
        QvRihXAhtEB8oPyohOnLpOAO6uM/
X-Google-Smtp-Source: APiQypLgL0BNupES2fskOUM21pKl/rDCVu+OP0SF7FJCBNEdF6HBSjXWjjho1YvOBX3WBlLXsQtV9g==
X-Received: by 2002:a05:6402:22a6:: with SMTP id cx6mr14498532edb.277.1588605310748;
        Mon, 04 May 2020 08:15:10 -0700 (PDT)
Received: from kozik-lap ([194.230.155.237])
        by smtp.googlemail.com with ESMTPSA id 10sm1488687ejt.80.2020.05.04.08.15.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 May 2020 08:15:10 -0700 (PDT)
Date:   Mon, 4 May 2020 17:15:08 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     kgene@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] S5PV210 and Aries DTS improvements
Message-ID: <20200504151508.GA3205@kozik-lap>
References: <20200426183604.28494-1-xc-racer2@live.ca>
 <BN6PR04MB066033FD7FF6E5C37747C7A2A3AB0@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <BN6PR04MB066033FD7FF6E5C37747C7A2A3AB0@BN6PR04MB0660.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 04:50:01PM -0700, Jonathan Bakker wrote:
> This patchset makes several improvements to Aries devices which are
> based on S5PV210.  Several pulls on GPIOs were incorrect/not specified,
> sleep GPIO configurations have been added, and more devices have been
> added.
> 
> Touching the common S5PV210 DTSI are the addition of the ADC node
> as well as fixes to the FIMC definitions and a sleep GPIO helper
> added.  The GPI gpio node name has been corrected.
> 
> The patches have been tested on both a GT-i9000 as well as an
> SGH-T959P and both can now suspend/resume properly.
> 
> Changes from v1:
> - Correct ADC node name to match reg
> - Restore removed regulator suspend state
> - Split commit adding support for new devices into separate commits
>   for each device
> - Add note where sleep gpio cfgs come from
> - Ensure subject of all patches matches subsystem
> - Add patch correcting GPI node name
> 
> 
> Jonathan Bakker (17):
>   ARM: dts: s5pv210: Add helper define for sleep gpio config
>   ARM: dts: s5pv210: Add sleep GPIO configuration for fascinate4g
>   ARM: dts: s5pv210: Add sleep GPIO configuration for galaxys
>   ARM: dts: s5pv210: Set keep-power-in-suspend for SDHCI1 on aries
>   ARM: dts: s5pv210: Disable pulls on GPIO i2c adapters for aries
>   ARM: dts: s5pv210: Add WM8994 support to aries boards
>   ARM: dts: s5pv210: Add FSA9480 support to Aries boards
>   ARM: dts: s5pv210: Add touchkey support to aries boards
>   ARM: dts: s5pv210: Add panel support to aries boards
>   ARM: dts: s5pv210: Add remaining i2c-gpio adapters to aries
>   ARM: dts: s5pv210: Disable pull for vibrator ena GPIO on aries
>   ARM: dts: s5pv210: Add an ADC node
>   ARM: dts: s5pv210: Enable ADC on aries boards
>   ARM: dts: s5pv210: Assign clocks to MMC devices on aries
>   ARM: dts: s5pv210: Correct FIMC definitions
>   ARM: dts: s5pv210: Set MAX8998 GPIO pulls on aries
>   ARM: dts: s5pv210: Correct gpi gpio node name
> 
> Paweł Chmiel (1):
>   ARM: dts: s5pv210: Add si470x fmradio to galaxys
>

Nice job!

Thanks, I applied entire set.

Best regards,
Krzysztof

