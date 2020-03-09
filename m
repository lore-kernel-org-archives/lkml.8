Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A833C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647B120675
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583754046;
	bh=1u3fQeKObvGdqQJ+Esn1kpQobCpm0xfxw2OMS652VBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=diAtLTCjte7kHmTH1Q3950YK6wXs31HWiKcnquOMON5VpqQQa09eEi287t7iXABD7
	 UoMJX7b/qetfX++0Fr+kTaJXjcTvrPvUCsV8RpvExMlhOFcJ8frps9SgJ3NDrOoT7x
	 efhOghk3XNLuidaMSi5zL17uWzuw8eyFJUyvGBBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgCILkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:40:45 -0400
Received: from foss.arm.com ([217.140.110.172]:50918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgCILko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:40:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 333BE1FB;
        Mon,  9 Mar 2020 04:40:44 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A85703F6CF;
        Mon,  9 Mar 2020 04:40:43 -0700 (PDT)
Date:   Mon, 9 Mar 2020 11:40:42 +0000
From:   Mark Brown <broonie@kernel.org>
To:     peng.fan@nxp.com
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: debugfs: check count when read regmap file
Message-ID: <20200309114042.GB4101@sirena.org.uk>
References: <1583673058-20531-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline
In-Reply-To: <1583673058-20531-1-git-send-email-peng.fan@nxp.com>
X-Cookie: Above all things, reverence yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 08, 2020 at 09:10:58PM +0800, peng.fan@nxp.com wrote:

> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 6406 at mm/page_alloc.c:4738 __alloc_pages_nodemask+0x2c8/0xda4
> Modules linked in: mx6s_capture ov5640_camera_v2 galcore(O) [last unloaded: snvs_ui]
> CPU: 0 PID: 6406 Comm: grep Tainted: G           O      5.4.3-lts-lf-5.4.y+g54cbaf43e23e #1

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5mKzkACgkQJNaLcl1U
h9A1NAf+MvtTSm6pMQkX0RhJu+q+wrijhQBuIogNcCPaAohdEEtEbMGL6TGU7JXc
aRggsykAalVHDwNhqLMGI33TqWRFIK4qK7zq/MBC4eVeZo6MplzT6raFSG33xUZg
mo6yGVt18UdV1t3E4V1t8SPEv+x+c9fa9vFvifNrb0i6FC7HBhW79KnwMN4Cqhc6
+DQxD601WVJ/9DZc+xE07w34tUkzVUvoZWt6NNbyUpCNAsnDcIkuvi1lE+chwBSz
6USpHqMtqiAizxmXYJ/ZLvuxbhWUGergv5qZ8fd+oQnOunw7v394bwZ05b+aV6VA
sAomF420ZzzZi4/3VSUsx6XzbppafA==
=ag6r
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
