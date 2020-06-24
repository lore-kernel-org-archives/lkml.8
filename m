Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB058C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBFE2207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389712AbgFXHWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:22:51 -0400
Received: from ms-10.1blu.de ([178.254.4.101]:60686 "EHLO ms-10.1blu.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbgFXHWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:22:47 -0400
Received: from [78.43.71.214] (helo=marius.fritz.box)
        by ms-10.1blu.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mail@mariuszachmann.de>)
        id 1jnzjw-0000VK-Jk; Wed, 24 Jun 2020 09:22:36 +0200
From:   Marius Zachmann <mail@mariuszachmann.de>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Marius Zachmann <mail@mariuszachmann.de>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH v4 0/3] hwmon: Add Corsair Commander Pro driver
Date:   Wed, 24 Jun 2020 09:21:51 +0200
Message-Id: <20200624072154.22486-1-mail@mariuszachmann.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Con-Id: 241080
X-Con-U: 0-mail
X-Originating-IP: 78.43.71.214
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v4 of a driver for the Corsair Commander Pro.
It provides sysfs attributes for:
- Reading fan speed
- Reading temp sensors
- Reading voltage values
- Writing pwm and reading last written pwm
- Reading fan and temp connection status

It is an usb driver, so it needs to be ignored by usbhid. (patch 3/3)
This is based on the staging/hwmon tree.

Signed-off-by: Marius Zachmann <mail@mariuszachmann.de>
---

Changes from v3
- add device ids to hid_ignore_list in hid-quirks.h
- removed unused update_interval
- ccp_disconnect is static

Changes from v2
- add corsair-cpro to Documentation/hwmon/index.rst
- add SPDX license identifier to corsair-cpro.rst
- remove fanX_enable from Documentation and driver
- changed comment style
- clarified protocol in comments
- add get_temp_cnct for reading temperature sensor
  connection status
- added temp_cnct and temp_label in ccp_device
- added tempX_label, showing connection status
- renamed get_fan_mode_label to get_fan_cnct
- get_temp_cnct and get_fan_cnct only called in probe
- send_usb_cmd checks errors in the device response
- send_usb_cmd clears the buffer and sets the
  command
- inlined get_fan_rpm and get_voltage and removed
  functions
- more reverse christmas tree


Marius Zachmann (3):
  input: add to hid_ignore_list
  add Documentation
  add driver

 Documentation/hwmon/corsair-cpro.rst |  40 +++
 Documentation/hwmon/index.rst        |   1 +
 MAINTAINERS                          |   6 +
 drivers/hid/hid-quirks.c             |   2 +
 drivers/hwmon/Kconfig                |  10 +
 drivers/hwmon/Makefile               |   1 +
 drivers/hwmon/corsair-cpro.c         | 489 +++++++++++++++++++++++++++
 7 files changed, 549 insertions(+)
 create mode 100644 Documentation/hwmon/corsair-cpro.rst
 create mode 100644 drivers/hwmon/corsair-cpro.c

--
2.27.0
