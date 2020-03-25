Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7CEC54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4833206F8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="AsXsybJQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v7VLUHqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgCYPcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:32:04 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43399 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727491AbgCYPcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:32:04 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 1FC0A5C031C;
        Wed, 25 Mar 2020 11:32:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 25 Mar 2020 11:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=bn9u5SBogt3E/ylsE/CTdHc+JD6
        shpx66LJUZbSMFcw=; b=AsXsybJQfnHOui4Zb2mb/51Vdp2JF97Pt8VJrkA6M7i
        gRG7qOooyKb/Vzue6M20B0yuwmtHJpCmNZ2MyU4y7NsS4B/WKyjd6SuNtuDjvxgG
        L+voviXm5qPDPHYM2FboGHUYhZYzhpJykKxuRWF3HMIo4VGNggl6E0/QFCk8tDSa
        x0Hen17ud9BEcqwFgnqsVdJF1kUKPH57duP551BfuxJjvRhPRfVeDgFNh0Ic8y8u
        3Bcmar2igSHTgRF2eVeB/r0ONa5PJhkjOa/bzg30SOgbtq4LyfOWRi9Glmw1ACKi
        9A/eT9o9WMMMO5yeDSDZOLhcUTFA5ln6NJKrFt6ro2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=bn9u5S
        Bogt3E/ylsE/CTdHc+JD6shpx66LJUZbSMFcw=; b=v7VLUHqzSNIFVRZI2973oI
        JDiYoR4TxFP/YxzuIVKQi/jr4yIVz6zOKvNLwh+3P2wi33rdKN5cxZRtmf8nTg7q
        tu5MFGqayww0mehaNDqHzZTGEnVl1wVNQj5jL4O4C08aRboXPdz4wgrPSlJECtPB
        6kO5USbZr0zW2y7dzmJmflWmVpXMOlK0qQodN1UEw8BYHJvUtjUHxKhAsMsCnROu
        MXkr9zLqawYXDxCUiScfSjIbKJsfbyzf6/+oGndhGvnkvXBTwo1okpKAaMG3WxSZ
        RscYg/B2+NTmFv8Gm6XeIbPVf1gZfgwiKJcnYQLsOKV1OASoUn6xObyo/61aG+HQ
        ==
X-ME-Sender: <xms:cnl7XlDS54mcdvQjp9-yZqDIzjAXi0b13RjGJxdnUv2Eu8a-NWFxiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudehgedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:cnl7XqS0nY8uPGLeNf41JaJGMygZCB-TGEDEIn27HL7Fv5zVe5axew>
    <xmx:cnl7XpZOARaWlG6GzdJiH6h0x3RwC7dxuIE3LOvVb3WjSiZf1gnvFQ>
    <xmx:cnl7Xkdn8nTZayqVmyy7ND3AM7d1X1w0fsq3ebQ7HZWVh7qxoFsJBw>
    <xmx:c3l7Xhqo97uK8oJzT63UONilD8xzY8_eKGAhwWgNLmagrEj-3K0MlQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4F5843280067;
        Wed, 25 Mar 2020 11:32:02 -0400 (EDT)
Date:   Wed, 25 Mar 2020 16:32:00 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH] clk: Pass correct arguments to __clk_hw_register_gate()
Message-ID: <20200325153200.6vdgglrirhpl4yh6@gilmour.lan>
References: <20200325022257.148244-1-sboyd@kernel.org>
 <158510329289.125146.2737057581185153152@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i3tk6gopaxtqqbfj"
Content-Disposition: inline
In-Reply-To: <158510329289.125146.2737057581185153152@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i3tk6gopaxtqqbfj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 24, 2020 at 07:28:12PM -0700, Stephen Boyd wrote:
> Quoting Stephen Boyd (2020-03-24 19:22:57)
> > diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> > index 952ac035bab9..95cc8a4f6e39 100644
> > --- a/include/linux/clk-provider.h
> > +++ b/include/linux/clk-provider.h
> > @@ -539,10 +539,10 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
> >   * @clk_gate_flags: gate-specific flags for this clock
> >   * @lock: shared register lock for this clock
> >   */
> > -#define clk_hw_register_gate_parent_data(dev, name, parent_name, flags, reg,  \
> > +#define clk_hw_register_gate_parent_data(dev, name, parent_data, flags, reg,  \
> >                                        bit_idx, clk_gate_flags, lock)         \
> > -       __clk_hw_register_gate((dev), NULL, (name), (parent_name), NULL,      \
> > -                              NULL, (flags), (reg), (bit_idx),               \
> > +       __clk_hw_register_gate((dev), NULL, (name), NULL, NULL, (parent_data) \
>
> And this needs a comma after it.
>
> I'll apply this to clk-fixes and send to Linus in the next few days.

With that fix,
Tested-by: Maxime Ripard <mripard@kernel.org>

Maxime

--i3tk6gopaxtqqbfj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXnt5cAAKCRDj7w1vZxhR
xaDYAP9mtPJPssMoYYNICOo+TW6sVSKpiScbo2O4Di9iL3g+ggEA3M0Koz2MxzdS
tcLof290E1B6Vqlw963sCIvP8aNhxAI=
=usaU
-----END PGP SIGNATURE-----

--i3tk6gopaxtqqbfj--
