Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587E6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 329DE208A7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519819;
	bh=Pkh5lO2dAeyUZEdb0y4kAXD15PuXodtycXuzHRkW8eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wv/0pn8eqKpzW23MFe9upO/4V7ETMkLz2bujm0TIT98Pj1NfS4fkLF8Swy8kv66+r
	 SoIqkxvqhaB0uBzrwObwPgLZt0hStiBVptG606j1b3YITA5laNsUS5+Wi9NK5peN4y
	 iIwmJ5jEpRuTolew2lhvYyUN3H3t057Rc/QR+TZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391235AbgEZTDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:03:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403847AbgEZTDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:03:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C55BD208A7;
        Tue, 26 May 2020 19:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519810;
        bh=Pkh5lO2dAeyUZEdb0y4kAXD15PuXodtycXuzHRkW8eo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vpsUXmEXGrC8bZeV4akgnBoTiEoqHiJ0ofd9wDmJfq5G3+4+Lq54j9BYcOLDnzpux
         CXuaxtAwzl0JVsgr8NoEbQOcy/nAtNrCIcTbc97zttL68iM7oz0G97Zpe2bthe8sX+
         3dYstVP9CISSbPxiHzxwcprcCF7AZ4IB8dn/9MDI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Daniel Playfair Cal <daniel.playfair.cal@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 26/81] HID: i2c-hid: reset Synaptics SYNA2393 on resume
Date:   Tue, 26 May 2020 20:53:01 +0200
Message-Id: <20200526183930.368166265@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183923.108515292@linuxfoundation.org>
References: <20200526183923.108515292@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Playfair Cal <daniel.playfair.cal@gmail.com>

[ Upstream commit 538f67407e2c0e5ed2a46e7d7ffa52f2e30c7ef8 ]

On the Dell XPS 9570, the Synaptics SYNA2393 touchpad generates spurious
interrupts after resuming from suspend until it receives some input or
is reset. Add it to the quirk I2C_HID_QUIRK_RESET_ON_RESUME so that it
is reset when resuming from suspend.

More information about the bug can be found in this mailing list
discussion: https://www.spinics.net/lists/linux-input/msg59530.html

Signed-off-by: Daniel Playfair Cal <daniel.playfair.cal@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h              | 3 +++
 drivers/hid/i2c-hid/i2c-hid-core.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 2a9cec9764cf..e071fd3c6b2b 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1064,6 +1064,9 @@
 #define USB_DEVICE_ID_SYMBOL_SCANNER_2	0x1300
 #define USB_DEVICE_ID_SYMBOL_SCANNER_3	0x1200
 
+#define I2C_VENDOR_ID_SYNAPTICS     0x06cb
+#define I2C_PRODUCT_ID_SYNAPTICS_SYNA2393   0x7a13
+
 #define USB_VENDOR_ID_SYNAPTICS		0x06cb
 #define USB_DEVICE_ID_SYNAPTICS_TP	0x0001
 #define USB_DEVICE_ID_SYNAPTICS_INT_TP	0x0002
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index f2c8c59fc582..f17ebbe53abf 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -187,6 +187,8 @@ static const struct i2c_hid_quirks {
 		 I2C_HID_QUIRK_BOGUS_IRQ },
 	{ USB_VENDOR_ID_ALPS_JP, HID_ANY_ID,
 		 I2C_HID_QUIRK_RESET_ON_RESUME },
+	{ I2C_VENDOR_ID_SYNAPTICS, I2C_PRODUCT_ID_SYNAPTICS_SYNA2393,
+		 I2C_HID_QUIRK_RESET_ON_RESUME },
 	{ USB_VENDOR_ID_ITE, I2C_DEVICE_ID_ITE_LENOVO_LEGION_Y720,
 		I2C_HID_QUIRK_BAD_INPUT_SIZE },
 	{ 0, 0 }
-- 
2.25.1



