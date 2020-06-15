Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AFCC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA4D207F5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592227915;
	bh=DNx2FOJBhMQcsxpwss5JX13KZQpzmknMo4MZDCRvaTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gu5wLf+/O9suH3oheSaHrABlqC/1CSK+5XGqWJi6mecyDMkCxUT/qRgL36Qs5DZ/Y
	 wk3Q6yS2sDMYMBFtiL1+Oxa8yX2Y//cM2sC+qDViWYQr9d8Hls2W6o8h4KP/NGOZ+U
	 LVelvpz2CQPTXJtkuDKj2a4RJ6jn/q+ErDQ3GPO8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbgFONby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:31:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729875AbgFONbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:31:53 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A741E2071A;
        Mon, 15 Jun 2020 13:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592227913;
        bh=DNx2FOJBhMQcsxpwss5JX13KZQpzmknMo4MZDCRvaTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kWg1QPUT203sfVo4cN0dkBf3ax/CI8eZwCZTRDjv+wBMzPFsXVK/qN+vc/jXfeuxV
         soK+NrRQU6lXqwR+TMgW9IGnmXFT8GRM7tSbRgBZMHbWxq/LN2GPgL77E1OKGmLG2m
         kGqrWXANrPxWp+T2/JYhHIl9CgrcdSX/qqFFzzQ8=
Date:   Mon, 15 Jun 2020 14:31:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Cc:     kdasu.kdev@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 3/5] spi: bcm-qspi: Do not split transfers into small
 chunks
Message-ID: <20200615133150.GT4447@sirena.org.uk>
References: <20200615040557.2011-1-mark.tomlinson@alliedtelesis.co.nz>
 <20200615040557.2011-4-mark.tomlinson@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TJ9V72hR/LoebVea"
Content-Disposition: inline
In-Reply-To: <20200615040557.2011-4-mark.tomlinson@alliedtelesis.co.nz>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TJ9V72hR/LoebVea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 15, 2020 at 04:05:55PM +1200, Mark Tomlinson wrote:
> Instead of splitting transfers into smaller parts, just perform the
> operation that the higher level asked for.

I don't understand this change - presumably there was some reason for
splitting the transfers into smaller chunks (issues keeping up with
FIFOs or something)?  How is whatever that reason is handled?

--TJ9V72hR/LoebVea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7neEUACgkQJNaLcl1U
h9DAPwf/f7MYucU1Yu2itPj+OWXklfxkXLzGLvoujwfjGfJolzFqbslCSlcHKkUH
vNVdnlwNWIEufuxlgQevTuaE20sZKDKhS2eS9aaieODpt0bknbj/La/q3otQiNW7
5MdSPhOO0N+Gq2W3zX1e+biaTuS4KOEVDla6QOfrJ0VuUgKOxDP9Jdp96oOKypt5
rA5RamnnjaUM4i2i2VUBqOzIBWQdASrSaTOMA1o640swXH+1gqAlcjJrV40Ijczr
5C3s4txzOWJ7kCsdy9knZWkW/KEnMY3lj/c73A8LhkDzdtiozC2QScWoHIz0vvxT
yoNf/pBUq9d3jRcpqbP6KTf+NzijWA==
=ikNT
-----END PGP SIGNATURE-----

--TJ9V72hR/LoebVea--
