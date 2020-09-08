Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4EEC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 944DD21D7A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599551122;
	bh=/KtVhTU7bvGl1NhTGnSKTlQYPncJBxYlW52JAtYInuc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=0GZ8TfLK6eiC+ZTZaYuGQsv8EUIx61ciyrQdX1WAcUsv81Wr4Ux/opLBbxnVZs6t5
	 ESnGeQEaj+j6MnbLmcnEAboPIJcdTgAEm2Tr4PyhwGKwJXtECNF1hukVtgAviyC5EK
	 1lY7L5smUrawYPTnHomxxeygZYIMnkR0xvl+2rk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbgIHHpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:45:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728786AbgIHHpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:45:19 -0400
Received: from saruman (91-155-214-58.elisa-laajakaista.fi [91.155.214.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAE8221D43;
        Tue,  8 Sep 2020 07:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599551118;
        bh=/KtVhTU7bvGl1NhTGnSKTlQYPncJBxYlW52JAtYInuc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=xeJK1y9z3klHrI4hvOQjtKcs3ek+IESjTZH4VUE3Ex/IelJf973ZpOE6saCPhYQbJ
         RRyxP5dT07Ttbrh4QaSCZrtv8accqqBereHMkiSUyV1O71bxiKIdh3nonGZegINC/b
         YOCOZnzh3WquLxJr87MRZzg/UlvBqeVWDUFumwkI=
From:   Felipe Balbi <balbi@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/11] dwc3-of-simple: add support for Hikey 970
In-Reply-To: <20200908085307.2c25657b@coco.lan>
References: <cover.1599493845.git.mchehab+huawei@kernel.org>
 <83393769e4391d038c4ab69a67ac77e2ca34efd4.1599493845.git.mchehab+huawei@kernel.org>
 <20200908085307.2c25657b@coco.lan>
Date:   Tue, 08 Sep 2020 10:45:11 +0300
Message-ID: <87sgbslnjs.fsf@kernel.org>
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

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Em Mon,  7 Sep 2020 17:59:34 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
>
>> diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-o=
f-simple.c
>> index 8852fbfdead4..2d497165efe2 100644
>> --- a/drivers/usb/dwc3/dwc3-of-simple.c
>> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
>> @@ -49,7 +49,8 @@ static int dwc3_of_simple_probe(struct platform_device=
 *pdev)
>>  	 * Some controllers need to toggle the usb3-otg reset before trying to
>>  	 * initialize the PHY, otherwise the PHY times out.
>>  	 */
>> -	if (of_device_is_compatible(np, "rockchip,rk3399-dwc3"))
>> +	if (of_device_is_compatible(np, "rockchip,rk3399-dwc3") ||
>> +	    of_device_is_compatible(np, "hisilicon,hi3670-dwc3"))
>>  		simple->need_reset =3D true;
>
> It turns that this hunk caused Serror during my suspend/resume tests.
>
> Without this one, the driver works just fine.
>
> As you already applied this patch, do you prefer a patch dropping it,
> or should I send a version 2 without it?

Send me a new one, I'll remove the patch.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl9XNocRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQaEmg/9GSVgxWyhiXPv9kdWo2/OVE5R4aXOW1D8
YnECe0j0p9DKuYwJPhbSGDwTFN5aDzY28ANZk1fyEhDvPKymwXDh3d627pCUjAXv
GO+Bn+bAq/fdyA/Oe+yo1yZNkT02T036fWLDsUl0Pfi9Ym4tnFyx21kVgDN3jh+1
O4Xol+0Tra7OQjmwGlzlsXaWRMV3ix+0L1aYYxb3bLg7QEpRxgwAQusfU82NXYrE
pHv44+WmtrzCRj/eBz2xn0E19UC3FTJ4w00RlGaPMaFfOjwcj4/za6RYgUVAh1NQ
yQOi5XbmJs3EfqFkdHSiLQ80P2s89lqKZ2B2HVZ4LXtmGw5KRM6k/sM6Eqil6Wgi
l5nmA35hpFQQFdRw/CBR2UK3qrw0cggvYLOaW9r+lBwKIYVapdsuO7t3FkQHITFy
fzEeAvgzukdoVSXyU1aoewEHMKJCIBdSMnEEZJtXThpUVcHmNox3faDe5Wdrm8og
lHq1LJW8lPLnIW6n8F2834XvcpzvWZCe+YYdG9h3XAjyZ8QZMNUz7voCSRAmEZCP
5scH3Obdfk4fBwihxA8S4riRK43QRdl/pI1tL8vhgaD1cPfUBMJ9ZoaX3vHleoAM
9bTUg+2dWho/WBPKDZAOciIOs8UrsvKebXx9DzzQilEiBaXHLRvuTXZbANI5WFC6
J2vOXRF0CV8=
=HS2d
-----END PGP SIGNATURE-----
--=-=-=--
