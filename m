Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BDFC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B497E20675
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583243514;
	bh=u/F9ZU/2hZxMYN3LijiLnG+ultnxDD1SE3UmIK+Qc1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z0Ivn9Cr+B5VlCw+XlYdZMPmA3aHxA4LFjZz775RMNoxpaVxNf1LDsZNVqMayvgRi
	 Kb4EUujUJ8muqgcK0j7tTNw4iHQVeCXOcB2svtgnEe6Qo8fLiKTVDY1YpgN8xxBz1p
	 gTwSTyaUUL1V2DF6T7+3HKl1GaOP2vZZGQ/xlftE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgCCNvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 08:51:53 -0500
Received: from foss.arm.com ([217.140.110.172]:47326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgCCNvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 08:51:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC030FEC;
        Tue,  3 Mar 2020 05:51:52 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F4F53F6C4;
        Tue,  3 Mar 2020 05:51:52 -0800 (PST)
Date:   Tue, 3 Mar 2020 13:51:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ASoC: simple-card: Add support for codec2codec
 DAI links
Message-ID: <20200303135150.GH3866@sirena.org.uk>
References: <20200223034533.1035-1-samuel@sholland.org>
 <20200223034533.1035-4-samuel@sholland.org>
 <9cdcfcb6-63c2-5b76-9de1-46719e4e7139@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9sSKoi6Rw660DLir"
Content-Disposition: inline
In-Reply-To: <9cdcfcb6-63c2-5b76-9de1-46719e4e7139@sholland.org>
X-Cookie: Drilling for oil is boring.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9sSKoi6Rw660DLir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 03, 2020 at 07:49:33AM -0600, Samuel Holland wrote:
> On 2/22/20 9:45 PM, Samuel Holland wrote:

> > +{
> > +	struct snd_soc_dai_link *dai_link = rtd->dai_link;
> > +	struct snd_soc_component *component;
> > +	struct snd_soc_rtdcom_list *rtdcom;

> This variable is unused in v3. I can send a v4.

Please.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--9sSKoi6Rw660DLir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5eYPYACgkQJNaLcl1U
h9B5rwf/St5QDX5SN1mRQ5ysQc2ewxADKkT6BzDewPm/0lDrJU52bnh0QWb80af6
JUnm+B81S49IRZcdLono1Z0wGIgV8aXxYizB4YDZKZ+SFLveopQkNPQcUsAbS7nI
4cWQaWI4vm4xKvhjFMzy5ew+Ux6sAVtjWJ9VQJ/mSM/fhRd6UBuniicbR/ue2Mm1
p12yWoXMJEINSkh/JVK8jcT3+dXas4cNIk2IgPVUj0gD6ShyN12hJeLVec5YvXJo
WPZE3ItsCAbqIjJ6EfDE2rvZxw8GLMVJhGYqlsst4i8ceetqStvJg941kxSu894l
GckVXT0VFXGh2I0qNlSGQBDs6U4YtQ==
=Q4dE
-----END PGP SIGNATURE-----

--9sSKoi6Rw660DLir--
