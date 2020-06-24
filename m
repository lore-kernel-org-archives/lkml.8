Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492ACC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2581C206EB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592981336;
	bh=z/WV1GjcVul0twqlKG4re3FgnCVK5IXk/eJJ9f8NEpE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=X3KHhzHyA2UXXkmOUxm1C/sBOtKv/LRCURuSVZWS9o2VWihsE7CWdUjZNrXucjuQb
	 JcHeceHAyWcZcWcAAEdybUS2HwzNNW4q/1Ky8xhtFv8EoxkH2W4I/4PJYCgfaK4BdQ
	 xlErhjaliTH228uyXSj/KD0OSjHwwevKDFayDvm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389352AbgFXGsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 02:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388262AbgFXGsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:48:53 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83461C061573;
        Tue, 23 Jun 2020 23:48:52 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id i27so1304382ljb.12;
        Tue, 23 Jun 2020 23:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=IRbFpdkJ3X/gCdi+bm8bYb9HBVAeBDZzOaMrn1K9vME=;
        b=B5v2ozdGrqh9U3/uaxUU1JaCS6UKOE+z/we0h5T1q+eQ2YYUrPpNQVfzq9VDG5eHq+
         vUt3Rsy0PVigr0N8lWpEQtQLzg8tUGvNJ/mApcKvyoqfO9UCdUiON+4VjmbsmFVy54iw
         9SKiO/DwB7qK6ZNTsnjsXkYuMpQDqLrZyBqKYKhVyl4ASJ6y23hUoa8WFSQAkjuHuoK2
         WX5XKHduNZmP2mNHMGJf1CE2imrtxxYKnJT4M0JswK9jNZnhvnCzALRZzbDVy2wIx4Ma
         cFJ0Pf9CuY7t5ZOOotavuvdTCG/Rs4ZN+QmU9n1u4Y8rsQXXjXkZT8GjhOS16645Q/Kj
         iMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=IRbFpdkJ3X/gCdi+bm8bYb9HBVAeBDZzOaMrn1K9vME=;
        b=NYHRzcO6/dyKdF9Ij19BYTwfXswGXtXXdXr0hrm66LUl+sK9wEM+KYbKdIAdumgKlP
         1nh8/WtIxBVW/hno/0lP6wrFAoengdCfQ7vDcRElueP3ZTdll0rRaco8NTZ+Xa5IxM9k
         MAtnlJI2S3PXH6E8ku4jLTU1AJLkkqq+KIDCa8u89pSXgbWlOgvkyx4NpFehFq1FfM8/
         LBxd06/mkWbY8Spx8ZMZGaO9ac6+rNt/jiclLYv9jeWHdkA2hRDX8R9qBNtdYbOsxmvp
         8LvS3SaLYCJqM87DGtCG5d4bIOakFasotC1kIAkcY7S2M0+3t/b+wEVAm/eJnnT93g0k
         6ipw==
X-Gm-Message-State: AOAM531uXuDnmtyfA5aH9U/DbmcnUq2k6tubHGjpi4TTmxzAc7IVeo5Y
        d9xPf6Czkii6JmkASj8wrOc=
X-Google-Smtp-Source: ABdhPJwmDZadE8n80tc/QMW1BYRCHRY/M60C/nAIQapiHe3EgdDktOsrLP0ubc3zlanQ05rfvo3bAQ==
X-Received: by 2002:a2e:6c12:: with SMTP id h18mr13979607ljc.62.1592981330946;
        Tue, 23 Jun 2020 23:48:50 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id l27sm256021ljb.17.2020.06.23.23.48.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jun 2020 23:48:50 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Sergey Organov <sorganov@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>
Subject: Re: [PATCH 2/2] usb: gadget: u_serial: improve performance for large data
In-Reply-To: <1592310884-4307-2-git-send-email-macpaul.lin@mediatek.com>
References: <1592310884-4307-1-git-send-email-macpaul.lin@mediatek.com> <1592310884-4307-2-git-send-email-macpaul.lin@mediatek.com>
Date:   Wed, 24 Jun 2020 09:48:45 +0300
Message-ID: <87tuz1vu0i.fsf@kernel.org>
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

