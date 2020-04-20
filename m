Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C98C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C8B9206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgDTOuE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:50:04 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:50426 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgDTOuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:50:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id D316027E0867;
        Mon, 20 Apr 2020 16:50:02 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HWyQpPAO5Tvb; Mon, 20 Apr 2020 16:50:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 6B91027E0879;
        Mon, 20 Apr 2020 16:50:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id m5gn7ZtFqnkJ; Mon, 20 Apr 2020 16:50:02 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 4EB7227E0868;
        Mon, 20 Apr 2020 16:50:02 +0200 (CEST)
Date:   Mon, 20 Apr 2020 16:50:02 +0200 (CEST)
From:   =?utf-8?Q?Cl=C3=A9ment?= Leger <cleger@kalrayinc.com>
To:     Tudor Ambarus <Tudor.Ambarus@microchip.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1734428336.16421904.1587394202163.JavaMail.zimbra@kalray.eu>
In-Reply-To: <1950407.5XCTmqoEVg@192.168.0.120>
References: <20200417160839.25880-1-cleger@kalray.eu> <1950407.5XCTmqoEVg@192.168.0.120>
Subject: Re: [PATCH] mtd: spi-nor: Add support for is25lp01g
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.15_GA_3895 (ZimbraWebClient - GC81 (Linux)/8.8.15_GA_3895)
Thread-Topic: spi-nor: Add support for is25lp01g
Thread-Index: AQHWFw0/tWJ4ISRUwk6rGADNBybaDI6HnvBZ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

----- On 20 Apr, 2020, at 14:14, Tudor Ambarus Tudor.Ambarus@microchip.com wrote:

> Hi, Clement,
> 
> On Friday, April 17, 2020 7:08:39 PM EEST Clement Leger wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the
>> content is safe
>> 
>> Update the issi_parts table for is25lp01g (128MB) device from ISSI.
>> Tested on Kalray K200 board.
>> 
>> Signed-off-by: Clement Leger <cleger@kalray.eu>
>> ---
>>  drivers/mtd/spi-nor/issi.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
>> index ffcb60e54a80..c3c3438e3d08 100644
>> --- a/drivers/mtd/spi-nor/issi.c
>> +++ b/drivers/mtd/spi-nor/issi.c
>> @@ -49,6 +49,8 @@ static const struct flash_info issi_parts[] = {
>>                              SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ
>> | SPI_NOR_4B_OPCODES)
>>                 .fixups = &is25lp256_fixups },
>> +       { "is25lp01g",  INFO(0x9d601b, 0, 64 * 1024, 2048,
> 
> There is a "K" flavor of this flash which has 512 Byte Page size with 256 KB
> Block size. While the page size can be determined by parsing SFDP, I think we
> will have some problems with sector_size because as of now, the sector_size is
> always set to 64KB. An incorrect sector_size will affect erases and locking.

Thanks, I did not noticed that ! If I understand, this will require to modify
the core to handle sector size the same way as page_size and probably add a
fixup to detect the "K" options from SFDP ?
This is probably more changes than I can handle, and you can probably drop this
patch since not really functional for "K" type flash.

But thanks for noticing it !

Clément

> 
> Cheers,
> ta
