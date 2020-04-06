Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4352DC2BA18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B6820672
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="DCBWd0G3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U2MrMu41"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgDFITu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 04:19:50 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46945 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726514AbgDFITt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 04:19:49 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 216F65C0185;
        Mon,  6 Apr 2020 04:19:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 06 Apr 2020 04:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=wvTAY1mSJtdwdZNb7GGd9/3Iuv4
        S6eSRHy8ZndtxRXA=; b=DCBWd0G3K+Posw3LBukUYObJE+20LKVDGdpU1Lx0f3Z
        dcRwVFJKO+/ePpuSzgdG7qFDwddkwtK9MUKFXjd1ZONrZRqEGlC7ewjOMEOW2XRE
        ASxRjLE6ORNXqtobo6VAS68z1C4Ym0urqTeuPpcMMizINRg6K7uTsi9Syx1BmFVM
        /CpWpv0nEwxEJCGB5M5PynFBK49My2n0jNyhCclbfv/pn83pripeX7u0hmruL9sC
        0WqX6MiZS6/H4WTv+tafQn1vs7PCE46+JLmbgyPBL3FuelOYMcme8IkOhrScR+12
        rS+3qUx7gUysFluSxWGDLEObCARfUfUOi7JWKjRz3Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=wvTAY1
        mSJtdwdZNb7GGd9/3Iuv4S6eSRHy8ZndtxRXA=; b=U2MrMu41nXxJKr6X9/ftsp
        5ZQTwpAdqdiGlXMa0oCHJ3nKYrk5H/L3qXzFSP9t7cSgzZXN42XTryqXUga1dLeD
        BSAYZoEKjLc1loes0xXM7+maWw2fz0g5QqP6S/3cgc7OZNw0JPm5EKYvgt+fE1Ro
        bx3Ko9d+EV/g+hW1Y2U5o3f6tGwVIpNWI0SS4ZS0l6yBrbGfsJprXlvha4/Mg+R1
        mO+BPEZXU3CQFcMV/b+fI71a6BbNmbsXXEJBMlh6xpQnsSeuVzGLlnelpASz39eg
        jcVQ9hRQZoROO3VFReeEOY4Ox4//1QKlD0vSmKwnauY7BnHzqxl5PFWBZcZtMFSA
        ==
X-ME-Sender: <xms:IOaKXp2uhVufQ5k3U3wmYk0QyRKlxDo1ziCj1Y-fQOlFIfOeHabZmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudefgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:IOaKXkUDg_9Kr4O6EwIHAtnWo1D_BU6a5RVJQrydnx1YNFkN4m1SDg>
    <xmx:IOaKXtdVpVvGkRyGh1MvZq3-fCNY986eC6nN_bqkMysdmUn5UYrsKg>
    <xmx:IOaKXl_H5HxRW_4cxBsYz2SA0L8jmObuU-X33Cg5hxe3F0xCsudGlg>
    <xmx:JOaKXlnlmyLso9lN1qP0VCETdRXBw9ChJaAT-ySNOaX5gIMpcEY5eg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0BE41328006A;
        Mon,  6 Apr 2020 04:19:43 -0400 (EDT)
Date:   Mon, 6 Apr 2020 10:19:43 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] drm/sun4i: tcon: Delete an error message in
 sun4i_tcon_init_irq()
Message-ID: <20200406081943.hwjohk63lfpgrdvf@gilmour.lan>
References: <5a6cf5a7-3f27-5425-4d6a-550a17bc51e3@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2o2zzt4r53mxdgxh"
Content-Disposition: inline
In-Reply-To: <5a6cf5a7-3f27-5425-4d6a-550a17bc51e3@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2o2zzt4r53mxdgxh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 05, 2020 at 01:53:05PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 5 Apr 2020 13:45:53 +0200
>
> The function =E2=80=9Cplatform_get_irq=E2=80=9D can log an error already.
> Thus omit a redundant message for the exception handling in the
> calling function.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied, thanks

Maxime

--2o2zzt4r53mxdgxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXormHgAKCRDj7w1vZxhR
xcHuAP0WjOHzG00wGwXrC/L73opxmCYhJn2ZOmAfjN2ZfVnbHQEArryLB/dfTFEh
yOQICYvOYcUiHRoH6LIRW07gu19BxQU=
=YqNo
-----END PGP SIGNATURE-----

--2o2zzt4r53mxdgxh--
