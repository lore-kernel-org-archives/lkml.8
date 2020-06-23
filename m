Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82315C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C4A52078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592932727;
	bh=cIuJzlalHBnO+2yYEVOVo9FBHnL7aMmBDhMGCrHBgk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZPSYvRFnSX7PTmoigulnfOcLXpkSTWsVFyzIAMWOCGnRQHH4NTCd/hKIA1u+QHrAm
	 +3l6sPzUzFUUSd1Q7RTQFHO2cJHDFHn5MRXToKdj3SJMPrajRQqyYsyE1u5rC9Qtcy
	 P9Qp1POvQzqryoJyrCyx7VAOAkcyl0T/AoAOqzew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733061AbgFWRSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:18:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732408AbgFWRSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:18:45 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A51A220780;
        Tue, 23 Jun 2020 17:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592932725;
        bh=cIuJzlalHBnO+2yYEVOVo9FBHnL7aMmBDhMGCrHBgk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BNbAWLagG+qxgK2G9CP2wzedwW1br9Q7WF2deT2Qsm3h4cOL5D7x6G2pj8DJgPw4n
         wgZNNzROlt7Mzs9iVEG4t4IHdXIa712oRPL8ew0iHvNwSPhFD6zoCKZAzBuRQNO4+R
         PTAeC8xVB6UycZTKqCVwn9aGhPcqrdy8Lu32BowU=
Date:   Tue, 23 Jun 2020 18:18:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        robh@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] ASoC: tas2562: Update shutdown GPIO property
Message-ID: <20200623171842.GH5582@sirena.org.uk>
References: <20200612171412.25423-1-dmurphy@ti.com>
 <20200612171412.25423-2-dmurphy@ti.com>
 <cfb043e3-77c5-2957-20b6-2814f1445cf0@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Enx9fNJ0XV5HaWRu"
Content-Disposition: inline
In-Reply-To: <cfb043e3-77c5-2957-20b6-2814f1445cf0@ti.com>
X-Cookie: No motorized vehicles allowed.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Enx9fNJ0XV5HaWRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 23, 2020 at 10:59:49AM -0500, Dan Murphy wrote:
> On 6/12/20 12:14 PM, Dan Murphy wrote:
> > Update the shutdown GPIO property to be shutdown from shut-down.

> I have some other patches that go on top of this patchset I am wondering if
> I should re-submit with those patches on top or indicate in a cover letter
> the dependency

If you decide to resubmit please make the YAML conversion the very last
thing you do in your series, there is a considerable backlog on YAML
conversion reviews which slows down any changes that depend on them.

--Enx9fNJ0XV5HaWRu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7yOXIACgkQJNaLcl1U
h9DxlAf+KjPVhJ8fCMl8ps3tTLy8n/19ma5ndPpYF8kS9ZuKTLlBXh6hVWHTBnwq
KMMcn5CPNvDfmKqVKFygogITiYAtAeHc7WZvzX4ywLygdYWPL/gUwdY7ICTi+peL
CS2WAxTuYvUntqJoVld9hJIWfzC7fygA8N+FBsgZVRXrwwDDaJc2GWysUI4C8DX7
gtJ+nqk8DnmnRMAe4oVt0LOR69bNzu2MJNtAmpmBzGz7qXg6iqqnCTeJDkVCn+Ll
HmQIXKDlCbn4qz/4SpN73m9n0TdO8XUHmm6/DC32JviMHtgqqmUWgEn8cnS60Q6o
++jE7wjAKh4RwJdwZ8PDBCyIKbWUXw==
=ytyL
-----END PGP SIGNATURE-----

--Enx9fNJ0XV5HaWRu--
