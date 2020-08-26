Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A88C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 193402078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598460829;
	bh=yvbxB/dXm+wxQXgZYoFFZEVL9w4GvstjJ1BXu6Uy/Hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mSh39F7U7ex5LqwGUnPC6U9jF/hWE/nU30U62kiM8AVBFDYjNNvVKkcxvNYQOPMat
	 I0lEvIvwAnLBPiEnF/WvjVbkSTUccgC9EPtIgUOsz2Xzqel6ufrk6SuU+oQG3aIxmn
	 jBa89y+tVZKRtcjSUV4hP8AbrXgH5civ1qT/pSUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgHZQxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:53:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgHZQxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:53:44 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1DD32078B;
        Wed, 26 Aug 2020 16:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598460824;
        bh=yvbxB/dXm+wxQXgZYoFFZEVL9w4GvstjJ1BXu6Uy/Hc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G+EeWxWlvWkzBLDIG4YwXEVSUsPzaMdlqtMCM2GTdCgivysepguirOTd+5lMVVyNl
         i9dtROwHC76N4bjFqFddps3JLinWLMBAsEFpP1G3l7IiTW4xAaIG1kIJy28biGFpXk
         WCvP/u2YDSt5umUXhfoBNoy72IC0sT2M2Ob2p7Ns=
Date:   Wed, 26 Aug 2020 17:53:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     timur@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Fix unnecessary check in
 fsl_spdif_probe()
Message-ID: <20200826165308.GJ4965@sirena.org.uk>
References: <20200826150918.16116-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W/D3X8sky0X3AmG5"
Content-Disposition: inline
In-Reply-To: <20200826150918.16116-1-tangbin@cmss.chinamobile.com>
X-Cookie: Should I do my BOBBIE VINTON medley?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W/D3X8sky0X3AmG5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 26, 2020 at 11:09:18PM +0800, Tang Bin wrote:
> The function fsl_spdif_probe() is only called with an openfirmware
> platform device. Therefore there is no need to check that the passed
> in device is NULL.

Why is this an issue - the check will make things more robust if someone
manages to load the driver on a non-DT system and otherwise costs us a
couple of instructions?

--W/D3X8sky0X3AmG5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9Gk3MACgkQJNaLcl1U
h9AXowf+OVsKdeEZ3BjfcRZvF73cSt5ZNgBH2LZFoif+p5duvwFhYWYpiM838REI
CFWQz5uaMwq5pzA8Hx+iJA+HyEhiucpXw3yxW5Xs0j1nd/BgiSGKdyHlTXZ3RqD4
Gr2QdQXO17esiaT11+ZLFIwecynN29JLQ8GThARSMc7tGfmaXy5JQJkOy5c4nOFX
ycF3dds18vEua7ajqC3wFLTDygdqE6gv41YqIJgU3J9X/tAugKh1jtTa4k1eh/6M
ydH9ezNoA3havqWqAAhAGbW3kbLBCQFKsndWnZbYPU0VHZw5shBWTrx2+x6z8F68
YM/0TyIgmkvB07oBBF6wkjb5sD0hZA==
=6aKW
-----END PGP SIGNATURE-----

--W/D3X8sky0X3AmG5--
