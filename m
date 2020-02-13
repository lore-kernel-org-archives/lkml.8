Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57699C3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3418321734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgBMSWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:22:50 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:40116 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgBMSWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:22:50 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2FC631C25B1; Thu, 13 Feb 2020 19:22:48 +0100 (CET)
Date:   Thu, 13 Feb 2020 19:22:46 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 16/52] serial: uartps: Add a timeout to the tx empty
 wait
Message-ID: <20200213182246.GA10589@amd>
References: <20200213151810.331796857@linuxfoundation.org>
 <20200213151817.584286846@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <20200213151817.584286846@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 277375b864e8147975b064b513f491e2a910e66a upstream
>=20
> In case the cable is not connected then the target gets into
> an infinite wait for tx empty.
> Add a timeout to the tx empty wait.

Was this tested? Because it does not work...

> Reported-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: stable <stable@vger.kernel.org> # 4.19
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

> @@ -681,16 +683,20 @@ static void cdns_uart_set_termios(struct uart_port =
*port,
=2E..
> +	int err;
> =20
>  	spin_lock_irqsave(&port->lock, flags);
> =20
>  	/* Wait for the transmit FIFO to empty before making changes */
>  	if (!(readl(port->membase + CDNS_UART_CR) &
>  				CDNS_UART_CR_TX_DIS)) {
> -		while (!(readl(port->membase + CDNS_UART_SR) &
> -				CDNS_UART_SR_TXEMPTY)) {
> -			cpu_relax();
> +		err =3D readl_poll_timeout(port->membase + CDNS_UART_SR,
> +					 val, (val & CDNS_UART_SR_TXEMPTY),
> +					 1000, TX_TIMEOUT);
> +		if (err) {
> +			dev_err(port->dev, "timed out waiting for tx empty");
> +			return;
>  		}
>  	}
>

It will return with lock held and interrupts disabled. Mainline takes
spinlock later, so it does not have a problem.

Merging 107475685abfdee504bb0ef4824f15797f6d2d4d before this one
should fix the problem.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl5Fk/YACgkQMOfwapXb+vKWVwCgrR3lkdsYH37ig9SKEYYEed40
OPAAnAztBnU8iQVbyO8zDNktnPFmg296
=8vFB
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