Macpaul Lin <macpaul.lin@mediatek.com> writes:

> If the hardware (like DMA engine) could support large usb request exceeds
> maximum packet size, use larger buffer when performing Rx/Tx could reduce
> request numbers and improve performance.
>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  drivers/usb/gadget/function/u_serial.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/=
function/u_serial.c
> index 3cfc6e2..cdcc070 100644
> --- a/drivers/usb/gadget/function/u_serial.c
> +++ b/drivers/usb/gadget/function/u_serial.c
> @@ -80,6 +80,8 @@
>  #define QUEUE_SIZE		16
>  #define WRITE_BUF_SIZE		8192		/* TX only */
>  #define GS_CONSOLE_BUF_SIZE	8192
> +/* for hardware can do more than max packet */
> +#define REQ_BUF_SIZE		4096
>=20=20
>  /* console info */
>  struct gs_console {
> @@ -247,7 +249,8 @@ static int gs_start_tx(struct gs_port *port)
>  			break;
>=20=20
>  		req =3D list_entry(pool->next, struct usb_request, list);
> -		len =3D gs_send_packet(port, req->buf, in->maxpacket);
> +		len =3D gs_send_packet(port, req->buf, in->can_exceed_maxp ?
> +				REQ_BUF_SIZE : in->maxpacket);

just do this unconditionally.

>  		if (len =3D=3D 0) {
>  			wake_up_interruptible(&port->drain_wait);
>  			break;
> @@ -514,7 +517,9 @@ static int gs_alloc_requests(struct usb_ep *ep, struc=
t list_head *head,
>  	 * be as speedy as we might otherwise be.
>  	 */
>  	for (i =3D 0; i < n; i++) {
> -		req =3D gs_alloc_req(ep, ep->maxpacket, GFP_ATOMIC);
> +		req =3D gs_alloc_req(ep, ep->can_exceed_maxp ?
> +					REQ_BUF_SIZE : ep->maxpacket,
> +					GFP_ATOMIC);

allocating 4kiB in atomic isn't very good. A better idea would be to
preallocate a list of requests and recycle them, rather than allocating
every time you need to do a transfer

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl7y900ACgkQzL64meEa
mQbQkQ/9GPD9IUwPFZXWQvXatcq2kjBaWDem6KIElKchFEJa8vaHPdR93SSHtXkG
AJXN/hUR80rjEX0qVbEInAwX5zMXAS/JQsQvzmLbKnvtgiyi8tL+2CIcIt6ARH6n
X8uLzHIjzYo3yLLl5sScQI+mxZgUhGasblHZRyoJtnOQkv0VTsl1TWgM4yvkoFxE
mTT7aIAu/npGZA9tXnMQ1xeATTx3zYfgy43FjnLmEOoXE3b3KzpooGYCzEvK2k7D
DIXYNUQ7gB5YizBhQKZsbwH337ViR24BYbaITWC29TiPY3UyGvdF3Ch2CwCFLsss
JsCdjFKGfO0gyoQY/UQaqIYA22in/VpA0YFJ8DOLOoOKexl+v+FDWc0X3Vp2oibm
/tEnaCiulTF67tX/PnHJ0jkDPz2YbYkddwX84QLpuO9g1EO0b+QPl65HA77XpZu2
7pas6Suwom5CGw1E9w/ac2WzW6P4kAjs0E84oA/ntPInV2jjmPAtMpG2ngJPuONy
hRYVviE+TbqmyutNd0WNYwG/z6V4D+2SbpefT8rXVd/6ziwk14D8dgaNgag5oqe/
F71zWLK+BoEofX3n0frxNJNgZwHlcjE1lF9vTd9l4qSs4reW3NUx1hNEM/Do95w7
4OKPoCds9WZ5JO3B9w4CjZmxs3MMuD11VpThUhmgPIXSXSCeId0=
=fSGc
-----END PGP SIGNATURE-----
--=-=-=--
