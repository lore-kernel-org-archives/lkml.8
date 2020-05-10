Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E5BC54E49
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 20:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9E28206F5
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 20:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RZCkHmVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgEJUZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 16:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729413AbgEJUYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 16:24:54 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDECC05BD0B
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 13:24:54 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w65so3744634pfc.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 13:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gDtEYHl+vhPbK8gExr5i1enY2u7ASw/t7gafPT2Tua4=;
        b=RZCkHmVAC0P+C+6umcgVArdbYqZtRYnJRAlIhCh7f3a3cUMxFuV3H96Y96URE7Gof/
         u2VScQV+I5XS16Po+v3nw+05j9q1Km7Nj2pCvYr9O7F55AFy5XX2XIGOqxzR6uakM1Hi
         E0hhPic0V5ljBYELraELCZtE7STLs0OQLG804=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gDtEYHl+vhPbK8gExr5i1enY2u7ASw/t7gafPT2Tua4=;
        b=U0zX6CCcJTPJpLxdvFMJSCwxGXxsXiEp/b1N668zrelhxDKvPqMoNuXL02OcISnDls
         gn3k105OGGd1YeG2lWVkefGKISM7HBrmznES06LIue9zsvrDO4K9hQ8iiHsBKDNdjQ0L
         yOBHV5GdHk/Mueow3dWcni6u2DYwo9+ja+kNXkB+yrZFKVYiufaYhvy73Qqhh+HUW4Ri
         diyRM4fXQ+2SrishjzOeZMauub6qBmB0GxH3jqlM2V8BmFCfhkIh6tAdTQIImoc2CRo5
         a/mAapitXnHQt12sMsx+UibHkNjgNFzsvO8wsAyc6ZnlpU0KdSPSIA5q6j9mpPrQVG2t
         MzBA==
X-Gm-Message-State: AGi0PuaZ/fEMb7FSlpnbwuM7KDoH+CUTs3Ihl2wNn3m+PZZnNOrXjRV7
        J/4guwCjsFDYTTdmiKb72DQufw==
X-Google-Smtp-Source: APiQypLYkPhTk56rTdjpKjnLfkUUxgxCThNOHV4aV+bIc6cfzxu6EZU0TNu2gO+Z81qJwGnSbxv6Wg==
X-Received: by 2002:a63:c644:: with SMTP id x4mr11682741pgg.385.1589142293702;
        Sun, 10 May 2020 13:24:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v127sm7279503pfv.77.2020.05.10.13.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 13:24:52 -0700 (PDT)
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
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: [PATCH v7 15/18] pstore/blk: Provide way to query pstore configuration
Date:   Sun, 10 May 2020 13:24:33 -0700
Message-Id: <20200510202436.63222-16-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200510202436.63222-1-keescook@chromium.org>
References: <20200510202436.63222-1-keescook@chromium.org>
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
index cf11094e6b3a..e8e907ea8b03 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -93,6 +93,17 @@ static struct bdev_info {
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
  * struct pstore_device_info - back-end pstore/blk driver structure.
  *
@@ -148,13 +159,11 @@ static int psblk_register_do(struct pstore_device_info *dev)
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
@@ -455,6 +464,20 @@ void unregister_pstore_blk(unsigned int major)
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

