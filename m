Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE42C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 06:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 954D6207F7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 06:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gpBgbODu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgFLGPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 02:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgFLGPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 02:15:38 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17857C03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 23:15:38 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x22so3828907pfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 23:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AB6duoIorpNCuupP87XfqjRTKWNVpLNxq+yXW/n6Z7s=;
        b=gpBgbODuixln3S1jDP6abQvyKLI/PNpkBSKoN2AgwCvndHoniL6VDKCyO1MKkkEFBE
         tFRwQ+gKs95AYAjHWTuLYUJ3xBytaXBMLimo438uuHoTpvWKyakpNL4Kxr8zUvaROv9D
         TFoslVHnfqywBQoZr17eoEafe77jC08NEonuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AB6duoIorpNCuupP87XfqjRTKWNVpLNxq+yXW/n6Z7s=;
        b=hPfbINLTRyxBTWXXe7a8DhKBMcVgM/07LMaFF/piwrrF0vV4J6Y7JMK+IT7GZUBfmz
         E8YLLU6UXWitmJXfMzPPlFVYvi8KSE2tKbpQEdBYlMbhHlRlNibxOrd4iniRsSWrjzDO
         J/As3PZJc1xbQMwL5wCZU9HVIBYiiBLNasEp2oSs7PvM0mdv9QxoJ2LYJHp/33K/xr2l
         UI47hbEcANmpI5CIqGLEEQp3gkQTO0vGizpbPI60PYEvwYXnPnGrxolebfdCmyKho9BN
         tCnEdk9alDjvLPuPyVPMatAzkSentXrM+YRa8LkkvirKEYvK0xO4YrRMAKCkW+r7OUUZ
         /FNg==
X-Gm-Message-State: AOAM531TPzOgDsWkFbB0VuZzhOSCKfDrooCC6YntVJyR2euCKJ+ph546
        w+ysOwAQ+eYPU9UQpOR+4wlB7g==
X-Google-Smtp-Source: ABdhPJw3S6TChS4fEvtU9Ix6AjF5HrB5854+ldse1OFpfsj5MELs7glmtIqs/OHeai9xlJlxXkqS9w==
X-Received: by 2002:a65:67d0:: with SMTP id b16mr9335827pgs.91.1591942537580;
        Thu, 11 Jun 2020 23:15:37 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id g6sm4933923pfb.164.2020.06.11.23.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jun 2020 23:15:36 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Yoni Shavit <yshavit@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v3 1/7] Bluetooth: Add definitions for advertisement monitor features
Date:   Thu, 11 Jun 2020 23:15:23 -0700
Message-Id: <20200611231459.v3.1.I636f906bf8122855dfd2ba636352bbdcb50c35ed@changeid>
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

Changes in v3:
- Update command/event opcodes.
- Correct data types.

Changes in v2: None

 include/net/bluetooth/mgmt.h | 49 ++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 16e0d87bd8fae..fcc5d0349f549 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -702,6 +702,45 @@ struct mgmt_rp_set_exp_feature {
 	__le32 flags;
 } __packed;
 
+#define MGMT_ADV_MONITOR_FEATURE_MASK_OR_PATTERNS    BIT(0)
+
+#define MGMT_OP_READ_ADV_MONITOR_FEATURES	0x0051
+#define MGMT_READ_ADV_MONITOR_FEATURES_SIZE	0
+struct mgmt_rp_read_adv_monitor_features {
+	__le32 supported_features;
+	__le32 enabled_features;
+	__le16 max_num_handles;
+	__u8 max_num_patterns;
+	__le16 num_handles;
+	__le16 handles[];
+}  __packed;
+
+struct mgmt_adv_pattern {
+	__u8 ad_type;
+	__u8 offset;
+	__u8 length;
+	__u8 value[31];
+} __packed;
+
+#define MGMT_OP_ADD_ADV_PATTERNS_MONITOR	0x0052
+struct mgmt_cp_add_adv_patterns_monitor {
+	__u8 pattern_count;
+	struct mgmt_adv_pattern patterns[];
+} __packed;
+#define MGMT_ADD_ADV_PATTERNS_MONITOR_SIZE	1
+struct mgmt_rp_add_adv_patterns_monitor {
+	__le16 monitor_handle;
+} __packed;
+
+#define MGMT_OP_REMOVE_ADV_MONITOR		0x0053
+struct mgmt_cp_remove_adv_monitor {
+	__le16 monitor_handle;
+} __packed;
+#define MGMT_REMOVE_ADV_MONITOR_SIZE		2
+struct mgmt_rp_remove_adv_monitor {
+	__le16 monitor_handle;
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
+#define MGMT_EV_ADV_MONITOR_ADDED	0x002b
+struct mgmt_ev_adv_monitor_added {
+	__le16 monitor_handle;
+}  __packed;
+
+#define MGMT_EV_ADV_MONITOR_REMOVED	0x002c
+struct mgmt_ev_adv_monitor_removed {
+	__le16 monitor_handle;
+}  __packed;
-- 
2.26.2

