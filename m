Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EE4C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC6B24125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579597458;
	bh=+BntHW10VsAMTpAdnvWUfyBS2EH5yEdLzbKT5WRytaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yQR6247s3ZLRTLJZMIKpMmedLXUPZYJer1cadGkV5j8KKj9NdWzD7xMcgJDoiQDXW
	 BJu5pghboggDk5WJzq03u3Dyxv7wq9LiaWjMe3J0pd2YJAFkQ5EJ1as7pEoTXp7bk+
	 E98If8nM39LvWKcViqjLXM+bO2rBLN8pFT7iU11I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgAUJER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:04:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:42364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgAUJER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:04:17 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4776C217F4;
        Tue, 21 Jan 2020 09:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579597456;
        bh=+BntHW10VsAMTpAdnvWUfyBS2EH5yEdLzbKT5WRytaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MojKFViHCrandnedO2lPerv2S8a1/RSvUPdIuulKCKBcCJJvNTdaYyFEi4Xky0BcM
         chvbhnQ7E9OSIb36CD65VrcVqxaFGYYZR1b0wTFWTV6VqZSYa4tm/1SMNd1mOy6YeF
         oUdXrNFhJ7HX44VfIaA1yKBcSuITItumajK5gW9o=
Date:   Tue, 21 Jan 2020 10:04:14 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 2/9] arm64: dts: allwinner: pinebook: Remove unused
 vcc3v3 regulator
Message-ID: <20200121090414.apith3sfgr6zs4qu@gilmour.lan>
References: <20200119163104.13274-1-samuel@sholland.org>
 <20200119163104.13274-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uzxnfivy55v5lksq"
Content-Disposition: inline
In-Reply-To: <20200119163104.13274-2-samuel@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uzxnfivy55v5lksq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 19, 2020 at 10:30:57AM -0600, Samuel Holland wrote:
> This fixed regulator has no consumers, GPIOs, or other connections.
> Remove it.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied, thanks!
Maxime

--uzxnfivy55v5lksq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXia+jgAKCRDj7w1vZxhR
xTIGAP9ZNdshOtnLj+MOa83ArPOmfS27haDaXtWg8d6PBXAfegEAwNzTxcKxbwbH
XZhR0bLu/or8kbnS6BDPZmad+4n4fw4=
=dV8h
-----END PGP SIGNATURE-----

--uzxnfivy55v5lksq--
