Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58439C54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32AA820661
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgELNiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 09:38:55 -0400
Received: from sauhun.de ([88.99.104.3]:57380 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbgELNiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:38:55 -0400
Received: from localhost (p54B332DE.dip0.t-ipconnect.de [84.179.50.222])
        by pokefinder.org (Postfix) with ESMTPSA id 1A6642C1F86;
        Tue, 12 May 2020 15:38:53 +0200 (CEST)
Date:   Tue, 12 May 2020 15:38:52 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     qii.wang@mediatek.com
Cc:     linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com, leilk.liu@mediatek.com
Subject: Re: [PATCH] i2c: mediatek: Add i2c ac-timing adjust support
Message-ID: <20200512133852.GE13516@ninjato>
References: <1585223676-30809-1-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="10jrOL3x2xqLmOsH"
Content-Disposition: inline
In-Reply-To: <1585223676-30809-1-git-send-email-qii.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--10jrOL3x2xqLmOsH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Qii Wang,

On Thu, Mar 26, 2020 at 07:54:36PM +0800, qii.wang@mediatek.com wrote:
> From: Qii Wang <qii.wang@mediatek.com>
>=20
> This patch adds a algorithm to calculate some ac-timing parameters
> which can fully meet I2C Spec.
>=20
> Signed-off-by: Qii Wang <qii.wang@mediatek.com>

Could you rebase this on top of i2c/for-next or v5.7-rcX? Because of
commit 90224e6468e1 ("i2c: drivers: Use generic definitions for bus
frequencies") which was added two days before your patch was sent out.

Otherwise mostly minor nits.

> +static int mtk_i2c_max_step_cnt(unsigned int target_speed)
> +{
> +	if (target_speed > MAX_FS_MODE_SPEED)
> +		return MAX_HS_STEP_CNT_DIV;
> +	else
> +		return MAX_STEP_CNT_DIV;
> +}

Maybe ternary operator here? Your choice.

And my code checkers complained:

    CPPCHECK
drivers/i2c/busses/i2c-mt65xx.c:591:11: warning: Redundant assignment of 's=
da_max' to itself. [selfAssignment]
  sda_max =3D sda_max;
          ^
drivers/i2c/busses/i2c-mt65xx.c:597:11: warning: Redundant assignment of 's=
da_min' to itself. [selfAssignment]
  sda_min =3D sda_min;

Last question: You seem to be the one doing major updates to this
driver. Thanks for that! Are you maybe interested in becoming the
maintainer for this driver? I think there won't be much patches to
review and reports to handle but it will speed up processing for me.

All the best,

   Wolfram


--10jrOL3x2xqLmOsH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl66pugACgkQFA3kzBSg
Kba3FQ//feg8sBvAPAGQ1c3TSFF7+uw13pr2B3K6UysUq9MRXolh+3dXFzkWXahk
YXtv9nHURBVjj+2SnDD2ZwnD9x1UGyxPug6Sp62VJMS80rjYvsL3/8s58srZeHsI
MoO68IX50ZMvaJip6LPoNk8Sw9Pl4RhK1Q6hejBsihdf27cWXt/W4jNVBlENaw5u
mIhZR2faLpWYIVwI/7+tFVJWqp5fn8zh28/7YNi3B0+NJexDi+z+lRSuD17s4VV7
63S6JpAzZm9VOW8myXtcyMV+nVAyBhgxQ3O/WybHAgaceOcjZJuTYd1rYTAznZGd
UAdcdrfAnQnnVnLYtFsqtCNWtqrxwvV2fktTT6O01d1YNwSvKGYD7csCo8rB4kQZ
TctS7orhQi8YbhRTZAZoGmVOChgsQ/nwy3ik8BaC/vcziXkQ+OpsXsNYz23nNmvh
YgugC/ueHcklhIxhinDJx4R1NSVrpuqRSFHceX/7ez64lRtAGlm7A8zdcOBy3I3j
oAWgUgd0b6OLnW0j0E8rJAGQJ9ub58VLFAfaZH0GVpxtXkYQ6npgVxzjwwwj+ONX
rC+pocqPujlCKBidHpJh+obmCUMlalkm3W4EMlEp1Mz/yAZ6JKDnC60YzfJtUStz
GiCto6g4vEd8j+KeH0eVABf5LQoE7ia1SC3f4eg0pfU1juidIww=
=LYkG
-----END PGP SIGNATURE-----

--10jrOL3x2xqLmOsH--
