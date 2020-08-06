Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9CCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C18122065C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BdO/l8Jt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgHFAqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 20:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgHFAqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 20:46:46 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F895C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 17:46:46 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 9so7319404wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 17:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qz7MuNPVCvdbh+ZgEThp7mjF9Pplt5mjBACsV2Ifvtc=;
        b=BdO/l8JtsMVy+miLw7oFMn+vyW5gAsU9JqwymH1qszE3VshXA+j29bsos/yVHMssK6
         rNjKg6cKFebKsQRFYho6Sy1Rc0JaD1/aCZfunsloyShOiWvGmVRAEx2kF9Q52x7ZF8hQ
         2azaCRY7D1ictaxXwOl2vQbqQ2wBFJL2nIUKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qz7MuNPVCvdbh+ZgEThp7mjF9Pplt5mjBACsV2Ifvtc=;
        b=pc/v8Z2ZjcPOaNmlv4Oafr6GEUy3TSc6EFgf5dfvQvll06BNx/nCW0cp3zk/0Sv5WH
         NCQjMxQu515xNaeMIn8KjDPv1LTswrV89i9wcDoFImZ7prKiI5iffg3xzBRjOjGQBShN
         fK0TNBi0ZVh2VzGh710urXQhnuaC5isuQnaPsV50USrM/8N1lgpzuKafbKMif50mz1N0
         SEfShi09ORwQSYRmjNsytmzMS8Sk3n/C/Uozphm8o+Cb3Xxpfpsb0RSFIPXIkPckDR7M
         A+XsRe5xV8w4Hj3OuqyW6IBHxlYxEtJCQegHrCPkMCIa1AL3eGQm/7A2tzPiuAqT0qJQ
         joFw==
X-Gm-Message-State: AOAM530yhm1WRRNhzUBWg6zWgI4h0mZc0gfMWEhIEbOaG76yqbo7DWCh
        sFd7pGR6RgbG7kdDfIPjYs+zDg==
X-Google-Smtp-Source: ABdhPJxcPiCB4exZCrqIT83emZ+t4/VByn3DT4VociUqIwTpuaf3GhmfXS/X5Gc7oJuShwIxbHYVzg==
X-Received: by 2002:a1c:f204:: with SMTP id s4mr5746669wmc.9.1596674805113;
        Wed, 05 Aug 2020 17:46:45 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c17sm4665745wrc.42.2020.08.05.17.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 17:46:44 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v2 1/3] bcm-vk: add bcm_vk UAPI
Date:   Wed,  5 Aug 2020 17:46:29 -0700
Message-Id: <20200806004631.8102-2-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806004631.8102-1-scott.branden@broadcom.com>
References: <20200806004631.8102-1-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add user space api for bcm-vk driver.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 include/uapi/linux/misc/bcm_vk.h | 99 ++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 include/uapi/linux/misc/bcm_vk.h

