Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA7DC83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D11BE2073E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgD3IPH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 04:15:07 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:23412 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726127AbgD3IPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 04:15:07 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-163-g0_seeJgO5ihcWbcW0LISw-1; Thu, 30 Apr 2020 09:15:03 +0100
X-MC-Unique: g0_seeJgO5ihcWbcW0LISw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 30 Apr 2020 09:15:02 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 30 Apr 2020 09:15:02 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>
CC:     Takashi Iwai <tiwai@suse.de>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ALSA: opti9xx: shut up gcc-10 range warning
Thread-Topic: [PATCH] ALSA: opti9xx: shut up gcc-10 range warning
Thread-Index: AQHWHljP0SPhFOMubESmHZ4J5JyFcqiRUaDQ
Date:   Thu, 30 Apr 2020 08:15:02 +0000
Message-ID: <c513eb4c4a01470eb3c47d8134afbec1@AcuMS.aculab.com>
References: <20200429190216.85919-1-arnd@arndb.de>
In-Reply-To: <20200429190216.85919-1-arnd@arndb.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann
> Sent: 29 April 2020 20:02
> gcc-10 points out a few instances of suspicious integer arithmetic
> leading to value truncation:
> 
> sound/isa/opti9xx/opti92x-ad1848.c: In function 'snd_opti9xx_configure':
> sound/isa/opti9xx/opti92x-ad1848.c:322:43: error: overflow in conversion from 'int' to 'unsigned char'
> changes value from '(int)snd_opti9xx_read(chip, 3) & -256 | 240' to '240' [-Werror=overflow]
>   322 |   (snd_opti9xx_read(chip, reg) & ~(mask)) | ((value) & (mask)))
>       |   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
> sound/isa/opti9xx/opti92x-ad1848.c:351:3: note: in expansion of macro 'snd_opti9xx_write_mask'
>   351 |   snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(3), 0xf0, 0xff);
>       |   ^~~~~~~~~~~~~~~~~~~~~~
> sound/isa/opti9xx/miro.c: In function 'snd_miro_configure':
> sound/isa/opti9xx/miro.c:873:40: error: overflow in conversion from 'int' to 'unsigned char' changes
> value from '(int)snd_miro_read(chip, 3) & -256 | 240' to '240' [-Werror=overflow]
>   873 |   (snd_miro_read(chip, reg) & ~(mask)) | ((value) & (mask)))
>       |   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
> sound/isa/opti9xx/miro.c:1010:3: note: in expansion of macro 'snd_miro_write_mask'
>  1010 |   snd_miro_write_mask(chip, OPTi9XX_MC_REG(3), 0xf0, 0xff);
>       |   ^~~~~~~~~~~~~~~~~~~
> 
> These are all harmless here as only the low 8 bit are passed down
> anyway. Change the macros to inline functions to make the code
> more readable and also avoid the warning.
> 
> Strictly speaking those functions also need locking to make the
> read/write pair atomic, but it seems unlikely that anyone would
> still run into that issue.
> 
> Fixes: 1841f613fd2e ("[ALSA] Add snd-miro driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/isa/opti9xx/miro.c           | 9 ++++++---
>  sound/isa/opti9xx/opti92x-ad1848.c | 9 ++++++---
>  2 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
> index e764816a8f7a..b039429e6871 100644
> --- a/sound/isa/opti9xx/miro.c
> +++ b/sound/isa/opti9xx/miro.c
> @@ -867,10 +867,13 @@ static void snd_miro_write(struct snd_miro *chip, unsigned char reg,
>  	spin_unlock_irqrestore(&chip->lock, flags);
>  }
> 
> +static inline void snd_miro_write_mask(struct snd_miro *chip,
> +		unsigned char reg, unsigned char value, unsigned char mask)
> +{
> +	unsigned char oldval = snd_miro_read(chip, reg);
> 
> -#define snd_miro_write_mask(chip, reg, value, mask)	\
> -	snd_miro_write(chip, reg,			\
> -		(snd_miro_read(chip, reg) & ~(mask)) | ((value) & (mask)))
> +	snd_miro_write(chip, reg, (oldval & ~mask) | (value & mask));
> +}

Isn't that likely to add additional masking with 0xff at the call sites?
You will probably get better code if the arguments are 'unsigned int'.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

