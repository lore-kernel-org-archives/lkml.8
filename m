Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1796EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE98120706
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592981258;
	bh=yV4lDkKWrpIuA536BshFSNV22/r+qUAet/WX/NorpMk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=lcqq36SYAPvtEgMWDI/rpOISFl9NCywGqQ5oyitgGimqS6VJobcdo8NQvNylHfF0Q
	 v0j+pHElg9ijyo9HXwD2zyUb8NcjVexAQar4VPLypEerly10ZlVAnjf+B4sXw4c4F3
	 gTV7tNADxU0vvH4n2jAXe1hq6FA12LFdO7khVo8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389528AbgFXGrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 02:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388972AbgFXGrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:47:35 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AF5C061573;
        Tue, 23 Jun 2020 23:47:35 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n24so1318687lji.10;
        Tue, 23 Jun 2020 23:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=KBYbtbUKckC2WprsPkCJDR+2VdRMgtKwaRao1I/1VEY=;
        b=vOHxiLlZOJSGwUCk3S7v5VCD+Vtu4X7fMdvCUw5TxpdOJM7vYSC5F1K2Qz+oSjWure
         HQw89CPretl6MfOkzjocZ76EM8K3UJkNFOBOfGxERHz6gUkAbjQgjfU0NB+1RGJDZJfo
         zMpl2v3wAdWkdnELcVOBC2Ll4fOpWnjubiwwrryQ8XjOhAPnJc22e7pQ/X2FMocmgVJy
         8ayimVhaa5f8qz5aSwgr5dZCPPYOIZ4pUm85Lc86XBwErJ2+7QWEHbd4BmKF/YeDUTeu
         RJn39xS0R+l9PIaHnVptJAF2xHCak5VK3vH2Fh/Vz1lj/k31kCslpU8P6zMmbKhQFua3
         W0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=KBYbtbUKckC2WprsPkCJDR+2VdRMgtKwaRao1I/1VEY=;
        b=JBGeUIuf5pXF7z3i1LY/Vw+bzapetCTcvhtNMpMt2zRmMXDEQmB3j6msbHUhEnEL54
         ty/EPcdTE7Pn2ipXQWZB+Ph5Q7lk4W6tjbp6tvrjo4AcafUVVrJKdzXQpyA6TV6pC0Sl
         XjrbKs7pbOIinPvBrLVr0kMBhaPvzwNs+kasQfykoKgocERv8h0pPRLPxp3WKXn1Vc3K
         4imXANVIF+8V3pXdEa2ehhNWP2EBqOEGnA5gmI8vBwDK9xFUGICZ0RtsErjY8E8jZ+uO
         o0Eb9ncFHAWYvX+/3KQpdy8JmHdYOscHcvtv+upvdDek9WrNLj+G3FVvXhJ2Ak1CNKHJ
         BUKg==
X-Gm-Message-State: AOAM532KNdCL9aSGCVx6hN/1hNzM3ashSsmwHsREAXO+5U4/gKiUpIaj
        AMsAbwmJBEbysUd4xHPxvjk=
X-Google-Smtp-Source: ABdhPJzVfCi3+7R9Ev/bd8EixB1X61p3Gj5vppkMY4nRMZxXAXIbxRyrfjHGhuVF/2ZNb+Fd4hBzgg==
X-Received: by 2002:a2e:a16a:: with SMTP id u10mr12507287ljl.222.1592981254027;
        Tue, 23 Jun 2020 23:47:34 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id o22sm2051751ljh.32.2020.06.23.23.47.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jun 2020 23:47:33 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Sergey Organov <sorganov@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>
Subject: Re: [PATCH 1/2] usb: gadget: introduce flag for large request
In-Reply-To: <1592310884-4307-1-git-send-email-macpaul.lin@mediatek.com>
References: <1592310884-4307-1-git-send-email-macpaul.lin@mediatek.com>
Date:   Wed, 24 Jun 2020 09:47:28 +0300
Message-ID: <87wo3xvu2n.fsf@kernel.org>
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

