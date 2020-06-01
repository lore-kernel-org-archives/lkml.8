Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C40C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C07AD2074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591009676;
	bh=caREpQpA8csTUZs4FnhILO+HMcvsNx+fyqfYJiN/Tbw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=XXCMeunJ2lNHcRmpqb9lNHyoIX+QK/xEB9hu8gc4f0BQPZrr6bmLZurp0uKIfC7+G
	 UVbKT416deiJrO1PlQbtloLmMh/MZC75Bf2ZN7+hQNWkLVN1kD3FhpGqF694Hn1mtP
	 P9DvF4NwLSmNNUdPymdaPLTAXObokwG1As2LtaG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgFALH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 07:07:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbgFALHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 07:07:55 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C2832074B;
        Mon,  1 Jun 2020 11:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591009675;
        bh=caREpQpA8csTUZs4FnhILO+HMcvsNx+fyqfYJiN/Tbw=;
        h=Date:From:To:Cc:Subject:From;
        b=j61VqtIOoD+OwCYB1XG3jPiOaSVGI6F6wkwQIVvGMpONoKyb7oI7lUT+dhvXcc5nM
         8eEFMVMWTyTsMYBS4s1mLGLHIlQAahUAYDQqT2sRe6rVQsKOprjwsKq1XrxqaVrHkd
         7kE1ji8ZipkdVuKnVkW3GKM1fMHYLvYItcFS42CI=
Date:   Mon, 1 Jun 2020 12:07:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] regmap updates for v5.8
Message-ID: <20200601110752.GC5234@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 9cb1fd0efd195590b828b9b865421ad345a4a145:

  Linux 5.7-rc7 (2020-05-24 15:32:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.8

for you to fetch changes up to 9b98f92ca446f4302607a88fbb67619af968f3cf:

  Merge remote-tracking branch 'regmap/for-5.8' into regmap-next (2020-05-29 14:03:32 +0100)

----------------------------------------------------------------
regmap: Updates for v5.8

This has been a very active release for the regmap API for some reason,
a lot of it due to new devices with odd requirements that can sensibly
be handled here.

 - Add support for buses implementing a custom reg_update_bits()
   method in case the bus has a native operation for this.
 - Support 16 bit register addresses in SMBus.
 - Allow customization of the device attached to regmap-irq.
 - Helpers for bitfield operations and per-port field initializations.

----------------------------------------------------------------
AceLan Kao (1):
      regmap-i2c: add 16-bit width registers support

Baolin Wang (1):
      regmap: Add bus reg_update_bits() support

Bartosz Golaszewski (1):
      regmap: provide helpers for simple bit operations

Dejin Zheng (2):
      regmap: Simplify implementation of the regmap_read_poll_timeout() macro
      regmap: Simplify implementation of the regmap_field_read_poll_timeout() macro

Marco Felsch (1):
      regmap: add reg_sequence helpers

Mark Brown (6):
      Merge series "Add new reg_update_bits() support" from Baolin Wang <baolin.wang7@gmail.com>:
      Merge series "Add support for Kontron sl28cpld" from Michael Walle <michael@walle.cc>:
      Merge series "New DSA driver for VSC9953 Seville switch" from Vladimir Oltean <olteanv@gmail.com>:
      Merge series "regmap: provide simple bitops and use them in a driver" from Bartosz Golaszewski <brgl@bgdev.pl> Bartosz Golaszewski <bgolaszewski@baylibre.com>:
      Merge remote-tracking branch 'regmap/for-5.7' into regmap-linus
      Merge remote-tracking branch 'regmap/for-5.8' into regmap-next

Michael Walle (1):
      regmap-irq: make it possible to add irq_chip do a specific device node

Peng Fan (1):
      regmap: debugfs: check count when read regmap file

Vladimir Oltean (1):
      regmap: add helper for per-port regfield initialization

 drivers/base/regmap/regmap-debugfs.c |   6 ++
 drivers/base/regmap/regmap-i2c.c     |  61 ++++++++++++++++++++
 drivers/base/regmap/regmap-irq.c     |  84 ++++++++++++++++++++++-----
 drivers/base/regmap/regmap.c         |  23 ++++++++
 include/linux/regmap.h               | 109 ++++++++++++++++++++++-------------
 5 files changed, 228 insertions(+), 55 deletions(-)

--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7U4YgACgkQJNaLcl1U
h9CsOQf/fOCyw/eetluIyuL7OXKJY0lQYIuwofm62HEgEYBm1Faheg9UB/ZvoBgF
Q4r2s+D/CJDyCo9asW2WS/HYRvTDJfFezwwEu6aTUfj4oNjyIpVNubVNaJyTZc2v
GRuM11hCd2/fhzF1cflIqgsT7TnJISaP4iZ0EzP7dq+PxqoXTGC0SMExA067IP2f
/fJE9HZtFbtxbi7vsaiQI7aE3pRijomFBczxbxNj13W12RZffJDzzVAYIUQoAavA
GsNktyHDZ029JiNX2/ibeJXHl8isAB5xS+0MWxs8ekEfWBlTqkmrlJCzIG6lB00E
Zo94hFxktrRGBL5ZV8obPW/7DEhcPw==
=zTVv
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--
