Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F49C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7C69206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="ejnAZ/px"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgDUHH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 03:07:59 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:47722 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgDUHH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 03:07:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id A6CDF27E039A;
        Tue, 21 Apr 2020 09:07:57 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id VnFh86lcJuca; Tue, 21 Apr 2020 09:07:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id DFC6727E06C1;
        Tue, 21 Apr 2020 09:07:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu DFC6727E06C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1587452876;
        bh=ufm9yZSRtYmx3MHRNMrA5MNRiT5MrRD1Yhw3IeM6pZA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ejnAZ/pxGLDwi3zSwxLtUnKn7C6TI+a20eVd1LlWQ+Kz1237P+LBdvKlCqvCZ9+hs
         L3WOOs0581spu9PyXfeEXsksUlddUiisiv0qdHmHjeVPCnch3f8fsv/T3Igo/3XSWw
         PBzfe2iIs2Gcv2wWkN0AoEkI2QtSkadvffddzL4I=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QoHi6CGZQf_D; Tue, 21 Apr 2020 09:07:56 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id C98EC27E039A;
        Tue, 21 Apr 2020 09:07:56 +0200 (CEST)
Date:   Tue, 21 Apr 2020 09:07:56 +0200 (CEST)
From:   =?utf-8?Q?Cl=C3=A9ment?= Leger <cleger@kalray.eu>
To:     Tudor Ambarus <Tudor.Ambarus@microchip.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        richard <richard@nod.at>, vigneshr <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1220480151.16477138.1587452876610.JavaMail.zimbra@kalray.eu>
In-Reply-To: <2185268.xDFeLDFsC1@192.168.0.120>
References: <20200417160839.25880-1-cleger@kalray.eu> <1950407.5XCTmqoEVg@192.168.0.120> <1734428336.16421904.1587394202163.JavaMail.zimbra@kalray.eu> <2185268.xDFeLDFsC1@192.168.0.120>
Subject: Re: [PATCH] mtd: spi-nor: Add support for is25lp01g
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.15_GA_3895 (ZimbraWebClient - GC81 (Linux)/8.8.15_GA_3895)
Thread-Topic: spi-nor: Add support for is25lp01g
Thread-Index: AQHWFw0/tWJ4ISRUwk6rGADNBybaDFUftyjv
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

----- On 21 Apr, 2020, at 06:40, Tudor Ambarus Tudor.Ambarus@microchip.com =
wrote:

> On Monday, April 20, 2020 5:50:02 PM EEST Cl=C3=A9ment Leger wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know t=
he
>> content is safe
>>=20
>> Hi Tudor,
>=20
> Hi, Clement,
>=20
>>=20
>> ----- On 20 Apr, 2020, at 14:14, Tudor Ambarus Tudor.Ambarus@microchip.c=
om
> wrote:
>> > Hi, Clement,
>> >=20
>> > On Friday, April 17, 2020 7:08:39 PM EEST Clement Leger wrote:
>> >> EXTERNAL EMAIL: Do not click links or open attachments unless you kno=
w
>> >> the
>> >> content is safe
>> >>=20
>> >> Update the issi_parts table for is25lp01g (128MB) device from ISSI.
>> >> Tested on Kalray K200 board.
>> >>=20
>> >> Signed-off-by: Clement Leger <cleger@kalray.eu>
>> >> ---
>> >>=20
>> >>  drivers/mtd/spi-nor/issi.c | 2 ++
>> >>  1 file changed, 2 insertions(+)
>> >>=20
>> >> diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
>> >> index ffcb60e54a80..c3c3438e3d08 100644
>> >> --- a/drivers/mtd/spi-nor/issi.c
>> >> +++ b/drivers/mtd/spi-nor/issi.c
>> >> @@ -49,6 +49,8 @@ static const struct flash_info issi_parts[] =3D {
>> >>=20
>> >>                              SECT_4K | SPI_NOR_DUAL_READ |
>> >>                              SPI_NOR_QUAD_READ
>> >> |=20
>> >> | SPI_NOR_4B_OPCODES)
>> >> |=20
>> >>                 .fixups =3D &is25lp256_fixups },
>> >>=20
>> >> +       { "is25lp01g",  INFO(0x9d601b, 0, 64 * 1024, 2048,
>> >=20
>> > There is a "K" flavor of this flash which has 512 Byte Page size with =
256
>> > KB Block size. While the page size can be determined by parsing SFDP, =
I
>> > think we will have some problems with sector_size because as of now, t=
he
>> > sector_size is always set to 64KB. An incorrect sector_size will affec=
t
>> > erases and locking.
>> Thanks, I did not noticed that ! If I understand, this will require to
>> modify the core to handle sector size the same way as page_size and
>> probably add a fixup to detect the "K" options from SFDP ?
>=20
> Right. You can add a post_bfpt fixup hook for this flash. You can
> differentiate between the "K" version and the rest by the page size. Sinc=
e the
> page size is tightly coupled with the sector size, you can amend both in =
the
> post_bfpt hook.

Ok, this seems clear ! I'll give it a try. By looking quickly at the code I
think that n_sectors will also have to be updated after discovering the
sector_size from BFPT (for flash size computation). Since some parameters
of the nor are initialized early in spi_nor_info_init_params using
sector_size, should I move the call making use of sector_size later in the
init (in spi_nor_late_init_params for instance) ?

>=20
>> This is probably more changes than I can handle, and you can probably dr=
op
>> this patch since not really functional for "K" type flash.
>=20
> I dropped it. You should try to fix it, I can guide you if needed. Or I c=
an do
> it myself, but I'll need some help from you at testing.

I will try to do it but I will probably only be able to test the patches in=
 a=20
couple of weeks due to our architecture not being rebased on 5.7 yet.

Thanks,

Cl=C3=A9ment

>=20
> Cheers,
> ta
