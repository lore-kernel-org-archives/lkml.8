Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED05C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 344662145D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599464712;
	bh=GvP6mhCj1aRy77o0gWFMzh619d1ltTMeuCvkmXTYlmU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=aWHXoFQlrrTD5dEytiWa48uQcCidLy1y/q805/h0l1RfTRFLBruqDU4m/rbiJZ6em
	 0ctIWzhoTxF9BPpAGDwKoTs468Bb08pVpTGc1P/ur7NTXK9c5MS4IFaGstcBN2pjTt
	 GzBAImq1hs7kicLZDdq/Dw0Je9qnXvv/vHNy/m/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgIGHpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbgIGHpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:45:03 -0400
Received: from saruman (91-155-214-58.elisa-laajakaista.fi [91.155.214.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40560207C3;
        Mon,  7 Sep 2020 07:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599464702;
        bh=GvP6mhCj1aRy77o0gWFMzh619d1ltTMeuCvkmXTYlmU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Odqr7TZCi5Km3/tYsZ1ZKJkh4HJyBSOCmukqCkAlAW+0gRPwoKKCideVa8E7fYDTA
         E7bwPnK2RV0VvGi/GwX86dW1w3DOTaQNeJo/6PRf8venAAjueO1+Q+qgmCVFEi8O6s
         w+VbCBJMKw9NxalfgdyF+vHZnDL8wICHbBGgusRE=
From:   Felipe Balbi <balbi@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>,
        Mark Brown <broonie@kernel.org>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Subject: Re: [PATCH v3] usb: dwc3: Add support for VBUS power control
In-Reply-To: <be4013b6-01c6-7f67-35ad-5c398b85c066@topic.nl>
References: <20200619142512.19824-1-mike.looijmans@topic.nl>
 <20200723075612.tn5dbkhes2chohwh@axis.com>
 <20200723110523.GA4759@sirena.org.uk>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.2698920d-90ba-4c46-abda-83e18e2093c8@emailsignatures365.codetwo.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.0d2bd5fa-15cc-4b27-b94e-83614f9e5b38.ac9c2a67-d7df-4f70-81b3-db983bbfb4db@emailsignatures365.codetwo.com>
 <e63ee918-c9e3-a8ee-e7c5-577b5a3e09be@topic.nl>
 <20200727102317.GA6275@sirena.org.uk>
 <be4013b6-01c6-7f67-35ad-5c398b85c066@topic.nl>
Date:   Mon, 07 Sep 2020 10:44:55 +0300
Message-ID: <87a6y21154.fsf@kernel.org>
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

Mike Looijmans <mike.looijmans@topic.nl> writes:
> Met vriendelijke groet / kind regards,
>
> Mike Looijmans
> System Expert
>
>
> TOPIC Embedded Products B.V.
> Materiaalweg 4, 5681 RJ Best
> The Netherlands
>
> T: +31 (0) 499 33 69 69
> E: mike.looijmans@topicproducts.com
> W: www.topicproducts.com
>
> Please consider the environment before printing this e-mail
> On 27-07-2020 12:23, Mark Brown wrote:
>> On Sun, Jul 26, 2020 at 09:10:39AM +0200, Mike Looijmans wrote:
>>> On 23-07-2020 13:05, Mark Brown wrote:
>>=20
>>>> Does the device actually support running without power so that's a thi=
ng
>>>> that can happen?  _get_optional() should only ever be used for supplies
>>>> that may be physically absent.
>>=20
>>> It's the 5V VBUS power for the USB "plug" that's being controlled here.=
 It
>>> must turned on when the controller is in "host" mode. Some boards arran=
ge
>>> this in hardware through the PHY, and some just don't have any control =
at
>>> all and have it permanently on or off. On a board where the 5V is contr=
olled
>>> using a GPIO line or an I2C chip, this patch is required to make it wor=
k.
>>=20
>> That sounds like the driver should not be using _get_optional() then.
>>=20
>
> Making it mandatory would break most (read: all except Topic's) existing=
=20
> boards as they won't have it in their devicetree. I'm perfectly okay with=
=20
> that, but others might disagree.

you're perfectly okay with break all existing users of the driver?
That's a bit harsh

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl9V5PcRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQYGJg//UoDK4AFFB+hwyzIO9lg3Jf/bQb4hjUEs
i8AxmSTRBajNyw2tkKHYMyLZev3kW7XS5E/LGNHZEoc+BP8qqF9gggIugXKuQJ1Y
NON5XhiIgyBak2hEqRlzL6KX0QT+UmseJqs6nZctD3STrpT0oNtsh+oehuVTKBmV
vfj1lZU+gJxfZR8spkjPuiV8OXW7sWT7SIQQeQGJQyF60HfIKnMyIrV4cLG3lS5X
EniYqukV5ubijrc4eV7+xhLwN8j0QA2JED4ooP/+CBpraEzdNo8dlU20kf9EkJft
ReL04i3B+zOF7FX16TQ6Kg4tiVDQg3Otzns0o70moYzD7hltrstxlpQD84RF0r2O
O9QHVEah1FSxcQGy7EiLB35sh6z69TiWFf+K+R8H5Ri/x4YkmYImWA+Eej1dqbq6
DCzgVYgjLG+3wnNjTOrw0TZctCWLcoceXYAUhOVDxJ3Ds/LJKKFENY/z3S5qXrh8
4Ds8+7Rt6WXcbd6SmxGWHU02iQMvcWzu3kR/MVtimrdONGg1lE5yhqjkO69/YCTL
d8n/A6FsR87q5owSXvCBbgf5QM6fJgYg/CjG5pwqxiYERk/D/LBujr6S2KVULmE/
+HdutgXWcvhp8BJCWRNAnGZb3NrfhlzS4RNteb1HNjy8846J2742BijtjPZFyvu9
TOu3It4R4rY=
=CBCD
-----END PGP SIGNATURE-----
--=-=-=--
