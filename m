Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CADFC5519B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 697B12070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587898057;
	bh=JtQjnWUbwyz4+fwS23njQst6S5pkA8XEFHZr58lmIs8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=JHtjZUbBtIUdcraERSfqdVMthTOLMhy9T/SLLSrxDSXL+A52Mm3jQtgKQSAc3fSPm
	 o+0AgNQS7KVJmpQzXtDqDwfxCZAfPMTamW7I+iRiNuZ4b41bcZlNW4EWHQLne+JtKK
	 PSKMiYGrGMalrvfLibO5mK2aBgVbvtJQE9chlaac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgDZKrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 06:47:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgDZKre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 06:47:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 968B32070A;
        Sun, 26 Apr 2020 10:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587898053;
        bh=JtQjnWUbwyz4+fwS23njQst6S5pkA8XEFHZr58lmIs8=;
        h=Date:From:To:Cc:Subject:From;
        b=GIg7YHfkXATA0ETK1WyjoQp51Ptd0CCqK8RY5z6geftyn8QQGeaMyQPCIb65ncyUk
         9gyU+lFZz7Fb12tLDBrSPPgUEgxVn9vlnNJj4rVx96lunfm8ZAuXQ4wTnMQAWJ4Sed
         7nrtxPFd/afNyyBrecYKbfGdsUN/Q5ExmfXWOdbo=
Date:   Sun, 26 Apr 2020 12:47:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging/IIO driver fixes for 5.7-rc3
Message-ID: <20200426104730.GA2120674@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git staging-5.7-rc3

for you to fetch changes up to 664ba5180234593b4b8517530e8198bf2f7359e2:

  staging: vt6656: Fix calling conditions of vnt_set_bss_mode (2020-04-23 13:47:34 +0200)

----------------------------------------------------------------
Staging/IIO driver fixes for 5.7-rc3

Here are some small staging and IIO driver fixes for 5.7-rc3

Lots of tiny things for reported issues in staging and IIO drivers,
including a counter driver fix as well (the iio drivers seem to be tied
to those).  Full details of the fixes are in the shortlog.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexandre Belloni (1):
      iio: adc: ti-ads8344: properly byte swap value

Alexandru Ardelean (2):
      iio: adc: ad7192: fix null pointer de-reference crash during probe
      MAINTAINERS: remove Stefan Popa's email

Colin Ian King (1):
      iio: dac: ad5770r: fix off-by-one check on maximum number of channels

Fabrice Gasnier (1):
      dt-bindings: iio: adc: stm32-adc: fix id relative path

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-for-5.7a' of git://git.kernel.org/.../jic23/iio into staging-linus

Ian Abbott (1):
      staging: comedi: dt2815: fix writing hi byte of analog output

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_mpu6050: fix suspend/resume with runtime power

Lars Engebretsen (1):
      iio: core: remove extra semi-colon from devm_iio_device_register() macro

Lars-Peter Clausen (4):
      iio: xilinx-xadc: Fix ADC-B powerdown
      iio: xilinx-xadc: Fix clearing interrupt when enabling trigger
      iio: xilinx-xadc: Fix sequencer configuration for aux channels in simultaneous mode
      iio: xilinx-xadc: Make sure not exceed maximum samplerate

Lary Gibaud (1):
      iio: st_sensors: rely on odr mask to know if odr can be set

Lorenzo Bianconi (3):
      iio: imu: st_lsm6dsx: fix read misalignment on untagged FIFO
      iio: imu: st_lsm6dsx: specify slave odr in slv_odr
      iio: imu: st_lsm6dsx: flush hw FIFO before resetting the device

Luis Mendes (1):
      staging: gasket: Fix incongruency in handling of sysfs entries creation

Malcolm Priestley (5):
      staging: vt6656: Power save stop wake_up_count wrap around.
      staging: vt6656: Don't set RCR_MULTICAST or RCR_BROADCAST by default.
      staging: vt6656: Fix drivers TBTT timing counter.
      staging: vt6656: Fix pairwise key entry save.
      staging: vt6656: Fix calling conditions of vnt_set_bss_mode

Mircea Caprioru (1):
      iio: core: Fix handling of 'dB'

Olivier Moysan (1):
      iio: adc: stm32-adc: fix sleep in atomic context

Syed Nayyar Waris (1):
      counter: 104-quad-8: Add lock guards - generic interface

Xiyu Yang (1):
      staging: comedi: Fix comedi_device refcnt leak in comedi_open

YueHaibing (1):
      iio:ad7797: Use correct attribute_group

 .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  |   2 +-
 MAINTAINERS                                        |  15 +-
 drivers/counter/104-quad-8.c                       | 194 +++++++++++++++++----
 drivers/iio/adc/ad7192.c                           |  63 +++++--
 drivers/iio/adc/ad7793.c                           |   2 +-
 drivers/iio/adc/stm32-adc.c                        |  31 +++-
 drivers/iio/adc/ti-ads8344.c                       |   6 +-
 drivers/iio/adc/xilinx-xadc-core.c                 |  95 +++++++---
 drivers/iio/common/st_sensors/st_sensors_core.c    |   2 +-
 drivers/iio/dac/ad5770r.c                          |   2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  11 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   3 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |  23 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  24 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c       |  29 ++-
 drivers/iio/industrialio-core.c                    |   7 +-
 drivers/staging/comedi/comedi_fops.c               |   4 +-
 drivers/staging/comedi/drivers/dt2815.c            |   3 +
 drivers/staging/gasket/gasket_sysfs.c              |   3 +-
 drivers/staging/gasket/gasket_sysfs.h              |   4 -
 drivers/staging/vt6656/key.c                       |  14 +-
 drivers/staging/vt6656/main_usb.c                  |  31 ++--
 drivers/staging/vt6656/usbpipe.c                   |   3 +-
 include/linux/iio/iio.h                            |   2 +-
 24 files changed, 429 insertions(+), 144 deletions(-)
