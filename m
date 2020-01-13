Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F100CC33C9A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B690B2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="jxINMd2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgAMKHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 05:07:42 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:44037 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgAMKHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 05:07:42 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9882822FE4;
        Mon, 13 Jan 2020 11:07:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1578910059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xEkS0LWcI4tJwU+s+4VJpzUfEiZFuLEe8r7ewTMtCKE=;
        b=jxINMd2pY60jpL/BmHks3d9VhIoMfVF8fpCONuWYcCBwBINF8KhrnV0sXF6BPYbq+dKQAt
        I4n0ca30DmHCz52w3/E/Len4FXo/8rimFeQ7l+Tusp1Lq8kjX6Lthvpr6+HCx3cszrcaA0
        u8XZCCssqfCazx/8b+3fWr4O9ZRT6bk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 13 Jan 2020 11:07:39 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        richard@nod.at, vigneshr@ti.com, miquel.raynal@bootlin.com
Subject: Re: [PATCH] mtd: spi-nor: Add support for w25qNNjwim
In-Reply-To: <4050087.dyKUiXJtgz@localhost.localdomain>
References: <20200103223423.14025-1-michael@walle.cc>
 <12341010.b9DRC5f9X7@192.168.0.113>
 <9d39be0f45f4c8e087b269f0c802ed6b@walle.cc>
 <4050087.dyKUiXJtgz@localhost.localdomain>
