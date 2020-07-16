Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AD7C433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 946FF2076A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594913387;
	bh=W80dXnsx8xCpD4ZJDZiVreuYHVetErKPCjXzs3QZiGQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=uFArVDNAAht++Zb/aM+2+7LsFa4QN+qvq2CK43sFOSEu9typNtOE3Tu4jYZ28nCog
	 ve1FylC4j4WJDhKpvhlzbYZAgEqCiSxbHlOEcwxJPKmRubIXQSN5NdWYN85X7scrw/
	 r+V7xNmW47vaNJRXRw2lxikiq0sm+BJbMTqpeaJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgGPP3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:29:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728412AbgGPP3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:29:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B77D2065F;
        Thu, 16 Jul 2020 15:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594913385;
        bh=W80dXnsx8xCpD4ZJDZiVreuYHVetErKPCjXzs3QZiGQ=;
        h=Date:From:To:Cc:Subject:From;
        b=nhMKkuL8h1iFlTPmdvCAYA7hY4RttU7BKfsBtwtmAruEV190ao2fY2n8Kam/p67Az
         HcomLt91gviNdfpgNpTOWos7VSNNYRnn4hPEGVvKBg0qcsdZIVKCCtGNizP6SKqjM6
         ITnzp68hCPggpIfPHWn2mvgVAaI4L0uYZK0KTgxA=
Date:   Thu, 16 Jul 2020 17:29:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging/IIO driver fixes for 5.8-rc6
Message-ID: <20200716152939.GA2378914@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:

  Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.8-rc6

for you to fetch changes up to ef75e14a6c935eec82abac07ab68e388514e39bc:

  staging: comedi: verify array index is correct before using it (2020-07-10 14:03:00 +0200)

----------------------------------------------------------------
IIO/Staging driver fixes for 5.8-rc6

Here are some IIO and staging driver fixes for 5.8-rc6.

The majority of fixes are for IIO drivers, resolving a number of small
reported issues, and there are some counter fixes in here too that were
tied to the IIO fixes.  There's only one staging driver fix here, a
comedi fix found by code inspection.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Christophe JAILLET (1):
      iio: adc: ad7780: Fix a resource handling path in 'ad7780_probe()'

Chuhong Yuan (1):
      iio: mma8452: Add missed iio_device_unregister() call in mma8452_probe()

Dan Carpenter (1):
      staging: comedi: verify array index is correct before using it

Dinghao Liu (1):
      iio: magnetometer: ak8974: Fix runtime PM imbalance on error

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-for-5.8a' of git://git.kernel.org/.../jic23/iio into staging-linus

Jonathan Cameron (6):
      iio:health:afe4403 Fix timestamp alignment and prevent data leak.
      iio:health:afe4404 Fix timestamp alignment and prevent data leak.
      iio:magnetometer:ak8974: Fix alignment and data leak issues
      iio:humidity:hdc100x Fix alignment and data leak issues
      iio:humidity:hts221 Fix alignment and data leak issues
      iio:pressure:ms5611 Fix buffer element alignment

Matt Ranostay (1):
      iio: core: add missing IIO_MOD_H2/ETHANOL string identifiers

Navid Emamdoost (1):
      iio: pressure: zpa2326: handle pm_runtime_get_sync failure

Nuno Sá (1):
      iio: adc: adi-axi-adc: Fix object reference counting

Syed Nayyar Waris (2):
      counter: 104-quad-8: Add lock guards - differential encoder
      counter: 104-quad-8: Add lock guards - filter clock prescaler

 drivers/counter/104-quad-8.c                    | 22 ++++++++++++++++---
 drivers/iio/accel/mma8452.c                     |  5 ++++-
 drivers/iio/adc/ad7780.c                        |  2 +-
 drivers/iio/adc/adi-axi-adc.c                   |  4 ++--
 drivers/iio/health/afe4403.c                    |  9 +++++---
 drivers/iio/health/afe4404.c                    |  8 ++++---
 drivers/iio/humidity/hdc100x.c                  | 10 ++++++---
 drivers/iio/humidity/hts221.h                   |  7 ++++--
 drivers/iio/humidity/hts221_buffer.c            |  9 ++++----
 drivers/iio/industrialio-core.c                 |  2 ++
 drivers/iio/magnetometer/ak8974.c               | 29 +++++++++++++++----------
 drivers/iio/pressure/ms5611_core.c              | 11 +++++++---
 drivers/iio/pressure/zpa2326.c                  |  4 +++-
 drivers/staging/comedi/drivers/addi_apci_1500.c | 10 ++++++---
 14 files changed, 91 insertions(+), 41 deletions(-)
