Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F24C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EA992070E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592921300;
	bh=W8SifQZMmjCYOz9qiXwOH2QVh2XWoUWbt24ej70khxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rSHjyAFEjbJywbfHXasWTqbB15x1aFS/ciogbArzQCce6njkohqcMeU03UmjEhzcx
	 s+ZkT2joKp3LXNLXtjlUSndLsjO4WP1hoGKXdtZmdg687wjjipGV2EXMaXUI7/pNrc
	 wg2oKvhY3x9Owv5pstZumH/MtYt0NlVtXXgjXmWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732803AbgFWOIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:08:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732698AbgFWOIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:08:18 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D41420723;
        Tue, 23 Jun 2020 14:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592921298;
        bh=W8SifQZMmjCYOz9qiXwOH2QVh2XWoUWbt24ej70khxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s5IZW2unLbgPcf1GaXFLgEYZkEpAwlHKNREQy+AWFQWgADend2w3xj37HI3ZnMxoY
         e8S87CU7nCCyEn/88gb3SOmk5G9NovgAKDbzAeKUq7MGfMKxllqbYk1fw1CMlhlpts
         cVbTTbU819ljJGLFxkJDcC17wuzu2rplU0wXHYO8=
Date:   Tue, 23 Jun 2020 15:08:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lars Povlsen <lars.povlsen@microchip.com>
Cc:     Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v2 3/6] spi: dw: Add Microchip Sparx5 support
Message-ID: <20200623140815.GF5582@sirena.org.uk>
References: <20200619113121.9984-1-lars.povlsen@microchip.com>
 <20200619113121.9984-4-lars.povlsen@microchip.com>
 <20200619121107.GE5396@sirena.org.uk>
 <87imfjxtrq.fsf@soft-dev15.microsemi.net>
 <20200622121706.GF4560@sirena.org.uk>
 <878sgddh2l.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ChQOR20MqfxkMJg9"
Content-Disposition: inline
In-Reply-To: <878sgddh2l.fsf@soft-dev15.microsemi.net>
X-Cookie: No motorized vehicles allowed.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ChQOR20MqfxkMJg9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 23, 2020 at 03:53:22PM +0200, Lars Povlsen wrote:
> Mark Brown writes:

> >If there's a mux that needs to be handled specially that mux should be
> >described in DT on the relevant boards, there shouldn't just be
> >something hard coded in the controller driver.

> I looked at the spi-mux driver, but that is more for muxing the CS's, as
> I understand - not the actual bus segment. I could use it, but it would

It doesn't matter that much exactly what signals get switched I think,
we can't really tell by the time we get back to the controller.

> require encoding the bus segment into the CS (double the normal
> range). Also, selecting the bus interface is tightly coupled to the
> controller - its not an externally constructed board mux.

It sounds like this controller should be describing a mux all the time -
if there's completely separate output buses that you can switch between
then we'll need to know about that if someone wires up a GPIO chip
select.

--ChQOR20MqfxkMJg9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7yDM8ACgkQJNaLcl1U
h9BfZgf+JDO/cCKJ4sjkHrz8THiBZ35D3xuuzurTm4Tr8gePq3LGdQdvbnaLi+kh
ybEPdfXHOunOJtY1eV1Loo3ckwW0KEOLa5M8GuFXFicZmomG51V+/5Xx0tuf27lS
sK5o15TjgRKD3PGmIrquSL3vdunu/X2xkV7HT5IS9sv2t6Iwh/ulyFIgD0Q/dUS/
rTIMg7VaQAiEVYtnheZdDHIAxS8Djgwj5u4im0Wv+HtKDa4MB0GtGOB/lV9YOkzv
DKPm2/KgoSvBGALhUslEHDJCae8z642b13PnX4vCYgCNn5fm38/a3gk3GNQWd1l5
hJvmc2AR85/s5cD47zvzaPRz1pl35w==
=7Tnk
-----END PGP SIGNATURE-----

--ChQOR20MqfxkMJg9--
