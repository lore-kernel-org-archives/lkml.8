Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2820C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDFCD2253D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J7JuvkDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgATSLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 13:11:54 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58057 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728093AbgATSLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 13:11:53 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 0A4A521D25;
        Mon, 20 Jan 2020 13:11:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 20 Jan 2020 13:11:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=3eLX0e
        f+TjguMEDNQ4OqQg1MbtOe1MZnC7yyN6gjokc=; b=J7JuvkDQay6+NBdblOPewo
        RfJhDS3JUf0TWtuMcX/K5jGwDS+DYQXZbSyfL7aLx3XJVHJc86kle0a0PQoWy0zb
        uRrXXyN+/XIX2kMU68B40hIjoq0pIjb3qUD6wBPFjfPgyYbgk+24BnVniW4cXVwk
        cM5+3hKCLbGB2R0Q/szbK95h6NXXBihjkAlaF6sDuSQHFkW7fIVcCyGS9wDW/ArG
        M80xbcpEbNLO81Wla/bfKr59DUUfKx36SudmTR/bX4Awzg9zi4losnWMUlxfgobV
        8v/9sSkmkqu4hGGegfoz2YYGFPSViNbJZGWRVI7OdYeNvCMBx34gHEHGIMnBT/LQ
        ==
X-ME-Sender: <xms:Zu0lXslUU6-MGtXpdNaemRY51oWdb94kEKtoBTL76xtyU7Pg50dm1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudeigdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrrhgvkhcu
    ofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomhgrrhhmrghrvghksehinhhvih
    hsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuffhomhgrihhnpehlihhnuhigfhho
    uhhnuggrthhiohhnrdhorhhgnecukfhppeeluddrieehrdefgedrfeefnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhmrghrvghksehi
    nhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:Zu0lXnoaJbkd_uCCkRJHVs_Qtq_KtTQ5GoLG4AUtHooRQGdGxzAetg>
    <xmx:Zu0lXmAbXycj-ZHg1cCg2yo_pH2uZnhA0aA3LsppuUu2sjMbEawh8g>
    <xmx:Zu0lXiElReVvpHFvWUg6rn9c3T1GOB1MGEp5OFSvKmPuSKe37bD3Ow>
    <xmx:aO0lXkT8fumM0nUUeav2lWoz3rCOwjsGNqmDoUQFvyuhGJvG4rGAGg>
Received: from mail-itl (ip5b412221.dynamic.kabel-deutschland.de [91.65.34.33])
        by mail.messagingengine.com (Postfix) with ESMTPA id A7280306099E;
        Mon, 20 Jan 2020 13:11:49 -0500 (EST)
Date:   Mon, 20 Jan 2020 19:11:46 +0100
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fbdev: wait for references go away
Message-ID: <20200120181146.GL1314@mail-itl>
References: <CGME20200120100025eucas1p21f5e2da0fd7c1fcb33cb47a97e9e645c@eucas1p2.samsung.com>
 <20200120100014.23488-1-kraxel@redhat.com>
 <d143e43b-8a38-940e-3ae5-e7b830a74bb3@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p0HNO2YbtFeVXwJ3"
Content-Disposition: inline
In-Reply-To: <d143e43b-8a38-940e-3ae5-e7b830a74bb3@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p0HNO2YbtFeVXwJ3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] fbdev: wait for references go away

On Mon, Jan 20, 2020 at 06:51:17PM +0100, Bartlomiej Zolnierkiewicz wrote:
> I guess that a problem is happening during DRM driver load while fbdev
> driver is loaded? I assume do_unregister_framebuffer() is called inside
> do_remove_conflicting_framebuffers()?

Yes, exactly. More details here:
https://lists.linuxfoundation.org/pipermail/virtualization/2020-January/045=
026.html

> At first glance it seems to be an user-space issue as it should not be
> holding references on /dev/fb0 while DRM driver is being loaded.

How plymouth would know when exactly it needs to release /dev/fb0?

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--p0HNO2YbtFeVXwJ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAl4l7WIACgkQ24/THMrX
1ywYwQgAimDeFDny3c/ar866L78Bc5TRyJynEGGbFlnb9BR/gCc9gpS1tNCyemPC
keqTV3PxXHMFaTPnrJi2ebuUP+Lmj/YOK+tCXB8+ipwMs3Z1HZv1DR7D4s3gDDzk
To8b4e0RnxpCdQJ4xpOoWL+XcueHy+RB8FtEXqXyVJTW/bJWGYGnuyQVSubBKQxL
TyEp6ASDocGLFX0QsSrdVEkuVF/PMdfbyu6Th9MwQMtMmd0s2BuepAfJhDP3js1f
JlMnL3N1wscxFOWn1TSAGywTMbAjwRctGwrCcULMDME2STVryuH0VNWpapKIMQpj
PUlDFH5CMVOKGjXo2OkywONz4gP7kQ==
=2hqv
-----END PGP SIGNATURE-----

--p0HNO2YbtFeVXwJ3--
