Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547BDC2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2852C20733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585552753;
	bh=tUO5xBUaLmGaE463uTd4jFBmm6quq53ul/74EK8/8wo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=TqGMLLuBLbOOFqxNNMueecyKgwGlIvAP08uBLFqigDcdwwyRyFWaRxLEC1u8Hq53d
	 Iu+PfGwKB/4blDJ0lIDtG9hi6PBeufV8HVSJ6ZCovxplp0IqbFHSdRrixC0SB4b7oB
	 hDRj1+NqbiHmZKIumtI3E03RGj6IgY0F6ni3zZGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbgC3HTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 03:19:12 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35362 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbgC3HTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 03:19:11 -0400
Received: by mail-lf1-f68.google.com with SMTP id t16so12402773lfl.2;
        Mon, 30 Mar 2020 00:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=bCtjkH9GNCfz9ry2jRL1x5QjfVMjTIj52PFOHN7SRd8=;
        b=bbyRyf05BpbFf0kyMhkwZmR+bQoI3hNyDydtDNkAfsxRFXy5LK9MzcCbssK7+vQ0Sl
         Vb0Qucj09Cyvm4YmtGaxQ9fD5ZVnkCQiDjkBt7Uaap5IpHiy4pxqFTwQVe+6DeiF7OFQ
         7FdMGFlbk/jd/wfj/e3uMgizPy74ZU0IoBWD1eILAvTQzXUEIPiQ8wQClkehrczRnl6x
         j6p6d0pIIouCpEkx64rEhUxhGqABgl3v7uzUGoPPA70lB/57D/J0OYhMAnRWyTe8FI3+
         6S1HvM8pVrM6DXKBSa1DqOP2w7aAbGTxOQJJ0a2SVJ5bFBDn0OZVF0iNkGD9AocFeaBz
         iypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=bCtjkH9GNCfz9ry2jRL1x5QjfVMjTIj52PFOHN7SRd8=;
        b=iCthFczeJtFXM+vrH/k1h+Rks3LJXcRzkON9EgzeSGc6mdvcvOg+7D1IpEU/5v/VZm
         zcLpqXH64l0AqebylZ7Rs19ATqZbbyChLDLMFWSadmTSXhrslaFOu9//OBOXgfzfzERf
         5EGCM2T3DpJCBxX7BLu5CLMzoWfJcIFTqsSj3YUyN4d+qAfhdFsRP7GSwMuknL7shBpm
         RTaEuhZZ5emqRVY6hIMu7MG3eUe+3vuRcSNkGVqcxwjVWpoQyLsLDX+GVmAw7OHwrnsB
         Kv+X3mAjLtBGgHd2rypzKO55l+QJ+KZmzxAbomifUU3bjFkM+eX7WAeajSVccJkzBLML
         pKug==
X-Gm-Message-State: AGi0PuY4ubftoCT7Oe/D3vswsQ2C1nl7sv62kR92l5F/1zOfOT1v5Nqs
        qU9gzQb0i7B4nvIuth0Y5K57fKucMI8=
X-Google-Smtp-Source: APiQypKDOw4DDcdFxkBABC5MdEF6InHqmuu0DsExWRTx5Y98zemlgQrsKSbbIl2MSB+82j/EqoKHuw==
X-Received: by 2002:a19:f20c:: with SMTP id q12mr6481954lfh.34.1585552749461;
        Mon, 30 Mar 2020 00:19:09 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id g8sm7390070ljl.45.2020.03.30.00.19.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 00:19:08 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Michael Grzeschik <mgr@pengutronix.de>
Cc:     lars@metafoo.de, alexandru.Ardelean@analog.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, bigeasy@linutronix.de,
        m.olbrich@pengutronix.de, kernel@pengutronix.de
Subject: Re: [PATCH] usb: dwc3: gadget: don't dequeue requests on already disabled endpoints
In-Reply-To: <20200329190244.GK27849@pengutronix.de>
References: <dc52d6a0-12ed-a34c-01c4-0fc5ccbf7b1d@metafoo.de> <20200327084302.606-1-m.grzeschik@pengutronix.de> <875zeokhoa.fsf@kernel.org> <20200329190244.GK27849@pengutronix.de>
Date:   Mon, 30 Mar 2020 10:18:57 +0300
Message-ID: <87sghq2tum.fsf@kernel.org>
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

