Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C7EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 22:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F241E20810
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 22:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590790472;
	bh=HbieGG+dqeFNzfE+gXE0brEWwMkEcSVqmduNHcX+lNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kqODsyd5bnWcIRGY/JOchsKJcV6pOBfibdRGwy2zLGitcLK6tc7cHOgtm6zXgkeJ6
	 9+ASRGRqxcpRUVfdh/WXJHrCRrTzrPNRkp5mliyN0tduVeZ+J38jAhJ4Z5PVvKeuh3
	 FmlWWUdR3rxfeWr/EwZsaoznI8K+nOMp7wcpWApQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgE2WOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 18:14:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgE2WOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 18:14:30 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFC8120776;
        Fri, 29 May 2020 22:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590790470;
        bh=HbieGG+dqeFNzfE+gXE0brEWwMkEcSVqmduNHcX+lNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u3OwFVT4UwFJaDkw5WJYdru5s0NB8r/wp+anepwsEnS+uLbDDXjfwNMcs4By19gMd
         WwYEq6dI74lEgQnMYRGk2VGT9RTaoNuDtOAmDrlg+loAK6A+VFE2iaRjQl3SZnnCnj
         M4ucXdt6AYQsf6jClWKEPcAEqSTTKrC+EvfkTtEg=
Date:   Fri, 29 May 2020 23:14:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jens Thoms Toerring <jt@toerring.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] regmap: fix alignment issue
Message-ID: <20200529221427.GW4610@sirena.org.uk>
References: <20200529192538.GA28402@toerring.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lQcP9vuZCkvmDKre"
Content-Disposition: inline
In-Reply-To: <20200529192538.GA28402@toerring.de>
X-Cookie: The Killer Ducks are coming!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lQcP9vuZCkvmDKre
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2020 at 09:25:38PM +0200, Jens Thoms Toerring wrote:

> pointers with odd addresses. On architectures with strict alignment
> requirements this results in a kernel crash for u16 and u32 values.

Which architectures out of interest?

--lQcP9vuZCkvmDKre
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7RiUIACgkQJNaLcl1U
h9CIZAf6A92KEpjeqTknZeH1/hg0oLCkeGilARVE6kQb5tgg1uKnT2Hq9Kl+yR+k
mtOZl87BsFhDLS2LFeNkfUOM3ux4yT/1uzTAbI9CBdADZ7v4UUoCPcXrfMFSuhVc
k4BXdONgzmYVllCGS2bRiGJLRhgWI/o/03R96u5+BPtojKNm8dbjb4UQ5Edjwj+t
LxXGpwswR7GKq+sBa5H9SEBEHX5kAkh9zejmeLHlzxlRTjurqzE+z3VxONXgCr4h
SKcGL/YWkcwaLq6PgUShNFUiPJRzfXvddvqt6rX+tYkNp9pq/eWRxE1D8G/xlEnF
1yrVNAUOv78AgkhZE+jIxkvTwMFXWQ==
=9o9n
-----END PGP SIGNATURE-----

--lQcP9vuZCkvmDKre--