diff --git a/include/uapi/linux/misc/bcm_vk.h b/include/uapi/linux/misc/bcm_vk.h
new file mode 100644
index 000000000000..783087b7c31f
--- /dev/null
+++ b/include/uapi/linux/misc/bcm_vk.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
+/*
+ * Copyright 2018-2020 Broadcom.
+ */
+
+#ifndef __UAPI_LINUX_MISC_BCM_VK_H
+#define __UAPI_LINUX_MISC_BCM_VK_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+#define BCM_VK_MAX_FILENAME 64
+
+struct vk_image {
+	__u32 type; /* Type of image */
+#define VK_IMAGE_TYPE_BOOT1 1 /* 1st stage (load to SRAM) */
+#define VK_IMAGE_TYPE_BOOT2 2 /* 2nd stage (load to DDR) */
+	char filename[BCM_VK_MAX_FILENAME]; /* Filename of image */
+};
+
+struct vk_reset {
+	__u32 arg1;
+	__u32 arg2;
+};
+
+#define VK_MAGIC		0x5e
+
+/* Load image to Valkyrie */
+#define VK_IOCTL_LOAD_IMAGE	_IOW(VK_MAGIC, 0x2, struct vk_image)
+
+/* Send Reset to Valkyrie */
+#define VK_IOCTL_RESET		_IOW(VK_MAGIC, 0x4, struct vk_reset)
+
+/*
+ * message block - basic unit in the message where a message's size is always
+ *		   N x sizeof(basic_block)
+ */
+struct vk_msg_blk {
+	__u8 function_id;
+#define VK_FID_TRANS_BUF	5
+#define VK_FID_SHUTDOWN		8
+	__u8 size;
+	__u16 trans_id; /* transport id, queue & msg_id */
+	__u32 context_id;
+	__u32 args[2];
+#define VK_CMD_PLANES_MASK	0x000f /* number of planes to up/download */
+#define VK_CMD_UPLOAD		0x0400 /* memory transfer to vk */
+#define VK_CMD_DOWNLOAD		0x0500 /* memory transfer from vk */
+#define VK_CMD_MASK		0x0f00 /* command mask */
+};
+
+#define VK_BAR_FWSTS			0x41c
+#define VK_BAR_COP_FWSTS		0x428
+/* VK_FWSTS definitions */
+#define VK_FWSTS_RELOCATION_ENTRY	BIT(0)
+#define VK_FWSTS_RELOCATION_EXIT	BIT(1)
+#define VK_FWSTS_INIT_START		BIT(2)
+#define VK_FWSTS_ARCH_INIT_DONE		BIT(3)
+#define VK_FWSTS_PRE_KNL1_INIT_DONE	BIT(4)
+#define VK_FWSTS_PRE_KNL2_INIT_DONE	BIT(5)
+#define VK_FWSTS_POST_KNL_INIT_DONE	BIT(6)
+#define VK_FWSTS_INIT_DONE		BIT(7)
+#define VK_FWSTS_APP_INIT_START		BIT(8)
+#define VK_FWSTS_APP_INIT_DONE		BIT(9)
+#define VK_FWSTS_MASK			0xffffffff
+#define VK_FWSTS_READY			(VK_FWSTS_INIT_START | \
+					 VK_FWSTS_ARCH_INIT_DONE | \
+					 VK_FWSTS_PRE_KNL1_INIT_DONE | \
+					 VK_FWSTS_PRE_KNL2_INIT_DONE | \
+					 VK_FWSTS_POST_KNL_INIT_DONE | \
+					 VK_FWSTS_INIT_DONE | \
+					 VK_FWSTS_APP_INIT_START | \
+					 VK_FWSTS_APP_INIT_DONE)
+/* Deinit */
+#define VK_FWSTS_APP_DEINIT_START	BIT(23)
+#define VK_FWSTS_APP_DEINIT_DONE	BIT(24)
+#define VK_FWSTS_DRV_DEINIT_START	BIT(25)
+#define VK_FWSTS_DRV_DEINIT_DONE	BIT(26)
+#define VK_FWSTS_RESET_DONE		BIT(27)
+#define VK_FWSTS_DEINIT_TRIGGERED	(VK_FWSTS_APP_DEINIT_START | \
+					 VK_FWSTS_APP_DEINIT_DONE  | \
+					 VK_FWSTS_DRV_DEINIT_START | \
+					 VK_FWSTS_DRV_DEINIT_DONE)
+/* Last nibble for reboot reason */
+#define VK_FWSTS_RESET_REASON_SHIFT	28
+#define VK_FWSTS_RESET_REASON_MASK	(0xf << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_SYS_PWRUP	(0x0 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_MBOX_DB		(0x1 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_M7_WDOG		(0x2 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_TEMP		(0x3 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_PCI_FLR		(0x4 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_PCI_HOT		(0x5 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_PCI_WARM		(0x6 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_PCI_COLD		(0x7 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_L1		(0x8 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_L0		(0x9 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_UNKNOWN		(0xf << VK_FWSTS_RESET_REASON_SHIFT)
+
+#endif /* __UAPI_LINUX_MISC_BCM_VK_H */
-- 
2.17.1

