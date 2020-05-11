Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C48C54E4A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 23:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE12C2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 23:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TA638fRT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgEKXdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 19:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728111AbgEKXch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 19:32:37 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0C7C05BD0A
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 16:32:37 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d184so5466713pfd.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 16:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=up5YLynN/0wgy5FnxIIi/GoPnmSYw4UconoozjrfHTM=;
        b=TA638fRTRspNQHa6ZRPlPqnJ7kHnQX8LkUTZ6e+sNVAwzBtYrrXpbl19Y4WD38udvW
         ZvZpfmGRyuj77IMbwJQ4fpjI6fcDmGKhhDeBUFmdtDeQpcmEXNSHhaQQl87/w85J/UnN
         vFFRnSGPxnDdtl4aXi1QiFFilhD7kEhPb0KVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=up5YLynN/0wgy5FnxIIi/GoPnmSYw4UconoozjrfHTM=;
        b=dXgjkH+JLqvX/ETrCug16ch+ceYReeCTgErz66SKW5KRchypYkFR8yjAJiyTWVezB7
         UeBr988e/qWTKlW4g6yNEJLj8O9y5aRI5cQAX0Qrnhrw3i8ax9wFwsITQRKhHoqTqUF0
         xrbTqVv8P51euHhnEfelIpye61bh4xIDruXkTtCLI8sqWzp7rvCLCFyH81UBSmMJWJwQ
         JCaHa+wgkJCTnmpGqGwLLlqDNl1YS9XBQ+/mNBw64ocQGA0p53RmiwwQrWHC59hvN9wx
         GJ1APwtmSMbzxTO0VZR0SPV6xaZ4sQbFWQvpofdp/BVWbofxKyRxIkx5nPGKy6M+eXd4
         vi0g==
X-Gm-Message-State: AGi0PuZiQvRWQ7fqlu82Xf+BLTBfAs8WAoLXv6V2FNoQ7lU2ipbgcdNy
        zadP9+HeEAp5PO4DSDhlXWJjxg==
X-Google-Smtp-Source: APiQypJkb6jHb758mGKvTWOFgTGdpxWAvBuyyJ6rv4NbyvJBoOkYAuP18aIVkbSPEH/AsGoH+x2YGQ==
X-Received: by 2002:a63:211d:: with SMTP id h29mr16662828pgh.231.1589239957178;
        Mon, 11 May 2020 16:32:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w1sm8895930pgh.53.2020.05.11.16.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 16:32:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH v8 08/11] pstore/blk: Provide way to query pstore configuration
Date:   Mon, 11 May 2020 16:32:26 -0700
Message-Id: <20200511233229.27745-9-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511233229.27745-1-keescook@chromium.org>
References: <20200511233229.27745-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WeiXiong Liao <liaoweixiong@allwinnertech.com>

In order to configure itself, the MTD backend needs to be able to query
the current pstore configuration. Introduce pstore_blk_get_config() for
this purpose.

Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
Link: https://lore.kernel.org/r/1585126506-18635-10-git-send-email-liaoweixiong@allwinnertech.com
Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/blk.c            | 37 ++++++++++++++++++++++++++++++-------
 include/linux/pstore_blk.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index 8c78eb9906fb..95436cff8976 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -94,6 +94,17 @@ struct bdev_info {
 	sector_t start_sect;
 };
 
+#define check_size(name, alignsize) ({				\
+	long _##name_ = (name);					\
+	_##name_ = _##name_ <= 0 ? 0 : (_##name_ * 1024);	\
+	if (_##name_ & ((alignsize) - 1)) {			\
+		pr_info(#name " must align to %d\n",		\
+				(alignsize));			\
+		_##name_ = ALIGN(name, (alignsize));		\
+	}							\
+	_##name_;						\
+})
+
 /**
  * struct pstore_device_info - back-end pstore/blk driver structure.
  *
@@ -149,13 +160,11 @@ static int psblk_register_do(struct pstore_device_info *dev)
 		dev->flags = UINT_MAX;
 
 #define verify_size(name, alignsize, enabled) {				\
-		long _##name_ = (enabled) ? (name) : 0;			\
-		_##name_ = _##name_ <= 0 ? 0 : (_##name_ * 1024);	\
-		if (_##name_ & ((alignsize) - 1)) {			\
-			pr_info(#name " must align to %d\n",		\
-					(alignsize));			\
-			_##name_ = ALIGN(name, (alignsize));		\
-		}							\
+		long _##name_;						\
+		if (enabled)						\
+			_##name_ = check_size(name, alignsize);		\
+		else							\
+			_##name_ = 0;					\
 		name = _##name_ / 1024;					\
 		pstore_zone_info->name = _##name_;			\
 	}
@@ -456,6 +465,20 @@ void unregister_pstore_blk(unsigned int major)
 }
 EXPORT_SYMBOL_GPL(unregister_pstore_blk);
 
+/* get information of pstore/blk */
+int pstore_blk_get_config(struct pstore_blk_config *info)
+{
+	strncpy(info->device, blkdev, 80);
+	info->max_reason = max_reason;
+	info->kmsg_size = check_size(kmsg_size, 4096);
+	info->pmsg_size = check_size(pmsg_size, 4096);
+	info->ftrace_size = check_size(ftrace_size, 4096);
+	info->console_size = check_size(console_size, 4096);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pstore_blk_get_config);
+
 static void __exit pstore_blk_exit(void)
 {
 	mutex_lock(&pstore_blk_lock);
diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
index ccba8c068752..0c40774e71e0 100644
--- a/include/linux/pstore_blk.h
+++ b/include/linux/pstore_blk.h
@@ -49,4 +49,32 @@ struct pstore_blk_info {
 int  register_pstore_blk(struct pstore_blk_info *info);
 void unregister_pstore_blk(unsigned int major);
 
+/**
+ * struct pstore_blk_config - the pstore_blk backend configuration
+ *
+ * @device:		Name of the desired block device
+ * @max_reason:		Maximum kmsg dump reason to store to block device
+ * @kmsg_size:		Total size of for kmsg dumps
+ * @pmsg_size:		Total size of the pmsg storage area
+ * @console_size:	Total size of the console storage area
+ * @ftrace_size:	Total size for ftrace logging data (for all CPUs)
+ */
+struct pstore_blk_config {
+	char device[80];
+	enum kmsg_dump_reason max_reason;
+	unsigned long kmsg_size;
+	unsigned long pmsg_size;
+	unsigned long console_size;
+	unsigned long ftrace_size;
+};
+
+/**
+ * pstore_blk_get_config - get a copy of the pstore_blk backend configuration
+ *
+ * @info:	The sturct pstore_blk_config to be filled in
+ *
+ * Failure returns negative error code, and success returns 0.
+ */
+int pstore_blk_get_config(struct pstore_blk_config *info);
+
 #endif
-- 
2.20.1

