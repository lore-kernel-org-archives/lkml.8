Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4649C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACF852078B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597747506;
	bh=V2xRo09r41goWcHkv/TbZqQoAC4ijfdpV8AhWqNHVa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Sew0eZJiC3+aGmi8eIplH9p3MLAh54QsRbKZqfbhp2iUgbKgFRCSZ/LzArhkhoSdl
	 JRHdkCICMfQYIl+ri1Uhr/Rsmf3yOouT64PgPCgZvx9qeoTr2A3qZpQq9xQTIzg100
	 SWIGWm6mm3jjpqm+xPM+gl5bm5pbNapBFQsMF5fo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgHRKpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 06:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgHRKpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 06:45:03 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4408204EA;
        Tue, 18 Aug 2020 10:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597747503;
        bh=V2xRo09r41goWcHkv/TbZqQoAC4ijfdpV8AhWqNHVa8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fh5UJUtv8etbELwMr2WpcfExLHbDpbyxc8JOao7kijScx1xcMrMp2cxAMpUru677p
         m9jcw94Zv7743Oy88oRexPOJWKKsp3xONJUS3/SWF4Dv6qL0cjeTppw8xJuMheqfxZ
         LTzaqXDgyTnnreT1mV1S2GX3/m2Q6XYGFyIC8AGc=
Date:   Tue, 18 Aug 2020 11:44:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Allen Pais <allen.cryptic@gmail.com>, perex@perex.cz,
        tiwai@suse.com, clemens@ladisch.de, o-takashi@sakamocchi.jp,
        timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        keescook@chromium.org, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Allen Pais <allen.lkml@gmail.com>
Subject: Re: [PATCH 00/10] sound: convert tasklets to use new tasklet_setup()
Message-ID: <20200818104432.GB5337@sirena.org.uk>
References: <20200817085703.25732-1-allen.cryptic@gmail.com>
 <s5hsgckl084.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
In-Reply-To: <s5hsgckl084.wl-tiwai@suse.de>
X-Cookie: You're at Witt's End.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 18, 2020 at 12:25:31PM +0200, Takashi Iwai wrote:

> Mark, may I apply those ASoC patches through my tree together with
> others?  Those seem targeting to 5.9, and I have a patch set to
> convert to tasklet for 5.10, which would be better manageable when
> based on top of those changes.

These patches which I wasn't CCed on and which need their subject lines
fixing :( .  With the subject lines fixed I guess so so

Acked-by: Mark Brown <broonie@kernel.org>

but judging from some of the other threads about similar patches that I
was randomly CCed on I'm not sure people like from_tasklet() so perhaps
there might be issues.

Allen, as documented in submitting-patches.rst please send patches to
the maintainers for the code you would like to change.  The normal
kernel workflow is that people apply patches from their inboxes, if they
aren't copied they are likely to not see the patch at all and it is much
more difficult to apply patches.

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl87sQ8ACgkQJNaLcl1U
h9AXXgf9Grt6q+diq7m3+Va9EPuojISFzp0rHACAAAE39g0r2Kzx/g53wYjT8uoA
Yr6dm9ajOxkGjqsZp4Zsp6iSabfuXuEAi9qBBBkCJlatDiEWwObS4X77VNUE82lo
U7d2ljdnsbtM/zTfYjc63OaAstv4bXWHm+NtjgJhiO155DifPsUOW8js8IPoSlN+
XDEPT0VVKs1syY90ef4oz7i/aTnOKLlGEejv1YHLRkvwmQyWbjZOo83UHSuB7IPB
GeTWC/+jE9ujCAKoCFmW8la4LWjfn8yV15s0LI7OFBFZZQoulBBhC7Dp316u5wsw
B2jWhNhnIJc8tG4nAuopeUqjHqIKYA==
=oDDH
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
