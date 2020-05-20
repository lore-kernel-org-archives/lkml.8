Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02A9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0F0520758
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgETTV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 15:21:57 -0400
Received: from shelob.surriel.com ([96.67.55.147]:56038 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgETTV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 15:21:56 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <riel@shelob.surriel.com>)
        id 1jbUHh-0005vw-19; Wed, 20 May 2020 15:21:45 -0400
Message-ID: <667d8d156fa5d8420ef1c3b1d08b94a10d2398cc.camel@surriel.com>
Subject: Re: XHCI vs PCM2903B/PCM2904 part 2
From:   Rik van Riel <riel@surriel.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb <linux-usb@vger.kernel.org>, alsa-devel@alsa-project.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Date:   Wed, 20 May 2020 15:21:44 -0400
In-Reply-To: <20200520163840.GA11084@rowland.harvard.edu>
References: <273cc1c074cc4a4058f31afe487fb233f5cf0351.camel@surriel.com>
         <20200520163840.GA11084@rowland.harvard.edu>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-kor7JAH8v80RgB55+Ksv"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kor7JAH8v80RgB55+Ksv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-05-20 at 12:38 -0400, Alan Stern wrote:
> On Wed, May 20, 2020 at 07:26:57AM -0400, Rik van Riel wrote:
> > After a few more weeks of digging, I have come to the tentative
> > conclusion that either the XHCI driver, or the USB sound driver,
> > or both, fail to handle USB errors correctly.
> >=20
> > I have some questions at the bottom, after a (brief-ish)
> > explanation
> > of exactly what seems to go wrong.
> >=20
> > TL;DR: arecord from a misbehaving device can hang forever
> > after a USB error, due to poll on /dev/snd/timer never returning.
> >=20
> > The details: under some mysterious circumstances, the PCM290x
> > family sound chips can send more data than expected during an
> > isochronous transfer, leading to a babble error. Those
>=20
> Do these chips connect as USB-3 devices or as USB-2?  (I wouldn't
> expect=20
> an audio device to use USB-3; it shouldn't need the higher
> bandwidth.)

USB-2

> In general, errors such as babble are not supposed to stop
> isochronous=20
> endpoints.

However, it seems that they do. The urb never
gets an answer after snd_complete_urb refiles
it with usb_submit_urb.

> > However, the USB sound driver seems to have no idea that this
> > error happened. The function retire_capture_urb looks at the
> > status of each isochronous frame, but seems to be under the
> > assumption that the sound device just keeps on running.
>=20
> This is appropriate, for the reason mentioned above.

Having arecord get stuck forever does not seem like
the right behavior, though :)

> > This leads me to a few questions:
> > - should retire_capture_urb call snd_pcm_stop_xrun,
> >   or another function like it, if it sees certain
> >   errors in the iso frame in the URB?
>=20
> No.  Isochronous endpoints are expected to encounter errors from time
> to=20
> time; that is the nature of isochronous communications.  You're
> supposed=20
> to ignore the errors (skip over any bad data) and keep going.

...

> The notion of "stopped state" is not part of USB-2.  As a result, it=20
> should be handled entirely within the xhci-hcd driver.

Interesting. That makes me really curious why things are
getting stuck, now...

> > - how should the USB sound driver recover from these
> >   occasional and/or one-off errors? stop the sound
> >   stream, or try to reinitialize the device and start
> >   recording again?
>=20
> As far as I know, it should do its best to continue (perhaps fill in=20
> missing data with zeros).

That was my first intuition as well, given the documented
behavior of isochronous frames.

However, given that the device appears to stop sending
frames after that error, at least usbmon is not seeing
any, I am not sure what needs to happen in order to get
that behavior.

--=20
All Rights Reversed.

--=-kor7JAH8v80RgB55+Ksv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl7Fg0gACgkQznnekoTE
3oP6nAf/ela41PoyQHGOBVNUyLcwbl0jNWe/6JBUdk+jwh0wI/tP+dy5CLR6IOzG
Fu1aDqLgUXF/gGLcFvNUl9LBz5kf9UDRrCflmFEAEgeViLuO1eIV+DOoaoogdclh
X8L/tL4rv3fpK7lIRdx14Knwtpy2wTkmvFGyiTBQAtKs1FG00t+jRuYjYNKs6KNA
o8MyPBYtp4QE0XMua9pEBvVRm+fjh8bJCXcFYYJw88e4o+MhBkfnZWA6Xrnl5YGw
jwyfCSGWvNWCi8zKuJfkSWhsSOJk5a+TCGhIY7yhHNT3tUacLORRNEJ+8cbucpQ9
mdwQnjU9EBX+UB+99OwQCSlzTECYAQ==
=4YvF
-----END PGP SIGNATURE-----

--=-kor7JAH8v80RgB55+Ksv--

