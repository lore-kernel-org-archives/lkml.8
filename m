Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FCBC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 07:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900F2206D3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 07:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgBAHqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 02:46:33 -0500
Received: from foss.arm.com ([217.140.110.172]:41104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgBAHqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 02:46:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EB7CFEC;
        Fri, 31 Jan 2020 23:46:32 -0800 (PST)
Received: from u200856.usa.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC3C73F52E;
        Fri, 31 Jan 2020 23:50:10 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     netdev@vger.kernel.org
Cc:     opendmb@gmail.com, f.fainelli@gmail.com, davem@davemloft.net,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, wahrenst@gmx.net, andrew@lunn.ch,
        hkallweit1@gmail.com, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 0/6] Add ACPI bindings to the genet
Date:   Sat,  1 Feb 2020 01:46:19 -0600
Message-Id: <20200201074625.8698-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series allows the BCM GENET, as used on the RPi4,
to attach when booted in an ACPI environment. The DSDT entry to
trigger this is seen below. Of note, the first patch adds a
small extension to the mdio layer which allows drivers to find
the mii_bus without firmware assistance. The fifth patch in
the set retrieves the MAC address from the umac registers
rather than carrying it directly in the DSDT. This of course
requires the firmware to pre-program it, so we continue to fall
back on a random one if it appears to be garbage.

v1 -> v2:
     add a core routine mdio_find_bus(), then use it to attach
         to the phy rather than hard-coding the id.
     Broke initial ACPI support patch into 3 parts, two for bcmmii.c
     Address some review comments from Florian
     Lower the severity of a few dev_warns that happen all the time.

+    Device (ETH0)
+    {
+      Name (_HID, "BCM6E4E")
+      Name (_UID, 0)
+      Name (_CCA, 0x0)
+      Method (_STA)
+      {
+        Return (0xf)
+      }
+      Method (_CRS, 0x0, Serialized)
+      {
+        Name (RBUF, ResourceTemplate ()
+        {
+          Memory32Fixed (ReadWrite, 0xFd580000, 0x10000, )
+          Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { 0xBD }
+          Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { 0xBE }
+        })
+        Return (RBUF)
+      }
+      Name (_DSD, Package () {
+        ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+          Package () {
+          Package () { "phy-mode", "rgmii" },
+        }
+      })
+    }
+

Jeremy Linton (6):
  mdio_bus: Add generic mdio_find_bus()
  net: bcmgenet: refactor phy mode configuration
  net: bcmgenet: enable automatic phy discovery
  net: bcmgenet: Initial bcmgenet ACPI support
  net: bcmgenet: Fetch MAC address from the adapter
  net: bcmgenet: reduce severity of missing clock warnings

 .../net/ethernet/broadcom/genet/bcmgenet.c    | 66 +++++++++++-----
 drivers/net/ethernet/broadcom/genet/bcmmii.c  | 79 +++++++++++++------
 drivers/net/phy/mdio_bus.c                    | 17 ++++
 include/linux/phy.h                           |  1 +
 4 files changed, 122 insertions(+), 41 deletions(-)

-- 
2.24.1

