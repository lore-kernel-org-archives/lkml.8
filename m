Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EBDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF25920825
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595488100;
	bh=3G2i5Stf/TvnYqeL5wRQP30TtXBx8uZpidZ5GOtBvNw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=DHowDRuicGjFrS8lmEInDqZ8e9cVhXCH3fpOumbdOBFUEhX0QT/QWzl2kdAnOF8PV
	 c1Eo8zlPJJksokg6emeVwOKy7Xloy5i3L/pdK8YFv/PtaMjR45sgjNxs+fMotGRgKR
	 55d2Zndox0hqN2Empy1Jr+PXBgA6MxAQSfNSUVcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgGWHIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:08:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgGWHIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:08:18 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D079C206E3;
        Thu, 23 Jul 2020 07:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595488097;
        bh=3G2i5Stf/TvnYqeL5wRQP30TtXBx8uZpidZ5GOtBvNw=;
        h=Date:From:To:Cc:Subject:From;
        b=Jk8rZXLYz3rPjCNsqU54Qw1nVUf9csi5mdtjj6AltfjjNVCLYMBqy7f7QAfXMInrb
         lhA0C5mor9Z10aNyyZWINN/tkBKkxkQO0ivWKU8XrPEtvOw95J0Bz3pGXDsvNsR6LZ
         1aPztOukSPDi44vlmpyrFNwztyGj0EfhX2m5m2Bo=
Date:   Thu, 23 Jul 2020 12:38:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] soundwire updates for v5.9-rc1
Message-ID: <20200723070813.GV12965@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Greg,

Here are the updates for soundwire subsystem for 5.9. Please pull.


The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-5.9-rc1

for you to fetch changes up to a81844034e5b382df6cc06bc2943ae24be797afd:

  Soundwire: intel_init: save Slave(s) _ADR info in sdw_intel_ctx (2020-07-=
21 16:05:41 +0530)

----------------------------------------------------------------
soundwire updates for 5.9-rc1

This contains few core changes and bunch of Intel driver updates:

 - Adds definitions for 1.2 spec
 - Sanyog left as a MAINTAINER and Bard took his place while Sanyog
   is a reviewer now.
 - Intel: Lots of updates to stream/dai handling, wake support and link
   synchronization.

----------------------------------------------------------------
Bard Liao (3):
      soundwire: bus: clock_stop: don't deal with UNATTACHED Slave devices
      soundwire: intel/cadence: merge Soundwire interrupt handlers/threads
      Soundwire: intel_init: save Slave(s) _ADR info in sdw_intel_ctx

Pierre-Louis Bossart (23):
      soundwire: intel: cleanups for indirections/logs
      soundwire: intel: clarify drvdata and remove more indirections
      soundwire: intel_init: remove useless test
      soundwire: intel_init: use devm_ allocation
      soundwire: intel_init: pass link information as platform data
      soundwire: intel: transition to 3 steps initialization
      soundwire: add definitions for 1.2 spec
      soundwire: bus_type: convert open-coded while() to for() loop
      soundwire: extend SDW_SLAVE_ENTRY
      soundwire: bus: initialize bus clock base and scale registers
      soundwire: intel: implement get_sdw_stream() operations
      soundwire: stream: add helper to startup/shutdown streams
      soundwire: intel: remove stream allocation/free
      soundwire: cadence: allocate/free dma_data in set_sdw_stream
      soundwire: intel: don't free dma_data in DAI shutdown
      soundwire: sdw.h: fix PRBS/Static_1 swapped definitions
      soundwire: sdw.h: fix indentation
      soundwire: intel: reuse code for wait loops to set/clear bits
      soundwire: intel: revisit SHIM programming sequences.
      soundwire: intel: introduce a helper to arm link synchronization
      soundwire: intel: introduce helper for link synchronization
      soundwire: intel_init: add implementation of sdw_intel_enable_irq()
      soundwire: intel_init: use EXPORT_SYMBOL_NS

Rander Wang (1):
      soundwire: intel: add wake interrupt support

Rikard Falkeborn (1):
      soundwire: qcom: Constify static structs

Sanyog Kale (1):
      MAINTAINERS: change SoundWire maintainer

Vinod Koul (2):
      soundwire: Replace 'objs' by 'y'
      soundwire: fix the kernel-doc comment

 Documentation/driver-api/soundwire/stream.rst |  11 +-
 MAINTAINERS                                   |   3 +-
 drivers/soundwire/Makefile                    |  10 +-
 drivers/soundwire/bus.c                       | 130 +++++-
 drivers/soundwire/bus_type.c                  |  19 +-
 drivers/soundwire/cadence_master.c            |  70 ++--
 drivers/soundwire/cadence_master.h            |   4 +
 drivers/soundwire/intel.c                     | 549 +++++++++++++++++-----=
----
 drivers/soundwire/intel.h                     |  22 ++
 drivers/soundwire/intel_init.c                | 356 ++++++++++++++---
 drivers/soundwire/qcom.c                      |   4 +-
 drivers/soundwire/stream.c                    |  98 +++++
 include/linux/mod_devicetable.h               |   2 +
 include/linux/soundwire/sdw.h                 |  33 +-
 include/linux/soundwire/sdw_intel.h           |   2 +
 include/linux/soundwire/sdw_registers.h       | 117 +++++-
 scripts/mod/devicetable-offsets.c             |   2 +
 scripts/mod/file2alias.c                      |   6 +-
 18 files changed, 1136 insertions(+), 302 deletions(-)

Thanks
--=20
~Vinod

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl8ZN10ACgkQfBQHDyUj
g0eoHA//SeSSiv1vBQrZFUa0HdCG8pl33Vlw8t5dVPGMJ5d/bLSBgCxHVZYiTB2N
DvjPxOOVxv0ayR4ZYe0XeY/Izu4Cw+J0CSR2wuUixCUhm4tOOoNFQzqXwQiO0tZe
Ob8lvQD9tFHj2/8JidY2fVBsQT7WBZdw1YG82AgOKXOV9VUBGL8k5gdVqE0qUZx+
yGRI+bsFkQo2SBPxO+/0dc24AN7hEt6YDWdu4AiPSiGKGtdcJkWIG1GFWuP6mqiy
USacF9y9fjppXh1r6bsEIHyoPu9ozRM/zl3QB744rAS5OUwRgxyLLtbQBMYeewfg
oAYJmKimPFhjw0OoTXLj7O1ND/3HSWhdeqtJfVDpYeO3lhsgg/Tv/WTK+u1C0BzU
bYgBZMSQISeNhvesHiWKLFxf3WrPwUhXyWkVKztWCH+GM91gPFQHFqGqA5rYkQXD
7PeqXnO3SQ+Hksojyo2oVZdwK/Bo+78I309aKA3BnIfIb1K76a1rSO8UTx1EWxmR
ifco0C1l/x3WNkZ0spJpfvheZ56bS+7+LiTAJsoyFLvhKspevOMJmlCfODY+YHcS
89+jD5d1zHoGHdSsiL6QBmiJffk+4SxgpKi0ZVD9rVexsjZ+9zq6+Bl6jT8nPgdq
cor6hpzCBdPVgSkjNbAqk5vhjvFWB/ALdp08lJA2LvasKsVVI1Q=
=jUoh
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
