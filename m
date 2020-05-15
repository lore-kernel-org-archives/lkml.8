Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B793C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00A6B20728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgEOPS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:18:27 -0400
Received: from lists.gateworks.com ([108.161.130.12]:58520 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgEOPSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:18:23 -0400
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <tharvey@gateworks.com>)
        id 1jZc8s-0004Ex-88; Fri, 15 May 2020 15:20:54 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Lee Jones <lee.jones@linaro.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Jones <rjones@gateworks.com>
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v10 0/3] Add support for the Gateworks System Controller
Date:   Fri, 15 May 2020 08:18:08 -0700
Message-Id: <1589555891-16502-1-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the Gateworks System Controller used on Gateworks
Laguna, Ventana, and Newport product families.

The GSC is an MSP430 I2C slave controller whose firmware embeds the following
features:
 - I/O expander (16 GPIO's emulating a PCA955x)
 - EEPROM (enumating AT24)
 - RTC (enumating DS1672)
 - HWMON
 - Interrupt controller with tamper detect, user pushbotton
 - Watchdog controller capable of full board power-cycle
 - Power Control capable of full board power-cycle

see http://trac.gateworks.com/wiki/gsc for more details

v10:
 - mfd: fix typo and gramatical errors in Kconfig and comment block
 - mfd: drop unused i2c device-id table
 - mfd: added Lee's ack in s-o-b

v9:
 - rebase against 5.7-rc2
 - dt-binding: remove allOf: see https://lkml.org/lkml/2020/4/15/1930
 - dt-binding: encorporate Lee's review comments for item descriptions
 - dt-binding: added Reviewed-by: Rob Herring <robh@kernel.org>
 - mfd: cleanup gsc_powerdown() by using BIT(), put_unaligned_le32(), and
   avoid unnecessary assignments
 - mfd: rename GSC_CTRL_1 SLEEP related defines to simplify
 - mfd: add better description and sub-module info to driver description
 - mfd: whitespace changes per review
 - mfd: remove unused irq_data pointer in ddata
 - mfd: remove unnecesary i2c_set_clientdata
 - mfd: use devm_i2c_new_dummy_device to avoid need of free's
 - mfd: change regsiter definitions to enum
 - mfd: export gsc_{read,write} instead of sharing them via ddata
 - hwmon: use exported gsc_{read,write}
 - hwmon: added Reviewed-by: Guenter Roeck <linux@roeck-us.net>


v8:
 - mfd: whitespace fixes
 - mfd: describe sub-devices in Kconfig
 - mfd: add error print for invalid command
 - mfd: update copyright
 - mfd: use devm_of_platform_populate
 - mfd: use probe_new
 - mfd: move hwmon's regmap init to hwmon
 - hwmon: move hwmon's regmap init to hwmon
 - dt-bindings: add register to fan-controller node name

v7:
 - dt-bindings: change divider from mili-ohms to ohms
 - dt-bindings: add constraints for voltage divider and offset
 - dt-bindings: remove unnecessary ref for offset
 - dt-bindings: renamed fan to fan-controller and changed base prop to reg
 - mfd:  remove irq from private data struct
 - hwmon: fix whitespace in Kconfig
 - hwmon: remove unnecessary device pointer in private data
 - hwmon: change divider from mili-ohms to ohms
 - hwmon: move fan base property to reg

v6:
 - hwmon: fix size of info field
 - hwmon: improve pwm output control documentation
 - hwmon: include unit suffix in divider and offset
 - hwmon: change subnode name to gsc-adc
 - hwmon: change to fan subnode
 - hwmon: fix voltage offset
 - dt-bindings: fix commit message typo
 - dt-bindings: drop invalid description from #interrupt-cells property
 - dt-bindings: fix adc pattern property
 - dt-bindings: add unit suffix
 - dt-bindings: replace hwmon/adc with adc/channel
 - dt-bindings: changed adc type to gw,mode
 - dt-bindings: add unit suffix and drop ref for voltage-divider
 - dt-bindings: add unit suffix for voltage-offset
 - dt-bindings: moved fan to its own subnode with base register

v5:
 - fix checkpatch issues
 - fix dt_binding_check issues
 - address feedback from v4

v4:
 - hwmon: move to using pwm<n>_auto_point<m>_{pwm,temp} for FAN PWM
 - hwmon: remove unncessary resolution/scaling properties for ADCs
 - bindings: update to yaml Documentation
 - removed watchdog driver

v3:
 - removed unnecessary input driver
 - added wdt driver
 - bindings: encorporated feedback from mailng list
 - hwmon:
 - encoroprated feedback from mailng list
 - added support for raw ADC voltage input used in newer GSC firmware

v2:
 - change license comment block style
 - remove COMPILE_TEST
 - fixed whitespace issues
 - replaced a printk with dev_err
 - remove DEBUG
 - simplify regmap_bulk_read err check
 - remove break after returns in switch statement
 - fix fan setpoint buffer address
 - remove unnecessary parens
 - consistently use struct device *dev pointer
 - add validation for hwmon child node props
 - move parsing of of to own function
 - use strlcpy to ensure null termination
 - fix static array sizes and removed unnecessary initializers
 - dynamically allocate channels
 - fix fan input label
 - support platform data

Tim Harvey (3):
  dt-bindings: mfd: Add Gateworks System Controller bindings
  mfd: add Gateworks System Controller core driver
  hwmon: add Gateworks System Controller support

 .../devicetree/bindings/mfd/gateworks-gsc.yaml     | 196 +++++++++++
 Documentation/hwmon/gsc-hwmon.rst                  |  53 +++
 Documentation/hwmon/index.rst                      |   1 +
 MAINTAINERS                                        |  11 +
 drivers/hwmon/Kconfig                              |   9 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/gsc-hwmon.c                          | 390 +++++++++++++++++++++
 drivers/mfd/Kconfig                                |  15 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/gateworks-gsc.c                        | 278 +++++++++++++++
 include/linux/mfd/gsc.h                            |  76 ++++
 include/linux/platform_data/gsc_hwmon.h            |  44 +++
 12 files changed, 1075 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
 create mode 100644 Documentation/hwmon/gsc-hwmon.rst
 create mode 100644 drivers/hwmon/gsc-hwmon.c
 create mode 100644 drivers/mfd/gateworks-gsc.c
 create mode 100644 include/linux/mfd/gsc.h
 create mode 100644 include/linux/platform_data/gsc_hwmon.h

-- 
2.7.4

