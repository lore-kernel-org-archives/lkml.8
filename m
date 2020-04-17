Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9559C2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 05:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7A22221F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 05:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpUvL2Yu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgDQF7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 01:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726065AbgDQF7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 01:59:52 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C40DC061A0C;
        Thu, 16 Apr 2020 22:59:52 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id u10so825524lfo.8;
        Thu, 16 Apr 2020 22:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:date:references
         :to:in-reply-to:message-id;
        bh=KCPHum5NfriSROGpDRagY9arwqzGeCJ9Uy+nSz5Dbdc=;
        b=MpUvL2YuibSpJZaVDnKEidiTlm12+7C3IICF/DGMVymDcthklvavDzR4qLWBc5/AiQ
         LzQ6n82JAvdDE4x0Y0VHjZR8Q9R6fHgG4NmVFcNstmSjg/4fd8uZkVp0Ws+TogUnDemI
         KPu86DCU1sJ6qurFzBKyzEAocXBtgTIC7rdcBXhLcY+1IlGADeDPGcbMTSAv/tKDoHoq
         uKjlN1G6GwdEjh3rvN5BNXLUMaFnHFgJ+1/xBlo4WOoTnpYy860a/eBE3pC3ZD0CGVnV
         OSDjmijdX+nlYz5o9chHIAzSm8ou3CgTuft1M/q2FXXvu/cuf88J6eowvYGce7wufYEV
         AJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:references:to:in-reply-to:message-id;
        bh=KCPHum5NfriSROGpDRagY9arwqzGeCJ9Uy+nSz5Dbdc=;
        b=uV71KkaQciDUfLZoZNYyLK2BzlWstoPFTrr0TwfRgqbAxBTgsBAcf3ah8Quv0TC7z4
         rN34FR+iJb+7dos3w+Br8FO4LYa59od9flI2eAATKc+iYRCWr0q/wCqcI/3Ii0PK0W9V
         aRr/acJ/B9leaDSZIf1vLGANlEn8FFHGqli5ajelAiyr6F0TQ0kK6erDTMhWv9CaeKdu
         hkSaZ6plUdaFGUI3N7jZuhPjM32kgVXLR/1cou/7TDjLeHJCHIoaYHSf0Skf7HYDZeOb
         qO625foP7sV8TBvSfEbasTFRQX9+32LAEFdEW9aMD4S4JyKwgGTgsszcob513E3+N80s
         USFw==
X-Gm-Message-State: AGi0PuYuXcflCFwK9D5zSu0KeXLfhyXEpPBrxdHExhqEvNGEjWiuSXQW
        RoOXEAxp6ZTCKL1Dfdt6Z3DS8nJA
X-Google-Smtp-Source: APiQypI3qukQ4tZM9Ts9XozSXmQmnYwjcbblor1p9+Yx3fV/8PNw7LNqEB1j/HGIrOAooq+lva/v3w==
X-Received: by 2002:ac2:4213:: with SMTP id y19mr866623lfh.99.1587103190526;
        Thu, 16 Apr 2020 22:59:50 -0700 (PDT)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id c22sm15226427ljh.66.2020.04.16.22.59.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2020 22:59:49 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH] arm64: dts: meson-g12b-khadas-vim3: fix missing frddr_a
 node
Date:   Fri, 17 Apr 2020 09:59:45 +0400
References: <20200415095927.3780-1-christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200415095927.3780-1-christianshewitt@gmail.com>
Message-Id: <AA7AFC1F-AB6E-438D-8510-BC472552C554@gmail.com>
X-Mailer: Apple Mail (2.3445.104.14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 15 Apr 2020, at 1:59 pm, chewitt <christianshewitt@gmail.com> =
wrote:
>=20
> From: Christian Hewitt <christianshewitt@gmail.com>
>=20
> The frddr_a node was accidently deleted when creating a common dtsi =
for the
> Khadas VIM3/VIM3L boards, preventing audio from working on the VIM3.
>=20
> Fixes: 4f26cc1c96c9 ("arm64: dts: khadas-vim3: move common nodes into =
meson-khadas-vim3.dtsi")
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
> arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi | 4 ++++
> 1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi =
b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
> index c33e85fbdaba..c6c8caed8327 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
> @@ -154,6 +154,10 @@
> 	clock-latency =3D <50000>;
> };
>=20
> +&frddr_a {
> +	status =3D "okay";
> +};
> +
> &frddr_b {
> 	status =3D "okay";
> };
> --=20
> 2.17.1

NB: I appears the same change was sent by Neil in [1] as a fix to 5.4, =
but
this appears to have been dropped/missed somewhere.

[1] https://patchwork.kernel.org/patch/11198535/