Macpaul Lin <macpaul.lin@mediatek.com> writes:
> Some USB hardware like DMA engine can help to process (split) the data
> of each URB request into small packets. For example, the max packet size
> of high speed is 512 bytes. These kinds of hardware can help to split
> the continue Tx/Rx data requests into packets just at the max packet
> size during transmission. Hence upper layer software can reduce some
> effort for queueing many requests back and forth for larger data.
>
> Here we introduce "can_exceed_maxp" flag in gadget when these kinds of
> hardware is ready to support these operations.
>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  drivers/usb/mtu3/mtu3_qmu.c |   11 ++++++++++-
>  include/linux/usb/gadget.h  |    1 +
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/mtu3/mtu3_qmu.c b/drivers/usb/mtu3/mtu3_qmu.c
> index 3f414f9..2b51a20 100644
> --- a/drivers/usb/mtu3/mtu3_qmu.c
> +++ b/drivers/usb/mtu3/mtu3_qmu.c
> @@ -620,7 +620,7 @@ irqreturn_t mtu3_qmu_isr(struct mtu3 *mtu)
>=20=20
>  int mtu3_qmu_init(struct mtu3 *mtu)
>  {
> -
> +	int i;
>  	compiletime_assert(QMU_GPD_SIZE =3D=3D 16, "QMU_GPD size SHOULD be 16B"=
);
>=20=20
>  	mtu->qmu_gpd_pool =3D dma_pool_create("QMU_GPD", mtu->dev,
> @@ -629,10 +629,19 @@ int mtu3_qmu_init(struct mtu3 *mtu)
>  	if (!mtu->qmu_gpd_pool)
>  		return -ENOMEM;
>=20=20
> +	/* Let gadget know we can process request larger than max packet */
> +	for (i =3D 1; i < mtu->num_eps; i++)
> +		mtu->ep_array[i].ep.can_exceed_maxp =3D 1;
> +
>  	return 0;
>  }
>=20=20
>  void mtu3_qmu_exit(struct mtu3 *mtu)
>  {
> +	int i;
>  	dma_pool_destroy(mtu->qmu_gpd_pool);
> +
> +	/* Disable large request support */
> +	for (i =3D 1; i < mtu->num_eps; i++)
> +		mtu->ep_array[i].ep.can_exceed_maxp =3D 0;
>  }
> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> index 6a17817..60e0645 100644
> --- a/include/linux/usb/gadget.h
> +++ b/include/linux/usb/gadget.h
> @@ -236,6 +236,7 @@ struct usb_ep {
>  	unsigned		max_streams:16;
>  	unsigned		mult:2;
>  	unsigned		maxburst:5;
> +	unsigned		can_exceed_maxp:1;

every driver does this without this flag. This is unnecessary.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl7y9wAACgkQzL64meEa
mQZAMhAAgft5sx0Sthuj5ty6Jk7/YrHHMQzKjG9kRLJYN7ne2V/6mGSZT1DIWcNg
DGPpshkW1TLseVRF44HeK8ly5jVezzkV12zyshXaEap8j0/HuLnxoAfOCR+ZoWe7
NkK38xqJkLteRffaSNN8PMfBKQf0uUccPyzOFnCzAq9VlZmFqAUOB5YOXwHlU6J2
caK4tzOihkTHF4WjfHyZ/ObZm/KBgp/qvvJyzW9BB7aHMcoYHPwU/WT7c0Jdamwu
Oryq/BoKsbmghTGuvDHTFkXJPBIKrvcQ5GOVmi5NJX3Xf2gHoesOlM3AehMwMJCC
IeJn0tBF/HxJynii+0jPDETwbfxFH/zMlx4YPjojcRqyK6SXrhBR9b/RBbNRIJPX
1ZnhOMrHOp6JPvQGvSjhc0MmQEzdU0sKgVXAGUGYqyesbtuRAOz+TDPInSZGlR/e
6ZClDpIv9n1qQbAZv9MPtDoHPjCsJKxh4/Bir3FBnCE9Vset4iu3BDCYzldNAgZu
Ci7Nc1UdDLARRTWfbXMeuFHoP9Rz9StGkXPUQirSmx/ZABtQyz6QulqaH2eWEPQ0
orEi3ksZzENyqKPh+pLTuP96xhGWC9wF+OCtWV0MGBknkulc9BZY5754sDtEGLmN
ee8yYb5TbczXGLBnpLxQzCbSWE71D0Xbe8/k0fiwC2zSJmx8wj8=
=gGQs
-----END PGP SIGNATURE-----
--=-=-=--
