Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C28BC11D20
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4545E20679
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582233191;
	bh=WWyzUA1/3KGbFO+OnNgAC6QlyJprNA98Iyh36wKBubM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hLrGBwPLSPz+TJrhKCVMvIV9c9NsWWhRATi2N5pHbCCY6SmsJBE0KjRp0clteqPul
	 /NnSZMxFVysXihA2Md+OkLvYqdOWge8tSf89qN5PpOXzW0Volk2ywlArbI/WuWSiJp
	 BsevMRLh6xjh1T/FkmiGtx/CSFVJE7NBGFPlQn2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgBTVNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 16:13:10 -0500
Received: from foss.arm.com ([217.140.110.172]:51816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbgBTVNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 16:13:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5489D30E;
        Thu, 20 Feb 2020 13:13:09 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF1D33F68F;
        Thu, 20 Feb 2020 13:13:08 -0800 (PST)
Date:   Thu, 20 Feb 2020 21:13:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ASoC: tlv320adcx140: Add the tlv320adcx140 codec
 driver family
Message-ID: <20200220211307.GM3926@sirena.org.uk>
References: <20200219125942.22013-1-dmurphy@ti.com>
 <20200219125942.22013-3-dmurphy@ti.com>
 <20200220204834.GA20618@sirena.org.uk>
 <5cc47587-eae1-0b41-e91d-f9885a69d75e@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zHDeOHGDnzKksZSU"
Content-Disposition: inline
In-Reply-To: <5cc47587-eae1-0b41-e91d-f9885a69d75e@ti.com>
X-Cookie: You are number 6!  Who is number one?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zHDeOHGDnzKksZSU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2020 at 02:52:11PM -0600, Dan Murphy wrote:
> On 2/20/20 2:48 PM, Mark Brown wrote:

> > This doesn't apply against current code, please check and resend.

> Ok this is against linux master should this be against your for-next branch?

Yes, everything except bugfixes should be against the current
development tree (in general things should apply on the tree they're
targetting).

--zHDeOHGDnzKksZSU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5O9mIACgkQJNaLcl1U
h9AAigf/XSG3d+KNbLVuCL5Fw8T1HHOJG6NywlmHXJaZPJ0z2+gYsdvF2Kjm1hcB
odwSuIDhGOchTcn9O6d5F2TybHL6aPN46peEIogqTQyqO9/sJapVMsjnxtQ8XS4Q
4+gI1ppGi0mDcy3RdmZ47oiNwNNyfDA3cZYB4ebhTeQc0jakJGh3f9mVi01OyMal
r3mcpqgbFv+3Ab5gtpDmBmPN5xJJO0AERVsn8n8E/QGmapqeqn2GT1VFpPfSCzWC
K+d+CNzQ6Y/L6z4b2L8cU63W2iq72hVC6cZE7x4OvxbzPKZR9sy+tUJgV24B7srR
FcuVbqydSQRPeiB1Cffdw+OihXNvkg==
=nOnE
-----END PGP SIGNATURE-----

--zHDeOHGDnzKksZSU--
