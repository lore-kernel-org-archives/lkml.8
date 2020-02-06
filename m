Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E06C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3570E21741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580989776;
	bh=aeh2bnGaIQasagmj+LRJPLVBSVmtzVWOfHGUZwOPl9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CL8mbKblDkSaT8L5sYrMW1zs5iz33oG56DApFskMILah3VrjxrIWRK+86c4TPuq0t
	 +CcjyamPT54fQzs4udIUAv7vjBLEtB81ualx7ykD+Dz/eJOo+IWLseF8zWTfSZ+JC6
	 YxqABCYRoi58/esNGia1ZNJOsHwKnOR1vL1N1Xdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgBFLtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 06:49:35 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59312 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgBFLtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 06:49:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aeh2bnGaIQasagmj+LRJPLVBSVmtzVWOfHGUZwOPl9k=; b=uzMAt5emOT/DsoAgMGDNx0ij9
        tuZOOxrxBl7YfrZ7Noe82a9tTttXG8/pzRK1mI8sousbwvv2GX0Bmkb2gfV7Ua9/Zljmiej4jNAIX
        DeFeYfFPWNLFNZuMalqtWdpZ0c+4KKrajxqsP+hHOyg0uMxoOe8gQS3kp4sjLgGUCTxcE=;
Received: from fw-tnat-cam3.arm.com ([217.140.106.51] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1izfey-0001aU-5A; Thu, 06 Feb 2020 11:49:28 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id D10C3D01D7F; Thu,  6 Feb 2020 11:49:27 +0000 (GMT)
Date:   Thu, 6 Feb 2020 11:49:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Wen Su <Wen.Su@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v2 1/4] dt-bindings: regulator: Add document for MT6359
 regulator
Message-ID: <20200206114927.GN3897@sirena.org.uk>
References: <1580958411-2478-1-git-send-email-Wen.Su@mediatek.com>
 <1580958411-2478-2-git-send-email-Wen.Su@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WW66Wv25qHMoYYLs"
Content-Disposition: inline
In-Reply-To: <1580958411-2478-2-git-send-email-Wen.Su@mediatek.com>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WW66Wv25qHMoYYLs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 06, 2020 at 11:06:48AM +0800, Wen Su wrote:

> +Required properties:
> +- compatible: "mediatek,mt6359-regulator"

Why does this need a compatible string - it looks like it's just
encoding the way Linux splits devices up into the DT, not
providing some reusable IP block.

--WW66Wv25qHMoYYLs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl47/UcACgkQJNaLcl1U
h9AGqAf/ei5s8WFL5nFhQ5WtOwQKyMl6BzjPHZGCXguSsSzU+Bs45Cq1viLBg3ww
H/gXJ2VJxUuY4EU3kr3iP6Haxhe/h9TGEobGG917mADI9ZBScIkY6l7AGQPe44mQ
oCiBKl73LxwZtRu8DNFg7k1W13eAOKi0TLwQ0KaC4GalJ1loAnttpbgxUvBLVR02
BxiROqhvkQsNI1q+oh1Dnyvd0rFFT12QXDIgw0sbR6DEVkEvHFnvB9C720P5L9ld
4iFDo6hOqqSwZIecmI3G36JIpFEY3vE+f2plbZCRaf01Fd91TZPZX0YQlBSr4Qbk
uJ85eR2wboqLgi77IS+mzYNgxwg5vw==
=vTbL
-----END PGP SIGNATURE-----

--WW66Wv25qHMoYYLs--
