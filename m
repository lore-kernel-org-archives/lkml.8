Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0633CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E334B20758
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgETL1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:27:08 -0400
Received: from shelob.surriel.com ([96.67.55.147]:52946 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETL1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:27:08 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <riel@shelob.surriel.com>)
        id 1jbMsE-0003xQ-7J; Wed, 20 May 2020 07:26:58 -0400
Message-ID: <273cc1c074cc4a4058f31afe487fb233f5cf0351.camel@surriel.com>
Subject: XHCI vs PCM2903B/PCM2904 part 2
From:   Rik van Riel <riel@surriel.com>
To:     linux-usb <linux-usb@vger.kernel.org>
Cc:     alsa-devel@alsa-project.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Date:   Wed, 20 May 2020 07:26:57 -0400
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-KZ0PlQuw8u0ClyxHg+lW"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KZ0PlQuw8u0ClyxHg+lW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

After a few more weeks of digging, I have come to the tentative
conclusion that either the XHCI driver, or the USB sound driver,
or both, fail to handle USB errors correctly.

I have some questions at the bottom, after a (brief-ish) explanation
of exactly what seems to go wrong.

TL;DR: arecord from a misbehaving device can hang forever
after a USB error, due to poll on /dev/snd/timer never returning.

The details: under some mysterious circumstances, the PCM290x
family sound chips can send more data than expected during an
isochronous transfer, leading to a babble error. Those
circumstances seem to in part depend on the USB host controller
and/or the electrical environment, since the chips work just
fine for most people.

Receiving data past the end of the isochronous transfer window
scheduled for a device results in the XHCI controller throwing
a babble error, which moves the endpoint into halted state.

This is followed by the host controller software sending a
reset endpoint command, and moving the endpoint into stopped
state, as specified on pages 164-165 of the XHCI specification.

However, the USB sound driver seems to have no idea that this
error happened. The function retire_capture_urb looks at the
status of each isochronous frame, but seems to be under the
assumption that the sound device just keeps on running.

The function snd_complete_urb seems to only detect that the
device is not running if usb_submit_urb returns a failure.

        err =3D usb_submit_urb(urb, GFP_ATOMIC);
        if (err =3D=3D 0)
                return;

        usb_audio_err(ep->chip, "cannot submit urb (err =3D %d)\n", err);

        if (ep->data_subs && ep->data_subs->pcm_substream) {
                substream =3D ep->data_subs->pcm_substream;
                snd_pcm_stop_xrun(substream);
        }

However, the XHCI driver will happily submit an URB to a
stopped device. Looking at the call trace usb_submit_urb ->
xhci_urb_enqueue -> xhci_queue_isoc_tx_prepare -> prepare_ring,
you can see this code:

        /* Make sure the endpoint has been added to xHC schedule */
        switch (ep_state) {
...
        case EP_STATE_HALTED:
                xhci_dbg(xhci, "WARN halted endpoint, queueing URB anyway.\=
n");
        case EP_STATE_STOPPED:
        case EP_STATE_RUNNING:
                break;

This leads me to a few questions:
- should retire_capture_urb call snd_pcm_stop_xrun,
  or another function like it, if it sees certain
  errors in the iso frame in the URB?
- should snd_complete_urb do something with these
  errors, too, in case they happen on the sync frames
  and not the data frames?
- does the XHCI code need to ring the doorbell when
  submitting an URB to a stopped device, or is it
  always up to the higher-level driver to fully reset
  the device before it can do anything useful?
- if a device in stopped state does not do anything
  useful, should usb_submit_urb return an error?
- how should the USB sound driver recover from these
  occasional and/or one-off errors? stop the sound
  stream, or try to reinitialize the device and start
  recording again?

I am willing to write patches and can test with my
setup, but both the sound code and the USB code are
new to me so I would like to know what direction I
should go in :)

--=20
All Rights Reversed.

--=-KZ0PlQuw8u0ClyxHg+lW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl7FFAEACgkQznnekoTE
3oM+AAf+JhbuACD7UFirucp8tydQbMb1EuABebzvTo+DuA0miaAAYbfZu8o1g3P1
gg7edPquFrT88411j4qWGfHSBvG9n3WhF8qLm1aIdLB83K9Vi0R1oxDgizg8I4IR
R/EO16XdMWsOKAsv4yiKtuDGUZ8Y+TuGivRts6bTKjwqxABOVeX82zCPmHOPe6dI
z2EXhqmduk4W2Hfswz5ouBMHyNpPeMEMPWxlIwhU+d6a/5ZkhDcoWvaxC8sr5LRC
W4LhSZINZsMt+tzjy1dv7EkTQz/gGBKU+ZnTrA5XZxLAT83Y2YmdQd+76UUmSyzl
c9N17a9S0hnZ6luq73BDEh7vsj/ZZA==
=8U/0
-----END PGP SIGNATURE-----

--=-KZ0PlQuw8u0ClyxHg+lW--

