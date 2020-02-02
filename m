Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E71CC35249
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 14:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594A42067C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 14:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgBBOfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 09:35:18 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:49870 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgBBOfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 09:35:18 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 7B443200701;
        Sun,  2 Feb 2020 14:35:16 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 72CC3205FF; Sun,  2 Feb 2020 15:34:45 +0100 (CET)
Date:   Sun, 2 Feb 2020 15:34:45 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] pcmcia updates for v5.6
Message-ID: <20200202143445.GA263996@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus,

please pull the following changes since
	commit d1eef1c619749b2a57e514a3fa67d9a516ffa919 (Linux 5.5-rc2)

=66rom
	https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git pcmcia-next

up to 71705c611263cad99edf85a5ea021e098cac032b:

	PCMCIA/i82092: remove #if 0 block (2019-12-16 11:49:54 +0100)

This is a series co-developed by Simon Geis and Lukas Panzer to clean up
the i82092 PCMCIA device driver.

Thanks,
	Dominik

----------------------------------------------------------------

Simon Geis (10):
      PCMCIA/i82092: use dev_<level> instead of printk
      PCMCIA/i82092: add/remove spaces to improve readability
      PCMCIA/i82092: remove braces around single statement blocks
      PCMCIA/i82092: insert blank line after declarations
      PCMCIA/i82092: change code indentation
      PCMCIA/i82092: move assignment out of if condition
      PCMCIA/i82092: shorten the lines with over 80 characters
      PCMCIA/i82092: include <linux/io.h> instead of <asm/io.h>
      PCMCIA/i82092: delete enter/leave macro
      PCMCIA/i82092: remove #if 0 block

 drivers/pcmcia/i82092.c   | 648 ++++++++++++++++++++++--------------------=
----
 drivers/pcmcia/i82092aa.h |  11 -
 2 files changed, 311 insertions(+), 348 deletions(-)

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmgXaWKgmjrvkPhLCmpdgiUyNow0FAl423gUACgkQmpdgiUyN
ow06jw//T0NOsictd8XuLdxIFnpBU4cNh2RXXm3GD4dD8tJ3MjR4pqQtsoNTJEgN
PGhbKfSzvzVuvjbDacwFcXiFcbdUUlH2lsV/Bn65NYUZ906guOUiGnN4QGSYrH+a
vXNWRMqSUBhyO8lOd9GYEwMPZoRQi+8pClnEab3iFKhDZYOMcQ3zT4rBoDe9PInD
7TCqYDX/5GcMildBkQ6hErf1gMVw2zJZPukbWp6uV5MaOZg+Vxbw3PsqEv2jqraG
70LqU7D5d1nzaC6TIIdLvvs1iItt66wv5OEPT/eV+QcA9fn0IzqTLD9itRYzT+ht
2NTq+9bHfJeIy7R9F5S1wqVFhvwQcL5WzF8mluClVHgTDxzH5HspB7Kpb9Chvtzz
QNmQ6tmpMByxet4Tcsq6tzhzhm1VKQaa28teMgibFOB/yq4JYiLDF3P3sq+PxTWb
DKeD6LhQLvDHQjA6wanIaCaAAEicj4npgM0DJ1kr6xlYwV1dhBo5O3cwu70XjmFh
aWW45fCyKmv7jxTHaYkFYaE4xLM52NEb1qTEsmJx/a7avCfYgoRmFqnmOoN9Nd4M
3qXvCjIsRoJUVSQWmQzNlN0iqvAMpuZM6EHxPUbqfCKGZPSEoSjYbKtqE+djhrhD
0zjm8rt3YotO6DknNqD7zL720NLyFAhHWu8NNzNL9KfHyaovoLw=
=HcoJ
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
