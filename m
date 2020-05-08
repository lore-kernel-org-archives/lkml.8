Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10160C54E4B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5BDC20735
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i8ZcQCpA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgEHGkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 02:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727867AbgEHGkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 02:40:22 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096D4C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 23:40:22 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o18so420166pgg.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 23:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wKID/Cl4tUQxiQJpuetvI2JFoStwB5HzL1GiVfb5+cA=;
        b=i8ZcQCpAllHeEr1aHeWq2vIRYm4Xx5t0+HHrz3Z7O3f+6+t5f9E5knP3XB7ZroAzRR
         F45r9mSaTdqojAf8TmM34xYOd17MdlRZnRVelUlCL1DDpbqNepvGzwzmDPBuPL88PVZl
         UHun6+gAU4XsV8S5FEMS1Dvb5xTg4rIdPyKbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wKID/Cl4tUQxiQJpuetvI2JFoStwB5HzL1GiVfb5+cA=;
        b=bMdursrPiKQ0qP0sNtGJ8X0JqFcVmmy2mQ1htOpQWBXytk80TpOvsDd7YD9xjbXV4Z
         L5EH2vf6Ew+hU8TzoGvOd86ECT8p7hN+pyjw+677IyQqYY4ocaUjdqXJvhnXX5sqslEk
         JYq4s0A95aYOaSYTxajf0XqXLUVVa1cf7e+PRCEVk6fXrG28srTl+OnNTMBpYpqBqaWl
         HYOqThnCHrHWI2zhp2y3LAbGuxYQFOGXiLl2DIMHXkvLxAN+eMumReh1I59iNJpQ368Y
         mY3G2S1fnvRp32zdKc2yjEV/oP0bkXuzPys6HZQwjTmcuutqFPJ1KUZUDqK6w3GTEZQC
         ni2Q==
X-Gm-Message-State: AGi0Pub8+gomoa2+NZZynlJX0Cu1x4kWH6UXC3odTzpRoNNMPULyz5bT
        qid6V05vI9E8u9rW3d/IYe/dUQ==
X-Google-Smtp-Source: APiQypLfMwSWfqyHjhWWcMDEtuWVrnUuoVlaew9c4twdZv4OpDw51QuFRDD2qG1PeuMABCCofJYkAw==
X-Received: by 2002:a63:ad08:: with SMTP id g8mr973395pgf.40.1588920021542;
        Thu, 07 May 2020 23:40:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e11sm632749pgs.41.2020.05.07.23.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 23:40:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/12] pstore/blk: Provide way to query pstore configuration
Date:   Thu,  7 May 2020 23:40:02 -0700
Message-Id: <20200508064004.57898-11-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508064004.57898-1-keescook@chromium.org>
References: <20200508064004.57898-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WeiXiong Liao <liaoweixiong@allwinnertech.com>

In order to configure itself, the MTD backend needs to be able to query
the current pstore configuration. Introduce pstore_blk_usr_info() for
this purpose.

Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
Link: https://lore.kernel.org/r/1585126506-18635-10-git-send-email-liaoweixiong@allwinnertech.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/blk.c            | 37 ++++++++++++++++++++++++++++++-------
 include/linux/pstore_blk.h | 10 ++++++++++
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index e33e58afd4cb..c6d99d5dcd7f 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -86,6 +86,17 @@ static struct bdev_info {
 	sector_t start_sect;
 } g_bdev_info;
 
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
  * struct psblk_device - back-end pstore/blk driver structure.
  *
@@ -140,13 +151,11 @@ static int psblk_register_do(struct psblk_device *dev)
 	if (!dev->flags)
 		dev->flags = UINT_MAX;
 #define verify_size(name, alignsize, enable) {				\
-		long _##name_ = (enable) ? (name) : 0;			\
-		_##name_ = _##name_ <= 0 ? 0 : (_##name_ * 1024);	\
-		if (_##name_ & ((alignsize) - 1)) {			\
-			pr_info(#name " must align to %d\n",		\
-					(alignsize));			\
-			_##name_ = ALIGN(name, (alignsize));		\
-		}							\
+		long _##name_;						\
+		if (enable)						\
+			_##name_ = check_size(name, alignsize);		\
+		else							\
+			_##name_ = 0;					\
 		name = _##name_ / 1024;					\
 		pstore_zone_info->name = _##name_;				\
 	}
@@ -465,6 +474,20 @@ int psblk_blkdev_info(dev_t *devt, sector_t *nr_sects, sector_t *start_sect)
 }
 EXPORT_SYMBOL_GPL(psblk_blkdev_info);
 
+/* get information of pstore/blk */
+int pstore_blk_usr_info(struct pstore_blk_info *info)
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
+EXPORT_SYMBOL_GPL(pstore_blk_usr_info);
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("WeiXiong Liao <liaoweixiong@allwinnertech.com>");
 MODULE_DESCRIPTION("pstore backend for block devices");
diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
index 828b0763d477..dd5213044e21 100644
--- a/include/linux/pstore_blk.h
+++ b/include/linux/pstore_blk.h
@@ -27,4 +27,14 @@ int  psblk_register_blkdev(unsigned int major, unsigned int flags,
 void psblk_unregister_blkdev(unsigned int major);
 int  psblk_blkdev_info(dev_t *devt, sector_t *nr_sects, sector_t *start_sect);
 
+struct pstore_blk_info {
+	char device[80];
+	enum kmsg_dump_reason max_reason;
+	unsigned long kmsg_size;
+	unsigned long pmsg_size;
+	unsigned long console_size;
+	unsigned long ftrace_size;
+};
+int pstore_blk_usr_info(struct pstore_blk_info *info);
+
 #endif
-- 
2.20.1

