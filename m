Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04ABC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 09:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6042F205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 09:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584263612;
	bh=fYa0ZgT8KCmLMLHuyJeJEYGflGdQ+GXgqFT7ttaJ+H4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=vGzv1MaeupeeoCMvTKj5JwHhTIH/bKmQZi+TmkC97GGmQupFgQ9bqDu7Yy1tPdOWJ
	 gixi8THSigQyJKZ6LZhH+681jG2NeOdQJlNTRMB2/azH23ib8Gbbj7iFwT3AJANOBx
	 OLMZVCEvPjhxCQAD2vwaTZ1hKYCJ1pO7MdzFxsdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgCOJNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 05:13:31 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33039 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgCOJNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 05:13:30 -0400
Received: by mail-lf1-f67.google.com with SMTP id c20so11458693lfb.0;
        Sun, 15 Mar 2020 02:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=UghuRGGoBIV+FWQNja4tOmhBFo0fndDmk5q2GT0GtOQ=;
        b=OE8rpn8bhJf6/2wBB0yTz/U4GXx+xKixWRRwr2wc5+EqGaZFRPriQK1OrVqsX1oZuZ
         wat6Cqp3HQJMcSAo0401k+5UcTCTBgyYVJ491vPpFJ10o54BSxxjW40dwzq+iYSkPorX
         XsVnx7J5zD7iJEcLb1S0O/ZQ1EodC/17BMHDiF5Ix9aD4p7FoszX+PZYal5s7+pnxQVI
         SADdSdNusXj0nb4kcbhOw3iMj0LF1FvgvgbTdhcb8AWcLBsR+SB4tqBnX/wyzb7h+Ma+
         z7Gl0bi5Jl/ZTnOXMwvjWLPgwrNSwkrXcu9KvMyta2+aRIRgkv1K7mQkiK6gQrqTkWq4
         vxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=UghuRGGoBIV+FWQNja4tOmhBFo0fndDmk5q2GT0GtOQ=;
        b=FdObk1E7dRm8IRzgSNvKJ0LZPDnzLdVA9eaoznAabN/ietdnfkJ1dvEATTwAMjWRhN
         3831BLBtbqHW6Lla0/POcSogAcPiPzvvUd0/WM/PeEa9MSVkUQrlSE6MNOokKxo0pSoE
         b3za459FJiT6DodDXqT3W2Q8Sa0g3rSjmHwaeYBoIILi818qPpxZ7BjTA538OJvWJWK3
         G0UTRJuks9LWq1SxLZNl4BbsdIDPq5t6hngnP5CAajKZYWNhePKrw5qR5rYSaHlXvmwE
         nS6YKuI33ROPAqaDo04iggwlX6U5g0Rbm8OC0nR99f8/IpkeOwfWD7mn4mpiDIavVjfR
         6oDg==
X-Gm-Message-State: ANhLgQ1zIIsgbyq+4yhTB5aFaH2SahOHc+wx4vfDimg3p8Bl2NKePlrA
        WPhuVtfQ45yxydFjkkXLVwTyC1EPdlcH+Q==
X-Google-Smtp-Source: ADFU+vuNDwTV7TTjN789yXI4ocNKIO9XgqEucfCM596o81rTq4IFGZQFRVlPG9sow75NRuUBkLG/qg==
X-Received: by 2002:ac2:41c2:: with SMTP id d2mr7639986lfi.164.1584263608304;
        Sun, 15 Mar 2020 02:13:28 -0700 (PDT)
Received: from saruman (88-113-215-213.elisa-laajakaista.fi. [88.113.215.213])
        by smtp.gmail.com with ESMTPSA id s10sm5099137ljp.87.2020.03.15.02.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Mar 2020 02:13:27 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: Re: [RFC PATCH] usb: dwc3: enable runtime PM for drd role switch / extcon
In-Reply-To: <20200312143038.11719-1-martin.kepplinger@puri.sm>
References: <20200312143038.11719-1-martin.kepplinger@puri.sm>
Date:   Sun, 15 Mar 2020 11:13:22 +0200
Message-ID: <87fteaf0b1.fsf@kernel.org>
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

(for commit logs, please break your lines at 72 characters)

