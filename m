Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2139EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00C812075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gtAb7riy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgHYToQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgHYToN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 15:44:13 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F26C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 12:44:13 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ds1so28963pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 12:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EremuVG/LBCnMT6uJbuIYxEFyRv7sNgbJVFCa0Jy/iU=;
        b=gtAb7riyhjDR1YRETfbLKfjI90hlR76CMiQzSaixZFaTR6/FE7tI5Vla+qchsHBaI1
         JKK4wcSXWCA5NJfMto66UQfgEwfRopHa55PngsY8zEQBKxikmAPAPyxh8H+AjQIZ+sai
         BDko1xyWCZyyuqpvBi3B5P0AyfBxmZdFFfSg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EremuVG/LBCnMT6uJbuIYxEFyRv7sNgbJVFCa0Jy/iU=;
        b=BwFLWddmeIuPQY2lookZoTadEWyNgV9OycpS5I3e2PZo75VLuwc9VgUpvomrgtWdF5
         Q2T7v/E55A8i9Jf0SAAwBI8uZrj6vkGXWV6/207jbrYPTPd3I24GjAdexPYMGDoEvl8q
         koukW8rKu2k67IzzXFS4Djy7VvTeiEXcASE4LF2ES+bZeLXjLfbXLXWI+afnu1iM5as6
         BQUmyn1AohRy/A438fsZagpbrmwyNgsfKdtnIoqyv8cpXX/D9R7iPH3UsTDkTlT67uXT
         fO78SbcauMkzNlQBhgTsxZxAmOMSzAigREkh1ZMKSO2BO+C6b8VZcqMzJuMd6ibRH3ei
         +WdQ==
X-Gm-Message-State: AOAM530dxxtd5edUDgRPQUq4TYuBBq0Yngx7jIAQLx3m6S9SN9YMDXwu
        Zss8L7DcQhl+cla5uvXkcWZ9eA==
X-Google-Smtp-Source: ABdhPJxBxRET033WhoxkFQWBZNbXWE1140EpPDLrx8E50hUfn5dJis0yjvNJE4OPAS2428CgFdAr3A==
X-Received: by 2002:a17:90a:9483:: with SMTP id s3mr2879863pjo.98.1598384653056;
        Tue, 25 Aug 2020 12:44:13 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id x5sm45297pfj.1.2020.08.25.12.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 12:44:12 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v3 1/3] bcm-vk: add bcm_vk UAPI
Date:   Tue, 25 Aug 2020 12:43:58 -0700
Message-Id: <20200825194400.28960-2-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200825194400.28960-1-scott.branden@broadcom.com>
References: <20200825194400.28960-1-scott.branden@broadcom.com>
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
index 000000000000..da7848e7c438
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
+#define VK_FWSTS_RELOCATION_ENTRY	(1ULL << 0)
+#define VK_FWSTS_RELOCATION_EXIT	(1ULL << 1)
+#define VK_FWSTS_INIT_START		(1ULL << 2)
+#define VK_FWSTS_ARCH_INIT_DONE		(1ULL << 3)
+#define VK_FWSTS_PRE_KNL1_INIT_DONE	(1ULL << 4)
+#define VK_FWSTS_PRE_KNL2_INIT_DONE	(1ULL << 5)
+#define VK_FWSTS_POST_KNL_INIT_DONE	(1ULL << 6)
+#define VK_FWSTS_INIT_DONE		(1ULL << 7)
+#define VK_FWSTS_APP_INIT_START		(1ULL << 8)
+#define VK_FWSTS_APP_INIT_DONE		(1ULL << 9)
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
+#define VK_FWSTS_APP_DEINIT_START	(1ULL << 23)
+#define VK_FWSTS_APP_DEINIT_DONE	(1ULL << 24)
+#define VK_FWSTS_DRV_DEINIT_START	(1ULL << 25)
+#define VK_FWSTS_DRV_DEINIT_DONE	(1ULL << 26)
+#define VK_FWSTS_RESET_DONE		(1ULL << 27)
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

