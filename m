Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C872C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5EE2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583204208;
	bh=ZV8dvxl6uwGEoAc1BLIA9d9BiR8PgAVgeU9wYp/7O1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lV9pNz0U9mO2eniTJAGu/0R4mPf08Dz8xZhkqWxS/U5lwoNIsy7yEncAfVJjNnVwQ
	 kImWShK7vuFUOxR6nl+JsHBMJTEDVrvkWq1PhkUxTFDl5gaAw8fOlxQGA7vJvi2gFD
	 o8D2c/+U+3pyw4FdhCo7xmyU5ag8Uu2j8upfHVZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgCCC4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:56:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:44456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728465AbgCCCsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:48:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D82E246D6;
        Tue,  3 Mar 2020 02:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203715;
        bh=ZV8dvxl6uwGEoAc1BLIA9d9BiR8PgAVgeU9wYp/7O1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N55szuSo127wabnrXvH+MlG2WfymfNOicZVxz4khqHR4t2ozN8285xIlU8Yz9bT+x
         QUftFzViS+LzfZ6p+dMtEhgsXTrbmltbUEzD9VJskrZut+b+Pkks/uYyOQVsVW/AOb
         ujOxsGQIvYJ6XFLyt5ry015TLq3JDtlBhPxQyXjo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 45/58] nfc: pn544: Fix occasional HW initialization failure
Date:   Mon,  2 Mar 2020 21:47:27 -0500
Message-Id: <20200303024740.9511-45-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303024740.9511-1-sashal@kernel.org>
References: <20200303024740.9511-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

[ Upstream commit c3331d2fe3fd4d5e321f2467d01f72de7edfb5d0 ]

The PN544 driver checks the "enable" polarity during of driver's probe and
it's doing that by turning ON and OFF NFC with different polarities until
enabling succeeds. It takes some time for the hardware to power-down, and
thus, to deassert the IRQ that is raised by turning ON the hardware.
Since the delay after last power-down of the polarity-checking process is
missed in the code, the interrupt may trigger immediately after installing
the IRQ handler (right after the checking is done), which results in IRQ
handler trying to touch the disabled HW and ends with marking NFC as
'DEAD' during of the driver's probe:

  pn544_hci_i2c 1-002a: NFC: nfc_en polarity : active high
  pn544_hci_i2c 1-002a: NFC: invalid len byte
  shdlc: llc_shdlc_recv_frame: NULL Frame -> link is dead

This patch fixes the occasional NFC initialization failure on Nexus 7
device.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nfc/pn544/i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nfc/pn544/i2c.c b/drivers/nfc/pn544/i2c.c
index 720c89d6066ef..4ac8cb262559c 100644
--- a/drivers/nfc/pn544/i2c.c
+++ b/drivers/nfc/pn544/i2c.c
@@ -225,6 +225,7 @@ static void pn544_hci_i2c_platform_init(struct pn544_i2c_phy *phy)
 
 out:
 	gpiod_set_value_cansleep(phy->gpiod_en, !phy->en_polarity);
+	usleep_range(10000, 15000);
 }
 
 static void pn544_hci_i2c_enable_mode(struct pn544_i2c_phy *phy, int run_mode)
-- 
2.20.1

