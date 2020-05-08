Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D9BC47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B4520870
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bWDhDxic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgEHGlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 02:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727826AbgEHGkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 02:40:15 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311BAC05BD0A
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 23:40:15 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y25so443915pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 23:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1msrSyHZ6KfA51tZi5XgmUcYg/Y7t9cj83OUd8ZkNEY=;
        b=bWDhDxic/fxlTFZu9VXJ5niKiHgQNotH2cKyRKjaOx3VmhF/9tO0oDOy+4Q7SCS/Fo
         NzimCvCXTiQwZ/OttQPeFw9OtbLRrngc25eeJQaQjPqbJQPsAiB7zWEwEG+e4UG1pGt6
         WyS8X+qYsdFpjynUnDUildk4q8Swr1p2Gr9gE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1msrSyHZ6KfA51tZi5XgmUcYg/Y7t9cj83OUd8ZkNEY=;
        b=Def4LWnl66HFblvUjVrWkvolUDPYLiRvujfg9grvhdNzDMljXyd9wo+PMTSYMAQ7Uk
         15xbk7wTtoJWTx0Hq6VEYrH7UGx5X3MKIGFYuFTBr+NBguyeTiP1ODdDRdCHJnbugEFX
         sOe1mOlHE8eRNCZTKZ5cKRV8YbPmuR8KsN+jI44sr2Xvt0mpUP+mL2pX6pFKW9x5BHpq
         9etr6J9WIeJ6ha5r3uPJ49MJ6oe1iDU/r/AedOhy+OKoPtqvWp9iWrWKnN6xFbfYor9x
         s6rGN7slXjmktWbvqgIuv8NdgFrhvUzZwBKloNOf/cSsZZY0r3q42L2nFvlID389toqG
         le9A==
X-Gm-Message-State: AGi0PualQPgRm7NOkAoHzOO2dZAHELPpJvIlGOtbTili870KYm9KlSMJ
        eJLBeBgE7woE2ZUJ/oABWDKUmw==
X-Google-Smtp-Source: APiQypLk1Mg7kNeFeBwkDOe2wQg2PR/W23mwT2tRkzyl61Z5pOg8H5W6ETpAbHz0dzHI1KzyoDZfVA==
X-Received: by 2002:a63:a043:: with SMTP id u3mr856506pgn.287.1588920014676;
        Thu, 07 May 2020 23:40:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l137sm774866pfd.107.2020.05.07.23.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 23:40:12 -0700 (PDT)
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
Subject: [PATCH v4 04/12] pstore/blk: Provide way to choose pstore frontend support
Date:   Thu,  7 May 2020 23:39:56 -0700
Message-Id: <20200508064004.57898-5-keescook@chromium.org>
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

Most pstore backends lack support for all the pstore frontends, only
handling kmsg dump and not things like pmsg, console, and ftrace.
Provide a way for drivers using pstore/blk to list which frontends they
expect to support.

Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
Link: https://lore.kernel.org/r/1585126506-18635-4-git-send-email-liaoweixiong@allwinnertech.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/blk.c            | 16 +++++++++++++---
 include/linux/pstore_blk.h |  4 +++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index 286aa82aa483..d1c3074aa128 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -67,6 +67,9 @@ static struct bdev_info {
  *
  * @total_size: The total size in bytes pstore/blk can use. It must be greater
  *		than 4096 and be multiple of 4096.
+ * @flags:	Refer to macro starting with PSTORE_FLAGS defined in
+ *		linux/pstore.h. It means what front-ends this device support.
+ *		Zero means all backends for compatible.
  * @read:	The general read operation. Both of the function parameters
  *		@size and @offset are relative value to bock device (not the
  *		whole disk).
@@ -79,6 +82,7 @@ static struct bdev_info {
  */
 struct psblk_device {
 	unsigned long total_size;
+	unsigned int flags;
 	psz_read_op read;
 	psz_write_op write;
 	psz_write_op panic_write;
@@ -104,8 +108,11 @@ static int psblk_register_do(struct psblk_device *dev)
 		return -ENOMEM;
 	}
 
-#define verify_size(name, alignsize) {					\
-		long _##name_ = (name);					\
+	/* zero means all backends for compatible */
+	if (!dev->flags)
+		dev->flags = UINT_MAX;
+#define verify_size(name, alignsize, enable) {				\
+		long _##name_ = (enable) ? (name) : 0;			\
 		_##name_ = _##name_ <= 0 ? 0 : (_##name_ * 1024);	\
 		if (_##name_ & ((alignsize) - 1)) {			\
 			pr_info(#name " must align to %d\n",		\
@@ -312,6 +319,7 @@ static struct bdev_info *psblk_get_bdev_info(void)
  * psblk_register_blkdev() - register block device to pstore/blk
  *
  * @major: the major device number of registering device
+ * @flags: refer to macro starting with PSTORE_FLAGS defined in linux/pstore.h
  * @panic_write: the interface for panic case.
  *
  * Only the matching major to @blkdev can register.
@@ -322,7 +330,8 @@ static struct bdev_info *psblk_get_bdev_info(void)
  * * 0		- OK
  * * Others	- something error.
  */
-int psblk_register_blkdev(unsigned int major, psblk_panic_write_op panic_write)
+int psblk_register_blkdev(unsigned int major, unsigned int flags,
+		psblk_panic_write_op panic_write)
 {
 	struct block_device *bdev;
 	struct psblk_device dev = {0};
@@ -353,6 +362,7 @@ int psblk_register_blkdev(unsigned int major, psblk_panic_write_op panic_write)
 	blkdev_panic_write = panic_write;
 
 	dev.total_size = psblk_bdev_size(bdev);
+	dev.flags = flags;
 	dev.panic_write = panic_write ? psblk_blk_panic_write : NULL;
 	dev.read = psblk_generic_blk_read;
 	dev.write = psblk_generic_blk_write;
diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
index 5ff465e3953e..d8f609e60288 100644
--- a/include/linux/pstore_blk.h
+++ b/include/linux/pstore_blk.h
@@ -4,6 +4,7 @@
 #define __PSTORE_BLK_H_
 
 #include <linux/types.h>
+#include <linux/pstore.h>
 #include <linux/pstore_zone.h>
 
 /**
@@ -20,7 +21,8 @@
 typedef int (*psblk_panic_write_op)(const char *buf, sector_t start_sect,
 		sector_t sects);
 
-int  psblk_register_blkdev(unsigned int major, psblk_panic_write_op panic_write);
+int  psblk_register_blkdev(unsigned int major, unsigned int flags,
+		psblk_panic_write_op panic_write);
 void psblk_unregister_blkdev(unsigned int major);
 int  psblk_blkdev_info(dev_t *devt, sector_t *nr_sects, sector_t *start_sect);
 
-- 
2.20.1

