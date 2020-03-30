Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D064C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42939206F6
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585568963;
	bh=+ozbIfPuSmA7IOwW9BeuVgnEzn3EoW0JO7c0c47xUi0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=IBvMaTabozCMUS44J33iVdA0FmeaRCrT9BUlr+wnBCSvYl4Yj99uF3ypTXg675KCC
	 UnYY31Rljy1gbTAIbTwGqmzlnKDeds1ZsijKLeawm4jtfpZIJhXkm9mH2dSptZmixV
	 wF/TsLMpQYHVz63zU9T3FdYqy9ywRORvbZ78Fjp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbgC3LtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 07:49:22 -0400
Received: from foss.arm.com ([217.140.110.172]:51554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729669AbgC3LtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 07:49:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B7B931B;
        Mon, 30 Mar 2020 04:49:21 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E237B3F52E;
        Mon, 30 Mar 2020 04:49:20 -0700 (PDT)
Date:   Mon, 30 Mar 2020 12:49:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] regmap update for v5.7
Message-ID: <20200330114919.GG4792@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hTiIB9CRvBOLTyqY"
Content-Disposition: inline
X-Cookie: Ahead warp factor one, Mr. Sulu.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hTiIB9CRvBOLTyqY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 2e31aab08bad0d4ee3d3d890a7b74cb6293e0a41:

  regmap: fix writes to non incrementing registers (2020-01-21 17:16:26 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.7

for you to fetch changes up to ad5906bd6e9aa3e156dcac8fc070b153648e8b68:

  regmap: wrong descriptions in regmap_range_cfg (2020-02-19 18:12:31 +0000)

----------------------------------------------------------------
regmap: Update for v5.7

Only one small documentation fix for regmap this time around.

----------------------------------------------------------------
Phong LE (1):
      regmap: wrong descriptions in regmap_range_cfg

 include/linux/regmap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--hTiIB9CRvBOLTyqY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6B3L4ACgkQJNaLcl1U
h9BTAwf/cTb3fj0rWEstA8QfHR2qZE1CHDEPP/Mi44LCUAV7hxy/DdwJfrmRnffR
rEaUajKZ7q4QUUXd5/dyDHgj8TzGBpPLLYTfXz9mTSLc14oWoNNjfb46I+vNmuvY
oqIasmKJgaet+93H5IYOUbdwEI4ipclNgREZ4mg/5lE79xtYeE1TMPXO3FJu+04f
paEpHVzTasJN1EslUBCYZrR90q82Phe4tcoZNMv+8ArNI8DmaMvglcJ1brprRFuG
hC/XGFzv62M1epy+as6KxUUzpvc8IVLDf/ccA3ttNzELKxKFzXs2mioeqONz4JZ/
yaJjN8/MNPoP5qiFeHG8sRC0bBOBPw==
=O2Ef
-----END PGP SIGNATURE-----

--hTiIB9CRvBOLTyqY--
