Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BA8C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 893E822227
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgGNMCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:02:08 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:52543 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726041AbgGNMCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:02:08 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from vadimp@mellanox.com)
        with SMTP; 14 Jul 2020 15:02:05 +0300
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 06EC25dd004353;
        Tue, 14 Jul 2020 15:02:05 +0300
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     andy@infradead.org, dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH platform-next v2 00/11] platform/x86: Add new features for Mellanox systems
Date:   Tue, 14 Jul 2020 15:01:52 +0300
Message-Id: <20200714120203.10352-1-vadimp@mellanox.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset adds new features for the existing Mellanox systems.

Patch #1 add string helpers for upper/lower conversion.
Patch #2 add tests for these helpers.
Patch #3 updates license for module 'mlxreg-hotplug'.
Patch #4 allows to configure number of hotplug 'sysfs' attributes for
		 the particular system class according to the hardware data for
		 the specific system from this class, instead of configuring it
		 up-to maximum number in the class.
Patch #5 adds environmental data to hotplug 'uevent'.
Patches #6-#7 add more definitions for system attributes.
Patch #8 extends 'mlxreg-io' driver with complex attributes support.
Patch #9 extends documentation with new attributes.
Patches #10-#11 extend FAN platform data with register presence field.

Vadim Pasternak (11):
  lib/string_helpers: Introduce string_upper() and string_lower()
    helpers
  lib/test-string_helpers.c: Add string_upper() and string_lower() tests
  platform/mellanox: mlxreg-hotplug: Modify module license
  platform/mellanox: mlxreg-hotplug: Use capability register for
    attribute creation
  platform/mellanox: mlxreg-hotplug: Add environmental data to uevent
  platform_data/mlxreg: Add support for complex attributes
  platform/x86: mlx-platform: Add more definitions for system attributes
  platform/mellanox: mlxreg-io: Add support for complex attributes
  Documentation/ABI: Add new attribute for mlxreg-io sysfs interfaces
  platform_data/mlxreg: Add presence register field for FAN devices
  platform/x86: mlx-platform: Extend FAN platform data description

 Documentation/ABI/stable/sysfs-driver-mlxreg-io |  17 +++
 drivers/platform/mellanox/mlxreg-hotplug.c      | 114 ++++++++++---------
 drivers/platform/mellanox/mlxreg-io.c           |  45 ++++++--
 drivers/platform/x86/mlx-platform.c             | 141 ++++++++++++++++++++++++
 include/linux/platform_data/mlxreg.h            |   4 +
 include/linux/string_helpers.h                  |  15 +++
 lib/test-string_helpers.c                       |  67 +++++++++++
 7 files changed, 341 insertions(+), 62 deletions(-)

-- 
2.11.0

