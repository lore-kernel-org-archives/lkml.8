Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178C3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2D4D22C9F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596801281;
	bh=ZtA3NUxNT+VUCjbXoK3nwC7HwEhIkp1OwgDmyeuzGSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gmLh/9YvONM//0XOMVPAw/1znqpbvGYZqfx9xbdkYPEt36yhE2abzAXd6JNRHR60O
	 7EKmHUh9qNM7IIW/nInX8WSEmXfVCBt8ICp91QgfBqkLEdPeJegfBCOhFvBxBXaEbh
	 UkKUCBWhyCGY9pBPXrVUvy0WCcai66aKmz3J6j5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgHGLyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 07:54:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgHGLyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 07:54:40 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB2B02075D;
        Fri,  7 Aug 2020 11:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596801279;
        bh=ZtA3NUxNT+VUCjbXoK3nwC7HwEhIkp1OwgDmyeuzGSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SLO03/FOcrfNQ+qPTkxU1dgQGEhJFM2Ul9fpJa3e1SEXb3rQ+sKtvBXRHbjiseWu3
         1M4zGkfTAnUAIgaFLhVHAHs+Jg70ApN+OXLpv3F8ZDZtcmJ1X6x9iqRPL6ivYYqiSA
         ZGu8A2dvW5JwdJDq7Pe0y77lWF6FVtAvxNeYErRM=
Date:   Fri, 7 Aug 2020 12:54:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "RAVULAPATI, VISHNU VARDHAN RAO" 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: amd: Replacing component->name with codec_dai->name
Message-ID: <20200807115414.GI5435@sirena.org.uk>
References: <20200806101451.7918-1-Vishnuvardhanrao.Ravulapati@amd.com>
 <20200806112831.GA6442@sirena.org.uk>
 <BY5PR12MB429286C315F66F7E2E5EA501E7490@BY5PR12MB4292.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mhOzvPhkurUs4vA9"
Content-Disposition: inline
In-Reply-To: <BY5PR12MB429286C315F66F7E2E5EA501E7490@BY5PR12MB4292.namprd12.prod.outlook.com>
X-Cookie: Disposable, use only once.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mhOzvPhkurUs4vA9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 07, 2020 at 08:36:25AM +0000, RAVULAPATI, VISHNU VARDHAN RAO wr=
ote:
> On Thu, Aug 06, 2020 at 03:44:12PM +0530, Ravulapati Vishnu vardhan rao w=
rote:

> > Replacing string compare with codec_dai->name instead of comparing=20
> > with codec_dai->component->name in hw_params.

> >Why?

> Here the component name for codec RT1015 is "i2c-10EC1015:00" and will ne=
ver be "rt1015-aif1"
> As it is codec-dai->name so the strcmp always compares and fails to set t=
he sysclk,pll,bratio of expected codec-dai

This should be in the changelog so people can understand why the change
was made.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--mhOzvPhkurUs4vA9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8tQOUACgkQJNaLcl1U
h9AMEwf9EjG0TW7IazqtWGPRye237mVP6Pc8k9MNOPeSCB+0NwICOZWMa+bT2dr9
YAUGqvVRrbSFzqgPXlUvSP9WQoYXbnx9vyu/eNYinHy1P5ij0JMafTb79TekTqbW
QlaRNBdesjDQPuoFnHncAQZY8hddYW9OwKQ/dEGA3uvM9q86dGLgH5LrOhl9sRXp
zywg8qYT1oQkfj1gvfj3OgqjJHo6g65l6Ei7QQ1oNXk7lq+cxJGebjpTOVcVW6pA
pxwbi4r/fyemXLhJ/YvF62wZ6YVarLh2zWAn6sKBTRY+1owvQ/nOKpRAC/Ie+2WF
P8ojsr5EIog/QduiVBCAs2MV7ModLg==
=ml31
-----END PGP SIGNATURE-----

--mhOzvPhkurUs4vA9--
