Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8803C35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 12:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6EC20702
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 12:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580385734;
	bh=tVPXQH5q8XnlGUk0C1Vzpy1lLJul14m7fKhEYVRrAd4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=pa8SH2zySCnXhabbqLlq6oRiyiwTjynWsgVK8JJHFLYAm8M9bHTJ4yWJ2XUJT8gnS
	 +rKQl6zeCdxhG0UehGgkKNDpRGkfMNCSANnAh83a9jIpUBR9Ja+iHW+cWEC+rFekfn
	 w3R64cRpRn0OFjZ2QY2g3tIWyAxBPC22Nssm3fMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgA3MCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 07:02:14 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44422 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbgA3MCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 07:02:13 -0500
Received: by mail-lj1-f193.google.com with SMTP id q8so2998701ljj.11;
        Thu, 30 Jan 2020 04:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=CbriAO+YYaiW8OHBrskHol8fuQgG0MiL80JrFGJ4VkU=;
        b=GieZAgTO7yJC2xV9LQSQzlexrQv1xAzIbArjSVsjF/UQ6sRD5l+n37p6UWh5ImVjbD
         CPEbE8hVZfFXzuHyhT1cKbKy8BczbXLDba0jDWXMseIYgEaS2hvMbN+Gpf6e+1xCg4Qn
         7xDmpVmrHNz0kFY1aU2zJp+5BPFVvD/2y0oWaZxnx0bcJW4L4O5Rvyd9buX8k6M9vd1L
         3TvecjiGY6F56qCAPI94sPVDGVPnp8ycI6m4eDKccq8Eb+8qaPg0nhDQP0xWJDdOmfR3
         ef3T0CC9nUWl3fjYJOUsHOFWbdxLdXKdNzjgpuij1XPujePgrmHUgNf9E4GT99g/Cbd6
         /HkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=CbriAO+YYaiW8OHBrskHol8fuQgG0MiL80JrFGJ4VkU=;
        b=QNRSnQHWWcMRY58wF4CrRn2XmGUla2k+mJrq75oIAwvujhMfdxcLptMY+xdE4ripmQ
         Xa5RkAu+xB3PN0JTFfC5f7JGqQqlAZw944Caqjrfac2cP1gjeMy9OP6PuWAUaA7+zxKd
         USAFiWCl149YZPzMlFjj5Lg9GdevizI93cPyMMyEuZYtD3gz1uyyM7hlXNVloZfU1oqE
         92lLn0/S19dmENoQ44nUAbn+xZtYv8Fiowb7PkVesrq9wjbL318Mvgp3WDS2DWfNS2lE
         ZqTsIqxqOAmZs4sCoFSXZbbUmTgykLwwMItrAE5fIX1+Jn+5qys7T+Td/ByiY2LrVlXE
         Cvog==
X-Gm-Message-State: APjAAAUhLz4rzRGkpx1P7LrtIpfvVqfswCUpY9I5hj5V+mjf7Ue7xgEF
        DlgdAMk4R+5p0T/5x3prras=
X-Google-Smtp-Source: APXvYqy+RM59IGhHmXCuppva3qQWf3mfMzt7K1mfteyOWdFXq1P548w6Hc+gLb3RWWm1szJQCH80wQ==
X-Received: by 2002:a2e:9a01:: with SMTP id o1mr2647487lji.247.1580385731111;
        Thu, 30 Jan 2020 04:02:11 -0800 (PST)
Received: from saruman (88-113-215-33.elisa-laajakaista.fi. [88.113.215.33])
        by smtp.gmail.com with ESMTPSA id f29sm2702633ljo.76.2020.01.30.04.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Jan 2020 04:02:10 -0800 (PST)
From:   Felipe Balbi <balbi@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, bigeasy@linutronix.de,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Olbrich <m.olbrich@pengutronix.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH][RESEND] usb: dwc3: gadget: Handle dequeuing of non queued URB gracefully
In-Reply-To: <20200116132459.22383-1-alexandru.ardelean@analog.com>
References: <20191106144553.16956-1-alexandru.ardelean@analog.com> <20200116132459.22383-1-alexandru.ardelean@analog.com>
Date:   Thu, 30 Jan 2020 14:02:05 +0200
Message-ID: <87d0b1885e.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Alexandru Ardelean <alexandru.ardelean@analog.com> writes:

