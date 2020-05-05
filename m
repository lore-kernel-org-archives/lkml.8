Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CE4C47256
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 07:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67E5A20663
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 07:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588664101;
	bh=FVnRozTyjvC0K7bpo5KsY9+cQTK8l422pO1vVBdf9Qw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=j+dsGcyKXmKOih0U/kwR622vLKoh4O7B71eB7VpZ3zWJ2uu3fT1+DACZ6gPSATyV3
	 6AQuIiANKCLz8FVBjthbBKSfhqdnyGb+ks0h4zGr89dW153iFNSfBqClsTPe9JQbbQ
	 WznElhQDxPEXjrLLwEz9CSpQZ22wXIvCEbw2DSdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgEEHfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 03:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725915AbgEEHfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 03:35:00 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE16C061A0F;
        Tue,  5 May 2020 00:34:59 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id l19so542060lje.10;
        Tue, 05 May 2020 00:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=hxgTBVT8QEdNS+bAQm/hOUdTkietFo7Zucnk8IDHvq0=;
        b=JGqmpmD+lvbYFjEIUABtPMGYXu08++aqgOUAO8ipMCgBA01j4KLwRgXUKCX+Ft3c1X
         fIrQRQnmHeERuPA3gptvVCLFAnhBiliLIkGdZRjPWYnsprLgHQV5QJJUjWBSXxyQ+Yi2
         41lQLd7ot8KTOvLOfKyG+0OBEozQgynS8YWFKsWCCEwpc/OZk0fZnsRC05jvoIETsAAU
         gjBwjzPp6teqsthezGbxasvc/Q+yx11+gadzbB5SszDqSxF7CEIt0xMnSBSo0INzAGYu
         T6Ly40KX1M3ZwGNsZaHpeJT1a2Kzip8O/TaE/8fNMNnaRNUDW9XQew1++pXdzuE2d0t7
         esSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=hxgTBVT8QEdNS+bAQm/hOUdTkietFo7Zucnk8IDHvq0=;
        b=U5SPEhwEeu2mIUdHO2DE63cc5+84FgOiUkNmfHz1EG6CB6mAAN2i5P+aMBkr5aB1iK
         7Sdzjlq8su13JRq6ScZFzHUos3R0z2i6Wc0SSCY1fHtmtQqXZP1Y6I/vrGq6pZ+8lbtz
         UrKZ6K95PQeSyhFa+KViZsuX1eoOzzKuobp3ydtQUoUoZsunMs7tfaDOEgmwOUyEDvbm
         mwQWKkp4WHa3Eix6zxuTWxzQFGLcgQsoUmOEriyBaC7VCVED80Hct9nzrLBCJ3rlEqb0
         YbEB2V2DzyJ0Sv2fURupVACTUCujj0FZJzVsYZAavxipbdv2x5MTfvcMJTGc79ebGVDj
         eMDA==
X-Gm-Message-State: AGi0PubixD9/1C92EjuWiOKpo+P2xTFr22caI0AIRbQnJyNLsukRd2aT
        1RxPBX8K0ZQYE9laVeKmueM=
X-Google-Smtp-Source: APiQypL7145C/beIy8xWJ45iYx16tosWg8e9FhWk8oZmIkNssaargyUIQLkzhtD/Ky+aPmyl0inVYg==
X-Received: by 2002:a2e:8ed0:: with SMTP id e16mr990867ljl.96.1588664097656;
        Tue, 05 May 2020 00:34:57 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id a28sm1210237lfr.4.2020.05.05.00.34.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 May 2020 00:34:56 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Andrey Konovalov <andreyknvl@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v2] usb: raw-gadget: fix gadget endpoint selection
In-Reply-To: <2f05fe9aa7e4bcb1bad3f6d11e48a411c901af68.1588197975.git.andreyknvl@google.com>
References: <2f05fe9aa7e4bcb1bad3f6d11e48a411c901af68.1588197975.git.andreyknvl@google.com>
Date:   Tue, 05 May 2020 10:34:52 +0300
Message-ID: <875zdabzs3.fsf@kernel.org>
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

