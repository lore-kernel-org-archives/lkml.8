Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66881C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 08:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43C8C20842
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 08:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgFBIBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 04:01:13 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:53954 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgFBIBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 04:01:13 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id D78A18030835;
        Tue,  2 Jun 2020 08:01:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cdmgq3OZHxmj; Tue,  2 Jun 2020 11:01:08 +0300 (MSK)
Date:   Tue, 2 Jun 2020 11:01:04 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Joel Stanley <joel@jms.id.au>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        <devicetree-compiler@vger.kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 2/2] checks: Improve i2c reg property checking
Message-ID: <20200602080104.4vqobktck357j52v@mobilestation>
References: <20200528085650.1417942-1-joel@jms.id.au>
 <20200528085650.1417942-3-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200528085650.1417942-3-joel@jms.id.au>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 06:26:50PM +0930, Joel Stanley wrote:
> The i2c bindings in the kernel tree describe support for 10 bit
> addressing, which must be indicated with the I2C_TEN_BIT_ADDRESS flag.
> When this is set the address can be up to 10 bits. When it is not set
> the address is a maximum of 7 bits.
> 
> See Documentation/devicetree/bindings/i2c/i2c.txt.
> 
> Take into account this flag when checking the address is valid.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v2: Mask reg when checking the 10-bit size
> ---
>  checks.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/checks.c b/checks.c
> index feb1721f2603..3fe979a63290 100644
> --- a/checks.c
> +++ b/checks.c
> @@ -1023,6 +1023,7 @@ static void check_i2c_bus_bridge(struct check *c, struct dt_info *dti, struct no
>  WARNING(i2c_bus_bridge, check_i2c_bus_bridge, NULL, &addr_size_cells);
>  
>  #define I2C_OWN_SLAVE_ADDRESS	(1 << 30)

> +#define I2C_TEN_BIT_ADDRESS	(1 << 31)

As Andy neatly pointed out here:
https://lore.kernel.org/lkml/20200527133656.GV1634618@smile.fi.intel.com/
(1 << 31) is UB.

-Sergey

>  
>  static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, struct node *node)
>  {
> @@ -1057,10 +1058,13 @@ static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, struct node
>  		reg = fdt32_to_cpu(*(cells++));
>  		/* Ignore I2C_OWN_SLAVE_ADDRESS */
>  		reg &= ~I2C_OWN_SLAVE_ADDRESS;
> -		if (reg > 0x3ff)
> +
> +		if ((reg & I2C_TEN_BIT_ADDRESS) && ((reg & ~I2C_TEN_BIT_ADDRESS) > 0x3ff))
>  			FAIL_PROP(c, dti, node, prop, "I2C address must be less than 10-bits, got \"0x%x\"",
>  				  reg);
> -
> +		else if (reg > 0x7f)
> +			FAIL_PROP(c, dti, node, prop, "I2C address must be less than 7-bits, got \"0x%x\". Set I2C_TEN_BIT_ADDRESS for 10 bit addresses or fix the property",
> +				  reg);
>  	}
>  }
>  WARNING(i2c_bus_reg, check_i2c_bus_reg, NULL, &reg_format, &i2c_bus_bridge);
> -- 
> 2.26.2
> 
