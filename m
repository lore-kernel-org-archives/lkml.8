Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB53AC55181
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D5E020B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="iRucDdL2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="39HFL6dZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgDUIu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:50:58 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:51119 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726018AbgDUIu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:50:57 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id B047D5802FA;
        Tue, 21 Apr 2020 04:50:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 21 Apr 2020 04:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=kVXHl9ONWZxm/eCarGMy9NnfLaf
        sgVL03AsfObM5hQc=; b=iRucDdL2HuYht6LTO/SALHG4U3PK1SFIbulMcpbI1uy
        +PThkCsNrdnZCyAOfLX8ltOE2d0NtFXEfMjmaXqHvdvcSNIhOnl6AztA0sIKCjnf
        tWPCvZUAVCSgr6nq40urcjF9/cKStJRDT60TuVIRMeZ2nYEauEmjHQc9BmUCARif
        NBkO0lwcX0m/nekRx/hkb/9tWzCkS0QOYWiE/yzX4cMjKTRJLf53effos2Gs3ozq
        GkqefyuPFopp5I6PdjOlPjV2eChyPT0nzHqYo1VFtxKx7ZY584Wx1i0JoCkKMWrC
        B0FUCYvnrnYNp+JrU7SLnyqZiAOaA/YduMYhKrSuhVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=kVXHl9
        ONWZxm/eCarGMy9NnfLafsgVL03AsfObM5hQc=; b=39HFL6dZ8Gaf+PY9KOSHea
        9ZTTAMirPYkTZ5dVnv0se65w42OfbdhLIIgiLdpQrHAKfQZyc1glhUv3MBNRP27U
        q+fuA+fObhU36IWnOkuHyt31QGDZg79p56WT2Uw3Rmi1tsurNeLLTrmK/pcrTCGV
        4XshVegyBqN120PMNx9KwlMgH0BXE+UygOHlbMCLocH57+C1oGB8AIe8sr0oONMP
        PNoGJ1hTefvqCOLJ9ylLhO8Tv3jhUj8L+OTdM65x2uV7zBKt7EXBZC8W+RZf9dyy
        1KejlC+uSjdbui0S3jKF1jqU/MioV4UHodROWOwUK+8RjzH9SonUVlBc584mxgnA
        ==
X-ME-Sender: <xms:7rOeXocOsTB2H4XmzhdecsGgUyqsEgbagC39uF9bYhgJlhQB6LEVrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrgeehgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:7rOeXgH96sag2W05KIW3TXPdBdSkK2Id03KIXKFP2yB8hnOdIuCHtg>
    <xmx:7rOeXks20QQeggaqz8fYBsinWLclpLiuHvWBUd2P7AZn5Te6WzCVSg>
    <xmx:7rOeXoAEFXMD5f-zsCBBhlEdf4NVH6XR8W9-rvOcyrmgm9bxcHCvcA>
    <xmx:77OeXkDA144FK_yG2jaGc2pxn-3r26INx7HcQkJ-XF4mnktCgjizqA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5BEDC328005E;
        Tue, 21 Apr 2020 04:50:54 -0400 (EDT)
Date:   Tue, 21 Apr 2020 10:50:53 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Subject: Re: [PATCH v2 4/7] ASoC: sun4i-i2s: Set sign extend sample
Message-ID: <20200421085053.x2lcirwiej6sjgve@gilmour.lan>
References: <20200418224435.23672-1-peron.clem@gmail.com>
 <20200418224435.23672-5-peron.clem@gmail.com>
 <20200420124452.5vaoyw73n76jwmey@gilmour.lan>
 <CAJiuCccAFk3X03OV2MhGuqY7YW0HtM_1gJO9cW0=6OoTkSB6gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fqqhi4a56jzsency"
