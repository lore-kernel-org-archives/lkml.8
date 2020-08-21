Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DEEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 00:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A8CF207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 00:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dfaobI83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgHUAhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 20:37:54 -0400
Received: from ozlabs.org ([203.11.71.1]:39793 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbgHUAhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 20:37:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BXjKT5y2cz9sR4;
        Fri, 21 Aug 2020 10:37:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1597970270;
        bh=YEpKqRq7HTbFruaS+Kz80f89rtWDs6TOkJwAnXvS4g0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dfaobI83YizGdnWGmu3vQKGnKnMfGQnkwyV9qlUo2luUZsFAhoYa8CMOtqUcvp0Xw
         qVANAGsBzpvB9QbAezZbDUdLASNahZP/23ru6+q55bayjlVOJfe91APulVD6CZUE94
         vsWlphxVwk/kp2/ngO4cnToXi9mm8MAD/n+5A/8m4wUUWm06mtERnzv661iUzyNtzS
         WfT/KQsr3sKASAPozreS5Tb4OK6+BFahw/VP8Teiu8ooSFbZYuzNQtLT8InROfqOJn
         BcgMWcXDdY34HCzKzDPMIdxHipjd3wz7PeiihCF5bMe2W7kTkxTy1DIMlNB983rQrh
         qDelGGeVquuDg==
Date:   Fri, 21 Aug 2020 10:37:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bard liao <yung-chuan.liao@linux.intel.com>
Subject: Re: linux-next: build warnings after merge of the sound-asoc-fixes
 tree
Message-ID: <20200821103748.4e4e9ac0@canb.auug.org.au>
In-Reply-To: <a8b47ba9-7b45-bef1-08a2-820fe48c4cc4@linux.intel.com>
References: <20200821093901.4257afdc@canb.auug.org.au>
        <a8b47ba9-7b45-bef1-08a2-820fe48c4cc4@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_An+TFDMZ262Z8SmEwmbQ1v";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_An+TFDMZ262Z8SmEwmbQ1v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Pierre-Louis,

On Thu, 20 Aug 2020 19:01:15 -0500 Pierre-Louis Bossart <pierre-louis.bossa=
rt@linux.intel.com> wrote:
>
> On 8/20/20 6:39 PM, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > After merging the sound-asoc-fixes tree, today's linux-next build
> > (x86_64 allmodconfig) produced these warnings:
> >=20
> > WARNING: modpost: module snd-sof-intel-hda-common uses symbol sdw_intel=
_acpi_scan from namespace SOUNDWIRE_INTEL_INIT, but does not import it.
> > WARNING: modpost: module snd-sof-intel-hda-common uses symbol sdw_intel=
_probe from namespace SOUNDWIRE_INTEL_INIT, but does not import it.
> > WARNING: modpost: module snd-sof-intel-hda-common uses symbol sdw_intel=
_process_wakeen_event from namespace SOUNDWIRE_INTEL_INIT, but does not imp=
ort it.
> > WARNING: modpost: module snd-sof-intel-hda-common uses symbol sdw_intel=
_startup from namespace SOUNDWIRE_INTEL_INIT, but does not import it.
> > WARNING: modpost: module snd-sof-intel-hda-common uses symbol sdw_intel=
_exit from namespace SOUNDWIRE_INTEL_INIT, but does not import it.
> > WARNING: modpost: module snd-sof-intel-hda-common uses symbol sdw_intel=
_enable_irq from namespace SOUNDWIRE_INTEL_INIT, but does not import it.
> > WARNING: modpost: module snd-sof-intel-hda-common uses symbol sdw_intel=
_thread from namespace SOUNDWIRE_INTEL_INIT, but does not import it.
> >=20
> > Presumably introduced by commit
> >=20
> >    82cb71d68c22 ("ASoC: SOF: Intel: add build support for SoundWire") =
=20
>=20
> There is a companion patch 1eb629363aa35 ("ASoC: SOF: Intel: hda: import=
=20
> SOUNDWIRE_INIT namespace") that does the import, not sure what causes=20
> the warning?

That latter patch is in the sound-asoc tree (but not in the
sound-asoc-fixes tree).

--=20
Cheers,
Stephen Rothwell

--Sig_/_An+TFDMZ262Z8SmEwmbQ1v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8/F1wACgkQAVBC80lX
0Gzqzgf/YITOG3Lldcza8WPUh2HvndXkADGg5Zfrmc08vdxqRdPl6OUMlYZ/vwWF
9/mo2dEgZj9oq+ZfWeX1I2caecFe2By3m5EyzANPjzPrGhBh5C+wXH1oFwhadsfi
8ras7HEAs6vyVtG486nDqU+F9+v+YkVGv7SC/a4pyPSuk4/F9CGt1/REy6utJA7A
KUnjWDmwUrFbTyBLLm5zO+fFrzyffBCnUDvSp6OWXRfgL2iPVwH7t6ghODwAq6eO
HeUcDcUkZBQ0+H/l4VVoIdvnQxHUSZijGMnm1rF42RfXEWgIUdxw47WR8Wqs7Aj7
syHdlj/894kw2yGT+TXQKiZUGpf6wA==
=8jMT
-----END PGP SIGNATURE-----

--Sig_/_An+TFDMZ262Z8SmEwmbQ1v--
