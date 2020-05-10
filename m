Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59663C54E8A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 20:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34A6C20737
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 20:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="drD03wch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbgEJUYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 16:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729378AbgEJUYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 16:24:48 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DCEC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 13:24:47 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u22so3011735plq.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 13:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9b96+3F3UdF82FBwaSU5JLnw5ZdkMBQ4NVk3N1vy02U=;
        b=drD03wchFJ8JSi6NQlZOTRxtpLpre/PHVvk/pEeOVs/q7ZaC4QUP/gCZnLxqf1X9sk
         ytvjnrKwpw83qgDcoxIjucYAFsZ9QFtqdYQPRbOC/ItUOPjzt9OX3OK8tDNL+7XUv22B
         hPRWWXJBNSFKLTXd/IMgvZws7SyBYTA1VDjBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9b96+3F3UdF82FBwaSU5JLnw5ZdkMBQ4NVk3N1vy02U=;
        b=jm5UuedYoIz4JrhDyEFUcffIavkGYXdxGbDtPXVsu0NforlnfwTwlK/bHOEWQ932a0
         31SNB7sMUKKXfhB1f/BQvu1Pr1Jfofa9nk+KhZnQk7FBySeNm6ueJw6l5NdMeTRgc2GI
         noio1p1qrSh3fh0+x9hO7rTYQpHxFhPtCFxitd25851JpEKiFXpHaZKIfl+Aoxl26Pys
         Oy5p/pGlKkPL7j8QNlKNJVUGZN4OZ0hxj0O+wyV2zEpKetY3KFt9x5rYQP7mcBdrIzkT
         bl041eTRETNWMM/QZ+uNztboC6gbA/XwLAvkrLCxTy1/UOq3FQtE68Q1U2H264zPFtiY
         z26w==
X-Gm-Message-State: AGi0PubAQpL7eIeCLG8fjRTGHivWhRn1XXxzrLiaLtVabEVDbA0hXArh
        BcVI21qlxKaAwAnWDpNRYd35ug==
X-Google-Smtp-Source: APiQypK13VGjWO1X5uy4YJUs3elsqkv3kZFShDVm0qrPduOIuFGQ3nyFICLCIiUDGDPwI3WjCC6x/w==
X-Received: by 2002:a17:90a:21ce:: with SMTP id q72mr18453170pjc.0.1589142287117;
        Sun, 10 May 2020 13:24:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u5sm7508379pfu.198.2020.05.10.13.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 13:24:45 -0700 (PDT)
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
Subject: [PATCH v7 05/18] pstore/ram: Refactor ftrace buffer merging
Date:   Sun, 10 May 2020 13:24:23 -0700
Message-Id: <20200510202436.63222-6-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200510202436.63222-1-keescook@chromium.org>
References: <20200510202436.63222-1-keescook@chromium.org>
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

