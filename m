Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5E4C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACB212074B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591725185;
	bh=TgO873VK1uWIKP3ppDJ9nGZ4WoqU168LVpBfn9JCTYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QUi7I7fzVIp+m1Q6Qvj8OesHGqZXsH2rSwTPK+48UYiStlshCRcFo1akWYvcTY5xm
	 oNeGduyOhGXlnM8nXnC4zkIBf2z6zJ8jHmmOCKRebGdWUs9kQZrcwM3wmZ6a3LSXgQ
	 120gecQKtVqXyG3Yo9leacEO7j0tf+16j5Fpr4d8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732993AbgFIRxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:53:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732760AbgFIRwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:52:05 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3D05207C3;
        Tue,  9 Jun 2020 17:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591725125;
        bh=TgO873VK1uWIKP3ppDJ9nGZ4WoqU168LVpBfn9JCTYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=flY6tw4scXwcHAh5ndeODhVjKU39UiDaLUXkNgJF/VeacAKgTqHUSgyi7yWttmL2C
         dM9+M9jBx7AUtHP71uzwM8FS45GEfL+rpx7XhyaPu/XscJ137rzdA/NcQT7giIjpj6
         csJPNwgawxwvmK6IpC14ubbfssZ6sBrSNQmrMXks=
Date:   Tue, 9 Jun 2020 18:52:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        robh@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] TAS2563 DSP Firmware Loader
Message-ID: <20200609175203.GP4583@sirena.org.uk>
References: <20200609172841.22541-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uQ3BaAlxDi9XKvis"
Content-Disposition: inline
In-Reply-To: <20200609172841.22541-1-dmurphy@ti.com>
X-Cookie: Be careful!  Is it classified?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uQ3BaAlxDi9XKvis
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2020 at 12:28:39PM -0500, Dan Murphy wrote:

> These programs and configurations are selectable via files under the I2C dev
> node.  There may be a better way to select this through ALSA controls but I was
> unable to find a good example of this.  This is why this is an RFC patchset.

I think you can just use enums for most of this - what you want to do I
think is parse the firmware, build templates for the controls and then
add them with snd_soc_add_component_controls().  Userspace *should* cope
with controls being hotplugged.

--uQ3BaAlxDi9XKvis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7fzEIACgkQJNaLcl1U
h9Bd3Qf+M45/dHXuPejpoJQrP/PmR/7OYTmNoSJSL7fxpGkoxNV4A5VdPFEM7ZmP
rfspDqlxdJ9jDVZhCyTaRzlFP9VaklY/9EFupR5qc6ms6ZKdjYrcjWc98Cqlk+d1
RAN0Y4oxlqfxAZZKlw6ZHFLCMBHdV/vkOBGNZdiiaBqAFprXUVnqlevuGW8Lv7s3
yDf1Te02bvervNfinPb53nj6QtFoBwixBR8E8zdKINv1ZP8q31YF7c8j/0tvyMkQ
LZ6OhieBzZeb4YFR7/sieJVpr60qnUKefrtUaPWaJLrFtPb8vuuPmVK+jO4AQ4gF
5WqFDT0NEUZuTrTzITUHxyZZkRbq9Q==
=8iWz
-----END PGP SIGNATURE-----

--uQ3BaAlxDi9XKvis--
