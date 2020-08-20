Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30346C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F8B32072D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MXHgrmFG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgHTXjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:39:05 -0400
Received: from ozlabs.org ([203.11.71.1]:33381 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728746AbgHTXjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:39:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BXh1f3fFpz9sTF;
        Fri, 21 Aug 2020 09:39:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1597966742;
        bh=sYBaVBkEqe2/Mw/Lfq5kEh4Qy/zScPTo61xwiHFUTsg=;
        h=Date:From:To:Cc:Subject:From;
        b=MXHgrmFGNeGYhCzEHhGMHDlptaFrySiOyIrdL2smS2yTVSEqztX/u2uJ1E56hGQUk
         CCePijDuAMD1HWzCIqZeV8NtiwDmbGe8bZeyx48hd8GlqTB93Wv7QLsGuc7OITHETD
         h/lqERpGnauGE/Gkb9Ou0GL2Xko9BRwxl+x7ojLqGZ1fU0fR3wSpLh/PA8PuobArzU
         ZfSO+XPQ0l8Av7dWcpPjkUMH8Kuhi7n36CK3xncAsk24dYhXzKj4tQA8wyrQH945Be
         ged98WrSmmiLbhc+8+EUCfxaBac8K3HYUzwjcaPr9sHQ6qDvLPQDI33opkHZS1YNzK
         HreAP5SHF8ckA==
Date:   Fri, 21 Aug 2020 09:39:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warnings after merge of the sound-asoc-fixes tree
Message-ID: <20200821093901.4257afdc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/H=z86_dTv/Ev.5_C8zSBkV/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/H=z86_dTv/Ev.5_C8zSBkV/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc-fixes tree, today's linux-next build
(x86_64 allmodconfig) produced these warnings:

WARNING: modpost: module snd-sof-intel-hda-common uses symbol sdw_intel_acp=
i_scan from namespace SOUNDWIRE_INTEL_INIT, but does not import it.
WARNING: modpost: module snd-sof-intel-hda-common uses symbol sdw_intel_pro=
be from namespace SOUNDWIRE_INTEL_INIT, but does not import it.
WARNING: modpost: module snd-sof-intel-hda-common uses symbol sdw_intel_pro=
cess_wakeen_event from namespace SOUNDWIRE_INTEL_INIT, but does not import =
it.
WARNING: modpost: module snd-sof-intel-hda-common uses symbol sdw_intel_sta=
rtup from namespace SOUNDWIRE_INTEL_INIT, but does not import it.
WARNING: modpost: module snd-sof-intel-hda-common uses symbol sdw_intel_exi=
t from namespace SOUNDWIRE_INTEL_INIT, but does not import it.
WARNING: modpost: module snd-sof-intel-hda-common uses symbol sdw_intel_ena=
ble_irq from namespace SOUNDWIRE_INTEL_INIT, but does not import it.
WARNING: modpost: module snd-sof-intel-hda-common uses symbol sdw_intel_thr=
ead from namespace SOUNDWIRE_INTEL_INIT, but does not import it.

Presumably introduced by commit

  82cb71d68c22 ("ASoC: SOF: Intel: add build support for SoundWire")

--=20
Cheers,
Stephen Rothwell

--Sig_/H=z86_dTv/Ev.5_C8zSBkV/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8/CZUACgkQAVBC80lX
0GwIpQf+KDZgVI29MDPJFukKSCpymet1xG/gkD7MdDP8dWPEPLiaAgUjrH5ql47k
Nl+o9b2DeE/dcuKj/EplfLU17h0XLI9s8q2lzIWxeTiqeqZHTlyUr5dAif+NMftd
djdj+GpKkiluNYScFqsswf5koJCV8WOtFSPfshW/aYrwoWsz3Y0Q2ZgxK58ih+1+
4nQrfjc4LNcx6xkszv6/R9VriX1vAQSspM8rUrpH0rYto7shcdqGt55UcJ4oB4Mr
bPEcWpIIYVrcvoTOBydxVg4qoxZq8LTtwY7UmRKx3t77u+YEGgvOB+aD33C6op3N
tssc8LkpfUfWxTEyzS54EKdC7As6hw==
=8djY
-----END PGP SIGNATURE-----

--Sig_/H=z86_dTv/Ev.5_C8zSBkV/--
