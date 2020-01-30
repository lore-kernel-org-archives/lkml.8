Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E17C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3745020702
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580410343;
	bh=zuEUBKlZdyeN4POlgMWZuq1e8qLu6fLRLaFLDyY2sQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KVHk1Cr7Fw8hS6qx4cDReOHDRFMioNMXDDg3L5aoZtdGJXoRE+9RWbjNYbbJjnFJ3
	 28t5+1TQ9xixK8gPUlAqRLkdmsJG99+bY+JTlILqeTZc3yi//xqN8Txsz8dadAYMVC
	 De+/QmRB28S1Z+DrraGjG8DBoPE0SAhNkUjAo8L4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbgA3SwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:52:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:52444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728062AbgA3Snk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:43:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E153B20CC7;
        Thu, 30 Jan 2020 18:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409819;
        bh=zuEUBKlZdyeN4POlgMWZuq1e8qLu6fLRLaFLDyY2sQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zQro36d0HUNnN/x5tXLrbjEVCZgFsS1aT2ko3fDgRLwjqICJ/4UzKtE8REDAiOlCw
         QNbNc8aKKSX7gGNgBX2Km0awrd8S8GJeubEgC9OkFcFNzKQKLXlAiiArJa91ecPvIx
         WEJiXH3r9MJ4wQX5t6eYU3PWkG35hi90sooViItg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaron Ma <aaron.ma@canonical.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 044/110] HID: multitouch: Add LG MELF0410 I2C touchscreen support
Date:   Thu, 30 Jan 2020 19:38:20 +0100
Message-Id: <20200130183620.526273375@linuxfoundation.org>
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

From: Aaron Ma <aaron.ma@canonical.com>

[ Upstream commit 348b80b273fbf4ce2a307f9e38eadecf37828cad ]

Add multitouch support for LG MELF I2C touchscreen.
Apply the same workaround as LG USB touchscreen.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h        | 1 +
 drivers/hid/hid-multitouch.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 6273e7178e785..2888817261999 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -730,6 +730,7 @@
 #define USB_DEVICE_ID_LG_MULTITOUCH	0x0064
 #define USB_DEVICE_ID_LG_MELFAS_MT	0x6007
 #define I2C_DEVICE_ID_LG_8001		0x8001
+#define I2C_DEVICE_ID_LG_7010		0x7010
 
 #define USB_VENDOR_ID_LOGITECH		0x046d
 #define USB_DEVICE_ID_LOGITECH_AUDIOHUB 0x0a0e
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 3cfeb1629f79f..f0d4172d51319 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1985,6 +1985,9 @@ static const struct hid_device_id mt_devices[] = {
 	{ .driver_data = MT_CLS_LG,
 		HID_USB_DEVICE(USB_VENDOR_ID_LG,
 			USB_DEVICE_ID_LG_MELFAS_MT) },
+	{ .driver_data = MT_CLS_LG,
+		HID_DEVICE(BUS_I2C, HID_GROUP_GENERIC,
+			USB_VENDOR_ID_LG, I2C_DEVICE_ID_LG_7010) },
 
 	/* MosArt panels */
 	{ .driver_data = MT_CLS_CONFIDENCE_MINUS_ONE,
-- 
2.20.1



