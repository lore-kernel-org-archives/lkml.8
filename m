Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C2FC38A2A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 23:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2D6520735
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 23:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="YZrb7LGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgEFXOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 19:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgEFXOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 19:14:01 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3804DC061A10;
        Wed,  6 May 2020 16:14:01 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t12so3657445edw.3;
        Wed, 06 May 2020 16:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vh5sHkIk2ctB42dNaltmVdyOo6gu7M7B4FBlMbUP/78=;
        b=YZrb7LGmD+n+0wVJ2oxBjUDRo7Q+l5YL+EuBd+JHHr0T97aLS9wt1LuRXYAxG5hxrx
         91vy6KnrF5ec4Vh8kh7TdoG5yUcNScYVZoXLfmFCNv1OzNMhS5AfjcbZmnZqjlAQzsdQ
         9yWoSoV4QTqAiBHO25L9qlvP+8NmbNeyQYnts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vh5sHkIk2ctB42dNaltmVdyOo6gu7M7B4FBlMbUP/78=;
        b=tWrZDhVOsHAniKYQqeyKay99hAGSthloq/c5IE5KCUdMat77VzNvVRSL8eyP+BKkX8
         C1rP43Y2Wr/8OmhsoFKfvtddhiK9g+3oWRa9ev+5CkcvFmY1vPwJo3b8OcwCgWaJ0vco
         j67iL7tYag3vSM0zgufRxELg0oGrK0ihd+BclI2DuKJf710sqG7HB7N4XwCbulZZxMkh
         47O4njgRRSKkYwtPf/wslPfSQ7zinw9S/SOAsSQJYwXzRYXIyZmRq/piSmvc9LXLnQ1w
         umPe9G3FQds28WWNZycpnGdyU319w0EvpdHmzYLRoOf3Cwy8dPeGEkml/uQIqfqoemSN
         w/3g==
X-Gm-Message-State: AGi0PuZoYT0p8bX79ie84RyokJc9em8VbmRSzdHqD42/xFuM1vLobmDb
        sbP/7fsE9RUzHH5IVjKgv12GliD4ppFhHYvmDKo=
X-Google-Smtp-Source: APiQypI8Ewgq5yqLktUWwJKPyyv1TxfYTOTbdXEP0SpawXbQmffhZ2z0i20qFvoDhtpRclckUFjOpS0Y51YmfRnpoMs=
X-Received: by 2002:a50:8dc2:: with SMTP id s2mr9779893edh.318.1588806839283;
 Wed, 06 May 2020 16:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200507091008.1bd38185@canb.auug.org.au>
In-Reply-To: <20200507091008.1bd38185@canb.auug.org.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 6 May 2020 23:13:47 +0000
Message-ID: <CACPK8XfOJqj=E4JwQsZWvAsp7cv=bjqj2twZk0=MR+ZJQP1nqQ@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the aspeed tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        devicetree-compiler@vger.kernel.org
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>,
        Andrew Jeffery <andrew@aj.id.au>, Vijay Khemka <vkhemka@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, 6 May 2020 at 23:10, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the aspeed tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:

Thanks Stephen.

> arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts:126.11-130.4: Warning (i2c_bus_reg): /ahb/apb/bus@1e78a000/i2c-bus@80/ipmb1@10: I2C bus unit address format error, expected "40000010"
> arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts:128.3-30: Warning (i2c_bus_reg): /ahb/apb/bus@1e78a000/i2c-bus@80/ipmb1@10:reg: I2C address must be less than 10-bits, got "0x40000010"
> arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts:137.11-141.4: Warning (i2c_bus_reg): /ahb/apb/bus@1e78a000/i2c-bus@100/ipmb3@10: I2C bus unit address format error, expected "40000010"
> arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts:139.3-30: Warning (i2c_bus_reg): /ahb/apb/bus@1e78a000/i2c-bus@100/ipmb3@10:reg: I2C address must be less than 10-bits, got "0x40000010"
> arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts:148.11-152.4: Warning (i2c_bus_reg): /ahb/apb/bus@1e78a000/i2c-bus@180/ipmb5@10: I2C bus unit address format error, expected "40000010"
> arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts:150.3-30: Warning (i2c_bus_reg): /ahb/apb/bus@1e78a000/i2c-bus@180/ipmb5@10:reg: I2C address must be less than 10-bits, got "0x40000010"
> arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts:159.11-163.4: Warning (i2c_bus_reg): /ahb/apb/bus@1e78a000/i2c-bus@300/ipmb7@10: I2C bus unit address format error, expected "40000010"
> arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts:161.3-30: Warning (i2c_bus_reg): /ahb/apb/bus@1e78a000/i2c-bus@300/ipmb7@10:reg: I2C address must be less than 10-bits, got "0x40000010"

These are IPMB nodes with the SLAVE_ADDRESS bit set:

+&i2c5 {
+       //Host3 IPMB bus
+       status = "okay";
+       multi-master;
+       ipmb5@10 {
+               compatible = "ipmb-dev";
+               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+               i2c-protocol;
+       };

This is a correct entry, so dtc should not warn about it.

Cheers,

Joel

>
> Introduced by commit
>
>   266056d3c61d ("ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC")
>
> --
> Cheers,
> Stephen Rothwell
