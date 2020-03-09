Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F34C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E3B20674
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="rhP8IqmZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MalW71/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCIJ6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 05:58:17 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:40091 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725796AbgCIJ6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 05:58:16 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id BA7F52616;
        Mon,  9 Mar 2020 05:58:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 09 Mar 2020 05:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=x843TymkohDL0CNnlBbHCXKt7Ii
        gsbMrdZT6H6SSLmM=; b=rhP8IqmZ+jnmVnsMHlCOIX+LbZ63kU8RwEc3J0svGNY
        6l8keSJodZj1KEAzWpHFBUVsnNW/4Hoc5BNgfSJx1dlqwpUOnP6llj1JLVytgp8n
        G1VcpWl/HmiI62RepxfoKu4dquSqAHs+Yz2NPjR98pBIxB6DvTh0Oe7zzXa4V2io
        bzkne9Fd1SjR1ug31fLXuWQM62HVBP5MBI0uuZDcCSzNA9ForGP2B3w+r3lSMXGc
        Uaml2qVaTO/vYNR1e5lJAGzgiN6rewod4YdnLGuTyoNiwxk4k/H9Sd1Ox4uG0vX7
        8GALFXpaZxngop8xIjwSQ+ObinvCPW7UGMToYY+QvEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=x843Ty
        mkohDL0CNnlBbHCXKt7IigsbMrdZT6H6SSLmM=; b=MalW71/b0+98hpXSkEDGTd
        vItpnoXZ67gxttvgn8L//69iT2ScZYAkAXmTTi686fLpmjy6KIfpyTygbxyjv2gu
        NHiCm6ALZHS2jrMN4UW0bUHTyOJB4wgSaiuosEQwG3fqjuFm8t6MeuFNiPQbtBov
        H28FF+AvM84P6KVV/DHjHXvXL300JIBQWkkTqg4qxh7Nv8b9Oqhc4qaygrsNWMBe
        Yjr7emvKu9pF2YVO/Cf1pnTTr/WCYh/BplhCbQIgkVvWzJWyws+sPlDOVkQ8mUD5
        zRvHUEB5Efx+n/zMaqbn+U2GTLEJMZDUFhMIZcC8TL+lDH+hKe/OC2IfF60iJJUg
        ==
X-ME-Sender: <xms:NRNmXpJ642poT0Dt5Kmbum1UY08WvQ2u-9noaK5LPgiEhXZ_Q_8JcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddukedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:NRNmXvJKMpM5sDIjsIbInMlrLqbf8VAmWT6jQzFtiXrlhS7-654RDg>
    <xmx:NRNmXrxTqXFf5uSjuEE01s01PFt-cmZKHMZHD60E7njKY7Tmp-clFA>
    <xmx:NRNmXsJk5dlb4qXdDhwjsS0WwflSz1y6CIusJe9p-qL30nODKfJnfw>
    <xmx:NhNmXjlWHrL3bFOKqIfhkg4kI_jidnrmXT-SZ4RyTgi6r-VKZPseCg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0A780328005D;
        Mon,  9 Mar 2020 05:58:12 -0400 (EDT)
Date:   Mon, 9 Mar 2020 10:58:11 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vigneshr@ti.com, miquel.raynal@bootlin.com, han.xu@nxp.com,
        richard@nod.at, wens@csie.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vkoul@kernel.org
Subject: Re: [PATCH 4/7] mtd: rawnand: sunxi: Use dma_request_chan() instead
 dma_request_slave_channel()
Message-ID: <20200309095811.hg4maq663eaj3opz@gilmour.lan>
References: <20200227123749.24064-1-peter.ujfalusi@ti.com>
 <20200227123749.24064-5-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ghgfzfwbprbf3thj"
Content-Disposition: inline
In-Reply-To: <20200227123749.24064-5-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ghgfzfwbprbf3thj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2020 at 02:37:46PM +0200, Peter Ujfalusi wrote:
> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
> eating up the error code.
>
> By using dma_request_chan() directly the driver can support deferred
> probing against DMA.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--ghgfzfwbprbf3thj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXmYTMwAKCRDj7w1vZxhR
xUqpAP9DxNAJ2AawCZ9Jr/Mw8AxjK5nNtLKe6A6jtOsi8iEfGAD/ScHhr9eJJULD
Ty0cjoA0+ExrVGQk6FoSzvrsIHJ3BwE=
=BoAI
-----END PGP SIGNATURE-----

--ghgfzfwbprbf3thj--
