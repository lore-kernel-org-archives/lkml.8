Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE66C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68F23215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599645361;
	bh=80y+lBEjqoY3o25Mv/xR+Di0cs1Hb1ZUnm5ahaVP8PQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i3T4wvw+fzbzqLEkb3FvSwEInQs0aXNx6VLxDU6j/X8wBHHjP9QpQojJy38TAC2qF
	 /V+5l+7c/srLaGrQ+9fT47BjCCqr93lHXn1h2dNbXZ/5QEjDmRazYoyvI9tSY/OqwJ
	 SmNlznX9Y5zHtS/sceD+8uKly1U3YUo/FaBdQE3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgIIJz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:55:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgIIJz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:55:57 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2389921973;
        Wed,  9 Sep 2020 09:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599645356;
        bh=80y+lBEjqoY3o25Mv/xR+Di0cs1Hb1ZUnm5ahaVP8PQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vBNR0Fr5EaMVBJtkkyNq6OjoiTqYMi9y+Ji1xMLsdHYXqNzlDNomM9/8DpSliOBi1
         B0eqPbefVyP9v0r4yh1/f8edYVlU3P4soFFdvKEiM7jz6sf06u9465vJ/o+R4jlp19
         tZ3iZqu2G211WjE0K0HCr9KFPgnkfXVUHe0SzSk8=
Date:   Wed, 9 Sep 2020 10:55:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH v2 1/7] ASoC/soundwire: bus: use property to set
 interrupt masks
Message-ID: <20200909095511.GA4926@sirena.org.uk>
References: <20200908134521.6781-1-yung-chuan.liao@linux.intel.com>
 <20200908134521.6781-2-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20200908134521.6781-2-yung-chuan.liao@linux.intel.com>
X-Cookie: MIT:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2020 at 09:45:15PM +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>=20
> Add a slave-level property and program the SCP_INT1_MASK as desired by
> the codec driver. Since there is no DisCo property this has to be an
> implementation-specific firmware property or hard-coded in the driver.

Acked-by: Mark Brown <broonie@kernel.org>

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9Ypn4ACgkQJNaLcl1U
h9Dzggf8CeC4+qObdNWRVoM/vDjBHKmTecphR6nxQIObAN3+iyMQr/XRr1ogE3M7
IP6AkuTmKmE1I6/ux6klzsFt7pjp7I2lIXHQcBni/votOxbQOl6lKmcbnUmyIoBT
7zkyFU7e/TzUNv46LNgmAkq9/RWEuaBm3GZ4XCPsgSzEQgRM5TDgl+CWuipmrQtK
d7gDkReWkFwwcH2o4fPo6IDysPkL35ElClmiTHek94MPhGRZjysrLYc7DEGTz6YP
J0WQD12N9wAo0rKuo4KPKg3mUkKRl2gxHPxzmcg6QhN2cc00uUkm3GtrERX3QRwj
JLQ0OZl5T0MXW2KQVhoqfvZGVLy8+Q==
=VM+6
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
