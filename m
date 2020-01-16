Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C49C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70A92075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579179833;
	bh=nLa4mzUCNNQXbakZ76zVNx2Q2EDa/HNeuL9ET/YDcbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=Uc4er+FvlwByGem9SCzVuUlEgihIx6vLXecFdWzXt2IABKAfD12VDCElZwObcoTRb
	 NUYCQWBOF4RWvrww/By24UY95oShgObmYCpH4H9F/PlKWkBTU3ZbIFFXgVuU4vbe+8
	 R88GTyidlLO2JFBS6WAmsUnWgBU9aEjxlKG3KNAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgAPNDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:03:52 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33440 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgAPNDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:03:52 -0500
Received: by mail-lj1-f193.google.com with SMTP id y6so22579025lji.0;
        Thu, 16 Jan 2020 05:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=nLa4mzUCNNQXbakZ76zVNx2Q2EDa/HNeuL9ET/YDcbk=;
        b=q2FLat57Vdgj4Ns6HyBDp4JT8kAFvmECtrIIJywTUmVweK0FpvgbjV4aa37Xgiprkf
         NKlntky4x005cVJpHMov1qq2wdt0NshfeLDOSorFN9NMbBpXH20mUCOqaI850ql1pIax
         IqkkguPvCR957Wfq63PIvsbZVjutJ8ulP+lcUCz20EjDiclY8cj1rciifmoxLgB4qhc4
         aRGsV7uCPe8PVFrUL0PBVHn1LJFrC0Lj+TOVEewVTrZ9nfQdfsb9JN/AE6adqz86OGk8
         46Gs7oUMG1LMOAAPMJu21ltHHXZPZlMdTpr3/UXwRKEqKkhyt+eh6kvfd0DXlh7EDaV0
         Rs2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=nLa4mzUCNNQXbakZ76zVNx2Q2EDa/HNeuL9ET/YDcbk=;
        b=fDzbVcD4W1i2gS0lSKIF0KHobFDXGTcsIjtJZUaWS+ED4D10//JFmdnS9QQXMLxMkX
         2pvhn2abWqZWypeQEnmyZMhijwloag3Wez85OPD8uIcGOImWRZOXKcokiZD+Se5DQKpE
         F0fYEWQPQlaK216msyiWjiK0v8GQHjuQsV2GSm1/fMFpK/+9j+8Gtqkb19XvJc/MkjT+
         jhwrx9NKXzIbaAxug/VrwkvDhlsP6ZZh9A90GXX3FzJlKTeRLzzqzdq4/ktYmDa2Uikd
         JGroyh1SIvaA1D3tUq3CKaP54lK/mbTlwzgRobjJJKwRIfOHAwhqjvdOpX47sCeuB8Kc
         gyMg==
X-Gm-Message-State: APjAAAVCe3fJlZX2oOpHzQu3+8uozgsJdFskTiBrCgsaBHOEU5ZsfN1W
        nVqf5B29rbpaEuCAy056TdE=
X-Google-Smtp-Source: APXvYqymJ6PvxMs6ozkarUeChMAsDOucSalTg5WW4l5iWlh+uuIvWzkv8S7yoJ1vjFnWb8NBFaGIQw==
X-Received: by 2002:a2e:804c:: with SMTP id p12mr2162976ljg.31.1579179829636;
        Thu, 16 Jan 2020 05:03:49 -0800 (PST)
Received: from saruman (88-113-215-33.elisa-laajakaista.fi. [88.113.215.33])
        by smtp.gmail.com with ESMTPSA id p136sm10661388lfa.8.2020.01.16.05.03.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 05:03:48 -0800 (PST)
From:   Felipe Balbi <balbi@kernel.org>
To:     "Ardelean\, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mina86\@mina86.com" <mina86@mina86.com>,
        "lars\@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH] usb: gadget: ffs: ffs_aio_cancel(): Save/restore IRQ flags
In-Reply-To: <f3f8e2a6480da78ba23ddedb68beee71f47e178f.camel@analog.com>
References: <20191106120219.15028-1-alexandru.ardelean@analog.com> <f3f8e2a6480da78ba23ddedb68beee71f47e178f.camel@analog.com>
Date:   Thu, 16 Jan 2020 15:04:48 +0200
Message-ID: <87imlb5z7z.fsf@kernel.org>
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

"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> writes:

> On Wed, 2019-11-06 at 14:02 +0200, Alexandru Ardelean wrote:
>> From: Lars-Peter Clausen <lars@metafoo.de>
>>=20
>> ffs_aio_cancel() can be called from both interrupt and thread context.
>> Make
>> sure that the current IRQ state is saved and restored by using
>> spin_{un,}lock_irq{save,restore}().
>>=20
>> Otherwise undefined behavior might occur.
>
> Hey,
>
> This is a patch-ping.

Please read:

https://lore.kernel.org/linux-usb/875zhd6pw0.fsf@kernel.org/T/#u

We're gonna need a resend, sorry

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl4gX3AACgkQzL64meEa
mQYQoA//WcHl7hIiiJpsfMSQdRklVLngnMyd9E7svXw1JVCkXUzWv6wfuxscFwJR
esBETg7bFT84K1bt+j9Dt582gkXidGUvQBkTevW5Dhhvk/7EdeptjmGlK8ImsZf4
MgAqTa+6L59KjtbtvmCzEOF031c/7Yi2luHibZ7enaiE7swuiSZV362MNQEs6uvE
VUeTet+1yIlkqCh1ckwAPTzpYYxfWTaNvzv5EV8yrkiPQe3AHpIdQUPtJJ+POWNd
PCoeVh4RH8BVFIAIVgmyGDHuGeo9nTr7E/lhzbENk5s5JkaMkRZF8f27NdgxswOP
49vjqcRIlaJJexj+oZi0yvKju0k08tE93Z7OMuNhnU8SLOEtDH9iWDaOROk+JDOC
QK7bGEX37B7GVOUdEMMX7VyTZiq2XKmoAfy9vpzpYAc6iKWjtxHJSOu3ZcOuBsVh
lrhLFl5iK95HUezj4OuUZbCAwqN9CZqCH7J7ofMd0pjcNp7rEO3IOaY26EcuBOP+
PN/CtJS86Wg4Ab/RQeAT4zzsQxteuQwDxkaxyKBA6zMXkdgx3LzxEHbF82Uq5eOr
sl+RTVXRTNVqtRB+MyCjdB9LXDPwwePONnUu3dWy2YerRCDS0bWNfnv7HCoPSbRj
RfPLTdyHGKJNMIvJC9gdjUUBJqNSvmVcNfTHgwdxggWjyPgHFeo=
=NnEc
-----END PGP SIGNATURE-----
--=-=-=--
