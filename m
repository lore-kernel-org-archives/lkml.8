Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D10C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E1BE208FE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599584317;
	bh=1oFmjQlUgTa71eRFaKWUQb7zp5miWus6zoZgGzOe5WY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nd63Sr1LAfmnjS1VL7gkvjnmTrVhz4ytfoqcxMxGis3sb8pPcw14/BtrT+swrDSsv
	 kyziLP5F9sSJq22ZMk2PNz0L1s89CCQbxI0VVe5ZSI/33wKrp4vICevhlEJ/WBEM0G
	 BHR9q+uTnGxZ1B28WX8doOLBuB5R9vyz9gpQeIMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732041AbgIHQ6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:58:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731864AbgIHQUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:20:13 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC429206B8;
        Tue,  8 Sep 2020 12:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599567137;
        bh=1oFmjQlUgTa71eRFaKWUQb7zp5miWus6zoZgGzOe5WY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SsM3uXHS3WpdsVZYPEApclhAwZMRIwwg/+fC6ZWLMZ34+WlbTavcoPCfeKBpDrq0P
         t/NZ9W7hdsJALfCsGcktqFz0jiBd8FBhTqmVmyEsMWZOzwMo9cZ8/DONK+XaQtT8QP
         Hn/eWkEW6gDH3zz/TEaICOdklnUmvTDAnZZxSrV0=
Date:   Tue, 8 Sep 2020 13:11:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, srinivas.kandagatla@linaro.org,
        jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 1/7] soundwire: bus: use property to set interrupt masks
Message-ID: <20200908121133.GA5551@sirena.org.uk>
References: <20200818140656.29014-1-yung-chuan.liao@linux.intel.com>
 <20200818140656.29014-2-yung-chuan.liao@linux.intel.com>
 <20200828065125.GI2639@vkoul-mobl>
 <ec5fe867-f2e4-4278-0376-e54bcdd7f94d@perex.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <ec5fe867-f2e4-4278-0376-e54bcdd7f94d@perex.cz>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 08, 2020 at 02:05:11PM +0200, Jaroslav Kysela wrote:
> Dne 28. 08. 20 v 8:51 Vinod Koul napsal(a):

> >>  sound/soc/codecs/rt700-sdw.c    |  4 ++++
> >>  sound/soc/codecs/rt711-sdw.c    |  4 ++++
> >>  sound/soc/codecs/rt715-sdw.c    |  4 ++++
> >>  sound/soc/codecs/wsa881x.c      |  1 +

> > This touches codecs, can you Ack it please

> Mark, could you ack the ASoC change to accept this patch via the soundwire repo?

I don't have this patch and since I seem to get copied on quite a lot of
soundwire only serieses I just delete them unread mostly.

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9XdPQACgkQJNaLcl1U
h9A5ngf+OrSLYDYVzhuanGeitM41iGcNjpTuhcMxyOTDKbQbseAq9/Ho+tDeS7by
cIPCEOX9UaRBBlqeursubOr0+EXPmtZGo5t3NqZ6MfOtpZlpcwMq4taAAokRSZBw
E6uNY6NDb2qP3RoTJ1UIR5qbz80uBgVtIRH58O4LQ3qrk1lJ3qbbi4lZCt1kwZ0p
D2au1Cuu6iUw0VJ3Or+Rt82XQvE4QesxmlfYR4yCZHw5M4y7c1jFTJa1knNvBcXe
7C5xmIG/XjqV3yzZgvyosEC1UecbE4R1ibauAx8FDPVahRRYGgeoDArzc/+64OyD
XLbOiBKLJhbWo4M1CKMEuuVWA2FzKw==
=UJFU
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
