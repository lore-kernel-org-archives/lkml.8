Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C8FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6482C20849
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590521545;
	bh=L/FpKjXSou7uk/badrKTLDSFf91QARNH996AHbIbPls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yk+1piPn0FOR0PuVtBqWv75kLyylLtCHn/iDQf5qEc0iI310SH7wPT6HEj0mfynkN
	 iPfH4VTPvpK9tS07PMAYj2amedvj5frVIa01RXrRsfnNKJJyhzjab6rnqIXCjQjmIS
	 sPGsXC+JU80tqvOuehbAAtPt9Bi3QX+1Qiw2WBTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390125AbgEZTcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:32:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390135AbgEZS5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:57:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53E982084C;
        Tue, 26 May 2020 18:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519459;
        bh=L/FpKjXSou7uk/badrKTLDSFf91QARNH996AHbIbPls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lzvwkZUmgUckUPZpiymkB12L1ersIZUrqkCmkpz7z6LfKOIIZOAzW8tyhjQ7J58d3
         /rmYug4oXoY26Ikri9EHEMGM9Cm5fask66skBTxq6OkvbAyz4kS8BUn3nejGjcXBtx
         VR9Up0OfeW0duC9wADNoXjuL94t2YeF5XdHntzjY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 12/64] HID: multitouch: add eGalaxTouch P80H84 support
Date:   Tue, 26 May 2020 20:52:41 +0200
Message-Id: <20200526183917.835608080@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183913.064413230@linuxfoundation.org>
References: <20200526183913.064413230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Reichel <sebastian.reichel@collabora.com>

[ Upstream commit f9e82295eec141a0569649d400d249333d74aa91 ]

Add support for P80H84 touchscreen from eGalaxy:

  idVendor           0x0eef D-WAV Scientific Co., Ltd
  idProduct          0xc002
  iManufacturer           1 eGalax Inc.
  iProduct                2 eGalaxTouch P80H84 2019 vDIVA_1204_T01 k4.02.146

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h        | 1 +
 drivers/hid/hid-multitouch.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 25c006338100..4630b58634d8 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -353,6 +353,7 @@
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7349	0x7349
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_73F7	0x73f7
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_A001	0xa001
+#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_C002	0xc002
 
 #define USB_VENDOR_ID_ELAN		0x04f3
 
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index fba655d639af..1207102823de 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1332,6 +1332,9 @@ static const struct hid_device_id mt_devices[] = {
 	{ .driver_data = MT_CLS_EGALAX_SERIAL,
 		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_A001) },
+	{ .driver_data = MT_CLS_EGALAX,
+		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_C002) },
 
 	/* Elitegroup panel */
 	{ .driver_data = MT_CLS_SERIAL,
-- 
2.25.1



