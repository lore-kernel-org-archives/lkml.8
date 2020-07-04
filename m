Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17E0C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 12:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8470D20885
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 12:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="PpetsJeH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K86n12m4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgGDMNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 08:13:09 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:44023 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726667AbgGDMNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 08:13:09 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id A9596580104;
        Sat,  4 Jul 2020 08:13:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 04 Jul 2020 08:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=5
        jhvqkvkWhZxXjs3LP2HbP7ewUguP0t5n9H4pdg7EEA=; b=PpetsJeHoadsGu6Jj
        BmST2pSe4zZS/Nj/P8dF0gKTugy+G5TQ5MSPNYh7F2fsvy7cbSV2/+Iwobqk2J34
        ksd2bfIwO+3mkpnVwgivxXM9nwGoUnSue4ftrQwJwXPpmpXtPfakcXnl/Wx9Lr16
        xmfOLiunn1zktpFrlrrja+xCUi4nJDLKzhQLeMMier2oXarnb8kOmtSqbN3SnQeE
        XXqTFlp+oak/LAaf+aCJWru2GMYwPTl3mbcCtLwFvBe4Yu+mv0OdC37pk7MdmaI0
        i+n9uAm/G8ASKmikG0w853huvbHASV+uJb9mff9+yuByPKEH+E1ZintiNFL6JUbY
        68VdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=5jhvqkvkWhZxXjs3LP2HbP7ewUguP0t5n9H4pdg7E
        EA=; b=K86n12m4TIAime46SbpINUp1l6NwhRZ+mYkwgohG6pgLg8XcwbvW7WQlQ
        XLYm0ni6lnqzwhvB+k5YUDiXAGfKvRYsET27C57TJcOhBOji74jSuDgDgorQpibM
        DM+XDcgP9hKwWX7WcdaofMk6UZW9/w4ZHUsSWB+4QIzOzdswL1f2Oj1K0rVlsKNL
        9c9O9SXb2JBL2Ym+CCZmltFTAt07qtnxs0EEsnyx8E3kpcMaAOC7G7UnK8P0ZI91
        MVGkyFFaZlwNmVlzUdAHvDruQtQhwq97f4ddSqPG6b1dtTkQJ+apoAbgPzAcUeWj
        4At4BhLSFuh5nXK2g7tbLV4Vimpbg==
X-ME-Sender: <xms:T3IAX4hYNof4x65X1niLLXF0VHSMcNupI5NkaKvMUJZ4rL2oqCTUnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrtdekgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtqhertddttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepheelvdfhkeelgfevleekleduvefftefhudekvdffhffhgeefuefgheegfeej
    vedtnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:T3IAXxD-AzvifBdTZe2qr3y4R3wo_4PdgB5foYqx4sL4VCpE0LkQRg>
    <xmx:T3IAXwHlFcWKE_QLLHBNqFqiiduLJOF74uZsRlKBbI4ES1Z3cBhygg>
    <xmx:T3IAX5TT4NUZtJfvTgmyj3hv-j3rOQoTZeYcQVw5E_fOXEspgoFfKw>
    <xmx:UHIAX0wsqRW7BjnpCZVFvK7KmxeVyOA5_Kadml5wIfmUtW6m0L5tTA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9FDDB328005E;
        Sat,  4 Jul 2020 08:13:03 -0400 (EDT)
Date:   Sat, 4 Jul 2020 14:13:01 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/14] [DO NOT MERGE] arm64: dts: allwinner: h6: Add
 GPU OPP table
Message-ID: <20200704121301.jfd3m3jnlghmddg4@gilmour.lan>
References: <20200704102535.189647-1-peron.clem@gmail.com>
 <20200704102535.189647-14-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200704102535.189647-14-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jul 04, 2020 at 12:25:34PM +0200, Cl=E9ment P=E9ron wrote:
> Add an Operating Performance Points table for the GPU to
> enable Dynamic Voltage & Frequency Scaling on the H6.
>=20
> The voltage range is set with minival voltage set to the target
> and the maximal voltage set to 1.2V. This allow DVFS framework to
> work properly on board with fixed regulator.
>=20
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

That patch seems reasonable, why shouldn't we merge it?

> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 80 ++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/bo=
ot/dts/allwinner/sun50i-h6.dtsi
> index 8f514a2169aa..a69f9e09a829 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -174,6 +174,7 @@ gpu: gpu@1800000 {
>  			clocks =3D <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
>  			clock-names =3D "core", "bus";
>  			resets =3D <&ccu RST_BUS_GPU>;
> +			operating-points-v2 =3D <&gpu_opp_table>;
>  			#cooling-cells =3D <2>;
>  			status =3D "disabled";
>  		};
> @@ -1036,4 +1037,83 @@ map0 {
>  			};
>  		};
>  	};
> +
> +	gpu_opp_table: gpu-opp-table {
> +		compatible =3D "operating-points-v2";
> +
> +		opp@216000000 {
> +			opp-hz =3D /bits/ 64 <216000000>;
> +			opp-microvolt =3D <810000 810000 1200000>;
> +		};

All those nodes will create DTC warnings though.

Maxime
