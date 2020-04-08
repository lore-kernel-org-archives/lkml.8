Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F111FC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 05:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7DD206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 05:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W/29l/zg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgDHFxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 01:53:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36976 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgDHFxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 01:53:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id x1so2141293plm.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 22:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=KBaLvYC51GzNJW9LkKAyV5Oj2tCZdUDKs+/z311mVWc=;
        b=W/29l/zgZPf5sWO3XEse6uzMGH1myUYGtAPbfuIAMK2F2N+uaiG3lD7ADcmA7mqP+Z
         zx/oeZ9T67Vm0K7EZEsJj1vLaPBrM7tVF2m61newmePd2sY6xMwPO0M7WrKHEUomFxJ+
         9xmtb7AznXcNP2mTws5lD2RAW7yVIwtik0RcrCKvpH480OzygM/rpf6RhrBkpQ6yDGPg
         ttGqAF2S26I7/SuzNmoFnV5zQTKFKkPHT4yK3s+QchxJRA6b6pYq9ouFc2qz/6akic4c
         b2yO8M9PMVg7Qgu6bWseVOkuEFWqE/K8xJdNmPQqrsS7a/+wIsL+4kK4K6REv8bUUuQK
         sKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=KBaLvYC51GzNJW9LkKAyV5Oj2tCZdUDKs+/z311mVWc=;
        b=rMj8LucY/1kXwnaGtlJAUYh5Nd2oJhLuBF52mayVpbTizcUfNLGhyyruvxIhEXZhej
         teOP+OzzGJkATziFFUFZnpIK2674QV+4OKBgO1vbvL5sZWZADLcDZNU96VKZTLfzP7pI
         HwHW7xR64eN7N/petTk37PXnBoHB5BuEdYqrIs9mwIWXHZy+XlEqVtze74yRe3BoNrIX
         QmZOsHMNAe/k0TWPhFlXfT8LIshMAIQCxQGNih7kvTb+caWXya6ITqbgf4AH7xP+26YA
         WYDKIWrVnCQgftAlJ93OjDNSO1aRzo86IIYYrtTur+V9fdhCSNm7THmvzqrtQRBo7Zj4
         faaw==
X-Gm-Message-State: AGi0Pube8inQcNXxzmPthujBSa2/VUHnzD+PLfDLAoIMSFXgFGotDRYq
        2nyj7Kj6diIINCTpkTbUnWf9FA==
X-Google-Smtp-Source: APiQypL6fM16CDyBMCoY6TWfoR5l7KfVtcHLDKS+jUlYyGWUle0cJ6oMwDofSYV3qgTc7mxLdKrPyQ==
X-Received: by 2002:a17:902:a5c7:: with SMTP id t7mr5715500plq.330.1586325222484;
        Tue, 07 Apr 2020 22:53:42 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id e80sm16095487pfh.117.2020.04.07.22.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 22:53:41 -0700 (PDT)
Date:   Tue, 7 Apr 2020 22:53:36 -0700
From:   Benson Leung <bleung@google.com>
To:     torvalds@linux-foundation.org
Cc:     bleung@kernel.org, bleung@chromium.org, bleung@google.com,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] chrome-platform changes for v5.7
Message-ID: <20200408055336.GA123431@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git t=
ags/tag-chrome-platform-for-v5.7

for you to fetch changes up to a46387712da12b61bf1ce1a3f63b60a17b098960:

  platform/chrome: cros_ec_spi: Wait for USECS, not NSECS (2020-04-07 14:42=
:08 -0700)

----------------------------------------------------------------
chrome platform changes for 5.7

* cros-usbpd-notify and cros_ec_typec
- Add a new notification driver that handles and dispatches USB PD
 related events to other drivers.
- Add a Type C connector class driver for cros_ec

* CrOS EC
- Introduce a new cros_ec_cmd_xfer_status helper

* Sensors/iio:
- A series from Gwendal that adds Cros EC sensor hub FIFO support

* Wilco EC
- Fix a build warning.
- Platform data shouldn't include kernel.h

* Misc
- i2c api conversion complete, with i2c_new_client_device instead of
 i2c_new_device in chromeos_laptop.
- Replace zero-length array with flexible-array member in cros_ec_chardev
 and wilco_ec
- Update new structure for SPI transfer delays in cros_ec_spi

----------------------------------------------------------------
Andy Shevchenko (1):
      platform/chrome: wilco_ec: Platform data shouldn't include kernel.h

Benson Leung (1):
      platform/chrome: cros_ec_spi: Wait for USECS, not NSECS

Enric Balletbo i Serra (8):
      Merge branch 'chrome-platform-5.6-fixes' into for-next
      platform/chrome: cros_ec_proto: Report command not supported
      platform/chrome: cros_ec_vbc: Use cros_ec_cmd_xfer_status helper
      platform/chrome: cros_ec_chardev: Use cros_ec_cmd_xfer_status helper
      platform/chrome: cros_ec_sysfs: Use cros_ec_cmd_xfer_status helper
      platform/chrome: cros_ec_lightbar: Use cros_ec_cmd_xfer_status helper
      platform/chrome: cros_ec: Use cros_ec_cmd_xfer_status helper
      platform/chrome: Kconfig: Remove CONFIG_ prefix from MFD_CROS_EC sect=
