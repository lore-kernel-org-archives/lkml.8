Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4839DC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1294920842
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581435531;
	bh=X2VUDfvRmFT8pY6TrTTAVIM1OvIacaKl3JmreByqD8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G4qDf0S7cYBvo9e6ICm2ros1TTVCgLMangc9KlEWWVxLIfi6sxBiYQzcpKI5Sx8fq
	 Fn7m1HBfSEfcY9aj05NQZ1I2QAJYf5CSsjqOLlEjmvOfRvqcRZH5vUUZiH+mOsfwtY
	 qMcxfY0n2/zeGPtbQ2cV8cZ319ALTe+L2U7SX4Ew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbgBKPiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:38:50 -0500
Received: from foss.arm.com ([217.140.110.172]:47980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729114AbgBKPiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:38:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 400CF30E;
        Tue, 11 Feb 2020 07:38:49 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B88483F68E;
        Tue, 11 Feb 2020 07:38:48 -0800 (PST)
Date:   Tue, 11 Feb 2020 15:38:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: amd: Buffer Size instead of MAX Buffer
Message-ID: <20200211153847.GK4543@sirena.org.uk>
References: <1581426768-8937-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lildS9pRFgpM/xzO"
Content-Disposition: inline
In-Reply-To: <1581426768-8937-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Cookie: Hire the morally handicapped.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lildS9pRFgpM/xzO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 11, 2020 at 06:42:28PM +0530, Ravulapati Vishnu vardhan rao wrote:

> Because of MAX BUFFER size in register,when user/app give small
> buffer size produces noise of old data in buffer.
> This patch rectifies this noise when using different
> buffer sizes less than MAX BUFFER.

In what way does this patch fix the issue?  I looks like it's moving a
buffer size setting from DMA to I2S but it's not clear why or how this
fixes the issue, or indeed what the actual issue that's causing what are
presumably underruns is?

--lildS9pRFgpM/xzO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5CyoYACgkQJNaLcl1U
h9DyKAf/ZqhMDhn36gZKS7USGUlNR9zhfLFj4h/Cwx4a0d+eNSjpmYaELKeXq060
kbOYE49cI3V4OnSDP1yoDQ7Tsuz9hQzebIzC+0KJdpCRIGyU10lKhK1pDI8JV3lK
vFofPqpWSGaTUj8abYbTHXyQf2T2ZPQqm14Sx7FQgPSnXI6M0gfo4I9hEyT4oe0E
NJqNs6e8uSUerJdPSDfSeV2hR04V8A8MEd4g4kjDM4ktTqmyv0HetsXFMiAfH3wF
ws4lB18nTxEDkvq1pZL/3Vfp5GVs8HVU1qWcJHgtUoZ5yLFUAF96MnAhPabLz2xH
V6keJYLuBDl29iEV1T20hO9NFdt7aQ==
=Evcz
-----END PGP SIGNATURE-----

--lildS9pRFgpM/xzO--
