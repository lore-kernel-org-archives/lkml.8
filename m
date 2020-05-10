Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3433C54E8D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 20:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9529520737
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 20:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fw8KyfeR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgEJUb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 16:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728468AbgEJUb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 16:31:57 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948D9C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 13:31:57 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f7so3760787pfa.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 13:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IGhCzVMcFSG8RfD2dnuoWGbvQKbAh3BbNL764FWITOg=;
        b=Fw8KyfeRY2o+iHX91RUx34YBABbxf6VuNlYyNsnrWdXif3s/ACuQVflYL+CJptaAuw
         gTkwG01vIwsxYH9f/tLpXxU2UnH3b3f+//pWjovG+r86XkEYeKe1/MFAGtf/PMTdBtIm
         McUum85+3EHfgMNTrU3qDsZ2l6EjV1jWiANN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IGhCzVMcFSG8RfD2dnuoWGbvQKbAh3BbNL764FWITOg=;
        b=KI11GIJ9SUtm0VGC05GUSAQZR+nP2e8+Tu6PPDxDbYBIWLZ1fLXcryWHvr9rGdMzwT
         vDE4Xvc2TTF/iNHuCOMvnDSdf8WiZyMwWOT8uVyH5ekvFnnP4opinsuA/VnoX+72jMHI
         YYeaqMT2R2SkWmUr5gsw8Ck8vQx5JpG5dv4RJIlVfZ0NfQ5arXRQhPqwm8brd7mrOsaV
         ogOE0Vhh/JNbB7VPVvmL5hiXz0wafBiPYGlGHFu8l0/9MGRCMBmt1mRQFZsepgLoBDiE
         dEFe7gOVn8ZpS8GZoAw9Cqe2qHBABvWWsw+GjysJ1T8GXN/Gg1ZkmwfC1BL0bznPJpzH
         iJJQ==
X-Gm-Message-State: AGi0PuYN/VORfjkbNfXm8Zs73PGQqbOqM31rTHaaYs6WMNIBcUYZBLP6
        nNiMcZMykiUNtoKbWvVU+ypMDg==
X-Google-Smtp-Source: APiQypJsRU9h+Mob7IV8V9hVnNZaLYlsu6I2Ml5FQNRy6o1udqUOVm9mMtwEsQaiHAaxP5NUL+g+Lg==
X-Received: by 2002:a63:dd51:: with SMTP id g17mr10543432pgj.2.1589142717130;
        Sun, 10 May 2020 13:31:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f30sm8149570pje.29.2020.05.10.13.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 13:31:56 -0700 (PDT)
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
Subject: [PATCH v7 18/18] pstore/blk: Introduce "best_effort" mode
Date:   Sun, 10 May 2020 13:24:36 -0700
Message-Id: <20200510202436.63222-19-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200510202436.63222-1-keescook@chromium.org>
References: <20200510202436.63222-1-keescook@chromium.org>
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
 fs/pstore/blk.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index 0dea8ded2de2..ad46860d5a78 100644
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
@@ -376,7 +380,8 @@ static int __register_pstore_blk(struct pstore_blk_info *info)
 	}
 
 	/* only allow driver matching the @blkdev */
-	if (!binfo.devt || MAJOR(binfo.devt) != info->major) {
+	if (!binfo.devt || (!best_effort &&
+			    MAJOR(binfo.devt) != info->major)) {
 		pr_debug("invalid major %u (expect %u)\n",
 				info->major, MAJOR(binfo.devt));
 		ret = -ENODEV;
@@ -479,6 +484,20 @@ int pstore_blk_get_config(struct pstore_blk_config *info)
 }
 EXPORT_SYMBOL_GPL(pstore_blk_get_config);
 
+static int __init pstore_blk_init(void)
+{
+	struct pstore_blk_info info = { };
+	int ret = 0;
+
+	mutex_lock(&pstore_blk_lock);
+	if (!pstore_zone_info && best_effort && blkdev[0])
+		ret = __register_pstore_blk(&info);
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

