Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645B9C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 419E920775
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594212554;
	bh=Uqa5Ixx9A8DkN2H2K4w6mWtGsN4oJbAFIYsvEF105uM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1rGABpptcUjpBTrNB/I/frhPmDZ+k+fK107PobLVm/12BFgxn6Op8Zzev+E0TJ4RD
	 /F845WkJjkZsMmL11ZYHbW2CZi1KmD/YXl34VcuulMcnz7OM5pBp66aavEK2MELIvU
	 ay07x9cVsI3+GU6ax64cOHFmDpvh61MGao0t8fTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgGHMtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:49:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729122AbgGHMtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:49:12 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B4A620775;
        Wed,  8 Jul 2020 12:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594212552;
        bh=Uqa5Ixx9A8DkN2H2K4w6mWtGsN4oJbAFIYsvEF105uM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oKbE2oFg2VMewf3p7Ik1zsK0oPUYm+PwxqnkQ3WyNwSaGQ+vK8bZ9pf7YiB1ykQXH
         XU3WCRTnd/8w1PxUBPh0r2Sq+WwCReWyrIGJMMqt77XDx21WOrQ4qLYv3To6Ef4nbj
         c5RMeN5svZBNGIr/TZziTEiSoPwEkXfcdR2Eldbs=
Date:   Wed, 8 Jul 2020 13:49:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        akashast@codeaurora.org, linux-arm-msm@vger.kernel.org,
        mkshah@codeaurora.org, swboyd@chromium.org,
        georgi.djakov@linaro.org, ctheegal@codeaurora.org,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 3/3] spi: spi-geni-qcom: Get rid of most overhead in
 prepare_message()
Message-ID: <20200708124903.GN4655@sirena.org.uk>
References: <20200702004509.2333554-1-dianders@chromium.org>
 <20200701174506.3.I2b3d7aeb1ea622335482cce60c58d2f8381e61dd@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Xb8pJpF45Qg/t7GZ"
Content-Disposition: inline
In-Reply-To: <20200701174506.3.I2b3d7aeb1ea622335482cce60c58d2f8381e61dd@changeid>
X-Cookie: Oh Dad!  We're ALL Devo!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Xb8pJpF45Qg/t7GZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 01, 2020 at 05:45:09PM -0700, Douglas Anderson wrote:
> There's a bunch of overhead in spi-geni-qcom's prepare_message.  Get
> rid of it.  Before this change spi_geni_prepare_message() took around
> 14.5 us.  After this change, spi_geni_prepare_message() takes about
> 1.75 us (as measured by ftrace).

Acked-by: Mark Brown <broonie@kernel.org>

--Xb8pJpF45Qg/t7GZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8FwL4ACgkQJNaLcl1U
h9D4Rgf/Uva2syJm8KRxZ3zqSrynarhaL0MlZwq4rb26hTPp7LnZs8TIOfboQ2aP
ReLvfYszSbgQhhIFxtZAnJAVpwEz2twAVROsnO0/K26NmqaV5/p0Z1KyPCPfgQfW
N7LN4MOtDh97n84llxMtJJG8P8Tqoje0YRAuQdwSIC9LkcRCvNe02yRdJ9cnPMzX
OTOYc4avIDtmWA+t+K7nyDJ1RoQmAqDyejMsUEy32LO1UmlW64hZ8njrNyZRisUu
+8XdZqLO/aiQOTxuvxXbTH7ZltyFd+kkwlksVqDVVto2THb5RDJ20/+MdU8arQYF
sN8xdQTvufuZYgkETqAeW5REBVttHQ==
=/s94
-----END PGP SIGNATURE-----

--Xb8pJpF45Qg/t7GZ--
