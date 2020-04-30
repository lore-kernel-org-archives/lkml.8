Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15E1C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 948902082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgD3JwO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 05:52:14 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:52635 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726405AbgD3JwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 05:52:14 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-128-jza2LrHfM5yaVMLeML32iw-1; Thu, 30 Apr 2020 10:52:09 +0100
X-MC-Unique: jza2LrHfM5yaVMLeML32iw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 30 Apr 2020 10:52:09 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 30 Apr 2020 10:52:09 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Takashi Iwai' <tiwai@suse.de>
CC:     'Arnd Bergmann' <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ALSA: opti9xx: shut up gcc-10 range warning
Thread-Topic: [PATCH] ALSA: opti9xx: shut up gcc-10 range warning
Thread-Index: AQHWHljP0SPhFOMubESmHZ4J5JyFcqiRUaDQ///yewCAACbi8A==
Date:   Thu, 30 Apr 2020 09:52:09 +0000
Message-ID: <94cc90ff07364743809698fae2ef7138@AcuMS.aculab.com>
References: <20200429190216.85919-1-arnd@arndb.de>
        <c513eb4c4a01470eb3c47d8134afbec1@AcuMS.aculab.com>
 <s5hk11xidob.wl-tiwai@suse.de>
In-Reply-To: <s5hk11xidob.wl-tiwai@suse.de>
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

From: Takashi Iwai
> Sent: 30 April 2020 09:25
> 
> On Thu, 30 Apr 2020 10:15:02 +0200,
> David Laight wrote:
> >
> > From: Arnd Bergmann
....
> > > +static inline void snd_miro_write_mask(struct snd_miro *chip,
> > > +		unsigned char reg, unsigned char value, unsigned char mask)
> > > +{
> > > +	unsigned char oldval = snd_miro_read(chip, reg);
> > >
> > > -#define snd_miro_write_mask(chip, reg, value, mask)	\
> > > -	snd_miro_write(chip, reg,			\
> > > -		(snd_miro_read(chip, reg) & ~(mask)) | ((value) & (mask)))
> > > +	snd_miro_write(chip, reg, (oldval & ~mask) | (value & mask));
> > > +}
> >
> > Isn't that likely to add additional masking with 0xff at the call sites?
> > You will probably get better code if the arguments are 'unsigned int'.
> 
> I don't think such a micro optimization is needed.
> All registers, values and masks in the driver are 8bit, so keeping all
> unsigned char is rather an improvement of readability.

And every time you do any arithmetic they get extended to int.
And if you pass them to a function (as char) the compiler
has to mask the result of any arithmetic back to 8 bits.

On x86 the compiler can use the 'as if' rule and do 8 bit arithmetic.
But only if it can determine that the high bits aren't actually used.
On almost every other architecture you are likely to get a lot
of masking operations.

Just because the domain of a variable of 0..255 doesn't mean
that 'unsigned char' is an appropriate type for a variable.

For x86-64 (and probably others) 'unsigned int' is usually best for
anything that cannot be negative.
In particular it saves the sign extension instruction that has to
be inserted when an 'int' variable is used as an array index.

FWIW I think that somewhere else the ~mask had to be replaced
with (mask ^ 0xff) do avoid another spurious compiler warning.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