Michael Grzeschik <mgr@pengutronix.de> writes:
>> > dwc3_gadget_ep_disable gets called before the last request gets
>> > dequeued.
>> >
>> > In __dwc3_gadget_ep_disable all started, pending and cancelled
>> > lists for this endpoint will call dwc3_gadget_giveback in
>> > dwc3_remove_requests.
>> >
>> > After that no list containing the afterwards dequed request,
>> > therefor it is not necessary to run the dequeue routine.
>> >
>> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>> > ---
>> > @Lars-Peter Clausen:
>> >
>> > This patch addresses the case that not queued requests get dequeued.
>> > The only case that this happens seems on disabling the gadget.
>> >
>> >  drivers/usb/dwc3/gadget.c | 3 +++
>> >  1 file changed, 3 insertions(+)
>> >
>> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> > index 9a6f741d1db0dc..5d4fa8d6c93e49 100644
>> > --- a/drivers/usb/dwc3/gadget.c
>> > +++ b/drivers/usb/dwc3/gadget.c
>> > @@ -1609,6 +1609,9 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep =
*ep,
>> >=20=20
>> >  	trace_dwc3_ep_dequeue(req);
>> >=20=20
>> > +	if (!(dep->flags & DWC3_EP_ENABLED))
>> > +		return 0;
>>=20
>> which driver is trying to call dequeue after the endpoint is disabled?
>> Got some tracepoints of the problem happening?
>
> I see the case when using uvc-gadget.
>
> Look into uvc_v4l2_release in uvc_v4l2.c:
>
> uvc_function_disconnect
>    composite_disconnect
>       reset_config
>          uvc_function_disable->usb_ep_disable
>
> uvcg_video_enable
>    usb_ep_dequeue
>       dwc3_gadget_ep_dequeue

Oh, I see what you mean. We get a disconnect, which disables the
endpoints, which forces all requests to be dequeued. Now I remember why
this exists: we giveback the requests from disconnect because not all
gadget drivers will call usb_ep_dequeue() if simply told about the
disconnect. Then UDC drivers have to be a little more careful and make
sure that all requests are givenback.

In any case, why is it a problem to call usb_ep_dequeue()? Is it only
because of that dev_err()? We could just remove that message,
really. Eventually, I want to move more of this logic into UDC core so
udc drivers can be simplified. For that work, though, first we would
have to add a "generic" struct usb_ep_hw implementation and manage list
of requests as part of UDC core as well.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl6BnWQACgkQzL64meEa
mQYDLg/+Nl6hQ4UQ27HfPic3YXL1ZnCNM6mz7wzJQSaMtKRf6Ts9LWGv2sroQzQI
Q5oJ4EOVsl04JAlM05oEj6HaQipAVnspcFq4kgvEr8kX62j+5Q0eVV60BmVZehCm
msnyQabelcTAT8U+YG5QgkWis2T3qt/alBg5RRjmh/e+Uu3Ivl6U3NoMapWxOuJR
IsOQTjQy4gSM9p95/P/YimxnYlv18hSFmqliJAmpGSt0KtOwVaNeNCDL6bh1H5O/
OjJ0z2ouEBUP8H9GSaZ6E16DJcGgqSC+EPek0Lw1BU88cwZEPRN4Fq0k+Kd1oUHE
KyeQ3QYEdJeWPEZSpOe19IbegDspU0YpQc6EGdFTQeOdCsW6J5aJ7tCXauEwq8Yn
mT4YXSWORoYnbbMMqLTKishui5WD53zPf/mVbs5muQ7eiJ6hZnX0t9taFOvW7SBk
Oc//1NqpF5ApsmOTKLds7j4sHdfJ5qM3ZVMeDdE06VLQJLq/2pQIU0MYiblE9Q8y
CjcWIti780ZUuUDwKQCDC1/P7j281VSv3VtYDxKNwf618dBQM2//D/3kaQzKbA/R
akHfx3IaCxGiI0+XbsGBRd7KpalR1UALnJKCgaJEvfocCyy2RB/u/h9RrmivUnk7
YgueD6QLQcYRAns5QAFlJy+Vw5V+BadBwygryOTXQV2Pc2wNF08=
=kwrC
-----END PGP SIGNATURE-----
--=-=-=--
