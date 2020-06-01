Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3091CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B38206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgFAJTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:19:05 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:51528 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726011AbgFAJTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:19:01 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from vadimp@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 1 Jun 2020 12:18:54 +0300
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0519IsSo003135;
        Mon, 1 Jun 2020 12:18:54 +0300
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     andy@infradead.org, dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH platform-next v1 0/8] platform/x86: Add new features for Mellanox systems
Date:   Mon,  1 Jun 2020 12:18:43 +0300
Message-Id: <20200601091851.5491-1-vadimp@mellanox.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset adds new features for the existing Mellanox systems.

Patch #1 allows to configure number of hotplug 'sysfs' attributes for
		 the particular system class according to the hardware data for
		 the specific system from this class, instead of configuring it
		 up-to maximum number in the class.
Patch #2 adds environmental data to hotplug uevent.
Patches #3-#4 adds more definitions for system attributes.
Patch #5 extends 'mlxreg-io' driver with complex attributes support.
Patches #6 extends documentation with new attributes.
Patches #7-#8 extends FAN platform data with register presence field.

Vadim Pasternak (8):
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
 drivers/platform/mellanox/mlxreg-hotplug.c      |  81 ++++++++++----
 drivers/platform/mellanox/mlxreg-io.c           |  47 ++++++--
 drivers/platform/x86/mlx-platform.c             | 141 ++++++++++++++++++++++++
 include/linux/platform_data/mlxreg.h            |   4 +
 5 files changed, 258 insertions(+), 32 deletions(-)

-- 
2.11.0