> From: Lars-Peter Clausen <lars@metafoo.de>
>
> Trying to dequeue and URB that is currently not queued should be a no-op
> and be handled gracefully.
>
> Use the list field of the URB to indicate whether it is queued or not by
> setting it to the empty list when it is not queued.
>
> Handling this gracefully allows for race condition free synchronization
> between the complete callback being called to to a completed transfer and
> trying to call usb_ep_dequeue() at the same time.

We need a little more information here. Can you further explain what
happens and how you caught this?

> Tested-by: Michael Olbrich <m.olbrich@pengutronix.de>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>
> * Added Michael Olbrich's Tested-by tag
>   https://lore.kernel.org/linux-usb/20191112144108.GA1859@pengutronix.de/
>
>  drivers/usb/dwc3/gadget.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 1b8014ab0b25..22a78eb41a5b 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -177,7 +177,7 @@ static void dwc3_gadget_del_and_unmap_request(struct =
dwc3_ep *dep,
>  {
>  	struct dwc3			*dwc =3D dep->dwc;
>=20=20
> -	list_del(&req->list);
> +	list_del_init(&req->list);

this should *not* be necessary. Neither the INIT_LIST_HEAD() below.

>  	req->remaining =3D 0;
>  	req->needs_extra_trb =3D false;
>=20=20
> @@ -847,6 +847,7 @@ static struct usb_request *dwc3_gadget_ep_alloc_reque=
st(struct usb_ep *ep,
>  	req->epnum	=3D dep->number;
>  	req->dep	=3D dep;
>  	req->status	=3D DWC3_REQUEST_STATUS_UNKNOWN;
> +	INIT_LIST_HEAD(&req->list);
>=20=20
>  	trace_dwc3_alloc_request(req);
>=20=20
> @@ -1549,6 +1550,10 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *e=
p,
>=20=20
>  	spin_lock_irqsave(&dwc->lock, flags);
>=20=20
> +	/* Not queued, nothing to do */
> +	if (list_empty(&req->list))
> +		goto out0;

The loop below is actually looking for the request in our lists. You
just made the entire loop below unnecessary, but you didn't change it
accordingly. Moreover, I think that a user dequeueing a request that
wasn't queued for the current endpoint indicates a possible bug in the
gadget driver which needs to be fixed.

If you really disagree, suffice to change "ret =3D -EINVAL;" to "ret =3D
0;" and you would get what you want, without any of the extra cruft.

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl4yxb0ACgkQzL64meEa
mQa6yRAA3qZXokGaKbxI6YrzLjwzLNFTAfuzXmIzXQdyzTU5RKaFW/QMno+DKv/B
vBdYcrsuBInSw74GU4IRTwDTsy9q2Xpyn2lsRqQqjfGys0XzCX/b47HxdiPDlClT
rGwBXjp96qxcr/eeOLELxrH6EjhRBptD85/tK91Vqi0PmaAt1mt/7kPk80df92PH
h7kcxC0ZgsERFU3O5maWlNo5oHzWqr0aiRWOV8wsbWpecCk3UJhS00cQb0y+BHQ3
ByiQjIBCNpOxXvA7cerSeMTuJd2IaQ1GOzAwynGE+2VCzNR91/xJ24GMysD25KD2
XoiKOqgG1fm38UjI0WYdYRzTyuQwhvch+8FuBVO1grH55bJ1y16m4g9ZrMkv9LJP
ciob6UlmsuuYBBHBD/puZmeAPW4DPmhS7ZYaa1OdYwjIMf1EOO/iEiyENyysDHE+
ZnmOj4lO8Loip1HeFOE+HmmPi3Gg4zPlzdrtHSGGJFhVgciQ46SAHfRGf7+6TGR2
4U3pAZGsR69tuirwCbVWKRVmrH1ybxnuOOzM//rUhrK/IMRrFWnROCU57WXnDAh5
v8c8mxKiHTQ3aN4tD5P6w7DDC528gT555g6J3iyc1/85vrkdkFu3JEO+gMRNSuea
ubV8SgriXmYHAd4+ggcRed6AYUtpYAAIrt+8f9yV57PpH3gP0OE=
=BG5P
-----END PGP SIGNATURE-----
--=-=-=--
