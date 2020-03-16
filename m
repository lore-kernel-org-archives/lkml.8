Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BA9C2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063E0206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584361578;
	bh=wLXZj/rQOoK1wG6OXYHycuFl5KB8T+77ikZuAOuVcxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WWmN8+JAZ8L1snp5HsbYPA3UQFzs+mctC3WC8mwkGbeZuwfh2qaSzmVHKcXE7MlCs
	 HF795BmVtAiMerMJ/qiT0QC3s4az+RLvFdztIXGZNpDNMke0g3lB/GnM4v8rPLwBSN
	 Ks1ATkbO1SOUqd+4uFYVtOe2Iyf2MxFnR6UaDmsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbgCPM0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:26:16 -0400
Received: from foss.arm.com ([217.140.110.172]:47378 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730902AbgCPM0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:26:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F97E30E;
        Mon, 16 Mar 2020 05:26:15 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F75B3F52E;
        Mon, 16 Mar 2020 05:26:14 -0700 (PDT)
Date:   Mon, 16 Mar 2020 12:26:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: Re: [PATCH v3 06/12] spi: spi-fsl-dspi: Replace interruptible wait
 queue with a simple completion
Message-ID: <20200316122613.GE5010@sirena.org.uk>
References: <20200314224340.1544-1-olteanv@gmail.com>
 <20200314224340.1544-7-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M/SuVGWktc5uNpra"
Content-Disposition: inline
In-Reply-To: <20200314224340.1544-7-olteanv@gmail.com>
X-Cookie: I thought YOU silenced the guard!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 15, 2020 at 12:43:34AM +0200, Vladimir Oltean wrote:

> The wait queue was actually restructured as a completion, after polling
> other drivers for the most "popular" approach.

> Fixes: 349ad66c0ab0 ("spi:Add Freescale DSPI driver for Vybrid VF610 platform")

Fixes should generally go at the start of the series to make sure that
they can be applied without any dependencies on the rest of the series
and sent to mainline before the merge window.

--M/SuVGWktc5uNpra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5vcGQACgkQJNaLcl1U
h9BuGwf/TNkbNlpccB3oDAPTRoqpGwgXMT50uneLIqM+UWYDfTdo503/gwBuVGUZ
Ix/lJF/B9AD4LGk+CJED3A9PB8UahrL+5hl8+bojzSHjpRLyWrGqGg0GDEuH5DFV
fZxWjtf5laBqVYUzAvNi65PTOzLgXhO01FetyFQyToHLdFGQZs6wq0uZcJlq5A55
22ACschvXdQ8k3aOsPXLOwTaNxEIsWex+GpybtDIZdoUMnT6Y7Gf/LaWl9noJzCC
PTqYrePE1pwPUKo+/y2QXdUvao5UzQ/0qcBR7MHt0mjwFWlwikRRiF2dJf7s4Bqn
M/7m7bPS6B2ieiOoQgB2bp02f5FZnQ==
=3FFa
-----END PGP SIGNATURE-----

--M/SuVGWktc5uNpra--
