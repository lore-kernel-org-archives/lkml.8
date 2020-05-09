Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C301C47255
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5786621775
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hEl6rWsg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgEIXq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 19:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729070AbgEIXqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 19:46:50 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5F3C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 16:46:50 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 7so6256039pjo.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 16:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W/OyM5xWMsCxGKhpd57n8B6pYDT/bbNCXahzUEHyQHM=;
        b=hEl6rWsgGI5gElw0aUE/odwxzL2ZvqGO33b/PnrzxDJf5pz8m4nE6cMvPg9O3eZw4v
         kWwXWbwTpba7DXwtb3X8PVyVu/ms5Pc5MB7DdYKfPzYZ+cqI4rSynBUUaRpok34yeHug
         /OTMMd3FIF38Pv/p/ZggrIcEarV7883a3JO38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W/OyM5xWMsCxGKhpd57n8B6pYDT/bbNCXahzUEHyQHM=;
        b=aLGhwcgCdgSklSSfHhIR8sRGpfs5oxRBQlJFp85IFeVDqEONhOJVTTEAV765SV6jWk
         RvVD149uqxXMBChqNOeuTcaHbmbhli/FDg0meJuYq1FveqUKCY8/BYjND1SYjF4NzCLh
         2siZYmbk7PtuulhlunDJokEJ02JXvjBYmr8J0rnIQ3HMwMewfwZCtxHJghW7uVHa4i1p
         1KYpKajuB4TX0tZEwRHYXlG2M3LrI1qSll9MdzAGD1/Gf3jp+Pci2UBH8MDS00x5TmuX
         sGkorKLWXmAf+Y6t2yGle+jOEFPzqlV/n9aUek4+MEaYym+ts+p4IIy9EUr0D7kDPq9k
         vwgw==
X-Gm-Message-State: AGi0Puajg96MAS7VTH81848rEC/oHsoqIJfZvGCeGCJzOOLp0t5zS4zq
        CbxDeTXMXCx+lUs38NWJbgR4Mg==
X-Google-Smtp-Source: APiQypKMTk+Db8R/TljPB2LFy2Oe3CFdrjNzI1wijISitcrWhwLAUAgNunD98TF1maMmXEhKS0COGw==
X-Received: by 2002:a17:90b:246:: with SMTP id fz6mr14475254pjb.138.1589068009793;
        Sat, 09 May 2020 16:46:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 13sm5534768pfv.95.2020.05.09.16.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 16:46:49 -0700 (PDT)
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
Subject: [PATCH v6 18/18] pstore/blk: Introduce "best_effort" mode
Date:   Sat,  9 May 2020 16:41:03 -0700
Message-Id: <20200509234103.46544-19-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200509234103.46544-1-keescook@chromium.org>
References: <20200509234103.46544-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use arbitrary block devices as a pstore backend, provide a
new module param named "best_effort", which will allow using any block
device, even if it has not provided a panic_write callback.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/blk.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index 3e67bd4557ea..b7c33ef4c646 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -51,6 +51,10 @@ static long ftrace_size = -1;
 module_param(ftrace_size, long, 0400);
 MODULE_PARM_DESC(ftrace_size, "ftrace size in kbytes");
 
+static bool best_effort;
+module_param(best_effort, bool, 0400);
+MODULE_PARM_DESC(best_effort, "use best effort to write (i.e. do not require storage driver pstore support, default: off)");
+
 /*
  * blkdev - the block device to use for pstore storage
  *
@@ -388,7 +392,7 @@ static int __register_pstore_blk(unsigned int major, unsigned int flags,
 		return PTR_ERR(binfo);
 
 	/* only allow driver matching the @blkdev */
-	if (!binfo->devt || MAJOR(binfo->devt) != major) {
+	if (!binfo->devt || (!best_effort && MAJOR(binfo->devt) != major)) {
 		pr_debug("invalid major %u (expect %u)\n",
 				major, MAJOR(binfo->devt));
 		return -ENODEV;
@@ -532,6 +536,19 @@ int pstore_blk_usr_info(struct pstore_blk_info *info)
 }
 EXPORT_SYMBOL_GPL(pstore_blk_usr_info);
 
+static int __init pstore_blk_init(void)
+{
+	int ret = 0;
+
+	mutex_lock(&pstore_blk_lock);
+	if (!pstore_zone_info && best_effort && blkdev[0])
+		ret = __register_pstore_blk(0, 0, NULL);
+	mutex_unlock(&pstore_blk_lock);
+
+	return ret;
+}
+late_initcall(pstore_blk_init);
+
 static void __exit pstore_blk_exit(void)
 {
 	mutex_lock(&pstore_blk_lock);
-- 
2.20.1

