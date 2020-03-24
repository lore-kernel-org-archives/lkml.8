Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD17C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A65520775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585044927;
	bh=irZafchmJC4U0lv9GYjkF+aotrzrF07X8GyRS+i1tRo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=rURdpDClgnipkhOkHRsKhX+uc9IMb2mQ+RVFJRX2u/r6/ZMVsOz/KEMixewjknj/b
	 F2hysDnjSXgJgEn7MKJskPP12kCw2VX9gOdtUNEe3s03f/+C8s1lz9h9+DPo29OTs8
	 nrjaV0xaKlQYhFP4wiaZKzT9f2wbgu2A1F/QNGY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgCXKP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:15:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgCXKPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:15:25 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E844D20719;
        Tue, 24 Mar 2020 10:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585044924;
        bh=irZafchmJC4U0lv9GYjkF+aotrzrF07X8GyRS+i1tRo=;
        h=From:To:Cc:Subject:Date:From;
        b=TAHl1fBrhkLbzdCRhlijzeA/oMGBkpqbAR2eAHdU+H2Qhl1M8U4EviBu7wW3RTwFi
         mRDt/zSZMXJIPG3vCXAhqENzVmAkqWB1XAufvlCNc2/bMmjMYf6rRy2KzkrdXAwKOt
         RLCgEwr6i9Bg3YA3QfyFXbyg1+njPp/BVJMl4V4k=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jGgag-001pjG-65; Tue, 24 Mar 2020 11:15:22 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Helen Koike <helen.koike@collabora.com>
Subject: [PATCH 0/8] Reorganize media Kconfig
Date:   Tue, 24 Mar 2020 11:15:13 +0100
Message-Id: <cover.1585044374.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series do some reorg at the media Kconfig options.
It also move test drivers from platform dir to a new one.

After this change, the main config is organized on 4 sections,
indicated via "comment" directives:

	- type of devices selection - the filtering options
	- Media core options - with API and other core stuff
	- Media drivers
	- Media ancillary drivers

The "type of devices" menu has the filtering options for:

	- Cameras and video grabbers
	- Analog TV
	- Digital TV
	- AM/FM radio receivers/transmitters
	- SDR
	- CEC
	- Embeded devices (SoC)
	- Test drivers

This way, one interested only on embedded devices can unselect
everything but "Embedded devices (SoC)" option.

Distros for PC/Laptops can enable everything but 
"Embedded devices (SoC)" and "Test drivers".

Users can select just what they want, without bothering with
hundreds of options that he won't have any clue about their
meanings.

