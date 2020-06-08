Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9CAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C97E2068D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658733;
	bh=DbPi6ubGFiDaGJ0+RYNkMqNi08+FYLBtOLdfRIUJRlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mUePIGSL3QduQrzhOE3Iw4DcLvjxuXHgG0nm+idKI0zAsfMfidfFFPwItyRRgPLrX
	 6YnaEZKVczWsMyv80y1ZXPH25VeeZka4zENmprKanHNpGReD5HzunZRIkftInzcETv
	 GLsx1+claEAzrgExYojnY5oAtlUf20as5np3HElg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731816AbgFHXZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:25:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:44322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729227AbgFHXUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:20:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A090B2074B;
        Mon,  8 Jun 2020 23:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658434;
        bh=DbPi6ubGFiDaGJ0+RYNkMqNi08+FYLBtOLdfRIUJRlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TzTpV7RIf8nI3+hpjKzVRdA85y0gZyxufQvjpnu+mA8PuJLGs3d7yhvF5ryyqJN3j
         kzCNxiuTIUghsfrYh+V7B/joAQWuZz8Voc023U8b3fAV1pMYxGi48fbwHAOOZq9yXJ
         /15gMTUT9d2rNSSJXH0JcqPRC+yapNBp9CJxoHa8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 078/175] Bluetooth: btbcm: Add 2 missing models to subver tables
Date:   Mon,  8 Jun 2020 19:17:11 -0400
Message-Id: <20200608231848.3366970-78-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231848.3366970-1-sashal@kernel.org>
References: <20200608231848.3366970-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit c03ee9af4e07112bd3fc688daca9e654f41eca93 ]

Currently the bcm_uart_subver_ and bcm_usb_subver_table-s lack entries
for the BCM4324B5 and BCM20703A1 chipsets. This makes the code use just
"BCM" as prefix for the filename to pass to request-firmware, making it
harder for users to figure out which firmware they need. This especially
is problematic with the UART attached BCM4324B5 where this leads to the
filename being just "BCM.hcd".

Add the 2 missing devices to subver tables. This has been tested on:

1. A Dell XPS15 9550 where this makes btbcm.c try to load
"BCM20703A1-0a5c-6410.hcd" before it tries to load "BCM-0a5c-6410.hcd".

2. A Thinkpad 8 where this makes btbcm.c try to load
"BCM4324B5.hcd" before it tries to load "BCM.hcd"

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btbcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index f02a4bdc0ca7..dd29d687cd38 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -329,6 +329,7 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ 0x410e, "BCM43341B0"	},	/* 002.001.014 */
 	{ 0x4204, "BCM2076B1"	},	/* 002.002.004 */
 	{ 0x4406, "BCM4324B3"	},	/* 002.004.006 */
+	{ 0x4606, "BCM4324B5"	},	/* 002.006.006 */
 	{ 0x6109, "BCM4335C0"	},	/* 003.001.009 */
 	{ 0x610c, "BCM4354"	},	/* 003.001.012 */
 	{ 0x2122, "BCM4343A0"	},	/* 001.001.034 */
@@ -343,6 +344,7 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
 };
 
 static const struct bcm_subver_table bcm_usb_subver_table[] = {
+	{ 0x2105, "BCM20703A1"	},	/* 001.001.005 */
 	{ 0x210b, "BCM43142A0"	},	/* 001.001.011 */
 	{ 0x2112, "BCM4314A0"	},	/* 001.001.018 */
 	{ 0x2118, "BCM20702A0"	},	/* 001.001.024 */
-- 
2.25.1

