Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C09DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D89122080C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599584285;
	bh=LCVrNQR0n6xhi0XBZwi5U5vpkEB09Qnglc31/QkieYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=skmq0jy36/FhPE9oOQIQL0yNLcygOqXI0LPl1LiEm4JFWNnmZFm8q2nKcYWrMQSgM
	 K/SQDgWYTy9YfCzPqp/35AJGWcI1ICqjbATLw1zXbKiZPZ1GWrIM7+EZK9HQ/fcePS
	 DtByOi5luCsztQ5UJra4GP780dkUdZdokoE3FQJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbgIHQ56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:57:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731881AbgIHQUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:20:22 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E58DB20757;
        Tue,  8 Sep 2020 12:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599568244;
        bh=LCVrNQR0n6xhi0XBZwi5U5vpkEB09Qnglc31/QkieYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DXCSd7t5qrdH9m1+fHgrswDu7ZjOP5DBBxLFjMNaquYzAPaptSWyAQX3DMmAYnnJd
         DY8JMPb8cajDuqwfvfmIi98Tya65Sgy0eNNhrvWp1YTumS7V4KvGatBXZBCABpZlSc
         9TgJLrrTI6V6SX6nl+3kmQ3l7Dy6mTZJ2BJW6mUQ=
Date:   Tue, 8 Sep 2020 13:30:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, vkoul@kernel.org,
        pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org,
        tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, srinivas.kandagatla@linaro.org,
        jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH v3 0/3] ASoC: Add sdw stream operations to dailink ops.
Message-ID: <20200908123000.GB5551@sirena.org.uk>
References: <20200904182854.3944-1-yung-chuan.liao@linux.intel.com>
 <46f44acb-7d4b-965c-a6e2-98a4da79e6cc@perex.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <46f44acb-7d4b-965c-a6e2-98a4da79e6cc@perex.cz>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 08, 2020 at 02:26:14PM +0200, Jaroslav Kysela wrote:

>   "[PATCH v2 0/4] soundwire: Remove sdw stream operations from Intel" and
> cannot be used standalone. I believe that one maintainer should accept it or
> there should be a co-ordination between Mark and Vinod to push this in sync.
> We should really settle, how to accept such changes. I believe that Vinod
> should take it with the ack from Mark for this case. Please, don't require to
> split changes which depends on each other.

Or just tag the bit from Soundwire that needs to be shared so I can pull
it in which is the more usual way to handle this sort of thing.

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9XeUcACgkQJNaLcl1U
h9AAhAf8Cv4OT4BdkRuxqIJ/Qar6kTiZLfYGNEOoPVZNRwbCufv0AHEr6lJUzJ27
AgXDTxC3dpvdMa1thezGg21uizwh54Z2eItpFBgQ8vjPCfBYTpZJalkWFHYpQhd9
xsmY1SfHOJvwE9cOVCiXnKcunwMMd59b8Djn8G+AQjkzBByq8yEKBqWLjgDi559m
/oIRmt8i+WC1eDIjuLTW2bVjwdr49V8B1101ru4D0L8xsaRywHon0ovrzsFj2FvQ
yg9o0NSgdPCDvPdSKxrm8gUoS5Xwww5wNhY6bcITuuPTa52EnN0q+VUdN7hTJC1B
56LjFe1YSYeLxlIlxsb/STxUYRPVrA==
=oa2A
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
