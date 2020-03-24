Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AC4C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36854206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585056910;
	bh=tdxlHC/Nt/JYLK2aZ5IrQP9+Kpk4VTVaNb+CHIexKwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NIn4Al69GAeD17lylfqUsJE7tfQ9EWvKowzO5Rr2nU2gKrEXpde0G4aZaAdFnsSjx
	 0WnIxIf4RlUbqUoSn9S90hwT5/uZmVblDJzHke0qWmq96ZkQYm/2dpGZ2hDiueOobR
	 3UYCoptbWKOBaL826LeL+6hEHnto1VXefBlAQnc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgCXNfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:35:09 -0400
Received: from foss.arm.com ([217.140.110.172]:35222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgCXNfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:35:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 798F91FB;
        Tue, 24 Mar 2020 06:35:08 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F16843F52E;
        Tue, 24 Mar 2020 06:35:07 -0700 (PDT)
Date:   Tue, 24 Mar 2020 13:35:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     lgirdwood@gmail.com, heiko@sntech.de, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: sound: convert rockchip spdif
 bindings to yaml
Message-ID: <20200324133506.GC7039@sirena.org.uk>
References: <20200324123155.11858-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline
In-Reply-To: <20200324123155.11858-1-jbx6244@gmail.com>
X-Cookie: I feel ... JUGULAR ...
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 24, 2020 at 01:31:53PM +0100, Johan Jonker wrote:
> Current dts files with 'spdif' nodes are manually verified.
> In order to automate this process rockchip-spdif.txt
> has to be converted to yaml.

> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> Changed V2:
>   dmas and dma-names layout

This is the second v2 you've sent of this today - it adds these but
drops Rob's ack?

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl56DIkACgkQJNaLcl1U
h9AN6Af+MtKFdLKwXOq0ZSd3pZudYzkK/o1iRhCoZguoCb361prSfHsrNxVH7UgS
NoCl9lTGtnOnD0dSRW08nP6R1Uzy6S4RUHXymuSFsbFoE807UgdMhI2SlwOkSwYF
3LqiuhploNOIFoQaW3InXfrzV1Xf5DQoC2765ifQGd/WvEMD42tBSLLWHZHtS2uU
KykRMKF9TMjBko2J1usbH41ye2j5a/ubelF180cqOOdjGD+3hZ9V7CYqcEAS8zVX
CRdNEpBGVl8EDKzzcnJAR1+cjxdUAO3bC0vtcN1HD+71ut9ZN6hc5SyMvBTL2/FU
1m9eFraFsZ2Jpr4U0N4/N/LTdSmjTw==
=I6tW
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
