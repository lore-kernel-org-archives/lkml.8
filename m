Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6C8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54EF620801
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591882849;
	bh=cvz/YxFSgXtIw2nOa4VErS/4b3tA507ZBN5/rPyfuu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QMUftzyxV1z2tpQCqmKSzDNoXVwMEE0zPidYb/vpZphJcwIGSrg2nqXNFCboFc8ZE
	 /axOswGOd0keU8F+87qS0PtGgLMGhcHa3O23UIvco5vjesz/6fon17tIFupUkKDZHr
	 CcASghw7J0rrV2JrxUR/C6X89I3/JPifXF1SWtY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgFKNkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:40:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgFKNkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 09:40:45 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29B8420760;
        Thu, 11 Jun 2020 13:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591882844;
        bh=cvz/YxFSgXtIw2nOa4VErS/4b3tA507ZBN5/rPyfuu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tPXBu1yFAiTRygRf37l3z9KXCEWhdc+r8uUQpZeIFKHSyzX1Mkh762yKf4crAhReV
         zJrxSPi4Anm1TS+12b60syNQX7ROOtQrR3YNsGEJWPIsUHVt9cRHKxFimUYl/txXap
         KN+qKdAE2Il8rMK0JhTKm44arnXXf1thA+ajbEfg=
Date:   Thu, 11 Jun 2020 14:40:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        robin.murphy@arm.com, matthias.schiffer@ew.tq-group.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 RFC 1/2] spi: introduce fallback to pio
Message-ID: <20200611134042.GG4671@sirena.org.uk>
References: <1591880310-1813-1-git-send-email-yibin.gong@nxp.com>
 <1591880310-1813-2-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iAL9S67WQOXgEPD9"
Content-Disposition: inline
In-Reply-To: <1591880310-1813-2-git-send-email-yibin.gong@nxp.com>
X-Cookie: I like your SNOOPY POSTER!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iAL9S67WQOXgEPD9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 11, 2020 at 08:58:29PM +0800, Robin Gong wrote:
> Add SPI_CONTROLLER_FALLBACK to fallback to pio mode in case dma transfer
> failed.
> If spi client driver want to enable this feature please set master->flags
> with SPI_MASTER_FALLBACK and add master->fallback checking in its can_dma()
> as spi-imx.c

If we were going to do this I don't see why we'd have a flag for this
rather than just doing it unconditionally but...

>  			ret = ctlr->transfer_one(ctlr, msg->spi, xfer);
>  			if (ret < 0) {
> +				if (ctlr->cur_msg_mapped &&
> +				   (ctlr->flags & SPI_CONTROLLER_FALLBACK)) {
> +					__spi_unmap_msg(ctlr, msg);
> +					ctlr->fallback = true;
> +					goto fallback_pio;
> +				}

...I don't think this can work sensibly - this is going to try PIO if
there's *any* error.  We might have had some sort of issue during the
transfer for example so have some noise on the bus.  Like I said on a
prior version of this I really think that we need to be figuring out if
the DMA controller can support the transaction before we even map the
buffer for it, having the controller just randomly fail underneath the
consumer just does not sound robust.

--iAL9S67WQOXgEPD9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7iNFkACgkQJNaLcl1U
h9Bf+AgAgmNtDbsABzuC2/FdzMOgrJBX+Sol1QlxGnFXxy0CasIDkgkgZFWfFd+f
55Ee2ZOKSfoZIb3+4SPDck6koXnMJVsaBU4NFjuqzc/l3uvgXM7pKdjpnWlcRZaj
9XPGvNv4VqLiGv+HTqbHSRdOuDAN1GZH9SSwJd15fjeZE9xA4bmzN2cT1DcxDJPl
fMscBXBBrMIIq9Dqw1lDJuta8vKoaB3y2o1ee4nihNa8OBDL/FdVzgzl7aAiVGS3
I38G2AZRgnZBWf2z+haWsFKMbumjUKmMB2vCjf5U4gI5N3O6iFDMFdEzkHQdTSQS
yU4UU7726S05d44UW6lXJgFBMoB0UQ==
=Y2mu
-----END PGP SIGNATURE-----

--iAL9S67WQOXgEPD9--