ion

Gustavo A. R. Silva (2):
      platform/chrome: cros_ec_chardev: Replace zero-length array with flex=
ible-array member
      platform/chrome: wilco_ec: event: Replace zero-length array with flex=
ible-array member

Gwendal Grignou (12):
      platform/chrome: cros_usbpd_notify: Fix cros-usbpd-notify notifier
      platform/chrome: cros_ec_sensorhub: Add the number of sensors in sens=
orhub
      platform/chrome: cros_ec_sensorhub: Add FIFO support
      platform/chrome: cros_ec_sensorhub: Add code to spread timestmap
      platform/chrome: cros_ec_sensorhub: Add median filter
      iio: cros_ec: Move function description to .c file
      iio: expose iio_device_set_clock
      iio: cros_ec: Register to cros_ec_sensorhub when EC supports FIFO
      iio: cros_ec: Remove pm function
      iio: cros_ec: Expose hwfifo_timeout
      iio: cros_ec: Report hwfifo_watermark_max
      iio: cros_ec: Use Hertz as unit for sampling frequency

Jon Flatley (2):
      platform: chrome: Add cros-usbpd-notify driver
      power: supply: cros-ec-usbpd-charger: Fix host events

Pi-Hsun Shih (1):
      platform/chrome: cros_ec_rpmsg: Fix race with host event

Prashant Malani (5):
      platform/chrome: cros_usbpd_notify: Add driver data struct
      platform/chrome: cros_usbpd_notify: Amend ACPI driver to plat
      platform/chrome: cros_usbpd_notify: Pull PD_HOST_EVENT status
      platform/chrome: Add Type C connector class driver
      platform/chrome: cros_ec_typec: Update port info from EC

Sergiu Cuciurean (1):
      platform/chrome: cros_ec_spi: Use new structure for SPI transfer dela=
ys

Stephen Boyd (1):
      platform/chrome: wilco_ec: Include asm/unaligned instead of linux/ pa=
th

Wolfram Sang (1):
      platform/chrome: chromeos_laptop: make I2C API conversion complete

Yicheng Li (1):
      platform/chrome: cros_ec: Query EC protocol version if EC transitions=
 between RO/RW

 drivers/iio/accel/cros_ec_accel_legacy.c           |    8 +-
 .../iio/common/cros_ec_sensors/cros_ec_lid_angle.c |    3 +-
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |   13 +-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |  375 +++++--
 drivers/iio/industrialio-core.c                    |    8 +-
 drivers/iio/light/cros_ec_light_prox.c             |   15 +-
 drivers/iio/pressure/cros_ec_baro.c                |   14 +-
 drivers/platform/chrome/Kconfig                    |   27 +-
 drivers/platform/chrome/Makefile                   |    5 +-
 drivers/platform/chrome/chromeos_laptop.c          |    2 +-
 drivers/platform/chrome/cros_ec.c                  |   32 +-
 drivers/platform/chrome/cros_ec_chardev.c          |    4 +-
 drivers/platform/chrome/cros_ec_lightbar.c         |   50 +-
 drivers/platform/chrome/cros_ec_proto.c            |    9 +-
 drivers/platform/chrome/cros_ec_rpmsg.c            |   16 +-
 drivers/platform/chrome/cros_ec_sensorhub.c        |  111 ++-
 drivers/platform/chrome/cros_ec_sensorhub_ring.c   | 1046 ++++++++++++++++=
++++
 drivers/platform/chrome/cros_ec_spi.c              |    6 +-
 drivers/platform/chrome/cros_ec_sysfs.c            |   36 +-
 drivers/platform/chrome/cros_ec_typec.c            |  357 +++++++
 drivers/platform/chrome/cros_ec_vbc.c              |    4 +-
 drivers/platform/chrome/cros_usbpd_notify.c        |  306 ++++++
 drivers/platform/chrome/wilco_ec/event.c           |    4 +-
 drivers/platform/chrome/wilco_ec/properties.c      |    5 +-
 drivers/platform/chrome/wilco_ec/sysfs.c           |    4 +
 drivers/power/supply/Kconfig                       |    2 +-
 drivers/power/supply/cros_usbpd-charger.c          |   50 +-
 include/linux/iio/common/cros_ec_sensors_core.h    |  104 +-
 include/linux/iio/iio.h                            |    2 +
 include/linux/platform_data/cros_ec_proto.h        |    4 +
 include/linux/platform_data/cros_ec_sensorhub.h    |  163 +++
 include/linux/platform_data/cros_usbpd_notify.h    |   17 +
 include/linux/platform_data/wilco-ec.h             |    8 +-
 33 files changed, 2467 insertions(+), 343 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_ec_sensorhub_ring.c
 create mode 100644 drivers/platform/chrome/cros_ec_typec.c
 create mode 100644 drivers/platform/chrome/cros_usbpd_notify.c
 create mode 100644 include/linux/platform_data/cros_usbpd_notify.h

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXo1m4AAKCRBzbaomhzOw
wrlQAQCtd59nMS/RQNZtKkkNVNl+3McVSDk45I2rJevcenqXrgEA00gN7akPEs1l
rX5UaJoZnUsPltHvsO+Aow8sSylSKgg=
=X54N
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
