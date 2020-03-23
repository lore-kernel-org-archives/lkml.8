Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9845AC10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 23:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6673420409
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 23:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cuzXzgMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbgCWXpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 19:45:21 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:40669 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbgCWXpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 19:45:20 -0400
Received: by mail-pg1-f201.google.com with SMTP id n16so12094021pgl.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 16:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0xG7SpHFsGGPYJqubi6X08/1oBrgthJjI40CuA+QSdM=;
        b=cuzXzgMYxlp2Hk8cl73XQ8CjeSrGWd6GdfReHHWmRMeKd6+1XygJZjnzoGFiXOGkuM
         teJ64eam15fP/Ri5ZHQb4vBWnN/XSpxsWi8Euql93wVPz1XwO1YOq4rFLX3ZqjxpIaw4
         RJhzPYz5kw0j5LDZwpU7AE+6zNF6g/Xyd737VaDQTIoFlfji2aEAAidkOEJuOSyHE86d
         Sv+bimEAuEpJCY3tEHzLwBCuc2228TrY4hT2BL+SUAVK/YbqcwHhQqZaf4ck7saog/oN
         qsKbOKgcSGT68pzK5YGV6GK0vOoy5csZEAO4QZ0RH2a9qR5K9JZZn7X5lqFYFT4oZFL6
         JvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0xG7SpHFsGGPYJqubi6X08/1oBrgthJjI40CuA+QSdM=;
        b=GphuOSAIkaDJhxtRoNpJ7ZLAeNPed8q5lwfCfUDJujTTAAXIPFgJpnleon68sUqAlT
         OPEXPr0134Z5qNH1bkTZ/2gDaTsxVxPVpg6pRi3mPg7A0q+Qlzbvrxfypo+10JZjkZ4z
         Zl7Lavm35xczwodevHt0cgmJ1UfvxcYW0c/c6Y0J5wHMXAVHY/3Pel4mxUwwUZ3qJah0
         QXyN9kNt4K6DqmXZLhqn9skerkqvLWJaIQUOYRT1BiLj3QAgLTCsExpnaTAIvEV+kBu7
         /fhbdpLhIPr/zPIcPZVpjUaB+07CTjaLarD1L29YL1QmWgk8M0obOhi138HSej1DQAsM
         I4hQ==
X-Gm-Message-State: ANhLgQ2EFYNsAOu0FqT0Cuv0y+tuEqGTOqyi9gWkN7lcAwmDWqJkL/Mw
        x/KMDMj/D3Y+wa0r0H+MmFxmARF2ku+o
X-Google-Smtp-Source: ADFU+vsR1uNwvPvRd9XsNS5rlpId8dNHQrxMfshA+HKQap35OolVUlrZmVmFMNvK998A+U3rthE/KBeeDFR6
X-Received: by 2002:a17:90b:230d:: with SMTP id mt13mr1997940pjb.164.1585007118195;
 Mon, 23 Mar 2020 16:45:18 -0700 (PDT)
Date:   Mon, 23 Mar 2020 16:45:04 -0700
In-Reply-To: <20200323234505.226919-1-rajatja@google.com>
Message-Id: <20200323234505.226919-4-rajatja@google.com>
Mime-Version: 1.0
References: <20200323234505.226919-1-rajatja@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH RESEND 4/5] Input: atkbd: Receive and use physcode->keycode
 mapping from FW
From:   Rajat Jain <rajatja@google.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@google.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajat Jain <rajatja@google.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, furquan@google.com,
        dlaurie@google.com, bleung@google.com, zentaro@google.com,
        dbehr@google.com
Cc:     rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the firmware to specify the mapping between the physical
code and the linux keycode. This takes the form of a "keymap"
property which is an array of u32 values, each value specifying
mapping for a key.

Signed-off-by: Rajat Jain <rajatja@google.com>

Change-Id: I18fd5eac746c0b75a23e8f4ee9b7595ce9eca707
---
 drivers/input/keyboard/atkbd.c | 39 ++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 7623eebef2593..c8017a5707581 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -66,6 +66,9 @@ MODULE_PARM_DESC(terminal, "Enable break codes on an IBM Terminal keyboard conne
 
 #define MAX_FUNCTION_ROW_KEYS	24
 
+#define PHYSCODE(keymap)	((keymap >> 16) & 0xFFFF)
+#define KEYCODE(keymap)		(keymap & 0xFFFF)
+
 /*
  * Scancode to keycode tables. These are just the default setting, and
  * are loadable via a userland utility.
@@ -236,6 +239,9 @@ struct atkbd {
 
 	u16 function_row_physmap[MAX_FUNCTION_ROW_KEYS];
 	int num_function_row_keys;
+
+	unsigned short fw_keymap[ATKBD_KEYMAP_SIZE];
+	bool use_fw_keymap;
 };
 
 /*
@@ -1045,7 +1051,10 @@ static void atkbd_set_keycode_table(struct atkbd *atkbd)
 	memset(atkbd->keycode, 0, sizeof(atkbd->keycode));
 	bitmap_zero(atkbd->force_release_mask, ATKBD_KEYMAP_SIZE);
 
-	if (atkbd->translated) {
+	if (atkbd->use_fw_keymap) {
+		memcpy(atkbd->keycode, atkbd->fw_keymap,
+		       sizeof(atkbd->keycode));
+	} else if (atkbd->translated) {
 		for (i = 0; i < 128; i++) {
 			scancode = atkbd_unxlate_table[i];
 			atkbd->keycode[i] = atkbd_set2_keycode[scancode];
@@ -1163,7 +1172,9 @@ static void atkbd_parse_fwnode_data(struct serio *serio)
 {
 	struct atkbd *atkbd = serio_get_drvdata(serio);
 	struct device *dev = &serio->dev;
-	int n;
+	int i, n;
+	u32 *ptr;
+	u16 physcode, keycode;
 
 	if (!dev_fwnode(dev))
 		return;
@@ -1176,6 +1187,30 @@ static void atkbd_parse_fwnode_data(struct serio *serio)
 		atkbd->num_function_row_keys = n;
 		dev_info(dev, "FW reported %d function-row key locations\n", n);
 	}
+
+	/* Parse "keymap" property */
+	n = device_property_count_u32(dev, "keymap");
+	if (n > 0 && n <= ATKBD_KEYMAP_SIZE) {
+
+		ptr = kcalloc(n, sizeof(u32), GFP_KERNEL);
+		if (!ptr)
+			return;
+
+		if (device_property_read_u32_array(dev, "keymap", ptr, n)) {
+			dev_err(dev, "problem parsing FW keymap property\n");
+			kfree(ptr);
+			return;
+		}
+
+		for (i = 0; i < n; i++) {
+			physcode = PHYSCODE(ptr[i]);
+			keycode = KEYCODE(ptr[i]);
+			atkbd->fw_keymap[physcode] = keycode;
+		}
+		dev_info(dev, "Using FW keymap (%d keys)\n", n);
+		atkbd->use_fw_keymap = true;
+		kfree(ptr);
+	}
 }
 
 /*
-- 
2.25.1.696.g5e7596f4ac-goog

