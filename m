Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BFBC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D986A20714
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585384079;
	bh=M2j6zAtpXScfFJewGbToz0iVcm9XFSH5Lbgy0/jYH4A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=vrMO7U54fj3/EcM9QSPXrrZc3jUCv/EdyUL3IA24hp86I0Fj5oXfb0GgMrk9dsWyP
	 EwC8tKRSNxpdG6L+9YgJRY+c3CnUnhziEsCdhOL+ANntbGV4qFs4nYJWtG7rkEOot3
	 rxAXGg4UTA2dI6B6/n1TWx5b1H26gi5sQpS2Ij60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgC1I16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 04:27:58 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45338 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgC1I16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 04:27:58 -0400
Received: by mail-lf1-f68.google.com with SMTP id v4so9765340lfo.12;
        Sat, 28 Mar 2020 01:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=kUuQzPOK0FDsYyqkv2vYZA3Ue/aoYacm6ACiG7IOKZo=;
        b=D3ovAOvgBPe1CBTNw3mm9a3KZ5CXPEA+l4jXGk7Th35AJzgeDqNkIuGm+rxRnjPUSF
         M4oEtFRfmz3NVWJ9dOOxo1Ka4WSvdLi35rEbwxQC/lT9fmBxRJ7hc5pekk7ZmyAVHm/b
         IdUMYN59IJrHO/+xsBROIf05zeqd1lDE6Alw3gKtOsI3+bJOzdQwVtn2MoKySl8Bdx7z
         1x2Q0xEMI7nalpj3fcIjeDm0mfMKRUAA16YIulw3f3ESbmmS3z2/YO0EDNkzrTaEJQJe
         MHFu5qGfNadhjHU8YUBIHrLduCG8wIHlQ2p8NJ0RMH9mXwrcnz7W/gO5AnK/4SVkZGKS
         hUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=kUuQzPOK0FDsYyqkv2vYZA3Ue/aoYacm6ACiG7IOKZo=;
        b=NIlR0uCug2kghEe09Xs6cAnCTLnE+ntQvGyF19xkavIyNIlOveZXjpzlJg+I4svZ6m
         SS3Vur8NhOEG1qCdwDoxWjoWGrnM3665Alb3kxHdyAJK8j/oCykmuargE74OVQ//BxrP
         HvFe538wj69WZpwOgiUq/uo6btKx20vABFgYTwIAGtQ234ZPCkfPe1pMyB02U9+QA0ej
         YAzHI58aHo/NPF9+IiyCOFlRbJKCa/XG7L7E4dwx9KJwmV1aFmzzb5ULoWZbx7QCbc1i
         3SuHl3bzGPa9CBku7wZPrM9oVADBzxv4keZ6+HBHURfLx+O4FSuTvLVtU+8FMQRKIpPu
         ZbJg==
X-Gm-Message-State: AGi0PuYQ2dzySgNKmWR/iNK2V+xJ1Mk5afr4tJeP5EOVncQIGbA/kzVv
        jR0kDYpydIb3JKDX1sNfrVNneW0D/FJkng==
X-Google-Smtp-Source: APiQypJD2C7Bvk9q0AbLfWc/Tf69kBZlymn623zBULc4fv66dYNd91FYSS1Y2sqLMQflyN3nnRfpgg==
X-Received: by 2002:a19:f606:: with SMTP id x6mr2094056lfe.44.1585384075257;
        Sat, 28 Mar 2020 01:27:55 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id n7sm4030919lfi.5.2020.03.28.01.27.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Mar 2020 01:27:54 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Michael Grzeschik <m.grzeschik@pengutronix.de>, lars@metafoo.de,
        alexandru.Ardelean@analog.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, bigeasy@linutronix.de,
        m.olbrich@pengutronix.de, kernel@pengutronix.de
Subject: Re: [PATCH] usb: dwc3: gadget: don't dequeue requests on already disabled endpoints
In-Reply-To: <20200327084302.606-1-m.grzeschik@pengutronix.de>
References: <dc52d6a0-12ed-a34c-01c4-0fc5ccbf7b1d@metafoo.de> <20200327084302.606-1-m.grzeschik@pengutronix.de>
Date:   Sat, 28 Mar 2020 10:27:49 +0200
Message-ID: <875zeokhoa.fsf@kernel.org>
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

Michael Grzeschik <m.grzeschik@pengutronix.de> writes:
> dwc3_gadget_ep_disable gets called before the last request gets
> dequeued.
>
> In __dwc3_gadget_ep_disable all started, pending and cancelled
> lists for this endpoint will call dwc3_gadget_giveback in
> dwc3_remove_requests.
>
> After that no list containing the afterwards dequed request,
> therefor it is not necessary to run the dequeue routine.
>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
> @Lars-Peter Clausen:
>
> This patch addresses the case that not queued requests get dequeued.
> The only case that this happens seems on disabling the gadget.
>
>  drivers/usb/dwc3/gadget.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 9a6f741d1db0dc..5d4fa8d6c93e49 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1609,6 +1609,9 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
>=20=20
>  	trace_dwc3_ep_dequeue(req);
>=20=20
> +	if (!(dep->flags & DWC3_EP_ENABLED))
> +		return 0;

which driver is trying to call dequeue after the endpoint is disabled?
Got some tracepoints of the problem happening?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl5/CoYACgkQzL64meEa
mQY47A/9F0MvaAz3S1tMcdQ9GJzZkykuDn0kwTsSU8Q03UGPUlJlD99/JvfdpFtU
uqdQMdgQf6NTxQvsE5GPyjkP0nVp8EwUEV+YdeM4hHLumSUEwHtYipQpSVkyUkVK
fpj6wP3Nt0z9OgLtJYAS4PR6nbd14MF7nAejWHO0hNkEjX01i7+KTtOyebyIVTQn
+FkA21J5g5rRyuacjWTc+X+YeCxxCcEFOP8SmdBPOAjeFCH63A5HQKb42BZgXb6o
KkKKClpWX1oq52jB6vukgN9dMqkpC/0OlfP+eXI/sfkNN8115Z2/oZvAt3fiww2F
vYcWSN9PF+Ce5rL/8Y130LHuSABEJ/bg7QD1cM82HRjSkkjzuhh3cbqJAm8dQEPM
19UgTemKsFY813EhyO0xZehh7AZ7OaqQihv/1ZjYxF6Y9+PuZkrw82I/TX52BeBx
MUaBzTkBxpkyUJUoiQpi5n2lcnsntqjaS0tRgQWgd9+mvkipVn/YfT0tqT7fyRvC
Nh6z5miQxKOUov8XRKWxseEk3PhuUdLsjgBBs4xmMy8/C74TGERTh0g/mV2iRq8i
/7r2sRoG8EvMQ0M4ABfH8Bsgmv+eSmpLVLQM8JcjgaoZeKp+V2O1MM1oJLabot7o
3y//MzQhRQyNhKqUac4syozGE/Bc+0Ox3SxErjR/N3N/W+073GY=
=0Q4s
-----END PGP SIGNATURE-----
--=-=-=--
