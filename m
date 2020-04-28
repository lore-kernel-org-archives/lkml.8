Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45837C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 04:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F9F12053B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 04:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GfSBfNQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgD1EQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 00:16:21 -0400
Received: from ozlabs.org ([203.11.71.1]:33639 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgD1EQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 00:16:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49B7cf4DmSz9sSG;
        Tue, 28 Apr 2020 14:16:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1588047379;
        bh=v0Bu0KndZcFQ+fPMjS/3UyOAN/p29pT9GlM62F1RfXA=;
        h=Date:From:To:Cc:Subject:From;
        b=GfSBfNQIBKJUSU0XOTjv8/AGbiNc2R184+xLXnqW/A8i2NVGgCe2THmqXTiQX8eYg
         XXBkUDp+jyFI7EzLLXgc+X5Jom2MJ96420LCTU0pc+ty553qlyZLNPZQNPk3RsLUTS
         iOEwFPFTLN8icN2dehYchwzypj9KOlP6CfCRDtH7dHiIvitbytvwbGESg7zvucc5+h
         FZFZLarswNCN0RsbZzT6bWwSqTREyq28Gm7O4OgikFa/p/hOlM0aEfDPrn79/Lx2wo
         c4xmiT5dhi9Glsj8Z+gzTIlgX5hhB8SSx/zC3fntCD1pHj04Wy3YQjQxUmKhcQFehh
         lL9F3vQrGk47Q==
Date:   Tue, 28 Apr 2020 14:16:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: linux-next: build warning after merge of the spi tree
Message-ID: <20200428141611.0ed0969a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9cBb235RP2ZfB53wD7Noz+G";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9cBb235RP2ZfB53wD7Noz+G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the spi tree, today's linux-next build (x86_64 allmodconfig)
produced this warning:

drivers/spi/spi-amd.c: In function 'amd_spi_fifo_xfer':
drivers/spi/spi-amd.c:171:17: warning: unused variable 'opcode' [-Wunused-v=
ariable]
  171 |  u8 cmd_opcode, opcode =3D 0;
      |                 ^~~~~~

Introduced by commit

  bbb336f39efc ("spi: spi-amd: Add AMD SPI controller driver support")

--=20
Cheers,
Stephen Rothwell

--Sig_/9cBb235RP2ZfB53wD7Noz+G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6nrgsACgkQAVBC80lX
0Gxvowf/fwcYOfEIAp1CyEccBt8rhaolwsGHyLL0Yo7iHRSLCZfYoiOuryHU6+f5
5D7Wdxfr8EkBUvXpmRoz4iTnWl3wmPdU8zar2ZPV7ioAUO7Jvf5R0UqpE/tQAQLP
1/m52GutYFjsLaybz/a58mIFuT8zpTOaXfisQ2Ynpt3MGVZj5g+W7pTj++IwZlmh
R0uCHpekqUEqb3b3xpbGfzsq/awc2Qjsm+xqO9QC1QL4G2F0wHh0hv+EINcMIwp/
kjY8j7MHhnTX55GOj25rQaxR0YSWilrr6zQ0D5SDd7nc12gR4NnnemApJB6YyIrO
4ASih7NXr6H1iVjk9FZF9j8S2XDI4A==
=zbff
-----END PGP SIGNATURE-----

--Sig_/9cBb235RP2ZfB53wD7Noz+G--
