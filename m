Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0427C33CA7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 23:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C5F120673
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 23:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="mwCECxaZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbgAKXQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 18:16:15 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:54451 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731318AbgAKXQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 18:16:15 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B484E22FF5;
        Sun, 12 Jan 2020 00:16:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1578784573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R/Rnt74sTEbFgl+i5rmFZG5lKEzsjstD10U5xxr8PJg=;
        b=mwCECxaZYSprDR/W8jMGTHrz8os8mIhz+cgX8C7siaX0QzThXqkixZS+EW3NzvoReCPOaT
        z3nZR72RIoyhGouXSrprPVR6VkNiM6sUnZqDiIUOq+dJrnaEzroRERPbUQo9m6I7atN5Wi
        zN1X5tHrjUBiKa19xcTIa6/lwl2BHvg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 12 Jan 2020 00:16:12 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        richard@nod.at, vigneshr@ti.com, miquel.raynal@bootlin.com
Subject: Re: [PATCH] mtd: spi-nor: Add support for w25qNNjwim
In-Reply-To: <12341010.b9DRC5f9X7@192.168.0.113>
References: <20200103223423.14025-1-michael@walle.cc>
 <12341010.b9DRC5f9X7@192.168.0.113>
Message-ID: <9d39be0f45f4c8e087b269f0c802ed6b@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.8
X-Spamd-Bar: /
X-Rspamd-Server: web
X-Rspamd-Queue-Id: B484E22FF5
X-Spamd-Result: default: False [-0.10 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         TO_DN_NONE(0.00)[];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM(-0.00)[-0.657];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

Am 2020-01-11 15:19, schrieb Tudor.Ambarus@microchip.com:
> Hi, Michael,
> 
> On Saturday, January 4, 2020 12:34:23 AM EET Michael Walle wrote:
>> Add support for the Winbond W25QnnJW-IM flashes. These have a
>> programmable QE bit. There are also the W25QnnJW-IQ variant which 
>> shares
>> the ID with the W25QnnFW parts. These have the QE bit hard strapped to
>> 1, thus don't support hardware write protection.
> 
> There are few flavors of hw write protection supported by this flash, 
> the Q
> version does not disable them all. How about saying just that the /HOLD
> function is disabled?

I don't get your point here ;) My understanding is that HOLD# and WP# 
will
be disabled. Thus there is no "hardware write protection". What other hw
write protection do you have in mind?

> When we receive new flash id patches, we ask the contributors to 
> specify if
> they test the flash, in which modes (single, quad), and with which 
> controller.
> Ideally all the flash's flags should be tested, but there are cases in 
> which
> the controllers do not support quad read for example, and we accept the
> patches even if tested in single read mode. SPI_NOR_HAS_LOCK and
> SPI_NOR_HAS_TB must be tested as well.
> 
> Even if the patches are rather simple, we ask for this to be sure that 
> we
> don't add a flash that is broken from day one. So, would you please 
> tell us
> what flashes did you test, what flags, and with which controller?

Ok will add that to the commit message. Just to make sure. I've only 
tested the
32mbit part. So is it still ok to include all other flashes of this 
family?

For now. tested with the NXP FlexSPI, single and dual (no quad since we 
are
using the write protection feature and IO2 and IO3 are not connected to 
the
CPU). So write protection is also tested. I will retest the TB bit.

>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  drivers/mtd/spi-nor/spi-nor.c | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>> 
>> diff --git a/drivers/mtd/spi-nor/spi-nor.c 
>> b/drivers/mtd/spi-nor/spi-nor.c
>> index addb6319fcbb..3fa8a81bdab0 100644
>> --- a/drivers/mtd/spi-nor/spi-nor.c
>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>> @@ -2627,6 +2627,11 @@ static const struct flash_info spi_nor_ids[] = 
>> {
>>  			SECT_4K | SPI_NOR_DUAL_READ |
> SPI_NOR_QUAD_READ |
>>  			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>>  	},
>> +	{
>> +		"w25q16jwim", INFO(0xef8015, 0, 64 * 1024,  32,
> 
> "i" is for the temperature range, which is not a fixed characteristic. 
> Usually
> there are flashes with the same jedec-id, but with different 
> temperature
> ranges. Let's drop the "i" and rename it to "w25q16jwm"

Only that there is no flash with that part name :( according to the 
datasheet
there is only this one temp range available. From what I've seen for now 
(esp
looking at the macronix parts) it seems to first come first serve ;)
That being said, I don't insist on keeping that name, I'm fine with any 
name,
since I've learned you cannot rely on it in any way. Eg. the w25q32jwiq 
will
be discovered as w25q32dw. Or some Macronix flashes will be discovered 
as
ancient ones.

Btw. is renaming the flashes also considered a backwards incomaptible 
change?
And can there be two flashes with the same name? Because IMHO it would 
be
better to just have the name "w25q16" regardless whether its an FW/JW/JV 
etc.
It's better to show an ambiguous name than a wrong name.

-michael
