Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9827C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1C1A206D4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599214115;
	bh=YuSrsI5KqLBnMX+vksl2yVrjohdpsF5I/0/1S7u3drc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=TIpMjOvtxTV/nIvHrR6tqbJWQaZY6TvdoMHp2/mAT7UrzDVkHfABzwIGHwaxCkpIm
	 vtMOlTkLvxt4yBo6jzy/8k3BawzxBFyk1/yHFAa/FOv2yXjHd9Lg8/EWeQu5RPIY3Q
	 lC2kjEDXfWwhLhuZm9oC1/0o7gsUr8Sb9IhY8N1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbgIDKId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:08:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgIDKIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:08:23 -0400
Received: from localhost (unknown [122.182.253.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 310ED206D4;
        Fri,  4 Sep 2020 10:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599214103;
        bh=YuSrsI5KqLBnMX+vksl2yVrjohdpsF5I/0/1S7u3drc=;
        h=Date:From:To:Cc:Subject:From;
        b=kPauqMoXES0825Hrny9OK5pTmG1Ex+Fh+3cyoMNoO2zles3wRmH2L/BS/8lSFKP+o
         0iuaglP9yLcoFOkHYffAYTx+GWcw5IeQNIo7SY73HK2Zw+lvRHgsUP7FaFV+itToHU
         M+9wjhIX6+c8K6jRyEC/X59udPV9ba+lY1uWyZgw=
Date:   Fri, 4 Sep 2020 15:38:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: soundwire fixes for v5.9
Message-ID: <20200904100818.GZ2639@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

I have two fixes for soundwire subsystem, please pull.

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-5.9-fixes

for you to fetch changes up to 3fbbf2148a406b3e350fe91e6fdd78eb42ecad24:

  soundwire: fix double free of dangling pointer (2020-09-03 14:10:19 +0530)

----------------------------------------------------------------
soundwire fixes for v5.8

This contains two fixes to sdw core for dangling pointer and a typo for
INTSTAT register

----------------------------------------------------------------
Pierre-Louis Bossart (1):
      soundwire: bus: fix typo in comment on INTSTAT registers

Tom Rix (1):
      soundwire: fix double free of dangling pointer

 drivers/soundwire/bus.c    | 2 +-
 drivers/soundwire/stream.c | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

Thanks
--=20
~Vinod

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl9SEhIACgkQfBQHDyUj
g0eclg/+P7eLv1f9mAgEuiwe55Uzi7WPAB7PbkCQr6pdxA25ViJWdVEwZrTW9Hmr
+GbB86Pakj+lx2P3Lpwyy9A0nuIq8ouQiTjKJZ1HgtMRKTr3tlhHFVlSrjmBqhmz
Rrq2bp5Dv/OCHkqXapdU9zZ1HVaLRvqjGxzie6KK9/c3kG4vzv3aoBMBRjHAOgRC
i0rzdFWOnFaxWhGQONLic0WNUh2N6XG7iQRVekMGW6GRn66qUIn0K2yOUMnChrhG
hDlWXwL5GZ3BE6JtEGBLjU//MPzS2pkB3SPhDUTszg33nYkGNK8PJcVDi/vNZ/oe
DXm++nPZ1QGgCKo2aIEiX/mr9esb/N4eu6gDJ/IC3RR2206baFfIyXsmpNvDhDwt
9YKo3YGvBRYNrRKqozIWCa4MVyJcMjyoIufDJ5PnJQ2c1BXPGqKkWjVUQ2OTdlk5
p2uXOYrSLecdBi5LOnFGxQARX17p1ILk0swYFo4LxNTqJMf3PnqcetxBmUYf0J6U
F9HMKw+WJEwzEqyRRGel2wObD/lVAzrnLyU6KOrcdJYQIW1jWFtYFlmm5lYP3EjN
+ENPUCPse+RHIuah1gbT+xS2la8g9j+9jwXVC6No7a0ZWtb6/DTsAo3ubtOo51xu
CFpfejmVe06vUmV57K1s51u9Ll17oFZWvOSn4LKrzuWV+A7f6tU=
=XdIt
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
