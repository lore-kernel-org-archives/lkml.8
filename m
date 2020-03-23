Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BD8C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634DD2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WMrI+iWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgCWFUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 01:20:24 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49397 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgCWFUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 01:20:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48m2l82QGTz9sRN;
        Mon, 23 Mar 2020 16:20:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1584940821;
        bh=9r28fk/9OOZynYwq499j4E+s3NAVj6LJlGdazC+e2QQ=;
        h=Date:From:To:Cc:Subject:From;
        b=WMrI+iWHNePeqBw6aqqKB9VlF55OXDEZelxloaUNWjM7OnPoLM6qqieI4FLHAJMgR
         9PzpNK0ko5Tsk9swZ8zJBvEyoxTVyCqqTr+I1vT61tsP+ukygDo1J7VWC23yxQIxyZ
         Vt0tAdH8C2ObS669Ch/9akd4AdaRxB40+JAcrnE6NP7DpwHjkZxpFLltlYMH3BvfBU
         y3mYzLuwWtWfghTMZVFsic9KcS85Nk8MrckQzLc4do8lyHQI0eZQroIj/2sYY3wWbj
         NWQo63Km2aOK9pU71IgGiXdwY6JciecSS17UKDmfsFu9gsnQZzuI70Ufxkw16oUFbD
         xEGBSaaEvsTLA==
Date:   Mon, 23 Mar 2020 16:20:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: linux-next: manual merge of the coresight tree with the char-misc
 tree
Message-ID: <20200323162018.17d3091f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8.4fvf9Yl=PKyrv_589xyfK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8.4fvf9Yl=PKyrv_589xyfK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the coresight tree got conflicts in:

  Documentation/ABI/testing/sysfs-bus-coresight-devices-cti
  Documentation/trace/coresight/coresight-ect.rst
  drivers/hwtracing/coresight/coresight-cti-sysfs.c
  drivers/hwtracing/coresight/coresight-cti.c
  drivers/hwtracing/coresight/coresight-priv.h
  drivers/hwtracing/coresight/coresight.c
  include/linux/coresight.h

There are a series of commits in both the char-misc tree and the coresight
tree that have the same subjects but are slightly different patches.
Since the coresight tree is merged via the char-misc tree (and that tree's
commits are more recent), I have dropped the coresoght tree for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/8.4fvf9Yl=PKyrv_589xyfK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl54RxIACgkQAVBC80lX
0GxZUgf9H8Tw4tGtxFZ8hyNV38Pp/w+r9DGygRIpuVOW00I6U7bkGcCKa6OWm0Kh
8fd6gGUV3e3FS6r7XTlODvcq6AdUxfwOxZux0s72F9IVvpbNlmiSw4dOkG1+WdZS
T6HAvneF+FWt0mspJFpYPtVCx8uoSKM8i0VDG1JTk7NDsk3ozjNclFgskeZEd1c0
klVITIfi1w1/5otwZ2At+53e11s/tZmdPpABELVF8nsXpg4DveqCB/34lU/EIM+s
qR3lKaayG9dqvFgjigXQXxSXigGWPMRpTC2rCBltP6wL5wuKxuTNXjAxtcKu+/eO
M6TZWfBVxGuY9LQ2ilXWq1/G2CzhKw==
=tiOC
-----END PGP SIGNATURE-----

--Sig_/8.4fvf9Yl=PKyrv_589xyfK--
