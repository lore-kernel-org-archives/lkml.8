Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DC5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74BF721BE5
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945095;
	bh=ayWTO8VHzqz9p3VnbCd0mRbHFFuvyRKBUrFM+f6HTXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JJIxUTw3HQZ19USmSO6axoqLq/drCR9Kg3kVVgXvoksNDDNp4dzOBYko6TH1wG3Jq
	 hYbAvOPmBH6TWUSidiW8NaUBzndlI5QR0HHUhyJlsp8Uq2bcjtkBo28iSeVZbtf3ac
	 oHy1BAw10pi+IrcEugBELZmM7GiQzhHjl2YhDnEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392616AbgFWUot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:44:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391610AbgFWUoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:44:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A29F121927;
        Tue, 23 Jun 2020 20:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592945085;
        bh=ayWTO8VHzqz9p3VnbCd0mRbHFFuvyRKBUrFM+f6HTXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mKGmgKtGzoJDViCF58b4Rzp8CO5AAVEiSPaS/jjiT6hSoBW8Xj4CI4OccUFrBuFQQ
         /AF1hBoayHp2w+FnWM8cDJ4iKcD2iBQOlP604/fvLLiNQCMY8KiR4pDFH9DdcJP7jM
         gY8ycJiIcOKylYZyQPfmTTCgyP45i8YqhTwsC+LE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adam Honse <calcprogrammer1@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 005/136] i2c: piix4: Detect secondary SMBus controller on AMD AM4 chipsets
Date:   Tue, 23 Jun 2020 21:57:41 +0200
Message-Id: <20200623195303.885163523@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195303.601828702@linuxfoundation.org>
References: <20200623195303.601828702@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 4b81dc231b18f..5345b731bb7cc 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -960,7 +960,8 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	}
 
 	if (dev->vendor == PCI_VENDOR_ID_AMD &&
-	    dev->device == PCI_DEVICE_ID_AMD_HUDSON2_SMBUS) {
+	    (dev->device == PCI_DEVICE_ID_AMD_HUDSON2_SMBUS ||
+	     dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS)) {
 		retval = piix4_setup_sb800(dev, id, 1);
 	}
 
-- 
2.25.1



