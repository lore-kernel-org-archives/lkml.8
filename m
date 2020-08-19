Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA68FC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CE702078D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597837051;
	bh=bz2q61a1QGUygLHfRAwZFSBYQUXwYUk++yBB0zbgQLk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=CSb6XCuqEOIMElYlgHgxiDEwU64eRezJZXN23ypAUccErEvtR5v9B52h4JQSVuVVj
	 IsCA2XOATS/RC7W+8LN61Fig55CdCnLGQd3x7msD3h1x1Ne3JajY8TL+iMu/pggRJB
	 xDUQXjdL4Bn+DvphDLIfQK0sHNjFFAhcQlkpRXQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgHSLh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 07:37:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbgHSLhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:37:21 -0400
Received: from saruman (unknown [85.206.163.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 099822078D;
        Wed, 19 Aug 2020 11:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597837040;
        bh=bz2q61a1QGUygLHfRAwZFSBYQUXwYUk++yBB0zbgQLk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=j6jNm51KfUTfd25ShvpMsalmrdyJvXseNjg+4OQSTU1HCB1j0z8zKgkS0YXK7BbVF
         BGms/qZGpMmpo4mBzcsbsG39iNOxcs1hVLURR0pSboFyev/me/1bdEdLddBwgUv+2w
         EXEsEbdGDIP/RkFH8m9YPdh1IAXgaguHNYXmbNcg=
From:   Felipe Balbi <balbi@kernel.org>
To:     Wesley Cheng <wcheng@codeaurora.org>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        jackp@codeaurora.org, Wesley Cheng <wcheng@codeaurora.org>
Subject: Re: [PATCH] usb: dwc3: Stop active transfers before halting the
 controller
In-Reply-To: <20200819051739.22123-1-wcheng@codeaurora.org>
References: <20200819051739.22123-1-wcheng@codeaurora.org>
Date:   Wed, 19 Aug 2020 14:37:11 +0300
Message-ID: <87zh6qyihk.fsf@kernel.org>
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
> In the DWC3 databook, for a device initiated disconnect, the driver is
> required to send dependxfer commands for any pending transfers.
> In addition, before the controller can move to the halted state, the SW
> needs to acknowledge any pending events.  If the controller is not halted
> properly, there is a chance the controller will continue accessing stale =
or
> freed TRBs and buffers.
>
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>
> ---
> Verified fix by adding a check for ETIMEDOUT during the run stop call.
> Shell script writing to the configfs UDC file to trigger disconnect and
> connect.  Batch script to have PC execute data transfers over adb (ie adb
> push)  After a few iterations, we'd run into a scenario where the
> controller wasn't halted.  With the following change, no failed halts aft=
er
> many iterations.
> ---
>  drivers/usb/dwc3/ep0.c    |  2 +-
>  drivers/usb/dwc3/gadget.c | 59 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 57 insertions(+), 4 deletions(-)
>
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

these two should be the same. If pullups are not connected, there's no
way we can have an endpoint descriptor. Did you find a race condition here?

> @@ -1926,6 +1926,24 @@ static int dwc3_gadget_set_selfpowered(struct usb_=
gadget *g,
>  	return 0;
>  }
>=20=20
> +static void dwc3_stop_active_transfers(struct dwc3 *dwc)
> +{
> +	u32 epnum;
> +
> +	for (epnum =3D 2; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
> +		struct dwc3_ep *dep;
> +
> +		dep =3D dwc->eps[epnum];
> +		if (!dep)
> +			continue;
> +
> +		if (!(dep->flags & DWC3_EP_ENABLED))
> +			continue;
> +
> +		dwc3_remove_requests(dwc, dep);
> +	}
> +}
> +
>  static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
>  {
>  	u32			reg;
> @@ -1950,16 +1968,37 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc,=
 int is_on, int suspend)
>=20=20
>  		dwc->pullups_connected =3D true;
>  	} else {
> +		dwc->pullups_connected =3D false;
> +
> +		__dwc3_gadget_ep_disable(dwc->eps[0]);
> +		__dwc3_gadget_ep_disable(dwc->eps[1]);
> +
> +		/*
> +		 * The databook explicitly mentions for a device-initiated
> +		 * disconnect sequence, the SW needs to ensure that it ends any
> +		 * active transfers.
> +		 */
> +		dwc3_stop_active_transfers(dwc);

IIRC, gadget driver is required to dequeue transfers before
disconnecting. My memory is a bit fuzzy in that area, but anyway, how
did you trigger this problem?

> @@ -1994,9 +2033,15 @@ static int dwc3_gadget_pullup(struct usb_gadget *g=
, int is_on)
>  		}
>  	}
>=20=20
> +	/*
> +	 * Synchronize and disable any further event handling while controller
> +	 * is being enabled/disabled.
> +	 */
> +	disable_irq(dwc->irq_gadget);

looks like a call to synchronize_irq() would be enough here.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl89DucRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQbK0g/+PGZ3r/FwZvIA5KkkqUjbQpd2wXWBXLrz
Vv0ZPdNu/VsVIulBDYtGYghXEaGkvstsCDwvmO0WPk2jZgxQ8qdhsS34m5G+G/AT
QmCtVKaKi5voX5u66cOf4NmiRph5In5R42gybkgFVzMmgje4YlcQS3c6cMe3Yzdl
z9wQX36dvZ/4gA2BmYNIACp/fmFACICG4H3N5VRCETDo1Ok/JfBHEKtlJTFIIw5Z
BpAoKlloPKN8O7Ge7bcrr3MFECohJguw2J6q59hCEJthMLJu5Ru1himq19whGdbn
ii6hLwWvLW4/hxpw1MHNNWobpDFl37B/dcfUgSh0doHsN/DbDvT28fl9cJb7/DZV
VrX8eFdbZ0bsruTmdHKT/R+lWB5r9icAf0dO3v9m0O/LYKcRAT0k3E3fnOvnuxWG
Qtgdh8DOJm0swhgThNsCTX2Q2ikHLV21ts6tdz6h2WJCLSLkUGku07MMP33mHz2S
PvUF/gFJjxB7UwAPKrUAVWyp/8pB+tY3CpxYwXJsDVTzfMlzzI1eztbKLR8uyY0e
HoG+J+LAcfecBZu6jLmFWtVwkQEG5AoOxhFmzW6Nfeo9hkr0UxuIxbvDK+jvHo35
dQMzd3hq4414CEtzjle5ySYwDE6IkufT6DGn9fyOmGpkKbgK/13lbwA1u0LOUuEJ
xz36oc6xhZ4=
=qJ1X
-----END PGP SIGNATURE-----
--=-=-=--