Message-ID: <2dffc658f21da502dff8c5721ec1b0a7@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.8
X-Spamd-Bar: /
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 9882822FE4
X-Spamd-Result: default: False [-0.10 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         TO_DN_NONE(0.00)[];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM(-0.00)[-0.783];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

Am 2020-01-13 10:06, schrieb Tudor.Ambarus@microchip.com:
> Hi, Michael,
> 
> On Sunday, January 12, 2020 1:16:12 AM EET Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the
>> content is safe
>> 
>> Hi Tudor,
>> 
>> Am 2020-01-11 15:19, schrieb Tudor.Ambarus@microchip.com:
>> > Hi, Michael,
>> >
>> > On Saturday, January 4, 2020 12:34:23 AM EET Michael Walle wrote:
>> >> Add support for the Winbond W25QnnJW-IM flashes. These have a
>> >> programmable QE bit. There are also the W25QnnJW-IQ variant which
>> >> shares
>> >> the ID with the W25QnnFW parts. These have the QE bit hard strapped to
>> >> 1, thus don't support hardware write protection.
>> >
>> > There are few flavors of hw write protection supported by this flash,
>> > the Q
>> > version does not disable them all. How about saying just that the /HOLD
>> > function is disabled?
>> 
>> I don't get your point here ;) My understanding is that HOLD# and WP#
>> will
>> be disabled. Thus there is no "hardware write protection". What other 
>> hw
>> write protection do you have in mind?
> 
> Time delay write disable after Power-up for example.

That is the usual "write enable" mechanism. while marketing may seem to 
see
that as write protection, I do not, esp. not hardware write protection.

What about changing it to the following?
"These have the QE bit hard strapped to 1, thus don't the /HOLD and /WP
pins".

>> 
>> > When we receive new flash id patches, we ask the contributors to
>> > specify if
>> > they test the flash, in which modes (single, quad), and with which
>> > controller.
>> > Ideally all the flash's flags should be tested, but there are cases in
>> > which
>> > the controllers do not support quad read for example, and we accept the
>> > patches even if tested in single read mode. SPI_NOR_HAS_LOCK and
>> > SPI_NOR_HAS_TB must be tested as well.
>> >
>> > Even if the patches are rather simple, we ask for this to be sure that
>> > we
>> > don't add a flash that is broken from day one. So, would you please
>> > tell us
>> > what flashes did you test, what flags, and with which controller?
>> 
>> Ok will add that to the commit message. Just to make sure. I've only
>> tested the
>> 32mbit part. So is it still ok to include all other flashes of this
>> family?
> 
> No, just the ones that you can test please.

ok

>> For now. tested with the NXP FlexSPI, single and dual (no quad since 
>> we
>> are
>> using the write protection feature and IO2 and IO3 are not connected 
>> to
>> the
>> CPU). So write protection is also tested. I will retest the TB bit.
> 
> Great, thanks.
> 
>> >> Signed-off-by: Michael Walle <michael@walle.cc>
>> >> ---
>> >>
>> >>  drivers/mtd/spi-nor/spi-nor.c | 22 ++++++++++++++++++++++
>> >>  1 file changed, 22 insertions(+)
>> >>
>> >> diff --git a/drivers/mtd/spi-nor/spi-nor.c
>> >> b/drivers/mtd/spi-nor/spi-nor.c
>> >> index addb6319fcbb..3fa8a81bdab0 100644
>> >> --- a/drivers/mtd/spi-nor/spi-nor.c
>> >> +++ b/drivers/mtd/spi-nor/spi-nor.c
>> >> @@ -2627,6 +2627,11 @@ static const struct flash_info spi_nor_ids[] =
>> >> {
>> >>
>> >>                      SECT_4K | SPI_NOR_DUAL_READ |
>> >
>> > SPI_NOR_QUAD_READ |
>> >
>> >>                      SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>> >>
>> >>      },
>> >>
>> >> +    {
>> >> +            "w25q16jwim", INFO(0xef8015, 0, 64 * 1024,  32,
>> >
>> > "i" is for the temperature range, which is not a fixed characteristic.
>> > Usually
>> > there are flashes with the same jedec-id, but with different
>> > temperature
>> > ranges. Let's drop the "i" and rename it to "w25q16jwm"
>> 
>> Only that there is no flash with that part name :( according to the
>> datasheet
> 
> The datasheet describes the W25Q32JW flash (check the first page of the
> datasheet). There are two flavors of this flash, each with its own 
> jedec-id: Q
> version uses 156016h, M 158016h. We should name this flashes as 
> "w25q32jwq"
> and "w25q32jwm".

You mean ef6016 and ef8016, yes that is correct. My point was there is 
no
"w25q15jwm": If linux kernel messages write "detected w25q32jwm" nobody 
will
know what that part is, because there is no such part. There is a 
w25q32jwim
or maybe w25q32jwXm but no w25q32jwm.

And naming the Q version w25q32jwq is not possible, because the id is 
shared
with the w25q32dw, which is already in spi-nor.c.

> Please notice that I skipped intentionally the "i"  that
> stands for temperature range. Manufacturers can provide better 
> temperature
> ranges for the same flash without changing the jedec-id. See this 
> datasheet:

I know that and get your point. But I fear that this will confuse 
others.

> 
> https://ro.mouser.com/datasheet/2/949/w25q128jv_revf_03272018_plus-1489608.pdf
> 
>> there is only this one temp range available. From what I've seen for 
>> now
>> (esp
>> looking at the macronix parts) it seems to first come first serve ;)
>> That being said, I don't insist on keeping that name, I'm fine with 
>> any
>> name,
> 
> you should be fine just with the name that best describes the flash :)
> 
>> since I've learned you cannot rely on it in any way. Eg. the 
>> w25q32jwiq
>> will
>> be discovered as w25q32dw. Or some Macronix flashes will be discovered
>> as
>> ancient ones.
> 
> Would you please study what's wrong with these names and provide a 
> patch to
> fix them?

Well, I've did that last week. But TBH I don't know if I want to go down 
that
road. Its not only the names, its also the flags. There is a mix of old 
and
new flashes in spi-nor.c; for example the newer ones supports dual and 
quad
mode. But the crux is, Macronix shares the same id over different 
generations
of the flash chip. For example look at the MX25L8005 (as it is supported 
in
the kernel) [1]. It doesn't support dual I/O mode. But the newer 
generation
MX25L8006E, which has the same id, supports it. So even I could come up 
with
something to fix it, I doubt it will be accepted without testing.


>> 
>> Btw. is renaming the flashes also considered a backwards incomaptible
>> change?
> 
> No, we can fix the names.
> 
>> And can there be two flashes with the same name? Because IMHO it would
>> be
> 
> I would prefer that we don't. Why would you have two different 
> jedec-ids with
> the same name?

Because as pointed out in the Winbond example you cannot distiguish 
between
W25Q32DW and W25Q32JWIQ; and in the Macronix example between MX25L8005 
and
MX25L8006E. Thus my reasoning was to show only the common part, ie 
W25Q32
or MX25L80 which should be the same for this particular ID. Like I said, 
I'd
prefer showing an ambiguous name instead of a wrong one. But then you 
may
have different IDs with the same ambiguous name.

>> better to just have the name "w25q16" regardless whether its an 
>> FW/JW/JV
>> etc.
>> It's better to show an ambiguous name than a wrong name.
>> 
>> -michael

-michael

[1] 
http://web.archive.org/web/20180712194807/https://www.mct.net/download/macronix/mx25l8005.pdf

