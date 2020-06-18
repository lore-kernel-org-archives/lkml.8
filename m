Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ABEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D870D2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592446033;
	bh=vp+pes/sM3I/nBuCLR4aObuWnGa4VZ7OKg61Q4yIjjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mvH7vE7WZfbJdWG9UUNmCGK+xKIUxQ6A7Dg1L3V5iZKTKbbKMZHuDydE2dcsuJ1IS
	 JHHGTOYrozoBxoCB5d2na8/npK7hcgFjTrN2WS6FooN3TqH38fnMDd844oA1LHvXlI
	 7HzGoJWxfcwN7lWPENhmLU3o9+WSYJklqJ/Oglsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732664AbgFRCHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:07:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730741AbgFRBWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:22:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35A0F20CC7;
        Thu, 18 Jun 2020 01:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443345;
        bh=vp+pes/sM3I/nBuCLR4aObuWnGa4VZ7OKg61Q4yIjjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aCzHTUh9Nuzao1mu5up2VNKSgqHeNXJPJBiOLXKTDld3yX8TyRIOjufYGo7zGugpq
         CnlHvlrcS30i5+HPNSav/p2DwzQiBf+ldUhsbD7q1W0RS55ul2H58EaFeFPVXmOF3R
         yzsYtGNpe+GP6Gkz2r3rCLMK58VQiAJTDzGcqe60=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Adam Honse <calcprogrammer1@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 005/172] i2c: piix4: Detect secondary SMBus controller on AMD AM4 chipsets
Date:   Wed, 17 Jun 2020 21:19:31 -0400
Message-Id: <20200618012218.607130-5-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Honse <calcprogrammer1@gmail.com>

[ Upstream commit f27237c174fd9653033330e4e532cd9d153ce824 ]

The AMD X370 and other AM4 chipsets (A/B/X 3/4/5 parts) and Threadripper
equivalents have a secondary SMBus controller at I/O port address
0x0B20.  This bus is used by several manufacturers to control
motherboard RGB lighting via embedded controllers.  I have been using
this bus in my OpenRGB project to control the Aura RGB on many
motherboards and ASRock also uses this bus for their Polychrome RGB
controller.

I am not aware of any CZ-compatible platforms which do not have the
second SMBus channel.  All of AMD's AM4- and Threadripper- series
chipsets that OpenRGB users have tested appear to have this secondary
bus.  I also noticed this secondary bus is present on older AMD
platforms including my FM1 home server.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202587
Signed-off-by: Adam Honse <calcprogrammer1@gmail.com>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Tested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-piix4.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 9ff3371ec385..f1c79f9b3919 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -958,7 +958,8 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	}
 
 	if (dev->vendor == PCI_VENDOR_ID_AMD &&
-	    dev->device == PCI_DEVICE_ID_AMD_HUDSON2_SMBUS) {
+	    (dev->device == PCI_DEVICE_ID_AMD_HUDSON2_SMBUS ||
+	     dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS)) {
 		retval = piix4_setup_sb800(dev, id, 1);
 	}
 
-- 
2.25.1