Andrey Konovalov <andreyknvl@google.com> writes:

> Currently automatic gadget endpoint selection based on required features
> doesn't work. Raw Gadget tries iterating over the list of available
> endpoints and finding one that has the right direction and transfer type.
> Unfortunately selecting arbitrary gadget endpoints (even if they satisfy
> feature requirements) doesn't work, as (depending on the UDC driver) they
> might have fixed addresses, and one also needs to provide matching
> endpoint addresses in the descriptors sent to the host.
>
> The composite framework deals with this by assigning endpoint addresses
> in usb_ep_autoconfig() before enumeration starts. This approach won't work
> with Raw Gadget as the endpoints are supposed to be enabled after a
> set_configuration/set_interface request from the host, so it's too late to
> patch the endpoint descriptors that had already been sent to the host.
>
> For Raw Gadget we take another approach. Similarly to GadgetFS, we allow
> the user to make the decision as to which gadget endpoints to use.
>
> This patch adds another Raw Gadget ioctl USB_RAW_IOCTL_EPS_INFO that
> exposes information about all non-control endpoints that a currently
> connected UDC has. This information includes endpoints addresses, as well
> as their capabilities and limits to allow the user to choose the most
> fitting gadget endpoint.
>
> The USB_RAW_IOCTL_EP_ENABLE ioctl is updated to use the proper endpoint
> validation routine usb_gadget_ep_match_desc() and also now accepts an
> optional usb_ss_ep_comp_descriptor argument.
>
> These changes affect the portability of the gadgets that use Raw Gadget
> when running on different UDCs. Nevertheless, as long as the user relies
> on the information provided by USB_RAW_IOCTL_EPS_INFO to dynamically
> choose endpoint addresses, UDC-agnostic gadgets can still be written with
> Raw Gadget.
>
> Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>
> Changes v1 -> v2:
> - Validate endpoint number against dev->eps_num instead of
>   USB_RAW_EPS_NUM_MAX.
> - Dropped maxburst from struct usb_raw_ep_limits, added reserved field
>   instead.
> - Don't allocate struct usb_raw_eps_info on stack, it's too large.
> - Assign SuperSpeed endpoint companion descriptor to usb_ep when enabling
>   endpoints.
> - Fixed typos in commit message.
>
> ---
>  Documentation/usb/raw-gadget.rst       |   6 +-
>  drivers/usb/gadget/legacy/raw_gadget.c | 217 +++++++++++++++++--------
>  include/uapi/linux/usb/raw_gadget.h    |  88 +++++++++-
>  3 files changed, 231 insertions(+), 80 deletions(-)
>
> diff --git a/Documentation/usb/raw-gadget.rst b/Documentation/usb/raw-gad=
get.rst
> index 9e78cb858f86..42bd446d72b2 100644
> --- a/Documentation/usb/raw-gadget.rst
> +++ b/Documentation/usb/raw-gadget.rst
> @@ -27,11 +27,7 @@ differences are:
>  3. Raw Gadget provides a way to select a UDC device/driver to bind to,
>     while GadgetFS currently binds to the first available UDC.
>=20=20
> -4. Raw Gadget uses predictable endpoint names (handles) across different
> -   UDCs (as long as UDCs have enough endpoints of each required transfer
> -   type).
> -
> -5. Raw Gadget has ioctl-based interface instead of a filesystem-based on=
e.
> +4. Raw Gadget has ioctl-based interface instead of a filesystem-based on=
e.
>=20=20
>  Userspace interface
>  ~~~~~~~~~~~~~~~~~~~
> diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/=
legacy/raw_gadget.c
> index 7b241992ad5a..e6abbc15341a 100644
> --- a/drivers/usb/gadget/legacy/raw_gadget.c
> +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> @@ -7,6 +7,7 @@
>   */
>=20=20
>  #include <linux/compiler.h>
> +#include <linux/ctype.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/kref.h>
> @@ -123,8 +124,6 @@ static void raw_event_queue_destroy(struct raw_event_=
queue *queue)
>=20=20
>  struct raw_dev;
>=20=20
> -#define USB_RAW_MAX_ENDPOINTS 32
> -
>  enum ep_state {
>  	STATE_EP_DISABLED,
>  	STATE_EP_ENABLED,
> @@ -134,6 +133,7 @@ struct raw_ep {
>  	struct raw_dev		*dev;
>  	enum ep_state		state;
>  	struct usb_ep		*ep;
> +	u8			addr;
>  	struct usb_request	*req;
>  	bool			urb_queued;
>  	bool			disabling;
> @@ -168,7 +168,8 @@ struct raw_dev {
>  	bool				ep0_out_pending;
>  	bool				ep0_urb_queued;
>  	ssize_t				ep0_status;
> -	struct raw_ep			eps[USB_RAW_MAX_ENDPOINTS];
> +	struct raw_ep			eps[USB_RAW_EPS_NUM_MAX];
> +	int				eps_num;
>=20=20
>  	struct completion		ep0_done;
>  	struct raw_event_queue		queue;
> @@ -202,7 +203,7 @@ static void dev_free(struct kref *kref)
>  		usb_ep_free_request(dev->gadget->ep0, dev->req);
>  	}
>  	raw_event_queue_destroy(&dev->queue);
> -	for (i =3D 0; i < USB_RAW_MAX_ENDPOINTS; i++) {
> +	for (i =3D 0; i < dev->eps_num; i++) {
>  		if (dev->eps[i].state !=3D STATE_EP_ENABLED)
>  			continue;
>  		usb_ep_disable(dev->eps[i].ep);
> @@ -249,12 +250,26 @@ static void gadget_ep0_complete(struct usb_ep *ep, =
struct usb_request *req)
>  	complete(&dev->ep0_done);
>  }
>=20=20
> +static u8 get_ep_addr(const char *name)
> +{
> +	/* If the endpoint has fixed function (named as e.g. "ep12out-bulk"),
> +	 * parse the endpoint address from its name. We deliberately use
> +	 * deprecated simple_strtoul() function here, as the number isn't
> +	 * followed by '\0' nor '\n'.
> +	 */
> +	if (isdigit(name[2]))
> +		return simple_strtoul(&name[2], NULL, 10);
> +	/* Otherwise the endpoint is configurable (named as e.g. "ep-a"). */
> +	return USB_RAW_EP_ADDR_ANY;
> +}
> +
>  static int gadget_bind(struct usb_gadget *gadget,
>  			struct usb_gadget_driver *driver)
>  {
> -	int ret =3D 0;
> +	int ret =3D 0, i =3D 0;
>  	struct raw_dev *dev =3D container_of(driver, struct raw_dev, driver);
>  	struct usb_request *req;
> +	struct usb_ep *ep;
>  	unsigned long flags;
>=20=20
>  	if (strcmp(gadget->name, dev->udc_name) !=3D 0)
> @@ -273,6 +288,13 @@ static int gadget_bind(struct usb_gadget *gadget,
>  	dev->req->context =3D dev;
>  	dev->req->complete =3D gadget_ep0_complete;
>  	dev->gadget =3D gadget;
> +	gadget_for_each_ep(ep, dev->gadget) {
> +		dev->eps[i].ep =3D ep;
> +		dev->eps[i].addr =3D get_ep_addr(ep->name);
> +		dev->eps[i].state =3D STATE_EP_DISABLED;
> +		i++;
> +	}
> +	dev->eps_num =3D i;
>  	spin_unlock_irqrestore(&dev->lock, flags);
>=20=20
>  	/* Matches kref_put() in gadget_unbind(). */
> @@ -555,7 +577,7 @@ static void *raw_alloc_io_data(struct usb_raw_ep_io *=
io, void __user *ptr,
>=20=20
>  	if (copy_from_user(io, ptr, sizeof(*io)))
>  		return ERR_PTR(-EFAULT);
> -	if (io->ep >=3D USB_RAW_MAX_ENDPOINTS)
> +	if (io->ep >=3D USB_RAW_EPS_NUM_MAX)
>  		return ERR_PTR(-EINVAL);
>  	if (!usb_raw_io_flags_valid(io->flags))
>  		return ERR_PTR(-EINVAL);
> @@ -682,52 +704,34 @@ static int raw_ioctl_ep0_read(struct raw_dev *dev, =
unsigned long value)
>  	return ret;
>  }
>=20=20
> -static bool check_ep_caps(struct usb_ep *ep,
> -				struct usb_endpoint_descriptor *desc)
> -{
> -	switch (usb_endpoint_type(desc)) {
> -	case USB_ENDPOINT_XFER_ISOC:
> -		if (!ep->caps.type_iso)
> -			return false;
> -		break;
> -	case USB_ENDPOINT_XFER_BULK:
> -		if (!ep->caps.type_bulk)
> -			return false;
> -		break;
> -	case USB_ENDPOINT_XFER_INT:
> -		if (!ep->caps.type_int)
> -			return false;
> -		break;
> -	default:
> -		return false;
> -	}
> -
> -	if (usb_endpoint_dir_in(desc) && !ep->caps.dir_in)
> -		return false;
> -	if (usb_endpoint_dir_out(desc) && !ep->caps.dir_out)
> -		return false;
> -
> -	return true;
> -}
> -
>  static int raw_ioctl_ep_enable(struct raw_dev *dev, unsigned long value)
>  {
>  	int ret =3D 0, i;
>  	unsigned long flags;
> -	struct usb_endpoint_descriptor *desc;
> -	struct usb_ep *ep =3D NULL;
> +	struct usb_raw_ep_descs *descs;
> +	struct usb_endpoint_descriptor *ep_desc;
> +	struct usb_ss_ep_comp_descriptor *comp_desc =3D NULL;
> +	struct raw_ep *ep;
>=20=20
> -	desc =3D memdup_user((void __user *)value, sizeof(*desc));
> -	if (IS_ERR(desc))
> -		return PTR_ERR(desc);
> +	descs =3D memdup_user((void __user *)value, sizeof(*descs));
> +	if (IS_ERR(descs))
> +		return PTR_ERR(descs);
> +
> +	ep_desc =3D &descs->ep;
> +	/*
> +	 * Assume that SuperSpeed endpoint companion descriptor is not present
> +	 * if its length is 0.
> +	 */
> +	if (descs->comp.bLength !=3D 0)
> +		comp_desc =3D &descs->comp;
>=20=20
>  	/*
>  	 * Endpoints with a maxpacket length of 0 can cause crashes in UDC
>  	 * drivers.
>  	 */
> -	if (usb_endpoint_maxp(desc) =3D=3D 0) {
> +	if (usb_endpoint_maxp(ep_desc) =3D=3D 0) {
>  		dev_dbg(dev->dev, "fail, bad endpoint maxpacket\n");
> -		kfree(desc);
> +		kfree(descs);
>  		return -EINVAL;
>  	}
>=20=20
> @@ -743,41 +747,34 @@ static int raw_ioctl_ep_enable(struct raw_dev *dev,=
 unsigned long value)
>  		goto out_free;
>  	}
>=20=20
> -	for (i =3D 0; i < USB_RAW_MAX_ENDPOINTS; i++) {
> -		if (dev->eps[i].state =3D=3D STATE_EP_ENABLED)
> +	for (i =3D 0; i < dev->eps_num; i++) {
> +		ep =3D &dev->eps[i];
> +		if (ep->state !=3D STATE_EP_DISABLED)
>  			continue;
> -		break;
> -	}
> -	if (i =3D=3D USB_RAW_MAX_ENDPOINTS) {
> -		dev_dbg(&dev->gadget->dev,
> -				"fail, no device endpoints available\n");
> -		ret =3D -EBUSY;
> -		goto out_free;
> -	}
> -
> -	gadget_for_each_ep(ep, dev->gadget) {
> -		if (ep->enabled)
> +		if (ep->addr !=3D usb_endpoint_num(ep_desc) &&
> +				ep->addr !=3D USB_RAW_EP_ADDR_ANY)
>  			continue;
> -		if (!check_ep_caps(ep, desc))
> +		if (!usb_gadget_ep_match_desc(dev->gadget, ep->ep,
> +							ep_desc, comp_desc))
>  			continue;
> -		ep->desc =3D desc;
> -		ret =3D usb_ep_enable(ep);
> +		ep->ep->desc =3D ep_desc;
> +		ep->ep->comp_desc =3D comp_desc;
> +		ret =3D usb_ep_enable(ep->ep);
>  		if (ret < 0) {
>  			dev_err(&dev->gadget->dev,
>  				"fail, usb_ep_enable returned %d\n", ret);
>  			goto out_free;
>  		}
> -		dev->eps[i].req =3D usb_ep_alloc_request(ep, GFP_ATOMIC);
> -		if (!dev->eps[i].req) {
> +		ep->req =3D usb_ep_alloc_request(ep->ep, GFP_ATOMIC);
> +		if (!ep->req) {
>  			dev_err(&dev->gadget->dev,
>  				"fail, usb_ep_alloc_request failed\n");
> -			usb_ep_disable(ep);
> +			usb_ep_disable(ep->ep);
>  			ret =3D -ENOMEM;
>  			goto out_free;
>  		}
> -		dev->eps[i].ep =3D ep;
> -		dev->eps[i].state =3D STATE_EP_ENABLED;
> -		ep->driver_data =3D &dev->eps[i];
> +		ep->state =3D STATE_EP_ENABLED;
> +		ep->ep->driver_data =3D ep;
>  		ret =3D i;
>  		goto out_unlock;
>  	}
> @@ -786,7 +783,7 @@ static int raw_ioctl_ep_enable(struct raw_dev *dev, u=
nsigned long value)
>  	ret =3D -EBUSY;
>=20=20
>  out_free:
> -	kfree(desc);
> +	kfree(descs);
>  out_unlock:
>  	spin_unlock_irqrestore(&dev->lock, flags);
>  	return ret;
> @@ -796,10 +793,6 @@ static int raw_ioctl_ep_disable(struct raw_dev *dev,=
 unsigned long value)
>  {
>  	int ret =3D 0, i =3D value;
>  	unsigned long flags;
> -	const void *desc;
> -
> -	if (i < 0 || i >=3D USB_RAW_MAX_ENDPOINTS)
> -		return -EINVAL;
>=20=20
>  	spin_lock_irqsave(&dev->lock, flags);
>  	if (dev->state !=3D STATE_DEV_RUNNING) {
> @@ -812,6 +805,11 @@ static int raw_ioctl_ep_disable(struct raw_dev *dev,=
 unsigned long value)
>  		ret =3D -EBUSY;
>  		goto out_unlock;
>  	}
> +	if (i < 0 || i >=3D dev->eps_num) {
> +		dev_dbg(dev->dev, "fail, invalid endpoint\n");
> +		ret =3D -EBUSY;
> +		goto out_unlock;
> +	}
>  	if (dev->eps[i].state !=3D STATE_EP_ENABLED) {
>  		dev_dbg(&dev->gadget->dev, "fail, endpoint is not enabled\n");
>  		ret =3D -EINVAL;
> @@ -836,10 +834,13 @@ static int raw_ioctl_ep_disable(struct raw_dev *dev=
, unsigned long value)
>=20=20
>  	spin_lock_irqsave(&dev->lock, flags);
>  	usb_ep_free_request(dev->eps[i].ep, dev->eps[i].req);
> -	desc =3D dev->eps[i].ep->desc;
> +	/*
> +	 * This kfree() frees both endpoint and SuperSpeed
> +	 * endpoint companion descriptors.
> +	 */
> +	kfree(dev->eps[i].ep->desc);
>  	dev->eps[i].ep =3D NULL;
>  	dev->eps[i].state =3D STATE_EP_DISABLED;
> -	kfree(desc);
>  	dev->eps[i].disabling =3D false;
>=20=20
>  out_unlock:
> @@ -868,7 +869,7 @@ static int raw_process_ep_io(struct raw_dev *dev, str=
uct usb_raw_ep_io *io,
>  {
>  	int ret =3D 0;
>  	unsigned long flags;
> -	struct raw_ep *ep =3D &dev->eps[io->ep];
> +	struct raw_ep *ep;
>  	DECLARE_COMPLETION_ONSTACK(done);
>=20=20
>  	spin_lock_irqsave(&dev->lock, flags);
> @@ -882,6 +883,12 @@ static int raw_process_ep_io(struct raw_dev *dev, st=
ruct usb_raw_ep_io *io,
>  		ret =3D -EBUSY;
>  		goto out_unlock;
>  	}
> +	if (io->ep >=3D dev->eps_num) {
> +		dev_dbg(&dev->gadget->dev, "fail, invalid endpoint\n");
> +		ret =3D -EINVAL;
> +		goto out_unlock;
> +	}
> +	ep =3D &dev->eps[io->ep];
>  	if (ep->state !=3D STATE_EP_ENABLED) {
>  		dev_dbg(&dev->gadget->dev, "fail, endpoint is not enabled\n");
>  		ret =3D -EBUSY;
> @@ -1027,6 +1034,71 @@ static int raw_ioctl_vbus_draw(struct raw_dev *dev=
, unsigned long value)
>  	return ret;
>  }
>=20=20
> +static void fill_ep_caps(struct usb_ep_caps *caps,
> +				struct usb_raw_ep_caps *raw_caps)
> +{
> +	raw_caps->type_control =3D caps->type_control;
> +	raw_caps->type_iso =3D caps->type_iso;
> +	raw_caps->type_bulk =3D caps->type_bulk;
> +	raw_caps->type_int =3D caps->type_int;
> +	raw_caps->dir_in =3D caps->dir_in;
> +	raw_caps->dir_out =3D caps->dir_out;
> +}
> +
> +static void fill_ep_limits(struct usb_ep *ep, struct usb_raw_ep_limits *=
limits)
> +{
> +	limits->maxpacket_limit =3D ep->maxpacket_limit;
> +	limits->max_streams =3D ep->max_streams;
> +}
> +
> +static int raw_ioctl_eps_info(struct raw_dev *dev, unsigned long value)
> +{
> +	int ret =3D 0, i;
> +	unsigned long flags;
> +	struct usb_raw_eps_info *info;
> +	struct raw_ep *ep;
> +
> +	info =3D kmalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	spin_lock_irqsave(&dev->lock, flags);
> +	if (dev->state !=3D STATE_DEV_RUNNING) {
> +		dev_dbg(dev->dev, "fail, device is not running\n");
> +		ret =3D -EINVAL;
> +		spin_unlock_irqrestore(&dev->lock, flags);
> +		goto out_free;
> +	}
> +	if (!dev->gadget) {
> +		dev_dbg(dev->dev, "fail, gadget is not bound\n");
> +		ret =3D -EBUSY;
> +		spin_unlock_irqrestore(&dev->lock, flags);
> +		goto out_free;
> +	}
> +
> +	memset(info, 0, sizeof(*info));
> +	for (i =3D 0; i < dev->eps_num; i++) {
> +		ep =3D &dev->eps[i];
> +		strscpy(&info->eps[i].name[0], ep->ep->name,
> +				USB_RAW_EP_NAME_MAX);
> +		info->eps[i].addr =3D ep->addr;
> +		fill_ep_caps(&ep->ep->caps, &info->eps[i].caps);
> +		fill_ep_limits(ep->ep, &info->eps[i].limits);
> +	}
> +	ret =3D dev->eps_num;
> +	spin_unlock_irqrestore(&dev->lock, flags);
> +
> +	if (copy_to_user((void __user *)value, info, sizeof(*info)))
> +		ret =3D -EFAULT;
> +
> +out_free:
> +	kfree(info);
> +out:
> +	return ret;
> +}
> +
>  static long raw_ioctl(struct file *fd, unsigned int cmd, unsigned long v=
alue)
>  {
>  	struct raw_dev *dev =3D fd->private_data;
> @@ -1069,6 +1141,9 @@ static long raw_ioctl(struct file *fd, unsigned int=
 cmd, unsigned long value)
>  	case USB_RAW_IOCTL_VBUS_DRAW:
>  		ret =3D raw_ioctl_vbus_draw(dev, value);
>  		break;
> +	case USB_RAW_IOCTL_EPS_INFO:
> +		ret =3D raw_ioctl_eps_info(dev, value);
> +		break;
>  	default:
>  		ret =3D -EINVAL;
>  	}
> diff --git a/include/uapi/linux/usb/raw_gadget.h b/include/uapi/linux/usb=
/raw_gadget.h
> index 8544802b25bd..722124fff290 100644
> --- a/include/uapi/linux/usb/raw_gadget.h
> +++ b/include/uapi/linux/usb/raw_gadget.h
> @@ -93,6 +93,79 @@ struct usb_raw_ep_io {
>  	__u8		data[0];
>  };
>=20=20
> +/*
> + * struct usb_raw_ep_descs - argument for USB_RAW_IOCTL_EP_ENABLE ioctl.
> + * @ep: Endpoint descriptor.
> + * @comp: SuperSpeed Endpoint Companion descriptor.
> + *
> + * Both of these descriptors are only used by the gadget subsystem inclu=
ding
> + * the UDC driver and don't affect the descriptors that are sent to the =
host.
> + * However, the user must make sure that the host and the gadget sides a=
gree
> + * on the used endpoint parameters (such as e.g. endpoint addresses).
> + */
> +struct usb_raw_ep_descs {
> +	struct usb_endpoint_descriptor		ep;
> +	struct usb_ss_ep_comp_descriptor	comp;
> +};
> +
> +/* Maximum number of non-control endpoints in struct usb_raw_eps_info. */
> +#define USB_RAW_EPS_NUM_MAX	30
> +
> +/* Maximum length of UDC endpoint name in struct usb_raw_ep_info. */
> +#define USB_RAW_EP_NAME_MAX	16
> +
> +/* Used as addr in struct usb_raw_ep_info if endpoint accepts any addres=
s. */
> +#define USB_RAW_EP_ADDR_ANY	0xff
> +
> +/*
> + * struct usb_raw_ep_caps - exposes endpoint capabilities from struct us=
b_ep
> + *     (technically from its member struct usb_ep_caps).
> + */
> +struct usb_raw_ep_caps {
> +	__u32	type_control	: 1;
> +	__u32	type_iso	: 1;
> +	__u32	type_bulk	: 1;
> +	__u32	type_int	: 1;
> +	__u32	dir_in		: 1;
> +	__u32	dir_out		: 1;
> +};
> +
> +/*
> + * struct usb_raw_ep_limits - exposes endpoint limits from struct usb_ep.
> + * @maxpacket_limit: Maximum packet size value supported by this endpoin=
t.
> + * @max_streams: maximum number of streams supported by this endpoint
> + *     (actual number is 2^n).
> + * @reserved: Empty, reserved for potential future extensions.
> + */
> +struct usb_raw_ep_limits {
> +	__u16	maxpacket_limit;
> +	__u16	max_streams;
> +	__u32	reserved;
> +};
> +
> +/*
> + * struct usb_raw_ep_info - stores information about a gadget endpoint.
> + * @name: Name of the endpoint as it is defined in the UDC driver.
> + * @addr: Address of the endpoint that must be specified in the endpoint
> + *     descriptor passed to USB_RAW_IOCTL_EP_ENABLE ioctl.
> + * @caps: Endpoint capabilities.
> + * @limits: Endpoint limits.
> + */
> +struct usb_raw_ep_info {
> +	__u8				name[USB_RAW_EP_NAME_MAX];
> +	__u32				addr;
> +	struct usb_raw_ep_caps		caps;
> +	struct usb_raw_ep_limits	limits;
> +};
> +
> +/*
> + * struct usb_raw_eps_info - argument for USB_RAW_IOCTL_EPS_INFO ioctl.
> + * eps: Structures that store information about non-control endpoints.
> + */
> +struct usb_raw_eps_info {
> +	struct usb_raw_ep_info	eps[USB_RAW_EPS_NUM_MAX];
> +};
> +
>  /*
>   * Initializes a Raw Gadget instance.
>   * Accepts a pointer to the usb_raw_init struct as an argument.
> @@ -126,12 +199,12 @@ struct usb_raw_ep_io {
>  #define USB_RAW_IOCTL_EP0_READ		_IOWR('U', 4, struct usb_raw_ep_io)
>=20=20
>  /*
> - * Finds an endpoint that supports the transfer type specified in the
> - * descriptor and enables it.
> - * Accepts a pointer to the usb_endpoint_descriptor struct as an argumen=
t.
> + * Finds an endpoint that satisfies the parameters specified in the prov=
ided
> + * descriptors (address, transfer type, etc.) and enables it.
> + * Accepts a pointer to the usb_raw_ep_descs struct as an argument.
>   * Returns enabled endpoint handle on success or negative error code on =
failure.
>   */
> -#define USB_RAW_IOCTL_EP_ENABLE		_IOW('U', 5, struct usb_endpoint_descri=
ptor)
> +#define USB_RAW_IOCTL_EP_ENABLE		_IOW('U', 5, struct usb_raw_ep_descs)
>=20=20
>  /* Disables specified endpoint.
>   * Accepts endpoint handle as an argument.
> @@ -164,4 +237,11 @@ struct usb_raw_ep_io {
>   */
>  #define USB_RAW_IOCTL_VBUS_DRAW		_IOW('U', 10, __u32)
>=20=20
> +/* Fills in the usb_raw_eps_info structure with information about non-co=
ntrol
> + * endpoints available for the currently connected UDC.
> + * Returns the number of available endpoints on success or negative erro=
r code
> + * on failure.
> + */
> +#define USB_RAW_IOCTL_EPS_INFO		_IOR('U', 11, struct usb_raw_eps_info)
> +

here you're changing userspace ABI. Aren't we going to possibly break
some existing applications?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl6xFxwACgkQzL64meEa
mQYxLQ/9GYcTQigGNJVlSxJtkp4iYNPpHi84isItgOJtNhzq4UF1bkEJv3inlwmY
yY8h6S/jrY716uvVJUgrHPLlxfJ6gu3TvwQ300+lTRRZBO2N+XY4M14N5cXIcsH8
0U8WQvS2qT9iMoPoSv4bjiD3hw1MmSS0BQ4imom++LFAlFVSKPL9vrA6oz42pGrn
8+TFB2GlSmdzERI+BCrwoN6sUqLLPqXTPKzlp12t87+v9F0tL7TJx4lm7oqBotBP
n8WWZb/BC3mqMQPk88E2uorsLd+PRrV+X9iXFnU3Kk64UuITDbZJlKDs/ZNQZOT+
FtaFGaxu0fgVclkmYujzfrk7e1/9BJz1g/slt2AY2GehqS64THTWuwCeabN452HK
4WvRB6s/HhNPJo9U76ib+2ON1MvcUntwDpA/lBVOmH4HFb4WAi3dZgQPXYHScKWA
/W9GCyZZ47piV3Q86nZmkyD0NVJGna6qwt9c7SsCDOKVrSpqNycVqm37/etSZ/wT
oFNHPRQBTl2mFpkZdXZNALHr84ow9eoveYKFctCfuxQajNxj/HtmJ5adUMSmN7fR
TMleIekxv0zeRkp08jgcUTO5XhWZSze2NC39tCsK93raipHeahZlM4sSyFmEgr+H
V7WIJs5Mmrrvz0T7JB8OO52J99KAeYumbmxkUN/hBiB4A8C2YKU=
=LycN
-----END PGP SIGNATURE-----
--=-=-=--
