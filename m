Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D1FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 571F22080D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592482427;
	bh=zlMHpKPW0q09W6RDM2ggzLUYctacuDuqAbHYFurGPzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YVbZnug2T5tIZK5cLqxCIdudYKErtxfX2PDGTwtEwIwAChiph4ok5MbRM8efiaib3
	 4bYMV+lfKqVyxwDat/YNfqOD9eDDQ6uwMFxsE1A/cKlyzevRHsld41nJEIgB3/2NQQ
	 mfF2EtHYQHjifPV1UR3SKXKt32wqGqMCikOBjZp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgFRMNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:13:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbgFRMNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:13:42 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0F31207DD;
        Thu, 18 Jun 2020 12:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592482422;
        bh=zlMHpKPW0q09W6RDM2ggzLUYctacuDuqAbHYFurGPzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MgTrurpY2WwRFZMiFOLuc/+EX73he9w5/j8XNdxcMhxek2dHNTznYTzwpPoDCAUkM
         3WUYySfhviMyex2qyhsZgUM/Vu50MXK3YJnnuwryA2FLP4X2eAlASLvfXXEP4TOYQq
         U9KVJQcYYf1syoJnX5w9cJn4RYObOuhyjQB5cvws=
Date:   Thu, 18 Jun 2020 13:13:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH AUTOSEL 5.7 055/388] ASoC: SOF: Do nothing when DSP PM
 callbacks are not set
Message-ID: <20200618121339.GH5789@sirena.org.uk>
References: <20200618010805.600873-1-sashal@kernel.org>
 <20200618010805.600873-55-sashal@kernel.org>
 <20200618110126.GC5789@sirena.org.uk>
 <1d1041f9-521b-98f5-a6ef-12d43615bc13@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y0Ed1hDcWxc3B7cn"
Content-Disposition: inline
In-Reply-To: <1d1041f9-521b-98f5-a6ef-12d43615bc13@nxp.com>
X-Cookie: Androphobia:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y0Ed1hDcWxc3B7cn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 18, 2020 at 02:44:18PM +0300, Daniel Baluta wrote:

> Indeed can be seen as an optimization, but it does unexpected things which
> can cause trouble

> and weird behavior for people not familiar with the matter.

> For example, as explained in the commit message if you only provide

> System PM handler but not runtime PM handler, then the DSP will be resetted

> even if this is not the intention.

The user shouldn't be thinking about if the DSP is reset during runtime
PM, or if it's being reset...

--y0Ed1hDcWxc3B7cn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7rWnMACgkQJNaLcl1U
h9CkHwf/fzvqyfr+cua8XR1XxSJiEGTyXJ/VvKSilf0hGJm5j4pkchTP+QMu+u84
NJ05+mKUW1R9f5iHvCFhu+DvcSnUqPwP5cNDwqNNG2LgiMVV7ncOdmfVAx0iez/9
LWr9pv2xR7OoeZUWBGButW0vR+Db7otynZ0g4KJUK32rQDdV7fDhd83v3PxZLZAT
ihIb7y2cGeyXAXNqxLqCqPnuPRnC1dzYdMxT9J5OKH2kfahG8O1pAuu4XZtAE68l
vFCQ7SgIqkq2HxAhen6J4rd+bTb0W9hpEL+/ltebF4Q1gw7nkruhZaEheiKrj6Ex
hUY08U4sFWY1/kA0scUxNk1+iGvIRA==
=wOoM
-----END PGP SIGNATURE-----

--y0Ed1hDcWxc3B7cn--
