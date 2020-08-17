Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF84FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8AA82065C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597672188;
	bh=neILveBskNIGri0vUIbvh+uU43bAIKbA+3Ui69RMDEs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=db9RicOq4jgE5e2OHK432rL26wrR4l0YQU7PLNOFZxhHCIDgqw+vIsd/A0FLaMc1U
	 6mQbtrC87xLg+PhYIl0P43t0y3e558WOfPbGsesMsHZMQhLO6SYCTPSaTBlR9H2Oj2
	 BdxxZNPRqMo7b5jDoTr8nsrYK024rtmlThg/2iiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbgHQNtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:49:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727953AbgHQNtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 09:49:42 -0400
Received: from saruman (unknown [194.34.132.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 383D72065C;
        Mon, 17 Aug 2020 13:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597672181;
        bh=neILveBskNIGri0vUIbvh+uU43bAIKbA+3Ui69RMDEs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=B2dQcjMvHdPr+yGQWxV5pReE59glr540FiC9zAx/WQDn0xn+sIBKD+xL2t18N9sM4
         SAWDG5mRanAZS3YXc1SbcOWFN+I++rs+P2t0AF94BeFQC9kUnY534zUyGQ1LVc4sEc
         Ew7LVl8v3JitXfdLzjWSBWhzkaD1SkxqAUpbWWOg=
From:   Felipe Balbi <balbi@kernel.org>
To:     rentao.bupt@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: Re: [PATCH] usb: gadget: aspeed: fixup vhub port irq handling
In-Reply-To: <20200528011154.30355-1-rentao.bupt@gmail.com>
References: <20200528011154.30355-1-rentao.bupt@gmail.com>
Date:   Mon, 17 Aug 2020 16:49:32 +0300
Message-ID: <875z9hz8k3.fsf@kernel.org>
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

rentao.bupt@gmail.com writes:
> From: Tao Ren <rentao.bupt@gmail.com>
>
> This is a follow-on patch for commit a23be4ed8f48 ("usb: gadget: aspeed:
> improve vhub port irq handling"): for_each_set_bit() is replaced with
> simple for() loop because for() loop runs faster on ASPEED BMC.
>
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> ---
>  drivers/usb/gadget/udc/aspeed-vhub/core.c | 10 +++-------
>  drivers/usb/gadget/udc/aspeed-vhub/vhub.h |  3 +++
>  2 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadg=
et/udc/aspeed-vhub/core.c
> index cdf96911e4b1..be7bb64e3594 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> @@ -135,13 +135,9 @@ static irqreturn_t ast_vhub_irq(int irq, void *data)
>=20=20
>  	/* Handle device interrupts */
>  	if (istat & vhub->port_irq_mask) {
> -		unsigned long bitmap =3D istat;
> -		int offset =3D VHUB_IRQ_DEV1_BIT;
> -		int size =3D VHUB_IRQ_DEV1_BIT + vhub->max_ports;
> -
> -		for_each_set_bit_from(offset, &bitmap, size) {
> -			i =3D offset - VHUB_IRQ_DEV1_BIT;
> -			ast_vhub_dev_irq(&vhub->ports[i].dev);
> +		for (i =3D 0; i < vhub->max_ports; i++) {
> +			if (istat & VHUB_DEV_IRQ(i))
> +				ast_vhub_dev_irq(&vhub->ports[i].dev);

how have you measured your statement above? for_each_set_bit() does
exactly what you did. Unless your architecture has an instruction which
helps finds the next set bit (like cls on ARM), which, then, makes it
much faster.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl86iuwRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQZuXg//doj2VlNrrpXSD2a83iUegA+NRRRKef1U
PRfUUrIK4igGr/FiQAhE9Mlilxj/sZTLcQ6qe1EhIY+f5JhyfucZ5Te4WhNFaxtZ
UJp24ndXVc0q8NTmSkre+c6GLX/lD4NFlfgMSsdqpvAlYJirzL4GY63EWA9W8I3k
cO4Igdvi8ZskhUgX2QBCM4kDxMk+WxV6PrD8L4EykHmXTzFqVJxKM30BO7U0Gdd4
bmImEVCqzUDSivYKC7xwDWnT0HAXjbm38tcb4hq40pePVtDNEGFiNd3NUo953SvP
065liQg/4ats64P21c+PN0qXFovkWoSTJBa1yzcqfWF+Yi8fKI5UVNp49W0CJZ2m
lEKNc/H4+qzEysoXCgWCCznDg4RCxE0f4Y5OsNxkf63QvVEAaFRePgNZ6txble7v
dJueHYNiEfsgCe2QUCxl4f805gq2+iIMKGnWvEdwcdlpUCmop+CBXouD9MuMt+hB
OLDU6hSo/REsEHKVsooiICwfUOuD0xrqiqObcLKwSd0krXnDRkkYjYm4FvN4u43y
y+sTwkU5jswAvcBCHDgayGgm37U0QsDLpZW5voCirwaPqdC+09yVQ18/lx4cA+Lq
Y2WHyvRRssi5U8G3YHQUoLVJ7umEx5o6k13rBQNBnueyfEsVM3G8V74j+uuYLGzO
BbmxKI2a0bY=
=TM9v
-----END PGP SIGNATURE-----
--=-=-=--
