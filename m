Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F8DC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 17:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C98E720767
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 17:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586884336;
	bh=iLPDmCamHeBUANt3XfQx2QQ0FRA3glnRqO+sB/D26/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NP+gBShPP2CxheXF9ngkMh2mcxySD75vaazmthnsqv5pyKjf8ICim6A1/AnidxZBW
	 SRbJ3JxUJJ0ChExBjuR3mSR/QDviCyLViA4ZbeKW141FhNPs5Kp7BVxz6DDZsD4rXY
	 deBTG8EPQ3v1iGY+IcaCO75IMRR2EOhFWTWRVSOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407575AbgDNRMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 13:12:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407517AbgDNRMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 13:12:12 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EF6B20767;
        Tue, 14 Apr 2020 17:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586884331;
        bh=iLPDmCamHeBUANt3XfQx2QQ0FRA3glnRqO+sB/D26/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OUr2iIHB+9sCs9gZlvoyHl49521GFxDIz6kiPIx6s5Cbd/OkUkkX0gd/OGdYlZSVd
         Yh4JoKVMYh9r8MzXW5llULxI+iR+ZbfW3kXhS5V6NSSn/umlmZajRMTqqEIWl+hRVm
         wEEMXNyfSLJLxIjPkonDW63VHkqj3fMnttJV/M0s=
Date:   Tue, 14 Apr 2020 18:12:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     lee.jones@linaro.org, arnd@arndb.de, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/3] regmap: Add bus reg_update_bits() support
Message-ID: <20200414171209.GH5412@sirena.org.uk>
References: <cover.1586757922.git.baolin.wang7@gmail.com>
 <df32fd0529957d1e7e26ba1465723f16cfbe92c8.1586757922.git.baolin.wang7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GBDnBH7+ZvLx8QD4"
Content-Disposition: inline
In-Reply-To: <df32fd0529957d1e7e26ba1465723f16cfbe92c8.1586757922.git.baolin.wang7@gmail.com>
X-Cookie: I've only got 12 cards.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GBDnBH7+ZvLx8QD4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 13, 2020 at 02:13:20PM +0800, Baolin Wang wrote:
> Add reg_update_bits() support in case some platforms use a special method
> to update bits of registers.

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-add-bus-update-bits

for you to fetch changes up to 80215f133d59310fdfce5ee4398aeb7076c2e99f:

  regmap: Add bus reg_update_bits() support (2020-04-14 16:05:35 +0100)

----------------------------------------------------------------
regmap: Allow bus update_bits() operation

Allow buses that provide custom operations to provide a custom
update_bits() operation.

----------------------------------------------------------------
Baolin Wang (1):
      regmap: Add bus reg_update_bits() support

 drivers/base/regmap/regmap.c | 1 +
 1 file changed, 1 insertion(+)

--GBDnBH7+ZvLx8QD4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6V7ugACgkQJNaLcl1U
h9Bj6Qf9GRDxeJWPL23ha9p1MgJ+9PmbWDNdIkPokFlHgqssZGj36IiVdeRJJ+xX
8g9JkkCTJ78I9RQzzYUwa7ap1Uj369VpzlTi79BP40MLYScigyPV4y98sFANdbos
xX+cBkko1uCk1EMtNfIomfFm0Q5UI58M4s80ULDJPfsP0zV6brO8Y4O4fXU6cWwe
lLcRhggZdNHX24cFY9Et/7PLw0tIqgVl9c3O1eFQNdME14GSyCZiun4mvQEM8r/O
h4byq1Cniw1zsJLN3YKyGA33gBvNh7TadmuBmZ39hqbguD00GX5zw1wCxOoZt+qk
8uH96PJLk9Wz0cEuPj5GZgHQ6kHZsg==
=HjPp
-----END PGP SIGNATURE-----

--GBDnBH7+ZvLx8QD4--
