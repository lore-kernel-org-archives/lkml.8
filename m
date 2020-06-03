Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A99C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 23:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FFC52220D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 23:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ElHgxlfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgFCXDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 19:03:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38654 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgFCXDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 19:03:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id u5so2641185pgn.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 16:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ez/bvlepDduVIxHglwNwBFWJmOXjR008iaFnpJzBvrU=;
        b=ElHgxlfyjmI7NpucOINNAzsvZ5SNoxnKGKnesGMsgq+IQV/BDLWGnfmdpJzmimiXXu
         ZvbjRqNFBCupDLSbotVaavThprfaI9hOeZQFEefs91YYMupST4hZ86HLrYoqd/Wi7Brt
         HKq8EBzLAbHemO26c3THGoxqcIuMiXxhsmFMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ez/bvlepDduVIxHglwNwBFWJmOXjR008iaFnpJzBvrU=;
        b=s8pygwymz0JM25aEnnWEMK4I/8K5pmVx6gNYRSvnOz95nHb3KZxpk1nCewr/3x+45b
         Phgak2sIb5cm1/aN2EVaARyE+6+wazrYk+SKrNSkzYJ4+AkAdqBhtV2uN4TnyNDJD4rs
         5yMZeZ599SyzIenngc2zl34T5gvHKLrV4X0wid1WRTHPLuf/iQrngque4TXlY8yMPXSP
         XjTGeaGFAP52UeaaRZo3/NjX+CGNJdEbkoQ5Oj1yHFN5O2ZXk/B5BLAhVH8LO+xcBuZX
         cR1fmB0AWtqJgcvQ4H5zeM45c9lyLbwxr4nku0zf0+wngI+vYQAAqshDqVDQoJSxIWDy
         Ti6g==
X-Gm-Message-State: AOAM5304zVUwPfsXvhQvwS7wQqMDyHONRkFVwiLB4jK6bx7wHD3kILYi
        0vxzcbOKmbOQWA4kj/xJFBGyig==
X-Google-Smtp-Source: ABdhPJzXfRYYgZFvZFZg1PG4JNnOp9p91vozXqd+fMmZBzV1SkYLmbUgwhnlA3AHb8tArt7NlPxYOg==
X-Received: by 2002:a65:5206:: with SMTP id o6mr1568522pgp.16.1591225332425;
        Wed, 03 Jun 2020 16:02:12 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id b11sm2715999pfd.178.2020.06.03.16.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jun 2020 16:02:11 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Manish Mandlik <mmandlik@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 1/7] Bluetooth: Add definitions for advertisement monitor features
Date:   Wed,  3 Jun 2020 16:01:44 -0700
Message-Id: <20200603160058.v2.1.I636f906bf8122855dfd2ba636352bbdcb50c35ed@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for Advertisement Monitor API. Here are the commands
and events added.
- Read Advertisement Monitor Feature command
- Add Advertisement Pattern Monitor command
- Remove Advertisement Monitor command
- Advertisement Monitor Added event
- Advertisement Monitor Removed event

Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
---

Changes in v2: None

 include/net/bluetooth/mgmt.h | 49 ++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 16e0d87bd8fae..df36c50d15f53 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -702,6 +702,45 @@ struct mgmt_rp_set_exp_feature {
 	__le32 flags;
 } __packed;
 
+#define MGMT_ADV_MONITOR_FEATURE_MASK_OR_PATTERNS    BIT(0)
+
+#define MGMT_OP_READ_ADV_MONITOR_FEATURES	0x004B
+#define MGMT_READ_ADV_MONITOR_FEATURES_SIZE	0
+struct mgmt_rp_read_adv_monitor_features {
+	__u32 supported_features;
+	__u32 enabled_features;
+	__u16 max_num_handles;
+	__u8 max_num_patterns;
+	__u16 num_handles;
+	__u16 handles[];
+}  __packed;
+
+struct mgmt_adv_pattern {
+	__u8 ad_type;
+	__u8 offset;
+	__u8 length;
+	__u8 value[31];
+} __packed;
+
+#define MGMT_OP_ADD_ADV_PATTERNS_MONITOR	0x004C
+struct mgmt_cp_add_adv_patterns_monitor {
+	__u8 pattern_count;
+	struct mgmt_adv_pattern patterns[];
+} __packed;
+#define MGMT_ADD_ADV_PATTERNS_MONITOR_SIZE	1
+struct mgmt_rp_add_adv_patterns_monitor {
+	__u16 monitor_handle;
+} __packed;
+
+#define MGMT_OP_REMOVE_ADV_MONITOR		0x004D
+struct mgmt_cp_remove_adv_monitor {
+	__u16 monitor_handle;
+} __packed;
+#define MGMT_REMOVE_ADV_MONITOR_SIZE		2
+struct mgmt_rp_remove_adv_monitor {
+	__u16 monitor_handle;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
@@ -933,3 +972,13 @@ struct mgmt_ev_exp_feature_changed {
 	__u8	uuid[16];
 	__le32	flags;
 } __packed;
+
+#define MGMT_EV_ADV_MONITOR_ADDED	0x0028
+struct mgmt_ev_adv_monitor_added {
+	__u16 monitor_handle;
+}  __packed;
+
+#define MGMT_EV_ADV_MONITOR_REMOVED	0x0029
+struct mgmt_ev_adv_monitor_removed {
+	__u16 monitor_handle;
+}  __packed;
-- 
2.26.2

