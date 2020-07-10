Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD563C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9749A207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwyEeodt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgGJNpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgGJNpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:45:44 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80541C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:45:44 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q7so6538113ljm.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ermy1NiTIasCWgG8l4eJfsbME3tGp4LPfrJcemoGPXM=;
        b=KwyEeodt5NpEMJq67fztoSxejY3rRcicqAiurh9lc72Cg5Ikpu26p2wVaQGvfoljnj
         83gkOAzdgb2aGHuW44nzRzMIkT1efKtlsV00Iiho5AMFMAwX+mCweGEIa15yvNmTJvg7
         6UHxoilcxq+PEubjb8kD8dw6BKqzZXWcXaaevZu9o71tiU7UZPhy9qCIo9hrsIuj/F/O
         G/O0xg5oLTGXJ6UX0/u8+NKWs47dVwckSRicO+xDS6y79M6NZCuk+4EnQe9QZjnsewLq
         IsLO59TwzeXeEgJ0rLb9bf0+qihOsn9J30sTyFJJj9Nrq29gUyRIJUaJthzVBL/cl/R6
         DN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ermy1NiTIasCWgG8l4eJfsbME3tGp4LPfrJcemoGPXM=;
        b=ewwvG1GXAQG4p0SW1Ei34YRqeYp1E18+qeUnPkqFA8bXyGiFF2lPfVc89N4VorpQhL
         tP1VbbW0QimtXKgsKqSby7ElYuUOEhGl0PTun7DKn7sEeLu0AZ2ivmEevYLZ7DAd822s
         ENILYk442y8aR+Mk8EDPgQP16jqOFhcRtEONWCRLvaJFu+9K6c+PVlRU2EcjGTXB8xRz
         3fPSGxqQNiVfeyr54yD6Q76pV52S+tN9eCcnwVY2/uKUPNzfV9pbmlAm39oScelZDPFz
         f4h/g34VY8x6i2BMlxgpd4126iZMpHr/sfxjpUqlxWIIper5ObhhvUXp3I5DQ/tv9OC1
         1H2A==
X-Gm-Message-State: AOAM533172o56163vAfFAZg4heAaCh4PEIQAzp95MKqc57ezGHfOi6r6
        NmsN4TWn8rthW37/BCm53gA=
X-Google-Smtp-Source: ABdhPJzDAXSMmQbiDz211yKlpNny0wSp8Rj9t2dBvyUNJmVxp4Pqdj6NKm6Hw1sjGZOphNEUTFIUqg==
X-Received: by 2002:a2e:9996:: with SMTP id w22mr2932963lji.446.1594388742977;
        Fri, 10 Jul 2020 06:45:42 -0700 (PDT)
Received: from [127.0.0.1] (84-10-202-70.dynamic.chello.pl. [84.10.202.70])
        by smtp.gmail.com with ESMTPSA id m9sm2213915lfb.5.2020.07.10.06.45.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jul 2020 06:45:42 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v3 13/14] [DO NOT MERGE] arm64: dts: allwinner: h6: Add
 GPU OPP table
From:   Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <20200709140322.131320-14-peron.clem@gmail.com>
Date:   Fri, 10 Jul 2020 15:45:40 +0200
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0A3B73FE-0732-4024-9729-1FCE02006C27@gmail.com>
References: <20200709140322.131320-1-peron.clem@gmail.com>
 <20200709140322.131320-14-peron.clem@gmail.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Wiadomo=C5=9B=C4=87 napisana przez Cl=C3=A9ment P=C3=A9ron =
