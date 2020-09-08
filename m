Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0E8C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99FBC20732
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599585161;
	bh=6+P+TO1BauV6jNZ7yLmJJOENSCp0lJZ2QmNtEP9yGMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=syeyD4ErBAourK1m5c9xbqEAvqjBXSj1FHa32qhvOl0Bwbj9+XdFRE7Xrg6dZj6qz
	 epq/50DgamWbt23EmXLvk/Zvmv+EotI5jCfH7ogf66K7bgFtm+3jAtcNOENwiH9QJp
	 w3BloAtJTyfTrRhze8HWRVOZn6PFmcPb+TuTqz3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731803AbgIHRMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:12:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731806AbgIHQTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:19:19 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1418123C90;
        Tue,  8 Sep 2020 15:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579403;
        bh=6+P+TO1BauV6jNZ7yLmJJOENSCp0lJZ2QmNtEP9yGMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U0ApBhOyQMqWHDRTWicWpbVIrQvBKfG1tEiHgPpeYFYQF6XjTyIiWAfksLJUMoScX
         JVeZZ9Ntk/rZQd9hC0U4BucEPIe9YzmvFHZvNCFWPzgOQtHsoJbs8X+IAQ5sV0Nsu/
         4uyOCR0M4ssTJQGpZMzc4Cy+V35DUETJnAJ5dBDI=
Date:   Tue, 8 Sep 2020 16:35:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, enric.balletbo@collabora.com,
        kernel@collabora.com, dafna3@gmail.com
Subject: Re: [PATCH] regmap: debugfs: potentially duplicate the name string
 of the config
Message-ID: <20200908153559.GF5551@sirena.org.uk>
References: <20200908152859.26279-1-dafna.hirschfeld@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tmoQ0UElFV5VgXgH"
Content-Disposition: inline
In-Reply-To: <20200908152859.26279-1-dafna.hirschfeld@collabora.com>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tmoQ0UElFV5VgXgH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 08, 2020 at 05:28:59PM +0200, Dafna Hirschfeld wrote:
> In function regmap_debugfs_init the name of the regmap_config is assigned
> in a node of regmap_debugfs_early_list to be used later after regmap
> is initialized. It is unknown how and when the name is allocated and freed.
> Therefore the name should be copied to the node using 'kstrdup_const'.

It does not follow that the name should be copied, it equally follows
(and is expected by the API given that the common case is that the name
is a static string assigned at build time) that the caller should not
free the string while the regmap is active.

> This fixes an error
> "debugfs: Directory 'dummy-' with parent 'regmap' already present!"
> where the name was freed in function of_syscon_register before
> it was accessed.

Fix the caller.  It is *very* much unclear to me why a syscon would be
assigning a name for a regmap it creates in the first place.

--tmoQ0UElFV5VgXgH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9XpN4ACgkQJNaLcl1U
h9BEFwf9Fqw6ngG0E+iNBhzxtUcVba2A3PvcBrAUSxh/WzkJXrgNJx4n5l8vEvJs
LHkGeeDOIYawjcoaQXJiKTFHDr6y0V1xi2aQdSD2SvRWWgRdJdMFVCDvU4A3yvBC
5n/tG6V2Ko9R1ZjLUIrd9I/O75mDeY/ZgbycZHIpAwpqZaghhk6OxYr3Yzk5EP/H
phjTMJoP1cd//+GlAoekgo2dUYLdni22HrZt0PfyhW2cemwWD23ULQsXma97RbgS
Ab8lRAN4Ql9g+eBYsRCS1vvftd4ggy6vn/zls7iWXMEUOqcZ6u60dDASYPggedtT
IRywQfMdoW0Axf0RYv9ayZHGIzp72w==
=40MK
-----END PGP SIGNATURE-----

--tmoQ0UElFV5VgXgH--
