Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E678C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F2420776
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584714483;
	bh=ND8w5U92rYsYpwnEj1Y1CsPVj4C+W7Lwf2SrMjdJgoY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=YVnofbEeAXpj2evci+c/FtErOohTwEBMleWh4RPUBaM1BfZ+FWOh564bJLQdrzquR
	 2MCM3N0zP6RFCFLSV+kRyoaWe7MHbthk4ZxIY/6To4aibJrOd+3lA3XU1Q07AwYpTf
	 wU1a43GuLQP0bxDz0nhB3F+E8oJbFh10hDl80Xh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbgCTO2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 10:28:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbgCTO2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 10:28:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D11A32070A;
        Fri, 20 Mar 2020 14:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584714480;
        bh=ND8w5U92rYsYpwnEj1Y1CsPVj4C+W7Lwf2SrMjdJgoY=;
        h=Date:From:To:Cc:Subject:From;
        b=X2UM9tPoF3qOd9/+Fl+Mcuk6+v3fDhKKdUDAgj7wQfzzWbDVYCGCbOIZp4iN7SXJW
         AOVEv0/dnXghzER/2gSh6ze3ZpRmH/tK4weMTpvNN/WkRWAc+HV2OyXrKjPe+dKhT/
         GS/szgQ6ssM5FtAiIlry2HmhKoClkh4fPGK+XzWQ=
Date:   Fri, 20 Mar 2020 15:27:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging/IIO driver fixes for 5.6-rc7
Message-ID: <20200320142758.GA760533@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f8788d86ab28f61f7b46eb6be375f8a726783636:

  Linux 5.6-rc3 (2020-02-23 16:17:42 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.6-rc7

for you to fetch changes up to 14800df6a020d38847fec77ac5a43dc221e5edfc:

  Merge tag 'iio-fixes-for-5.6a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2020-03-18 11:20:42 +0100)

----------------------------------------------------------------
Staging/IIO fixes for 5.6-rc7

Here are a number of small staging and IIO driver fixes for 5.6-rc7

Nothing major here, just resolutions for some reported problems:
	- iio bugfixes for a number of different drivers
	- greybus loopback_test fixes
	- wfx driver fixes

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexandru Tachici (1):
      iio: accel: adxl372: Set iio_chan BE

Eugen Hristev (1):
      iio: adc: at91-sama5d2_adc: fix differential channels in triggered mode

Fabrice Gasnier (1):
      iio: trigger: stm32-timer: disable master mode when stopping

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-for-5.6a' of git://git.kernel.org/.../jic23/iio into staging-linus

Johan Hovold (3):
      staging: greybus: loopback_test: fix poll-mask build breakage
      staging: greybus: loopback_test: fix potential path truncation
      staging: greybus: loopback_test: fix potential path truncations

Jérôme Pouiller (5):
      staging: wfx: fix warning about freeing in-use mutex during device unregister
      staging: wfx: fix lines ending with a comma instead of a semicolon
      staging: wfx: make warning about pending frame less scary
      staging: wfx: fix RCU usage in wfx_join_finalize()
      staging: wfx: fix RCU usage between hif_join() and ieee80211_bss_get_ie()

Michael Straube (1):
      staging: rtl8188eu: Add device id for MERCUSYS MW150US v2

Olivier Moysan (1):
      iio: adc: stm32-dfsdm: fix sleep in atomic context

Petr Štetiar (1):
      iio: chemical: sps30: fix missing triggered buffer dependency

Samuel Thibault (1):
      staging/speakup: fix get_word non-space look-ahead

Stephan Gerhold (1):
      iio: magnetometer: ak8974: Fix negative raw values in sysfs

Tomas Novotny (2):
      iio: light: vcnl4000: update sampling periods for vcnl4200
      iio: light: vcnl4000: update sampling periods for vcnl4040

Wen-chien Jesse Sung (1):
      iio: st_sensors: remap SMO8840 to LIS2DH12

YueHaibing (1):
      iio: ping: set pa_laser_ping_cfg in of_ping_match

 drivers/iio/accel/adxl372.c                   |  1 +
 drivers/iio/accel/st_accel_i2c.c              |  2 +-
 drivers/iio/adc/at91-sama5d2_adc.c            | 15 ++++++++++
 drivers/iio/adc/stm32-dfsdm-adc.c             | 43 +++++++--------------------
 drivers/iio/chemical/Kconfig                  |  2 ++
 drivers/iio/light/vcnl4000.c                  | 15 +++++-----
 drivers/iio/magnetometer/ak8974.c             |  2 +-
 drivers/iio/proximity/ping.c                  |  2 +-
 drivers/iio/trigger/stm32-timer-trigger.c     | 11 +++++--
 drivers/staging/greybus/tools/loopback_test.c | 21 ++++++-------
 drivers/staging/rtl8188eu/os_dep/usb_intf.c   |  1 +
 drivers/staging/speakup/main.c                |  2 +-
 drivers/staging/wfx/hif_tx.c                  | 15 +++++-----
 drivers/staging/wfx/hif_tx.h                  |  2 +-
 drivers/staging/wfx/hif_tx_mib.h              | 15 ++++++----
 drivers/staging/wfx/sta.c                     | 25 +++++++++-------
 16 files changed, 95 insertions(+), 79 deletions(-)
