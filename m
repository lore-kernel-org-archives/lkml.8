Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5334C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A96720775
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="lp6zVlpE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cdKcxH1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgD3PGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:06:39 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:58791 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726377AbgD3PGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:06:39 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id B54D7246;
        Thu, 30 Apr 2020 11:06:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 30 Apr 2020 11:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=xeYUSzizreuaYphksMpyWqjTJec
        L7d9Xwl6zIofVoEY=; b=lp6zVlpE3eoz9SYKA88UDswb1xxapdzJZmAnRgUG5B1
        PYJWbMW5muAIoBqCDokmHux9qoVl13bmpqtZvbVe5WAGOLC7KLkDXQ8b+9K8N6Zq
        YuRGY45RCjxVIo9tzDcBbH6+eRF7vXAP7RLVEovJbaHHi/pBq+qpZDXccqinetAd
        CZybS1xl/9CrDHjVInsjsiNsIZgKoQ5xbao9SOarTD30zYK1qSQnvKJjvUMH2qMy
        xb6X8/GIhO/pDOAmxjttdpjc924CoTFLx9JVSAQt9OsjhwwXDEYMWoX2QLktfoDG
        H+52AxC3+A/Rb0r4JUKrQjIrzCITyeOH8GRT9PFvnOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=xeYUSz
        izreuaYphksMpyWqjTJecL7d9Xwl6zIofVoEY=; b=cdKcxH1KGK98bzRIMgetPN
        9F7B9olUs9M9ZUZ6XH7yhU4EDCUO4WjtPT/6Evz/XcE6d2kMX0FHq9iB3dmoOB3X
        rPDn9gCh4C+MXDKCb0OyEV5JpF6jDLjJSCUCPbqI/ww9N+hUz7EDYOxklg3KvjR7
        XOXuJMEfy2ArCaFQXv8X07mPJnDdLsjbZE0N1mTZKhVwpGh1OzgxOZeKSYyxdBPg
        ggdvAeHHiwlZLfPEp004MN1V61630DNqwjhN5m2GwFnAa66xeo5J1wdzuf0DJfiw
        xAN/a2Roe+jWakXfRzQdAeX2BX13Bp1vCaSEzVDMpBjuFiiWVDDdlPJT3Mj11uoA
        ==
X-ME-Sender: <xms:e-mqXsban-fsGmkv5_OhAW_tF5_eLXapM9rgiwvbgI4ojK_wjPIVoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrieehgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddunecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghr
    nhhordhtvggthheqnecuggftrfgrthhtvghrnhepuddvudfhkeekhefgffetffelgffftd
    ehffduffegveetffehueeivddvjedvgfevnecukfhppeeltddrkeelrdeikedrjeeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimh
    gvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:e-mqXjBBR52nqK-zxgR-1G7jCWx1ArBxPPA07WEBQtCRUk7rw1qOmA>
    <xmx:e-mqXhZYCk94Sn5hdWvk4fJ7zLqLNmFG_uVpFogL-HDnXScXLrnfqw>
    <xmx:e-mqXkheQp4_GXv_UiRlLyI0XQLkF4nByEM-SdbnmpZRnyEVyPxp5Q>
    <xmx:femqXk1-IUJsjrcJbbO5ZJS4U14XdbWE1aZ4ofeIHpMxtmontqDhB3tsy4k>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9CBF73065F35;
        Thu, 30 Apr 2020 11:06:35 -0400 (EDT)
Date:   Thu, 30 Apr 2020 17:06:34 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Emmanuel Vadot <manu@freebsd.org>
Cc:     maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        airlied@linux.ie, daniel@ffwll.ch, matthew.d.roper@intel.com,
        noralf@tronnes.org, kraxel@redhat.com, tglx@linutronix.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND 2/2] drm/format_helper: Dual licence the header in GPL-2
 and MIT
Message-ID: <20200430150634.42zna3xwhj4cwsnd@gilmour.lan>
References: <20200430145537.31474-1-manu@FreeBSD.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hbb2lqbyfl32a4jv"
Content-Disposition: inline
In-Reply-To: <20200430145537.31474-1-manu@FreeBSD.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hbb2lqbyfl32a4jv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2020 at 04:55:37PM +0200, Emmanuel Vadot wrote:
> Source file was dual licenced but the header was omitted, fix that.
> Contributors for this file are:
> Noralf Tr=F8nnes <noralf@tronnes.org>
> Gerd Hoffmann <kraxel@redhat.com>
> Thomas Gleixner <tglx@linutronix.de>
>=20
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Noralf Tr=F8nnes <noralf@tronnes.org>
> Signed-off-by: Emmanuel Vadot <manu@FreeBSD.org>
> ---
>  include/drm/drm_format_helper.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_hel=
per.h
> index ac220aa1a245..7c5d4ffb2af2 100644
> --- a/include/drm/drm_format_helper.h
> +++ b/include/drm/drm_format_helper.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* SPDX-License-Identifier: GPL-2.0 or MIT */

You changed the GPL license there, was that intentional?

Maxime

--hbb2lqbyfl32a4jv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXqrpegAKCRDj7w1vZxhR
xVnGAP9cMyJIv4AkRNCKjdSzj/K4g5e8uw/jvdXScgB+ctQFaAD+K463Hxv77qvo
2lLF+91XcxMo/HIXjZAkKeW4uI9Udw4=
=Cwsu
-----END PGP SIGNATURE-----

--hbb2lqbyfl32a4jv--
