Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877D4C34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FBC2465A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dICGGJNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgBSAUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:20:51 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:42562 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbgBSAUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 19:20:51 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 11BA0C0098;
        Wed, 19 Feb 2020 00:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1582071650; bh=ddKM9xkbcpuB2cBOgjOc0jvYyLJYZ6mC3oVxtJxau2Q=;
        h=From:To:Cc:Subject:Date:From;
        b=dICGGJNh6vH/STWxR/oej8fNp8Uuz1I5m9moEHsNCMPpZzmSOiUYAzPKGJALDy5lc
         E/+2+5+el+eeqNre6i3Cil92pMdXZzU2+gbsclmQjztrsbRIAyeBH6YAMvI1PWuAU5
         RoTmjkTcLdyP1YmL4yzGPupCDMo17kugkYDgUPWgqXOdhea0m1eT+0oPU9Me56hKJg
         gMMeNCbqOXf8h9EOYm21f97u9mqka3tBAddnqU3TLKXO4X0RAHKrIEAOmtxgurl5Rj
         S3jRzA4krL0PaJYmwiQz6EmTbDLGc+b11s1HXgwQ0xF1dpcfLXh1UYEsx/4KzHVgWk
         oEKyAyBDgnbOQ==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 34E31A007B;
        Wed, 19 Feb 2020 00:20:47 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id E39B73D240;
        Wed, 19 Feb 2020 01:20:46 +0100 (CET)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org
Cc:     Joao.Pinto@synopsys.com, Jose.Abreu@synopsys.com,
        bbrezillon@kernel.org, gregkh@linuxfoundation.org,
        wsa@the-dreams.de, arnd@arndb.de, broonie@kernel.org,
        corbet@lwn.net, Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [PATCH v3 0/5] Introduce i3c device userspace interface
Date:   Wed, 19 Feb 2020 01:20:38 +0100
Message-Id: <cover.1582069402.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For today there is no way to use i3c devices from user space and
the introduction of such API will help developers during the i3c device
or i3c host controllers development.

The i3cdev module is highly based on i2c-dev and yet I tried to address
the concerns raised in [1].

NOTES:
- The i3cdev dynamically request an unused major number.

- The i3c devices are dynamically exposed/removed from dev/ folder based
  on if they have a device driver bound to it.

- For now, the module exposes i3c devices without device driver on
  dev/bus/i3c/<bus>-<pid>

- As in the i2c subsystem, here it is exposed the i3c_priv_xfer to
  userspace. I tried to use a dedicated structure as in spidev but I don't
  see any obvious advantage.

- Since the i3c API only exposes i3c_priv_xfer to devices, for now, the
  module just makes use of one ioctl(). This can change in the future with
  the introduction hdr commands or by the need of exposing some CCC
  commands to the device API (private contract between master-slave).
  Regarding the i3c device info, some information is already available
  through sysfs. We can add more device attributes to expose more
  information or add a dedicated ioctl() request for that purpose or both.

- Similar to i2c, I have also created a tool that you can find in [2]
  for testing purposes. If you have some time available I would appreciate
  your feedback about it as well.

[1] https://lkml.org/lkml/2018/11/15/853
[2] https://github.com/vitor-soares-snps/i3c-tools.git

Changes in v3:
  Use the xfer_lock to prevent device detach during ioctl call
  Expose i3cdev under /dev/bus/i3c/ folder like usb does
  Change NOTIFY_BOUND to NOTIFY_BIND, this allows the device detach occur
  before driver->probe call
  Avoid use of IS_ERR_OR_NULL
  Use u64_to_user_ptr instead of (void __user *)(uintptr_t) cast
  Allocate k_xfer and data_ptrs at once and eliminate double allocation
  check
  Pass i3cdev to dev->driver_data
  Make all minors available
  Add API documentation

Changes in v2:
  Use IDR api for minor numbering
  Modify ioctl struct
  Fix SPDX license

Vitor Soares (5):
  i3c: master: export i3c_masterdev_type
  i3c: master: export i3c_bus_type symbol
  i3c: master: add i3c_for_each_dev helper
  i3c: add i3cdev module to expose i3c dev in /dev
  Documentation: userspac-api: add i3cdev documentation

 Documentation/userspace-api/i3c/i3cdev.rst | 116 ++++++++
 drivers/i3c/Kconfig                        |  15 +
 drivers/i3c/Makefile                       |   1 +
 drivers/i3c/i3cdev.c                       | 429 +++++++++++++++++++++++++++++
 drivers/i3c/internals.h                    |   2 +
 drivers/i3c/master.c                       |  16 +-
 include/uapi/linux/i3c/i3cdev.h            |  38 +++
 7 files changed, 616 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/userspace-api/i3c/i3cdev.rst
 create mode 100644 drivers/i3c/i3cdev.c
 create mode 100644 include/uapi/linux/i3c/i3cdev.h

-- 
2.7.4