Martin Kepplinger <martin.kepplinger@puri.sm> writes:

> Note: runtime PM currently needs to be enabled ("auto") manually via
> sysfs as its power/control is set to "on" by the driver.

Right, that's on purpose

> When runtime PM enabled, dwc3 currently doesn't resume when a cable is
> connected.  It only suspends after a cable is disconnected.
>
> When using an extcon driver (for a different chip on the board), dwc3
> can register a hook for that. (Still undocumented -> TODO?).
>
> Make sure, dwc3 is resumed when "set_mode" is being called by drd.
>
> this is only a question about what's missing to properly keep runtime
> PM enabled for dwc3 and if my change makes any sense at all. It seems
> to work fine for me...
>
> I'm glad about any hints on how to keep runtime PM enabled (at least when
> having an extcon hook set up).

You need to remember that what you write here is going to be placed in
the commit log and will survive forever in the history of the
project. Can you be a little bit more technical? For example, why did
you change the asynchronous pm_runtime_put() to synchronous versions?
Why was that necessary?

Also, you're missing your Signed-off-by line. Please, read the
documentation about how to write patches.

> thanks,
>                                 martin
> ---
>  drivers/usb/dwc3/core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 1d85c42b9c67..201b712bd961 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -118,6 +118,9 @@ static void __dwc3_set_mode(struct work_struct *work)
>  	unsigned long flags;
>  	int ret;
>=20=20
> +	pm_runtime_mark_last_busy(dwc->dev);
> +	pm_runtime_put_sync_autosuspend(dwc->dev);

why synchronous?

> +
>  	if (dwc->dr_mode !=3D USB_DR_MODE_OTG)
>  		return;
>=20=20
> @@ -196,6 +199,8 @@ void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
>  {
>  	unsigned long flags;
>=20=20
> +	pm_runtime_get_sync(dwc->dev);

why get here and put on another function?

> +
>  	spin_lock_irqsave(&dwc->lock, flags);
>  	dwc->desired_dr_role =3D mode;
>  	spin_unlock_irqrestore(&dwc->lock, flags);
> @@ -1552,7 +1557,7 @@ static int dwc3_probe(struct platform_device *pdev)
>  		goto err5;
>=20=20
>  	dwc3_debugfs_init(dwc);
> -	pm_runtime_put(dev);
> +	pm_runtime_put_sync(dev);

why the conversion to synchronous?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl5t8bIACgkQzL64meEa
mQakMw/+JBJsuNCsHdTwzzkUPzdrQhbOijneHyRWoV1l1SRSkouGw64jbY5hjNgi
r9tWUq5gcxoEhPqvnl+Ay/qoZE81hAFZPK0qgng9rfDEFi99R26zZrr66SbZmoAi
FJAZgYmLN8xeqaU+wjBTiEaj72+FYHRlFvUDzi/9ZcjNwJiyv8QREGl4J03OTwRy
6XDFNyWe9kTs0dP7J71OUn2P037qBj78SRBhGkZwUjEMvfLXDmpA1yBovzHVV0tD
ysuVOYrCESLMgZVNDF33gEtRjuZIZXxCuNUqUpDBd3IE4i9uxfNIrfP73HkDp6mS
jFGv8ee6kOup8jJUUFPJleBztFzZaa31kysdX+8nR4sa6tikdkoF8v0AHjbQdEjL
hF1SilSACtkBj+OduYR2xhHQkonGhB6V9Ygi15BpshZt94VYIwWslTKn7cJA9CJe
w+lA6y87H2CtE8/iIvvYmIF8mkQe2Q46wcMYpX3canfHnNePGbvtXJf6gl12TmQ3
HgAG6vkAriYUu9vUCKRxLTVuTMCiFBacXjHAYQnFwXXgRWCKE9eWl5ZghnPXI285
3879mS+07bTH2hO/8CKkhHvz0dCV38tuMTGdj1RZcKzuPn6nSrP9CBoPFPmv03aU
JYv997O4NCp4eedoI/SWIG2xEbb40h8rP1lH8YIeJILGt6mwuro=
=g/OV
-----END PGP SIGNATURE-----
--=-=-=--
