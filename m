Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01507C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDB8205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580410246;
	bh=yi3SPWfrdUc2hmBaEB9c9QudFRVizN2qqqi3ustrzIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ms6AZ7gCw7+FtB2INR8h5gOphZ3GyDUVgsFBIaWEbm7sQiBgqaSB4HCr5vnmYuEqG
	 1RzxsKXpa1t0HHFcnkIUND8ROqmkskSx1Yxt/HAPx/W8jEi9BW3Wt2Amb/OzicfkIP
	 o9TDR3/CPVKqnNW+6ZoYHVDNhMlfy6/cj/XUt4Ls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731709AbgA3Suq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:50:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:56560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731195AbgA3Sqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:46:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75487205F4;
        Thu, 30 Jan 2020 18:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409990;
        bh=yi3SPWfrdUc2hmBaEB9c9QudFRVizN2qqqi3ustrzIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ABEW0aSmWe5nUFZHXvKpsxsaTyGHvR3w4iiFY5Os2Rtp9FboOLBZMitg2hJN1A4FX
         89KNRqQIeHVb1QILXTPXtjtnKe1dhnjzhUsOc87ouW6WsoWUis1u5s+SHbNHnCCIGk
         p7p473AeuaJdIYjjNYCYGSBWK31CY8dEUI+A77Wg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andre Heider <a.heider@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 098/110] Bluetooth: btbcm: Use the BDADDR_PROPERTY quirk
Date:   Thu, 30 Jan 2020 19:39:14 +0100
Message-Id: <20200130183625.427607453@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183613.810054545@linuxfoundation.org>
References: <20200130183613.810054545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andre Heider <a.heider@gmail.com>

[ Upstream commit a4f95f31a9f38d9bb1fd313fcc2d0c0d48116ee3 ]

Some devices ship with the controller default address, like the
Orange Pi 3 (BCM4345C5).

Allow the bootloader to set a valid address through the device tree.

Signed-off-by: Andre Heider <a.heider@gmail.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btbcm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 2d2e6d8620681..f02a4bdc0ca75 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -440,6 +440,12 @@ int btbcm_finalize(struct hci_dev *hdev)
 
 	set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 
+	/* Some devices ship with the controller default address.
+	 * Allow the bootloader to set a valid address through the
+	 * device tree.
+	 */
+	set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(btbcm_finalize);
-- 
2.20.1



