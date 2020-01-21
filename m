Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02F1C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9144E2465B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579597575;
	bh=IP8TTw8eR6SNbEms/U3ClJl6G3JlSnBntMjeiJR+aLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B9MqVXzEFnDpBsI5ydNlFq61JiI09+VVQxAEFg6yPvdKMU25i1nsNUB+wxxOIJ+Mu
	 zDuH5eKMAnYQemh22/6wawX6V5N62xgrQbD1PtxBdCbVC6NVQbEV2+dKQv2jnFaq7S
	 +kmwyHPotVnpK6Nh3Wdy7MLpQOcsbazo+qr8Im+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgAUJGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:06:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:51048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727220AbgAUJGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:06:14 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78A8A217F4;
        Tue, 21 Jan 2020 09:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579597573;
        bh=IP8TTw8eR6SNbEms/U3ClJl6G3JlSnBntMjeiJR+aLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ulkwydaYKwH9sf+SVZaVUZfxrIobH2lusklXVx+kmgK+Kzk5JDwSZMEaSUrba1W69
         63heEO5/XmOh2pRT6cDt7Mm/Io6roY0YChYpLaWIhPlgbRMXjNjyvIN1OC1MBYb8su
         IXsv/WISN1AU7847ysZLyc/zGZD20HXf0JuMnuXo=
Date:   Tue, 21 Jan 2020 10:06:11 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 4/9] arm64: dts: allwinner: pinebook: Sort device tree
 nodes
Message-ID: <20200121090611.nnhfpudc2qlws6mi@gilmour.lan>
References: <20200119163104.13274-1-samuel@sholland.org>
 <20200119163104.13274-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kyhjvp2xlumhq76a"
Content-Disposition: inline
In-Reply-To: <20200119163104.13274-4-samuel@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kyhjvp2xlumhq76a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 19, 2020 at 10:30:59AM -0600, Samuel Holland wrote:
> The r_i2c node should come before r_rsb, and in any case should not
> separate the axp803 node from its subnodes.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied, thanks!
Maxime

--kyhjvp2xlumhq76a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXia/AwAKCRDj7w1vZxhR
xeUkAPsHyBiBu4ddK9CKV4lDlwvilSLPKPU3fxtE40NQ0dpbtQEAj3n7bHXSXtlf
0dJ+UHMRUsdK2cvMIHQjLcGzUq0ZogM=
=9Udq
-----END PGP SIGNATURE-----

--kyhjvp2xlumhq76a--
