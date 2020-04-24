Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27C9C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C008520736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587731966;
	bh=L7vTCbCHK5QUVdLRP/hudQkCt/S3GNMCtxRfc2gl49E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fNbwqJ/NQ5x9BEzmLQ0LNA/q0sm53yVkm1qTK8oO/Hm/VKGbnPOZSkbs8inkYBpFL
	 j+vLYGq5zk5ttrAybM8MWrz6/I7sZAEzc79m7qzwwWuO3RC5CuM3/YGAftyxF6xg5I
	 ZFtZ02HYGZlTCRSoW71Z2s/WTOU2xVyOFhpZYLRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgDXMjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:39:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbgDXMjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:39:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D46720704;
        Fri, 24 Apr 2020 12:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587731965;
        bh=L7vTCbCHK5QUVdLRP/hudQkCt/S3GNMCtxRfc2gl49E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iVPTGngs30PgIDoHePGAg82N2cv2toTq3Gfc9RDatmKX9Nt3+mq9UM+6QpEMKCxTX
         QQdPBIcmk5xVQy/i+5/rG2NU/02LIwoGGWGnoQvi3hqqXJIAI8b7yDHNzsyscuSwpJ
         tcxxcYuaS/7uqYQMAhp1GAFHOmASztPluptgDF2Q=
Date:   Fri, 24 Apr 2020 13:39:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Aaron Sierra <asierra@xes-inc.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regmap-i2c: add 16 bits register width support
Message-ID: <20200424123922.GF5850@sirena.org.uk>
References: <20200423085857.93684-1-acelan.kao@canonical.com>
 <20200423144529.GM4808@sirena.org.uk>
 <CAFv23QmNLUqWKHTjK-sFE7ChUCu9j=0p6=Rn22d0E8_HeV-8aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y/WcH0a6A93yCHGr"
Content-Disposition: inline
In-Reply-To: <CAFv23QmNLUqWKHTjK-sFE7ChUCu9j=0p6=Rn22d0E8_HeV-8aw@mail.gmail.com>
X-Cookie: Information is the inverse of entropy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y/WcH0a6A93yCHGr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 24, 2020 at 08:24:53PM +0800, AceLan Kao wrote:

> I'm not an expert in this field, please let me know if there is any
> better way to archive this.

I think you're limited by the decisions of the hardware people here
sadly and there are no really good options.

--Y/WcH0a6A93yCHGr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6i3fkACgkQJNaLcl1U
h9CksQf/QlFtbzO4d7uYaF/4YDx2vWKQIG7Z8GYvPllPFb6dTd9BZcI/Onq95xpd
AWRYXybNuClD2NrsJ38sbK1yw33cScCNxBt0vkyUpK6143QUpjGjqzyb7igBxL6N
zSqUcjQHeiDOXYBqddQO0ylynY7bIEumiW/y8U5TZ/WtsLnfPwcJzcIXCopL/S5t
4iFF87LoT5KsVx6ZAH2tpYC+Jy51q+BQASar/KctOBo0TXVXckmmI3wPmt2aVxdC
ZzpmNl6SQkd//jr+G4U/fV552298if/HtKcV5xuWf8qWcsI7nHA41z3guqdpa5f2
Ve1iLld22XEQDdhxUli2A8ZhLuw5TA==
=/Ldv
-----END PGP SIGNATURE-----

--Y/WcH0a6A93yCHGr--
