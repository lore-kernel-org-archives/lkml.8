Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746E3C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DB4206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585659811;
	bh=EnBQqz1Zs0ivzG+fg1aNTGdyXL/Kj1Ictb4w4EVq7W4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HTaswNTw6WKQMi7BnRQYqMWFnEux3AaulflyywGCNdzB1cv66kks8MdXDPsA1EJUd
	 SrtHgZJIXNhKnwW/d1e6CGtdo4XvZ5+FVuXLriBe1BVlSbrVeEAlS3SCQpaMd/Hf+x
	 QnihnlI+xsJE9p78QZn5QyqSJTGmqCJHuNv81v7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbgCaNDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:03:30 -0400
Received: from foss.arm.com ([217.140.110.172]:52758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730442AbgCaND3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:03:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38C5D31B;
        Tue, 31 Mar 2020 06:03:29 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA9483F71E;
        Tue, 31 Mar 2020 06:03:28 -0700 (PDT)
Date:   Tue, 31 Mar 2020 14:03:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        kai.vehmanen@linux.intel.com, dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Yue Haibing <yuehaibing@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sound-open-firmware@alsa-project.org,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH 2/5] ASoC: SOF: imx: fix undefined reference issue
Message-ID: <20200331130327.GE4802@sirena.org.uk>
References: <20200319194957.9569-1-daniel.baluta@oss.nxp.com>
 <20200319194957.9569-3-daniel.baluta@oss.nxp.com>
 <20200331122540.GD4802@sirena.org.uk>
 <CAEnQRZD_Hjp2vsouUURuZ_zgAnnUXynq_L5YgCZAN4pFkcmGWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7CZp05NP8/gJM8Cl"
Content-Disposition: inline
In-Reply-To: <CAEnQRZD_Hjp2vsouUURuZ_zgAnnUXynq_L5YgCZAN4pFkcmGWQ@mail.gmail.com>
X-Cookie: It's later than you think.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7CZp05NP8/gJM8Cl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 31, 2020 at 03:41:57PM +0300, Daniel Baluta wrote:
> On Tue, Mar 31, 2020 at 3:25 PM Mark Brown <broonie@kernel.org> wrote:

> > This has you as the author but you list a signoff by Pierre before you?

> Patch was initially designed by Pierre [1] when in the internal SOF
> tree we already had the I.MX8M patches.
> Whereas, in the current patch series I firstly fix the i.MX8 then I
> add support for i.MX8M.

> Should I go back and put Pierre as original author?

Yes, if you're forwarding a patch someone else wrote you should keep
their authorship.

--7CZp05NP8/gJM8Cl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6DP54ACgkQJNaLcl1U
h9BNCwf8DKshKqaUb3H081iRZrUHWAJSZU+DnmiD5ENcYbns3F/gJNUhdt8nItvh
VRWzN4wsKM2ELUd0ktdzcRaxxQS52CBuw0JkJAsVMlOZ2UxE3hYBSe6HrT6gAvpf
BKcnouJmHOot/rGlw/Z+NtyCxEDQkqz24/+Jv63z6PRrnwb3DHDBJLhP8+FlJ2We
cKTS1TR290aRfdmPaXyPTiwxGolcGzf5ulXnmgi/0/ytRGd59Yi8IwbC/Cm1sbh7
rG+PE9vO5P2oHG8TBUUBAcGqO0nLtzn2UdkF6EVzM7IqcPr+QWeIdv9Fgo1b4BN8
h44Bx4448w4dpDXA6nidWLq33Zbe6Q==
=Aux6
-----END PGP SIGNATURE-----

--7CZp05NP8/gJM8Cl--
