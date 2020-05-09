Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE77C54E4A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C1D1217BA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BR2gb3g7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgEIXlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 19:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728309AbgEIXlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 19:41:13 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D0CC061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 16:41:13 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id b12so382915plz.13
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 16:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9b96+3F3UdF82FBwaSU5JLnw5ZdkMBQ4NVk3N1vy02U=;
        b=BR2gb3g7b7V4+4MgXIurtPzUewLXJbuzOVMhHXgSrlbbVBWKrf0yvnO7j/prwE/eJZ
         +TnY7bF8rZR990NDaKofxFlxmuslNYpk5fYEAZxGlk/C9/E6mgVghKET1lU76SFN4PkQ
         LlIp+O3fSRS4J/G+zUPYYKCd9qeI6kc7I69ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9b96+3F3UdF82FBwaSU5JLnw5ZdkMBQ4NVk3N1vy02U=;
        b=tDPBUjTfZU+AXMddx5YqYPAMI66O3zqBTTmJ/Xaf6zXGtQdoTY5gH3Km4tKPXbrQ9d
         VTvn/KDlwHdkTSZzMURvcVblpc38uJt1YtnuW2xxJq0jy+0wONY+AwmCf5cW3RHepgFa
         nNB/IA7ZFfbGSZCXUZtMhNKEvvlnyERKTU5iIfeaQMqlGd6f6F6k6ghqcZwFXkYReaz8
         h3epbxmiSa7uya7DaamcZTym7imwU2kE8KVmihsk+BKygKvrQBeEqnapAUaf3vkbqcG+
         PNBqSVChrElYzBW21yTPPPHd9in7cahkaIlhA867w5SvYDLgqUMVh9quNuydgcUhhUyR
         /0WA==
X-Gm-Message-State: AGi0PubqROTjl5pQvmBdsjePRugpeSBn1NeZZvAmUxLxFkI5YOfTuHkI
        Dw2Q/PnyRSv/EvB/1QMbcp8CKA==
X-Google-Smtp-Source: APiQypJgwi2ee+B4KoH7EDsxXkyzTzy+97Tc1ywbxQrfHFWHhOS1gVaYJjwR8QhZ6J3058IPDEvKSQ==
X-Received: by 2002:a17:90a:a893:: with SMTP id h19mr13650061pjq.138.1589067672623;
        Sat, 09 May 2020 16:41:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b11sm4480434pgq.50.2020.05.09.16.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 16:41:10 -0700 (PDT)
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
Subject: [PATCH v6 05/18] pstore/ram: Refactor ftrace buffer merging
Date:   Sat,  9 May 2020 16:40:50 -0700
Message-Id: <20200509234103.46544-6-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200509234103.46544-1-keescook@chromium.org>
References: <20200509234103.46544-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changes the ftrace record merging code to be agnostic of
pstore/ram, as the first step to making it available as a generic
routine for other backends to use, such as pstore/zone.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/ram.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 7f956053f4e5..672ad80646c5 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -172,8 +172,9 @@ static bool prz_ok(struct persistent_ram_zone *prz)
 			   persistent_ram_ecc_string(prz, NULL, 0));
 }
 
-static ssize_t ftrace_log_combine(struct persistent_ram_zone *dest,
-				  struct persistent_ram_zone *src)
+static
+ssize_t ftrace_log_combine(char **dest_log, size_t *dest_log_size,
+			   const char *src_log, size_t src_log_size)
 {
 	size_t dest_size, src_size, total, dest_off, src_off;
 	size_t dest_idx = 0, src_idx = 0, merged_idx = 0;
@@ -181,19 +182,19 @@ static ssize_t ftrace_log_combine(struct persistent_ram_zone *dest,
 	struct pstore_ftrace_record *drec, *srec, *mrec;
 	size_t record_size = sizeof(struct pstore_ftrace_record);
 
-	dest_off = dest->old_log_size % record_size;
-	dest_size = dest->old_log_size - dest_off;
+	dest_off = *dest_log_size % record_size;
+	dest_size = *dest_log_size - dest_off;
 
-	src_off = src->old_log_size % record_size;
-	src_size = src->old_log_size - src_off;
+	src_off = src_log_size % record_size;
+	src_size = src_log_size - src_off;
 
 	total = dest_size + src_size;
 	merged_buf = kmalloc(total, GFP_KERNEL);
 	if (!merged_buf)
 		return -ENOMEM;
 
-	drec = (struct pstore_ftrace_record *)(dest->old_log + dest_off);
-	srec = (struct pstore_ftrace_record *)(src->old_log + src_off);
+	drec = (struct pstore_ftrace_record *)(*dest_log + dest_off);
+	srec = (struct pstore_ftrace_record *)(src_log + src_off);
 	mrec = (struct pstore_ftrace_record *)(merged_buf);
 
 	while (dest_size > 0 && src_size > 0) {
@@ -217,9 +218,9 @@ static ssize_t ftrace_log_combine(struct persistent_ram_zone *dest,
 		src_size -= record_size;
 	}
 
-	kfree(dest->old_log);
-	dest->old_log = merged_buf;
-	dest->old_log_size = total;
+	kfree(*dest_log);
+	*dest_log = merged_buf;
+	*dest_log_size = total;
 
 	return 0;
 }
@@ -295,7 +296,11 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
 				tmp_prz->corrected_bytes +=
 						prz_next->corrected_bytes;
 				tmp_prz->bad_blocks += prz_next->bad_blocks;
-				size = ftrace_log_combine(tmp_prz, prz_next);
+
+				size = ftrace_log_combine(&tmp_prz->old_log,
+						&tmp_prz->old_log_size,
+						prz_next->old_log,
+						prz_next->old_log_size);
 				if (size)
 					goto out;
 			}
-- 
2.20.1