Content-Disposition: inline
In-Reply-To: <CAJiuCccAFk3X03OV2MhGuqY7YW0HtM_1gJO9cW0=6OoTkSB6gg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fqqhi4a56jzsency
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2020 at 02:56:31PM +0200, Cl=E9ment P=E9ron wrote:
> On Mon, 20 Apr 2020 at 14:44, Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > On Sun, Apr 19, 2020 at 12:44:32AM +0200, Cl=E9ment P=E9ron wrote:
> > > From: Marcus Cooper <codekipper@gmail.com>
> > >
> > > On the newer SoCs such as the H3 and A64 this is set by default
> > > to transfer a 0 after each sample in each slot. However the A10
> > > and A20 SoCs that this driver was developed on had a default
> > > setting where it padded the audio gain with zeros.
> > >
> > > This isn't a problem whilst we have only support for 16bit audio
> > > but with larger sample resolution rates in the pipeline then SEXT
> > > bits should be cleared so that they also pad at the LSB. Without
> > > this the audio gets distorted.
> > >
> > > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > > Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> > > ---
> > >  sound/soc/sunxi/sun4i-i2s.c | 22 ++++++++++++++++++++++
> > >  1 file changed, 22 insertions(+)
> > >
> > > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > > index a23c9f2a3f8c..618bbc5156f1 100644
> > > --- a/sound/soc/sunxi/sun4i-i2s.c
> > > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > > @@ -48,6 +48,9 @@
> > >  #define SUN4I_I2S_FMT0_FMT_I2S                               (0 << 0)
> > >
> > >  #define SUN4I_I2S_FMT1_REG           0x08
> > > +#define SUN4I_I2S_FMT1_REG_SEXT_MASK         BIT(8)
> > > +#define SUN4I_I2S_FMT1_REG_SEXT(sext)                        ((sext)=
 << 8)
> > > +
> > >  #define SUN4I_I2S_FIFO_TX_REG                0x0c
> > >  #define SUN4I_I2S_FIFO_RX_REG                0x10
> > >
> > > @@ -105,6 +108,9 @@
> > >  #define SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED                (1 << 7)
> > >  #define SUN8I_I2S_FMT0_BCLK_POLARITY_NORMAL          (0 << 7)
> > >
> > > +#define SUN8I_I2S_FMT1_REG_SEXT_MASK         GENMASK(5,4)
> > > +#define SUN8I_I2S_FMT1_REG_SEXT(sext)                        ((sext)=
 << 4)
> > > +
> > >  #define SUN8I_I2S_INT_STA_REG                0x0c
> > >  #define SUN8I_I2S_FIFO_TX_REG                0x20
> > >
> > > @@ -663,6 +669,12 @@ static int sun4i_i2s_set_soc_fmt(const struct su=
n4i_i2s *i2s,
> > >       }
> > >       regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> > >                          SUN4I_I2S_CTRL_MODE_MASK, val);
> > > +
> > > +     /* Set sign extension to pad out LSB with 0 */
> > > +     regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT1_REG,
> > > +                        SUN4I_I2S_FMT1_REG_SEXT_MASK,
> > > +                        SUN4I_I2S_FMT1_REG_SEXT(0));
> > > +
> > >       return 0;
> > >  }
> > >
> > > @@ -765,6 +777,11 @@ static int sun8i_i2s_set_soc_fmt(const struct su=
n4i_i2s *i2s,
> > >                          SUN8I_I2S_CTRL_BCLK_OUT | SUN8I_I2S_CTRL_LRC=
K_OUT,
> > >                          val);
> > >
> > > +     /* Set sign extension to pad out LSB with 0 */
> > > +     regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT1_REG,
> > > +                        SUN8I_I2S_FMT1_REG_SEXT_MASK,
> > > +                        SUN8I_I2S_FMT1_REG_SEXT(0));
> > > +
> > >       return 0;
> > >  }
> > >
> > > @@ -867,6 +884,11 @@ static int sun50i_i2s_set_soc_fmt(const struct s=
un4i_i2s *i2s,
> > >                          SUN8I_I2S_CTRL_BCLK_OUT | SUN8I_I2S_CTRL_LRC=
K_OUT,
> > >                          val);
> > >
> > > +     /* Set sign extension to pad out LSB with 0 */
> > > +     regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT1_REG,
> > > +                        SUN8I_I2S_FMT1_REG_SEXT_MASK,
> > > +                        SUN8I_I2S_FMT1_REG_SEXT(0));
> > > +
> >
> > If this is an issue only on the A10 / A20, why are you setting it up on=
 the
> > other generations too?
>=20
> To keep coherency between all set_soc_format(), and also avoid this
> kind of issue for future generation.
> As this doesn't cost much after all, and it avoid to rely on default,
> but what do you think ?

It makes sense, but it should be in the commit log ;)

Maxime

--fqqhi4a56jzsency
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXp6z7QAKCRDj7w1vZxhR
xRKPAQDKDkl/yXwfl6zP01kFEW33d7XQzfgr6caEpTneQ5fenwD/SEDIrclnDcLg
oBp79cAQbVbjsXW+AxD0wp6NpniGJAs=
=x3KU
-----END PGP SIGNATURE-----

--fqqhi4a56jzsency--