<peron.clem@gmail.com> w dniu 09.07.2020, o godz. 16:03:
>=20
> Add an Operating Performance Points table for the GPU to
> enable Dynamic Voltage & Frequency Scaling on the H6.
>=20
> The voltage range is set with minival voltage set to the target
> and the maximal voltage set to 1.2V. This allow DVFS framework to
> work properly on board with fixed regulator.
>=20
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> ---
> arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 80 ++++++++++++++++++++
> 1 file changed, 80 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi =
b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index 8f514a2169aa..a69f9e09a829 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -174,6 +174,7 @@ gpu: gpu@1800000 {
> 			clocks =3D <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
> 			clock-names =3D "core", "bus";
> 			resets =3D <&ccu RST_BUS_GPU>;
> +			operating-points-v2 =3D <&gpu_opp_table>;
> 			#cooling-cells =3D <2>;
> 			status =3D "disabled";
> 		};
> @@ -1036,4 +1037,83 @@ map0 {
> 			};
> 		};
> 	};
> +
> +	gpu_opp_table: gpu-opp-table {
> +		compatible =3D "operating-points-v2";
> +
> +		opp@216000000 {
> +			opp-hz =3D /bits/ 64 <216000000>;
> +			opp-microvolt =3D <810000 810000 1200000>;
> +		};
> +
> +		opp@264000000 {
> +			opp-hz =3D /bits/ 64 <264000000>;
> +			opp-microvolt =3D <810000 810000 1200000>;
> +		};
> +
> +		opp@312000000 {
> +			opp-hz =3D /bits/ 64 <312000000>;
> +			opp-microvolt =3D <810000 810000 1200000>;
> +		};
> +
> +		opp@336000000 {
> +			opp-hz =3D /bits/ 64 <336000000>;
> +			opp-microvolt =3D <810000 810000 1200000>;
> +		};
> +
> +		opp@360000000 {
> +			opp-hz =3D /bits/ 64 <360000000>;
> +			opp-microvolt =3D <820000 820000 1200000>;
> +		};
> +
> +		opp@384000000 {
> +			opp-hz =3D /bits/ 64 <384000000>;
> +			opp-microvolt =3D <830000 830000 1200000>;
> +		};
> +
> +		opp@408000000 {
> +			opp-hz =3D /bits/ 64 <408000000>;
> +			opp-microvolt =3D <840000 840000 1200000>;
> +		};
> +
> +		opp@420000000 {
> +			opp-hz =3D /bits/ 64 <420000000>;
> +			opp-microvolt =3D <850000 850000 1200000>;
> +		};
> +
> +		opp@432000000 {
> +			opp-hz =3D /bits/ 64 <432000000>;
> +			opp-microvolt =3D <860000 860000 1200000>;
> +		};
> +
> +		opp@456000000 {
> +			opp-hz =3D /bits/ 64 <456000000>;
> +			opp-microvolt =3D <870000 870000 1200000>;
> +		};
> +
> +		opp@504000000 {
> +			opp-hz =3D /bits/ 64 <504000000>;
> +			opp-microvolt =3D <890000 890000 1200000>;
> +		};
> +
> +		opp@540000000 {
> +			opp-hz =3D /bits/ 64 <540000000>;
> +			opp-microvolt =3D <910000 910000 1200000>;
> +		};
> +
> +		opp@576000000 {
> +			opp-hz =3D /bits/ 64 <576000000>;
> +			opp-microvolt =3D <930000 930000 1200000>;
> +		};
> +
> +		opp@624000000 {
> +			opp-hz =3D /bits/ 64 <624000000>;
> +			opp-microvolt =3D <950000 950000 1200000>;
> +		};
> +
> +		opp@756000000 {
> +			opp-hz =3D /bits/ 64 <756000000>;
> +			opp-microvolt =3D <1040000 1040000 1200000>;
> +		};
> +	};
> };

Clement,

I gave run for v3 on H6 GS1 TVbox and what i discovered:=20

1. I have frequent hard hangs if DVFS is enabled (hard reset required),

2. hangs seems to be related to operating points changing - as limiting =
OPP table to any single entry (tested on 5 highest OPP ) makes my GS1 =
stable working,

3. hang seems to be exactly related to OPP changes as having OPP table =
even with just 2 entries already gives hangs,

4. tunings with <regulator-ramp-delay> makes no difference (tested with =
0, 2500 and 25000). Also increasing <regulator-enable-ramp-delay> 2 =
times up (to 64000) makes no change.

Now I have 2 hypothesis:=20

a. issue is SW related: software operations in DVFS are somehow "unsafe" =
at touching hardware (is it possible we have i.e. concurrency issue =
here?);=20

b. issue is HW related: i.e. in steep-up OPP, time between sending =
change Vdd-gpu command to HW for increasing Vdd and sending command to =
HW for increasing GPU freq is too short.

To investigate further I done following test: limit OPP table to 4 =
entries+all 4 entries have the same Vdd.=20

If this test will pass the we know issue is b\.=20
If it will fail - then issue is a\.=20

And on my GS1 this test fails....so for me issue is a\ likely=E2=80=A6.

let me know how i can help!

br=
