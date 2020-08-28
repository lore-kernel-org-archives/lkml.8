Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D1DC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD7732086A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598611628;
	bh=tt8MF935pgWSjZW0cf4zzJI7hbVdJsomM9xcAT1mgm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ktgO3EIzaguKfHT6q8t0paAgARNpo138xIK0y0GcmMqtHXhF05aLB9D566HwZH2k5
	 XEpb/STuvtvmwPT6cbmzRKnxtDtn/nMmDggIehIC7FOPYx9y9V2O8qxDO7jSyAPF7P
	 Nbwcp8mLRWX/OlNKr88hJ2Uf10IC080frY8cBPb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbgH1KrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:47:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728680AbgH1KrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:47:01 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 917692086A;
        Fri, 28 Aug 2020 10:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598611620;
        bh=tt8MF935pgWSjZW0cf4zzJI7hbVdJsomM9xcAT1mgm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=olxNBFuslEexXluDdwpqUa0h6J1xoaS6MQi3/kEuynXo7N7i2aGXN7IEUf1I2lsOZ
         vNKi1OKi7rPMajX9OTxgP1p6gW6rflN/uy4Je+Kt/2g2QKxy9d78n4lkw+yrpRUGh9
         ko4IO5Cpa1hBJWOf1umJsu8WYToOoOtHxlyB7doQ=
Date:   Fri, 28 Aug 2020 11:46:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Liao, Bard" <bard.liao@intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "vinod.koul@linaro.org" <vinod.koul@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jank@cadence.com" <jank@cadence.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "rander.wang@linux.intel.com" <rander.wang@linux.intel.com>,
        "ranjani.sridharan@linux.intel.com" 
        <ranjani.sridharan@linux.intel.com>,
        "hui.wang@canonical.com" <hui.wang@canonical.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Kale, Sanyog R" <sanyog.r.kale@intel.com>,
        "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v2 3/3] ASoC: codecs: fix port_ready[] dynamic allocation
 in ASoC codecs
Message-ID: <20200828104622.GC5566@sirena.org.uk>
References: <20200820182639.11572-1-yung-chuan.liao@linux.intel.com>
 <20200820182639.11572-4-yung-chuan.liao@linux.intel.com>
 <DM6PR11MB40746716F856166D61EE573CFF520@DM6PR11MB4074.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline
In-Reply-To: <DM6PR11MB40746716F856166D61EE573CFF520@DM6PR11MB4074.namprd11.prod.outlook.com>
X-Cookie: Your fault -- core dumped
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2020 at 08:24:19AM +0000, Liao, Bard wrote:

> Sorry to ping you, but the patch is really easy to be ignored since I
> forget to add ASoC prefix  in the cover letter.
> Could you Ack it if it looks good to you, please?

I don't have this patch any more, so like I always say please resend:

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9I4H0ACgkQJNaLcl1U
h9B1Pgf/XnMsFTcV918d/rXMNFkYQurZB+NWC2RyBeSc1kt+ym6gWVm0UEu4ZwQz
zqCVr2fKuTlbomNtGmNw1BrrmdaDieUtJisVI48u7EdFPg+IVR6bxfePBHlPoFcM
hgnNoVMnhenD4+rh9mEGBy/Ro9F6Cp/9bTjws56bwm7ncCShDT0+O/FgGuO9enRx
jys4MGr9NU21WWtayqjilu82knuqgzTxze54nZwRU8p5KXv+mL0Hl8i73EB7m5iq
FmlFWSGX+QbkGbZjmh0t+4Qj2343DEzdFzDz1rDzvFhcBuoap9aJqA7we7Se+Neg
B15SPTf8mqAfKYVXCKR1IxI/oyRMNQ==
=eNS/
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
