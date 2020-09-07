Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E7CC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71615215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599459650;
	bh=FkdMsLs/B/AI52w0YJVQHs5rkHUi4N8XZ2mK6c2zwNI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=ayty0Bhx2hCiib7BZDlfRJvw/MX3NWgDFMaWPCFxZA593SR8MvS08NYK7SBqDddtJ
	 qIK91ABb26HJEsmX087fnJQNfCNO+UAK4lgINpNBITuGaUMt6HToKOmFJtIym0ZuU/
	 RZRm15CPwGvTptS/Hwu2ECTljroR1SHTe5+kqJ94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgIGGUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 02:20:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgIGGUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 02:20:46 -0400
Received: from saruman (91-155-214-58.elisa-laajakaista.fi [91.155.214.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 173FF21582;
        Mon,  7 Sep 2020 06:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599459645;
        bh=FkdMsLs/B/AI52w0YJVQHs5rkHUi4N8XZ2mK6c2zwNI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fkadxlKyjqm2/I2XGl9nTRHwOR9m5GeeP9HlXe8c3fTEZwdChgipSLrjP2gKquFiL
         y8qlppTfzDtC6LGivS7uBdPBmzBdQvEdGdmpKdZshHjBtE5NSA5uIn4KeqEmtoZW1O
         ysE4hJ07NXt0YDoGyQEcGgUOzzHzwDUI5Oox3w78=
From:   Felipe Balbi <balbi@kernel.org>
To:     Wesley Cheng <wcheng@codeaurora.org>, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        jackp@codeaurora.org, Wesley Cheng <wcheng@codeaurora.org>
Subject: Re: [PATCH v3] usb: dwc3: Stop active transfers before halting the
 controller
In-Reply-To: <20200903210954.24504-1-wcheng@codeaurora.org>
References: <20200903210954.24504-1-wcheng@codeaurora.org>
Date:   Mon, 07 Sep 2020 09:20:38 +0300
Message-ID: <87o8mi151l.fsf@kernel.org>
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

Wesley Cheng <wcheng@codeaurora.org> writes:
> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
> index 59f2e8c31bd1..456aa87e8778 100644
> --- a/drivers/usb/dwc3/ep0.c
> +++ b/drivers/usb/dwc3/ep0.c
> @@ -197,7 +197,7 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct u=
sb_request *request,
>  	int				ret;
>=20=20
>  	spin_lock_irqsave(&dwc->lock, flags);
> -	if (!dep->endpoint.desc) {
> +	if (!dep->endpoint.desc || !dwc->pullups_connected) {

this looks odd. If we don't have pullups connected, we shouldn't have a
descriptor, likewise if we don't have a a description, we haven't been
enumerated, therefore we shouldn't have pullups connected.

What am I missing here?

> @@ -1926,6 +1926,21 @@ static int dwc3_gadget_set_selfpowered(struct usb_=
gadget *g,
>  	return 0;
>  }
>=20=20
> +static void dwc3_stop_active_transfers(struct dwc3 *dwc)
> +{
> +	u32 epnum;
> +
> +	for (epnum =3D 2; epnum < DWC3_ENDPOINTS_NUM; epnum++) {

dwc3 knows the number of endpoints available in the HW. Use dwc->num_eps
instead.

> @@ -1971,6 +1986,8 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, i=
nt is_on, int suspend)
>  	return 0;
>  }
>=20=20
> +static void __dwc3_gadget_stop(struct dwc3 *dwc);
> +
>  static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>  {
>  	struct dwc3		*dwc =3D gadget_to_dwc(g);
> @@ -1994,9 +2011,37 @@ static int dwc3_gadget_pullup(struct usb_gadget *g=
, int is_on)
>  		}
>  	}
>=20=20
> +	/*
> +	 * Synchronize and disable any further event handling while controller
> +	 * is being enabled/disabled.
> +	 */
> +	disable_irq(dwc->irq_gadget);

why isn't dwc3_gadget_disable_irq() enough?

>  	spin_lock_irqsave(&dwc->lock, flags);

spin_lock_irqsave() will disable interrupts, why disable_irq() above?

> +	/* Controller is not halted until pending events are acknowledged */
> +	if (!is_on) {
> +		u32 count;
> +
> +		/*
> +		 * The databook explicitly mentions for a device-initiated
> +		 * disconnect sequence, the SW needs to ensure that it ends any
> +		 * active transfers.
> +		 */

make this a little better by mentioning the version and section of the
databook you're reading. That makes it easier for future
reference. Also, use an actual quote from the databook, along the lines
of:

		/*
                 * Synopsys DesignWare Cores USB3 Databook Revision
                 * X.YYa states in section W.Z that "device-initiated
                 * disconnect ...."
                 */

> +		dwc3_stop_active_transfers(dwc);
> +		__dwc3_gadget_stop(dwc);
> +
> +		count =3D dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
> +		count &=3D DWC3_GEVNTCOUNT_MASK;
> +		if (count > 0) {
> +			dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), count);
> +			dwc->ev_buf->lpos =3D (dwc->ev_buf->lpos + count) %
> +						dwc->ev_buf->length;
> +		}

don't duplicate code. Add a patch before this extracting this into
helper and use it for both irq handler and gadget pullup.

> +	}
> +
>  	ret =3D dwc3_gadget_run_stop(dwc, is_on, false);
>  	spin_unlock_irqrestore(&dwc->lock, flags);
> +	enable_irq(dwc->irq_gadget);
>=20=20
>  	return ret;
>  }
> @@ -3100,6 +3145,8 @@ static void dwc3_gadget_reset_interrupt(struct dwc3=
 *dwc)
>  	}
>=20=20
>  	dwc3_reset_gadget(dwc);
> +	/* Stop any active/pending transfers when receiving bus reset */

unnecessary comment. We're calling a function named "stop active
transfers" from within the "bus reset handler".

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl9V0TYRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQaxUw/+No1HiLvCnkSakNkNplU1N0hLR23QkR6V
945LSRtp6gIAbj5uPgSahMN6zcUDpgqOT8p/Q8GEnw0aoaHBHUVQ74G+dgR9heeG
GMvOPurO0a0nQElri2gOxMVDlxcHyDyJeH9U40I6vcvk05m6q/KYqTV7FGzs5gX7
5sdjrP+2UGvSC8xPQSBkaEVP+jhpFqPTrwgPvl5wyPUixxUPBm61QQJ47nGJUJsp
ZmHoPwHHPvD/nsa1v50jB+29Ia0VT7ogmFOLiLHCCcNM88sQt2UdN7166cspGxMj
9sFFy4El00gL9onZfWzSpjIOxwaUVYZ/rON0SClGmFP8nIR7k/SlWGZiq1434Qep
24sWuFZcWLJS2q38HDvArUdtZlJ1f0xefCGnwARw6zEyHVHllcD7n4DcIiKnUilf
G4fT9zXsDRhI/ceJ3yzdK5EasY1XtUn7teSn7M2oCg6yjJ5t3el8F6U+063UhC7j
SvvCIHLH/xWqYaSn1JIRopdeOtlSJdbUlq1rJ8NjSBPja/hTpOH2iFhCnJsw7Xoo
nKm4PAO8355hIZgwIrs/jxMbvqQR4BjksXB2pXyMMKwt9N3zKqjW668T8ks1NGI9
2j2nr0NesEFvvD3+rvL0pmfMCxR73HNMAC6gKhSESmknJx7GH+SD5TV8qWDr6FC3
3ejLiKiEphE=
=487c
-----END PGP SIGNATURE-----
--=-=-=--
