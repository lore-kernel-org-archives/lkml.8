Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AA3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C531D20772
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="gGxoGVWl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U/9yUmpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgFEJ2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 05:28:09 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:48019 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726177AbgFEJ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 05:28:08 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 16D90993;
        Fri,  5 Jun 2020 05:28:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 05 Jun 2020 05:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=u
        ayn6jo7ImJYjdlSiOadfkn6my1yynKqoqutqre9njM=; b=gGxoGVWl0d10b8/67
        usbzFBkOj/G/QK+zNYA8TYPV7Z2PlS/qBKPwwFa2/nrW0WV8N+/kNGjuuZbglrj6
        zIoAdkeLWWhiFlp++ritI5YhEU0MQs8LLW5ePiFzmpblMDmFbz1ZEvoYS4HoAJ3N
        GJFHMnj5EFp4DeXfRt6HIxVmbtvjw+hThVbSOlQKvL67WjtAJuiHpl9VCbty1wTr
        MOAAJ+VIFBnb6As+0/1lVGOZAD0BCVp2rE7dTWIfM0HhkBP5iG5anh0zVr1vDVcZ
        9y8o+5XXYbWuTCTOpSl/HkJbd7JYqUKkU4i5VKhJKSZOEnzzjmFNHJlsSL205myh
        1JPWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=uayn6jo7ImJYjdlSiOadfkn6my1yynKqoqutqre9n
        jM=; b=U/9yUmptNwqwVmCPjAst3HBHXETZDP+uL5Yev9vm1VxuyBioL7R6diOSo
        hXw6RAy3nC8s22mUIHdM3FRKJWAPLNHeXpkZtLBSYO8N/2UtQ3dccKkTCya4YD8U
        cx0MJELjtLOXKNMQMTm5JkN5xL0AZ4IJN8dmpWOE4sPNuv4aNGjIEnSoAcjqMwSO
        xOZTgYxhOcKKrRI21+ptmF84vCSNnHCC4Ia4ZJIZ/LAWSDiNVszJOBm5SnWTWoNK
        Ccyt5wDA6l/ZkjcrFacbXEScIkaaDEt/UEXxEOd2eZTY2RWQQoi8iBEZcaXO/+Wh
        pc6b6+UHJAw6kdFQ8+gxEjRfkOycA==
X-ME-Sender: <xms:JRDaXuAKr8Ogo62ytZyauPnyo69Vi6jiywu5itziUN7DylK7Fe3iSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudegfedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpefgjeettdejgffgffdvteeutdehtdehgeehueetkeefgefhtdetjeekledu
    gedvudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:JRDaXoj9wiOQt19b5WF0PoAAJsnbvZF3pYYJaNYdTm-s0tlV-n-SdQ>
    <xmx:JRDaXhl7jgqAoNciri9gqOlxTeU7z2xy-u2O-A5HJc0ocvRLHhExjw>
    <xmx:JRDaXsxLMu_khGHBGXF7Ko-GqovTsduIsjrc4vPb4OWwG8Twcq0t2w>
    <xmx:JhDaXhNPxAZUb-c7SZMCVJA_hjJP7qkcdLVl3F8rJugAU1-hFvDTmA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 351523280060;
        Fri,  5 Jun 2020 05:28:05 -0400 (EDT)
Date:   Fri, 5 Jun 2020 11:28:02 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH v3 12/25] clk: bcm: rpi: Use CCF boundaries instead of
 rolling our own
Message-ID: <20200605092802.xkoazjnin7xyqkoy@gilmour.lan>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
 <eb1b2838f1c3c006c24bcb9816f75e1351c63b05.1590594293.git-series.maxime@cerno.tech>
 <e096d89ab881d69b2477b209838a308f9de114b1.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e096d89ab881d69b2477b209838a308f9de114b1.camel@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On Thu, Jun 04, 2020 at 08:02:22PM +0200, Nicolas Saenz Julienne wrote:
> On Wed, 2020-05-27 at 17:45 +0200, Maxime Ripard wrote:
> > The raspberrypi firmware clock driver has a min_rate / max_rate clampin=
g by
> > storing the info it needs in a private structure.
> >=20
> > However, the CCF already provides such a facility, so we can switch to =
it
> > to remove the boilerplate.
> >=20
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > ---
> >  drivers/clk/bcm/clk-raspberrypi.c | 18 ++++++++----------
> >  1 file changed, 8 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-
> > raspberrypi.c
> > index a20492fade6a..e135ad28d38d 100644
> > --- a/drivers/clk/bcm/clk-raspberrypi.c
> > +++ b/drivers/clk/bcm/clk-raspberrypi.c
> > @@ -36,9 +36,6 @@ struct raspberrypi_clk {
> >  	struct rpi_firmware *firmware;
> >  	struct platform_device *cpufreq;
> > =20
> > -	unsigned long min_rate;
> > -	unsigned long max_rate;
> > -
> >  	struct clk_hw pllb;
> >  };
> > =20
> > @@ -142,13 +139,11 @@ static int raspberrypi_fw_pll_set_rate(struct clk=
_hw
> > *hw, unsigned long rate,
> >  static int raspberrypi_pll_determine_rate(struct clk_hw *hw,
> >  					  struct clk_rate_request *req)
> >  {
> > -	struct raspberrypi_clk *rpi =3D container_of(hw, struct raspberrypi_c=
lk,
> > -						   pllb);
> >  	u64 div, final_rate;
> >  	u32 ndiv, fdiv;
> > =20
> >  	/* We can't use req->rate directly as it would overflow */
> > -	final_rate =3D clamp(req->rate, rpi->min_rate, rpi->max_rate);
> > +	final_rate =3D clamp(req->rate, req->min_rate, req->max_rate);
> > =20
> >  	div =3D (u64)final_rate << A2W_PLL_FRAC_BITS;
> >  	do_div(div, req->best_parent_rate);
> > @@ -215,12 +210,15 @@ static int raspberrypi_register_pllb(struct
> > raspberrypi_clk *rpi)
> >  	dev_info(rpi->dev, "CPU frequency range: min %u, max %u\n",
> >  		 min_rate, max_rate);
> > =20
> > -	rpi->min_rate =3D min_rate * RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
> > -	rpi->max_rate =3D max_rate * RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
> > -
> >  	rpi->pllb.init =3D &init;
> > =20
> > -	return devm_clk_hw_register(rpi->dev, &rpi->pllb);
> > +	ret =3D devm_clk_hw_register(rpi->dev, &rpi->pllb);
> > +	if (!ret)
> > +		clk_hw_set_rate_range(&rpi->pllb,
> > +				      min_rate * RPI_FIRMWARE_PLLB_ARM_DIV_RATE,
> > +				      max_rate *
> > RPI_FIRMWARE_PLLB_ARM_DIV_RATE);
>=20
> Isn't there a potential race here? Albeit unlikely, cpufreq could show
> up and call clk_round_rate() in between the registration and you
> setting the ranges.

IIRC, driver's probe are not called in parallel but in sequence, so we
should be covered here.

Maxime
