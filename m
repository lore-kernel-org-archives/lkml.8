Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD77C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0DC82078C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="JGrN7IAR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MqguM69H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgGHIMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 04:12:06 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:56827 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726509AbgGHIMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:12:05 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8418F5801C9;
        Wed,  8 Jul 2020 04:12:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 04:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=G
        qh11UiG2+F/LHFxJpAOq5p7jpOlo0S6qUWZwnjh2/w=; b=JGrN7IARgfhBh+TYe
        spWxXGNdUcQDnVFdKyixl0fYvvH6xJE2djLhIpQoI3PaOR96xHYEKB9y7LWGuKQZ
        Wm7zqMOzf1+BMhTlzcE8XzeqGCEi+bK2b5nvOAfZL2xf+XXOv/fjw9c/pEKnzU87
        Op3zoBhLVrjR/2z3QbtXmmTP0AarXrW6b6w+MtwK4136yhs5Fme0addu/Z1mrQHT
        n0aCEWQxQnTxSwt7tQYfIooNx7qUGcB6BHJlapo40cTwRBEg2gIQK0mkzg+NSnoe
        lREucFh5AqjnYTuwk+vvfKGSt2Yz7TAiCOwGbdeuIKvzCiQVFduGlitQK1NABuv2
        o3sPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=Gqh11UiG2+F/LHFxJpAOq5p7jpOlo0S6qUWZwnjh2
        /w=; b=MqguM69HgwVhZ2LfdsU7p7gkgcYkwfx88zlEIjsnKU1qg+cYe812la7Dx
        9twClAB2Busn1YMK0XKL4KD0JUtkKln/PI6eKSdQQ5UI5CjlTqbaPDFG7Qn7pk8E
        nNBz3m03oYpmTN1jnGjnU/MvuwxHUgqRw0q0w3mmTyNz843v4eLp2yXnzyGxtyQK
        9mgu9SgHm/rNFPHnntSSVfI3iCo6cKnEzLdMx61KSp/77PjPBbr6657WZfLx0fqS
        bMuu/78tX+ccfUhyPz0CToWvlvmisfj6Rab/q2KHvOWcDU1n4iJYbmHdODifc9fQ
        cEbTIxzGqobWsI9uIzxCQ00CWiDpg==
X-ME-Sender: <xms:1H8FX_XqiUxkF3w1npvl2KiPBXj_eaKnhwZ_mjecBfLsUOe3224xZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepgfejtedtjefggfffvdetuedthedtheegheeuteekfeeghfdtteejkeeludeg
    vddunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:1H8FX3lEo9eAqzU90yHPSuQe4UhMoT9p6vjKrmqEilWV40AMB0dPiw>
    <xmx:1H8FX7Y19YTvZboPsu2qS3uYAV8aeE8lKAIIuU422hAJDAIOBgcURg>
    <xmx:1H8FX6XOVIfmPPzegoT0O_H9vMmmY1OaseE7zQIM6Y6nffXklZAgCw>
    <xmx:1H8FX_fXVuG5vBqH6T10VjYO0mtGtSNT19lkLwDCkTl7oHQPWmmi4Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B7227328005D;
        Wed,  8 Jul 2020 04:12:03 -0400 (EDT)
Date:   Wed, 8 Jul 2020 10:12:02 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 03/10] ASoC: sunxi: sun4i-spdif: fix kernel-doc
Message-ID: <20200708081202.2dlhr7unkdqma2gg@gilmour.lan>
References: <20200707191615.98296-1-pierre-louis.bossart@linux.intel.com>
 <20200707191615.98296-4-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200707191615.98296-4-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 02:16:08PM -0500, Pierre-Louis Bossart wrote:
> Fix W=3D1 warning - typo in field description
>=20
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