Mauro Carvalho Chehab (8):
  media: dvb-usb: auto-select CYPRESS_FIRMWARE
  media: Kconfig: not all V4L2 platform drivers are for camera
  media: pci: move VIDEO_PCI_SKELETON to a different Kconfig
  media: reorganize the drivers menu options
  media: Kconfig: update the MEDIA_SUPPORT help message
  media: Kconfig: use a sub-menu to select supported devices
  media: Kconfig: add an option to filter in/out the embedded drivers
  media: split test drivers from platform directory

 drivers/media/Kconfig                         | 65 ++++++++++++++-----
 drivers/media/common/Kconfig                  |  2 +-
 drivers/media/mmc/Kconfig                     |  2 +-
 drivers/media/pci/Kconfig                     | 10 +++
 drivers/media/platform/Kconfig                | 24 -------
 drivers/media/platform/Makefile               |  5 --
 drivers/media/test_drivers/Kconfig            | 28 ++++++++
 drivers/media/test_drivers/Makefile           |  9 +++
 .../vicodec/Kconfig                           |  0
 .../vicodec/Makefile                          |  0
 .../vicodec/codec-fwht.c                      |  0
 .../vicodec/codec-fwht.h                      |  0
 .../vicodec/codec-v4l2-fwht.c                 |  0
 .../vicodec/codec-v4l2-fwht.h                 |  0
 .../vicodec/vicodec-core.c                    |  0
 .../media/{platform => test_drivers}/vim2m.c  |  0
 .../{platform => test_drivers}/vimc/Kconfig   |  0
 .../{platform => test_drivers}/vimc/Makefile  |  0
 .../vimc/vimc-capture.c                       |  0
 .../vimc/vimc-common.c                        |  0
 .../vimc/vimc-common.h                        |  0
 .../vimc/vimc-core.c                          |  0
 .../vimc/vimc-debayer.c                       |  0
 .../vimc/vimc-scaler.c                        |  0
 .../vimc/vimc-sensor.c                        |  0
 .../vimc/vimc-streamer.c                      |  0
 .../vimc/vimc-streamer.h                      |  0
 .../{platform => test_drivers}/vivid/Kconfig  |  0
 .../{platform => test_drivers}/vivid/Makefile |  0
 .../vivid/vivid-cec.c                         |  0
 .../vivid/vivid-cec.h                         |  0
 .../vivid/vivid-core.c                        |  0
 .../vivid/vivid-core.h                        |  0
 .../vivid/vivid-ctrls.c                       |  0
 .../vivid/vivid-ctrls.h                       |  0
 .../vivid/vivid-kthread-cap.c                 |  0
 .../vivid/vivid-kthread-cap.h                 |  0
 .../vivid/vivid-kthread-out.c                 |  0
 .../vivid/vivid-kthread-out.h                 |  0
 .../vivid/vivid-kthread-touch.c               |  0
 .../vivid/vivid-kthread-touch.h               |  0
 .../vivid/vivid-meta-cap.c                    |  0
 .../vivid/vivid-meta-cap.h                    |  0
 .../vivid/vivid-meta-out.c                    |  0
 .../vivid/vivid-meta-out.h                    |  0
 .../vivid/vivid-osd.c                         |  0
 .../vivid/vivid-osd.h                         |  0
 .../vivid/vivid-radio-common.c                |  0
 .../vivid/vivid-radio-common.h                |  0
 .../vivid/vivid-radio-rx.c                    |  0
 .../vivid/vivid-radio-rx.h                    |  0
 .../vivid/vivid-radio-tx.c                    |  0
 .../vivid/vivid-radio-tx.h                    |  0
 .../vivid/vivid-rds-gen.c                     |  0
 .../vivid/vivid-rds-gen.h                     |  0
 .../vivid/vivid-sdr-cap.c                     |  0
 .../vivid/vivid-sdr-cap.h                     |  0
 .../vivid/vivid-touch-cap.c                   |  0
 .../vivid/vivid-touch-cap.h                   |  0
 .../vivid/vivid-vbi-cap.c                     |  0
 .../vivid/vivid-vbi-cap.h                     |  0
 .../vivid/vivid-vbi-gen.c                     |  0
 .../vivid/vivid-vbi-gen.h                     |  0
 .../vivid/vivid-vbi-out.c                     |  0
 .../vivid/vivid-vbi-out.h                     |  0
 .../vivid/vivid-vid-cap.c                     |  0
 .../vivid/vivid-vid-cap.h                     |  0
 .../vivid/vivid-vid-common.c                  |  0
 .../vivid/vivid-vid-common.h                  |  0
 .../vivid/vivid-vid-out.c                     |  0
 .../vivid/vivid-vid-out.h                     |  0
 drivers/media/usb/dvb-usb/Kconfig             |  1 +
 drivers/media/v4l2-core/Kconfig               | 10 ---
 73 files changed, 98 insertions(+), 58 deletions(-)
 create mode 100644 drivers/media/test_drivers/Kconfig
 create mode 100644 drivers/media/test_drivers/Makefile
 rename drivers/media/{platform => test_drivers}/vicodec/Kconfig (100%)
 rename drivers/media/{platform => test_drivers}/vicodec/Makefile (100%)
 rename drivers/media/{platform => test_drivers}/vicodec/codec-fwht.c (100%)
 rename drivers/media/{platform => test_drivers}/vicodec/codec-fwht.h (100%)
 rename drivers/media/{platform => test_drivers}/vicodec/codec-v4l2-fwht.c (100%)
 rename drivers/media/{platform => test_drivers}/vicodec/codec-v4l2-fwht.h (100%)
 rename drivers/media/{platform => test_drivers}/vicodec/vicodec-core.c (100%)
 rename drivers/media/{platform => test_drivers}/vim2m.c (100%)
 rename drivers/media/{platform => test_drivers}/vimc/Kconfig (100%)
 rename drivers/media/{platform => test_drivers}/vimc/Makefile (100%)
 rename drivers/media/{platform => test_drivers}/vimc/vimc-capture.c (100%)
 rename drivers/media/{platform => test_drivers}/vimc/vimc-common.c (100%)
 rename drivers/media/{platform => test_drivers}/vimc/vimc-common.h (100%)
 rename drivers/media/{platform => test_drivers}/vimc/vimc-core.c (100%)
 rename drivers/media/{platform => test_drivers}/vimc/vimc-debayer.c (100%)
 rename drivers/media/{platform => test_drivers}/vimc/vimc-scaler.c (100%)
 rename drivers/media/{platform => test_drivers}/vimc/vimc-sensor.c (100%)
 rename drivers/media/{platform => test_drivers}/vimc/vimc-streamer.c (100%)
 rename drivers/media/{platform => test_drivers}/vimc/vimc-streamer.h (100%)
 rename drivers/media/{platform => test_drivers}/vivid/Kconfig (100%)
 rename drivers/media/{platform => test_drivers}/vivid/Makefile (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-cec.c (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-cec.h (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-core.c (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-core.h (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-ctrls.c (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-ctrls.h (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-kthread-cap.c (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-kthread-cap.h (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-kthread-out.c (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-kthread-out.h (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-kthread-touch.c (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-kthread-touch.h (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-meta-cap.c (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-meta-cap.h (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-meta-out.c (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-meta-out.h (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-osd.c (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-osd.h (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-radio-common.c (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-radio-common.h (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-radio-rx.c (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-radio-rx.h (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-radio-tx.c (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-radio-tx.h (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-rds-gen.c (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-rds-gen.h (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-sdr-cap.c (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-sdr-cap.h (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-touch-cap.c (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-touch-cap.h (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-vbi-cap.c (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-vbi-cap.h (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-vbi-gen.c (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-vbi-gen.h (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-vbi-out.c (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-vbi-out.h (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-vid-cap.c (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-vid-cap.h (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-vid-common.c (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-vid-common.h (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-vid-out.c (100%)
 rename drivers/media/{platform => test_drivers}/vivid/vivid-vid-out.h (100%)

-- 
2.24.1


