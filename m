Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4030C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 23:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBE620721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 23:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ibtqUy2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgBCXOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 18:14:43 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55094 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgBCXOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 18:14:43 -0500
Received: by mail-pj1-f66.google.com with SMTP id dw13so468105pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 15:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=z0emKTNSxECysIf5/pHJGsK0ND1LPzB+bxUPAg860H4=;
        b=ibtqUy2Kd338VfcqmRFzMkXNX67TF49hXV5g+f1o1ip/vxyX497aMY1sHtxAK2Eri7
         ZH0EZytEf4SriWmvx1xIKWmDjK5xT0G0moazVt/lKOypy6ABMns4iWatMjEmRKaz61IR
         O+mu2cBRWs2L+/Ds5KDHkb0Re24QH+xnN4aNX2HfjQkro9UtVOHdJ0CpwjpLnWI4ZvyG
         uSDbc27aAWztjeGkogLugY2CIMeLH4U6pO+nqUR4OmAX/AVswfnS8sdP7yyHApmAU3VB
         2+VMgCaA3evtrO5PFpaHSiKoroHYMVwSk7MLIRvNHrIjiWh/XHtY8tRG7nmChIh6Mb2l
         zDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=z0emKTNSxECysIf5/pHJGsK0ND1LPzB+bxUPAg860H4=;
        b=e6npVYVxsBkYEv5wEp7+ulTs6XTXqUdBfIIvSM9Lehjzw7TXvr4rB1KMhc3OGLpob3
         MiJNJ1sskuIiHX8MSWb7P6CGCvORxA4nro5Q2xXclSWTAOWZ345p/WiyjwUJ2sGaPXtM
         VcufWnwxxcmDT2bJhHQs4aqHPRSAtqCiDSdPKDag+bwtyoNGaa+qKguX6v7RLxP95G8M
         YznAlgsuwsBqgVSsfPgecJ6LNgmRZmPGY0uA/g8nXMSM9F8FtRUw0nFQhfYs8YKa9WON
         el50wX5fq72G6a/5Dvt2IUrSq7f/Vgs+Nkset32K8sRQ8se0KzB+sibTX8I02jmavIg5
         cKEg==
X-Gm-Message-State: APjAAAWxM64gSd/iGtWnRY1etz9Ft1Jslil6LkR4o8/+y3ahJyjcK7ub
        I2u6ctdXpaaYgKHmLpuq1iV5PA==
X-Google-Smtp-Source: APXvYqzWzESicq3U0D9FxMqvkZpw32vjQdmjLABfnKa19ltd4kc/F++LluaICEoLcyEpKWEsPWJMEA==
X-Received: by 2002:a17:902:9687:: with SMTP id n7mr26624531plp.168.1580771680882;
        Mon, 03 Feb 2020 15:14:40 -0800 (PST)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id b3sm510826pjo.30.2020.02.03.15.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 15:14:39 -0800 (PST)
Date:   Mon, 3 Feb 2020 15:14:30 -0800
From:   Benson Leung <bleung@google.com>
To:     torvalds@linux-foundation.org
Cc:     bleung@kernel.org, bleung@chromium.org, bleung@google.com,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] chrome-platform changes for v5.6
Message-ID: <20200203231430.GA205960@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git t=
ags/tag-chrome-platform-for-v5.6

for you to fetch changes up to 034dbec179e5d2820480f477c43acbc50245e56d:

  platform/chrome: cros_ec: Match implementation with headers (2020-02-03 1=
7:14:50 +0100)

----------------------------------------------------------------
chrome platform changes for 5.6

* CrOS EC
- Refactoring of some of cros_ec's headers. include/linux/mfd/cros_ec.h now
  removed, new cros_ec.h added drivers/platform/chrome which contains shared
  operations of cros_ec transport drivers.
- Response tracing in cros_ec_proto

* Wilco EC
- Fix unregistration order.
- Fix keyboard backlight probing on systems without keyboard backlight
- Minor cleanup (newlines in printks, COMPILE_TEST)

* Misc
- chromeos_laptop converted to use i2c_new_scanned_device instead of
  i2c_new_probed_device

