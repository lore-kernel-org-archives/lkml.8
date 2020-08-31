Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042F2C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB4162098B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598867708;
	bh=HT/dHnUDrMXwyD5q0jInxv9lB8IyvR2AIAngyUE4ihs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=JmxmrTDjnsut7ja8TYjqQRuxoTwMNRjaY4HXiVCbggqa4AALQ7qnbexOkaSRGvBfa
	 Vn1jZ8GKrevP+2J10JbJw7lMpRJ8bAfybAfZ9p0rNyJ+gOObVmaT3M5OXYoz5rVD7d
	 uGgWmY5Lah1Ix5vIFK13fpnEdFbTPyNB8E6RzssM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgHaJzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbgHaJzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:55:05 -0400
Received: from saruman (91-155-214-58.elisa-laajakaista.fi [91.155.214.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 356372098B;
        Mon, 31 Aug 2020 09:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598867704;
        bh=HT/dHnUDrMXwyD5q0jInxv9lB8IyvR2AIAngyUE4ihs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cKvb8cb8UjAzTAmanRgpW0ydgrUNNIScnsG4pOpTle6dEDHASTV2qlifBQDcLULSZ
         vvIVAUAQ3mRJ85ywB8acd9Q1/3WhCoxmaPIzl3rsEN9yJDSw9C4jd9hercXUv/wwNv
         I5r+gaMFlrQuWcuyVfRfkiDvKVGlUUm6LAsu19j0=
From:   Felipe Balbi <balbi@kernel.org>
To:     Tao Ren <rentao.bupt@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Subject: Re: [PATCH] usb: gadget: aspeed: fixup vhub port irq handling
In-Reply-To: <20200817225603.GA21228@taoren-ubuntu-R90MNF91>
References: <20200528011154.30355-1-rentao.bupt@gmail.com>
 <875z9hz8k3.fsf@kernel.org>
 <20200817225603.GA21228@taoren-ubuntu-R90MNF91>
Date:   Mon, 31 Aug 2020 12:54:57 +0300
Message-ID: <87y2lv9m32.fsf@kernel.org>
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

Tao Ren <rentao.bupt@gmail.com> writes:
> On Mon, Aug 17, 2020 at 04:49:32PM +0300, Felipe Balbi wrote:
>>=20
>> Hi,
>>=20
>> rentao.bupt@gmail.com writes:
>> > From: Tao Ren <rentao.bupt@gmail.com>
>> >
>> > This is a follow-on patch for commit a23be4ed8f48 ("usb: gadget: aspee=
d:
>> > improve vhub port irq handling"): for_each_set_bit() is replaced with
>> > simple for() loop because for() loop runs faster on ASPEED BMC.
>> >
>> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
>> > ---
>> >  drivers/usb/gadget/udc/aspeed-vhub/core.c | 10 +++-------
>> >  drivers/usb/gadget/udc/aspeed-vhub/vhub.h |  3 +++
>> >  2 files changed, 6 insertions(+), 7 deletions(-)
>> >
>> > diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/g=
adget/udc/aspeed-vhub/core.c
>> > index cdf96911e4b1..be7bb64e3594 100644
>> > --- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
>> > +++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
>> > @@ -135,13 +135,9 @@ static irqreturn_t ast_vhub_irq(int irq, void *da=
ta)
>> >=20=20
>> >  	/* Handle device interrupts */
>> >  	if (istat & vhub->port_irq_mask) {
>> > -		unsigned long bitmap =3D istat;
>> > -		int offset =3D VHUB_IRQ_DEV1_BIT;
>> > -		int size =3D VHUB_IRQ_DEV1_BIT + vhub->max_ports;
>> > -
>> > -		for_each_set_bit_from(offset, &bitmap, size) {
>> > -			i =3D offset - VHUB_IRQ_DEV1_BIT;
>> > -			ast_vhub_dev_irq(&vhub->ports[i].dev);
>> > +		for (i =3D 0; i < vhub->max_ports; i++) {
>> > +			if (istat & VHUB_DEV_IRQ(i))
>> > +				ast_vhub_dev_irq(&vhub->ports[i].dev);
>>=20
>> how have you measured your statement above? for_each_set_bit() does
>> exactly what you did. Unless your architecture has an instruction which
>> helps finds the next set bit (like cls on ARM), which, then, makes it
>> much faster.
>
> I did some testing and result shows for() loop runs faster than
> for_each_set_bit() loop. Please refer to details below (discussion with
> Benjamin in the original patch) and kindly let me know your suggestions.

no strong feelings, just surprised that you're already worried about
20~40 cycles of cpu time ;-)

Patch applied for next merge window

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl9MyPERHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQbRNw//Ycg/zGDlByFwp5tnmnP1LkeCxblvsqjG
n01I9rv8UAccFtJT/9QSYTtd6KOMvXM3dkMaX46ikxSPYPU3cZzQlMCqK4d40JJ4
YZxp/EnTM/Kt4V0R7tim2n1L7Nghyn1fY6crnN+R0PRYmFfrj3iEokFMIHhjnS8d
PoDaT0aq3qH2uZRop0yN3mZmouAaTItfbXqxg42o13ZocuePy+M0bPeHPRXWZ9KQ
aqL4vC9XZM7AXzeTVxn+53gnGzhFbCTmEiIdhfiBBffJT624hsfocIPUAxrj+kJj
QyFUADnX5OHRElPzoiZyFKZlfAQUueQ6tC2I7/KFYuVu/tWT9/QE92aBOJ9Djomk
1+YCWr4MKz4RB313qyAw9zae77IpS2rQTbQwYts5iL3MTfpd1lwdTMX6TMJgReyG
KBJ+amV5/Y74n5mxypnUXCQOTr3EqyHkr5ieYH6vkx9rzd3RylX6Qr1yGw839avx
yIYcescxC9Wohlg8XAEs5ZCv+YsbapCzGlm7tq7m/eWHINbYIDOM+tpPkAfjzVmZ
ZA5iNVntd+4punCL1Alpw+At/ZoJVMVHHdHDt73rfrZUIq8Xh20acsJCBh0xeQAE
D6nte7wBz1h55Yz7NkWmNDaH9A0uUzYYnVeWRmZlt2RoNgkcx0w1OPXSJYtlInVi
K+VeRcQfwJ0=
=rGY9
-----END PGP SIGNATURE-----
--=-=-=--
