Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CE3C35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761342071E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fH0Ti3or"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgA2MRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:17:49 -0500
Received: from sv2-smtprelay2.synopsys.com ([149.117.73.133]:40438 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726256AbgA2MRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 07:17:45 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8D3E54082B;
        Wed, 29 Jan 2020 12:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1580300264; bh=THplBxZ0iV9F6K6doQzhuA0Zoa7QrZvTKvia+grxBPY=;
        h=From:To:Cc:Subject:Date:From;
        b=fH0Ti3orXuqtTvNNatvWyna/wAvShh0qvfkPulaqXGhwS+ToO7KzQxU18vwbBhowI
         yhpdd+5Rnp7k/Zs2jM5liMQV/tKK8v2fBfValrewrE8X1+i690PszpxrvPEfhgB99z
         9MAluDbT8PXmR2PgCtyZfxmiJ8yV0v4BlbVGhq0huKpDvOsSdrzAi4wkZt5e3+/qPP
         XAjqUweizL6xxSPFXfeAwgaCeCnJNvyDciE0Rf92t5ZIDWowKPoqVLJY07BTo9Ysmh
         mp6uQUMPRxckxHgjYh599yewIR53JaAp5zoqE3EB8GIe9l+VNNF+j6+7m9Iz/XbGJ2
         L+hrda14VbteA==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3CDDBA006E;
        Wed, 29 Jan 2020 12:17:38 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 2731E3F031;
        Wed, 29 Jan 2020 13:17:38 +0100 (CET)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org
Cc:     Joao.Pinto@synopsys.com, Jose.Abreu@synopsys.com,
        bbrezillon@kernel.org, gregkh@linuxfoundation.org,
        wsa@the-dreams.de, arnd@arndb.de, broonie@kernel.org,
        Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [RFC v2 0/4] Introduce i3c device userspace interface
Date:   Wed, 29 Jan 2020 13:17:31 +0100
Message-Id: <cover.1580299067.git.vitor.soares@synopsys.com>
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
  dev/i3c-<bus>-<pid>, but we can change the path to
  dev/bus/i3c/<bus>-<pid> or dev/i3c/<bus>-<pid>.

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

Changes in v2:
  Use IDR api for minor numbering
  Modify ioctl struct
  Fix SPDX license

Vitor Soares (4):
  i3c: master: export i3c_masterdev_type
  i3c: master: export i3c_bus_type symbol
  i3c: master: add i3c_for_each_dev helper
  i3c: add i3cdev module to expose i3c dev in /dev

 drivers/i3c/Kconfig             |  15 ++
 drivers/i3c/Makefile            |   1 +
 drivers/i3c/i3cdev.c            | 429 ++++++++++++++++++++++++++++++++++++++++
 drivers/i3c/internals.h         |   2 +
 drivers/i3c/master.c            |  16 +-
 include/uapi/linux/i3c/i3cdev.h |  38 ++++
 6 files changed, 500 insertions(+), 1 deletion(-)
 create mode 100644 drivers/i3c/i3cdev.c
 create mode 100644 include/uapi/linux/i3c/i3cdev.h

-- 
2.7.4