----------------------------------------------------------------
Ben Dooks (Codethink) (1):
      platform/chrome: cros_ec_ishtp: Make init_lock static

Benson Leung (1):
      Merge branch 'chrome-platform-5.5-fixes' into for-kernelci

Daniel Campello (2):
      platform/chrome: wilco_ec: Fix unregistration order
      platform/chrome: wilco_ec: Fix keyboard backlight probing

Enric Balletbo i Serra (4):
      platform/chrome: cros_ec_trace: Match trace commands with EC commands
      platform/chrome: cros_ec_lpc: Use platform_get_irq_optional() for opt=
ional IRQs
      cros_ec: treewide: Remove 'include/linux/mfd/cros_ec.h'
      platform/chrome: cros_ec: Match implementation with headers

Raul E Rangel (1):
      platform/chrome: cros_ec_proto: Add response tracing

Stephen Boyd (3):
      platform/chrome: wilco_ec: Add newlines to printks
      platform/chrome: wilco_ec: Allow wilco to be compiled in COMPILE_TEST
      platform/chrome: cros_ec: Drop unaligned.h include

Wolfram Sang (1):
      platform/chrome: chromeos_laptop: Convert to i2c_new_scanned_device

 drivers/iio/accel/cros_ec_accel_legacy.c           |  1 -
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |  1 -
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |  1 -
 drivers/iio/light/cros_ec_light_prox.c             |  1 -
 drivers/iio/pressure/cros_ec_baro.c                |  1 -
 drivers/media/platform/cros-ec-cec/cros-ec-cec.c   |  1 -
 drivers/mfd/cros_ec_dev.c                          |  1 -
 drivers/platform/chrome/chromeos_laptop.c          | 18 ++--
 drivers/platform/chrome/cros_ec.c                  |  3 +-
 drivers/platform/chrome/cros_ec.h                  | 19 +++++
 drivers/platform/chrome/cros_ec_chardev.c          |  1 -
 drivers/platform/chrome/cros_ec_debugfs.c          |  1 -
 drivers/platform/chrome/cros_ec_i2c.c              |  2 +
 drivers/platform/chrome/cros_ec_ishtp.c            |  4 +-
 drivers/platform/chrome/cros_ec_lightbar.c         |  1 -
 drivers/platform/chrome/cros_ec_lpc.c              |  3 +-
 drivers/platform/chrome/cros_ec_proto.c            |  6 +-
 drivers/platform/chrome/cros_ec_rpmsg.c            |  2 +
 drivers/platform/chrome/cros_ec_sensorhub.c        |  1 -
 drivers/platform/chrome/cros_ec_spi.c              |  2 +
 drivers/platform/chrome/cros_ec_sysfs.c            |  1 -
 drivers/platform/chrome/cros_ec_trace.c            | 97 ++++++++++++++++++=
++--
 drivers/platform/chrome/cros_ec_trace.h            | 26 ++++--
 drivers/platform/chrome/cros_ec_vbc.c              |  1 -
 drivers/platform/chrome/cros_usbpd_logger.c        |  1 -
 drivers/platform/chrome/wilco_ec/Kconfig           |  3 +-
 drivers/platform/chrome/wilco_ec/core.c            |  4 +-
 drivers/platform/chrome/wilco_ec/keyboard_leds.c   | 32 ++++---
 drivers/platform/chrome/wilco_ec/mailbox.c         |  4 +-
 drivers/platform/chrome/wilco_ec/telemetry.c       |  6 +-
 drivers/power/supply/cros_usbpd-charger.c          |  1 -
 drivers/rtc/rtc-cros-ec.c                          |  1 -
 include/linux/mfd/cros_ec.h                        | 35 --------
 include/linux/platform_data/cros_ec_proto.h        | 29 +++++--
 34 files changed, 208 insertions(+), 103 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_ec.h
 delete mode 100644 include/linux/mfd/cros_ec.h

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXjipVgAKCRBzbaomhzOw
wjtQAP9KR4M0xBCS/FwnRgse4s/wa/2i1Ey0qOcnXBKkZWrvmgD/XIJY/vGGnu3b
NnrEkPQQU14KNC4dWHd2OF0b9c2qvwk=
=z8g+
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
