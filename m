Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB8DC4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A6B21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OzRmdZuY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbgBZVor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:44:47 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33865 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbgBZVor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:44:47 -0500
Received: by mail-pl1-f193.google.com with SMTP id j7so237557plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 13:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=AZZieTb0ooqXHRXN3smm7F8J1uHIqS+LbMJIDQk//CQ=;
        b=OzRmdZuY7JrcPH64OgmXaEXDNA3tbPgT/H+Y1d0GQ0MnRm4cVGhgSDVEwVMIMVDIjt
         0Cas6UuejrObJK4CFwbuSUCwDiLkSI0kzFL2P0kzhDV9+m/hwibAWz2zPtO4Rdcap9H5
         lfQgaMVkRI2x0BuKAPZmLr29nK5ZEt7uCmwnSUezQ22I76VmPHnvffP3tl4QF0X1Y10G
         2WKdT6Vchv9UEcKcdA4euQODrF/mFn9NL+H3MpVkQJAdeE70hqkXcTv2nhnCsm6z7dqv
         pnYtSYpQrcGqKkgiPDKBqK5rT/+bG3jDY0W4Up0o3cfwt51doqnzceASdQAKUbxILKUj
         cEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=AZZieTb0ooqXHRXN3smm7F8J1uHIqS+LbMJIDQk//CQ=;
        b=Wdp2xrJae8pAsmVVYxp4dOuAcvgt5SEcn5xAC6389ZWuDxiD+Es3MP6NA+J0qvQSQu
         OJjnxPLtGKTFG/0hkqbYyYI1FOkjEyZXYveQMmX6SDkXwBQmcVr/2ETpp4r81E9dtMXh
         TV+jieCLRb3dz6jgrYloPfJigBvtdistoFijLqx9Aqkf4CyJ/IuwH+iWg4cV4470o/ua
         LBD+xeDXN1y1APd2WRboPmuNg3Kum0bqncWuo8rFxMQoSUT+uU+Vsoeyf/TtdxVF7N6V
         V19qCVvA/IQXgvEb+pqCGkSYIfF5arhzSWF1qjBOGd2u2LYd087lZ5I+Jnllrv6p24gA
         O0SQ==
X-Gm-Message-State: APjAAAXDaYhy0s3PZTiiOAmWqv6BRQp2Q/HBtQk2Ig03BEP/hQz0uKPp
        UGqTjop7QcSUZ96RVqeGKrG0Kg==
X-Google-Smtp-Source: APXvYqy/ub3YyEQgwwAdSIbBr+DSZkYESGjl2lep12UqTi7HOQSKdVkIwxxsFeWpNiSj357LDQQx3A==
X-Received: by 2002:a17:902:76c7:: with SMTP id j7mr1337449plt.45.1582753485548;
        Wed, 26 Feb 2020 13:44:45 -0800 (PST)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id q66sm3470604pgq.50.2020.02.26.13.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 13:44:44 -0800 (PST)
Date:   Wed, 26 Feb 2020 13:44:38 -0800
From:   Benson Leung <bleung@google.com>
To:     torvalds@linux-foundation.org
Cc:     bleung@kernel.org, bleung@chromium.org, bleung@google.com,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] chrome-platform fixes for v5.6-rc4
Message-ID: <20200226214438.GA207119@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git t=
ags/tag-chrome-platform-fixes-for-v5.6-rc4

for you to fetch changes up to 0cbb4f9c69827decf56519c2f63918f16904ede5:

  platform/chrome: wilco_ec: Include asm/unaligned instead of linux/ path (=
2020-02-11 09:10:36 +0100)

----------------------------------------------------------------
platform/chrome fixes for v5.6-rc4

Includes this commit:
platform/chrome: wilco_ec: Include asm/unaligned instead of linux/ path

Fixes a compilation warning.

----------------------------------------------------------------
Stephen Boyd (1):
      platform/chrome: wilco_ec: Include asm/unaligned instead of linux/ pa=
th

 drivers/platform/chrome/wilco_ec/properties.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Thanks,
Benson
--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXlbmxgAKCRBzbaomhzOw
woZrAP9McK3b9SKIttjcjQhoDNuzao9mPF+hPYoLHXZLg4tCqAD8DAVUNFaCPxcf
5QJ3SRq9aL9bHkkY0q54zXfxEWvoDwQ=
=+GDJ
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
