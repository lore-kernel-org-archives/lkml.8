Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32253C43461
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DB592098B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598867670;
	bh=05SB4QyhMRQEVhQuA76tAzTplfJxOwcQAfl8qdw+ScA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=t2J3MzsijgNSHQmr2nNNWhfuiDoDQnMtiIXnPTUKvZoomaCVN0h+bgaXuX6wlyMaH
	 tw87MkzThVEMcSm5Jckw24i6qWesOGf0ej3RHF6BYB+YV8AUMgYWFQtaDKe4rook9N
	 MzipiOReNtyNuYJq3j6/TBiTNiGXIg2WkR6uVMXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgHaJy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:54:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgHaJyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:54:19 -0400
Received: from saruman (91-155-214-58.elisa-laajakaista.fi [91.155.214.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BF2A20EDD;
        Mon, 31 Aug 2020 09:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598867659;
        bh=05SB4QyhMRQEVhQuA76tAzTplfJxOwcQAfl8qdw+ScA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=vJO2ySKK2PRG4joUm75ogezdndbhgzjUDQ745LoRUyXOLGew7GRZ770bVHmzV4m5f
         9WEBzxLHjfBpHSLBd2E3hXVsXcEu57+pv9z7rj2/Irudt8TkfV9TzoGt3JH6Oxxi6I
         trdvhQOhTGEnlh0iqxSOXRgs6gjhWLE4j01xCGeA=
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
Date:   Mon, 31 Aug 2020 12:54:10 +0300
Message-ID: <87zh6b9m4d.fsf@kernel.org>
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

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl9MyMIRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQaifA//Si7r2rDSXtDMDrTep0yeVpCJA9vk3Ajp
K1rz3FtJaOInbRADPFu4rEKMCiz2bYBB/kT+iiFDUzpw3AOiQvjxyXbS4IqETV5p
+yxIaRE8Hr4dYGobRps9aykJfpMO4fZhSVfm99DLPXyFlmVBhE3AO9iz2bn1yC/X
lq5ObwFqNnWya7yX7xOXLez4hM5waO621Fj45bWyXQFbO5Q+BaF5Tu+B0y0OptK0
7dhNBFDe8xXTLjlvgsATtByfcYYi5Ip83xNfOLev4gH49alc6QGmcIjeVR5fLaPb
YPJjsKi+NB1PsRHc1eKjKlKWiIVunvZ8zxnTKGec+PWsAF0dgOC8ARb3IMJhYxbD
bIRcK2qvmkrWa24KiMUIwguHyWRkVm2Wmd14rBTg2Q2REJThn/lTr/O+hxai7ZBL
V55vc/6E2l/ZMxDwNi8tvlxE6gu3qxYJeY07bFTXqXf4RiNPyT1vIpdzcSQzN4ZR
gjMSjNNXdTpvLLXfHYt1o29oBl1IhrvP4TzTPzPvxj3afMrgm8O9roOpeK9F7nCN
8Hp4PkQUE7PTwens37vC+sGCYXJUDAp5FU9Enzdansz0+QBCvRnJslNQq73P9vQB
HR6/1JvhJzQRr9K6YHY5xzo9HZtp+QqKtzZZV27M1dZr+w6/g83knFJUuDdwm0zx
jeRhoV3yH28=
=5dAd
-----END PGP SIGNATURE-----
--=-=-=--
