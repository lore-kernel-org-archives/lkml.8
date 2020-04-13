Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04067C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA56620739
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbgDMPGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:06:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59934 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbgDMPGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:06:47 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 31F6A2A1296
Received: by jupiter.universe (Postfix, from userid 1000)
        id 948F64800F7; Mon, 13 Apr 2020 17:06:42 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jean Delvare <jdelvare@suse.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Adam Honse <calcprogrammer1@gmail.com>
Subject: [PATCH] i2c: piix4: Add second SMBus for X370/X470/X570
Date:   Mon, 13 Apr 2020 17:06:34 +0200
Message-Id: <20200413150634.474842-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The second interface can be found on X370, X470 and X570 according
to the bugzilla entry. I only tested with X570 on an ASRock X570
Taichi:

$ lspci -nnv -d 1022:790b
00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller [1022:790b] (rev 61)
	Subsystem: ASRock Incorporation FCH SMBus Controller [1849:ffff]
	Flags: 66MHz, medium devsel
	Kernel driver in use: piix4_smbus
	Kernel modules: i2c_piix4, sp5100_tco

Before the patch:

$ i2cdetect -l | grep PIIX4
i2c-1	unknown   	SMBus PIIX4 adapter port 2 at 0b00	N/A
i2c-0	unknown   	SMBus PIIX4 adapter port 0 at 0b00	N/A

After the patch:

$ i2cdetect -l | grep PIIX4
i2c-1	unknown   	SMBus PIIX4 adapter port 2 at 0b00	N/A
i2c-2	unknown   	SMBus PIIX4 adapter port 1 at 0b20	N/A
i2c-0	unknown   	SMBus PIIX4 adapter port 0 at 0b00	N/A

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202587
Reported-by: Adam Honse <calcprogrammer1@gmail.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Hi,

The Bugzilla entry contains a second change, which reduces the timeouts
for quicker operation. I did not include that change, since I do not know
if this is a good idea for all devices supported by this driver. In any
case it should be a separate patch. Let's get the interface working for
now.

-- Sebastian
---
 drivers/i2c/busses/i2c-piix4.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 30ded6422e7b..3e89143a0ecf 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -976,9 +976,11 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		}
 	}
 
-	if (dev->vendor == PCI_VENDOR_ID_AMD &&
-	    dev->device == PCI_DEVICE_ID_AMD_HUDSON2_SMBUS) {
-		retval = piix4_setup_sb800(dev, id, 1);
+	if (dev->vendor == PCI_VENDOR_ID_AMD) {
+		if (dev->device == PCI_DEVICE_ID_AMD_HUDSON2_SMBUS ||
+		    dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) {
+			retval = piix4_setup_sb800(dev, id, 1);
+		}
 	}
 
 	if (retval > 0) {
-- 
2.25.1

