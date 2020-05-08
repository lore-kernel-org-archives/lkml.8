Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B4BC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82AC520735
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e0qe+uKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgEHGkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 02:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727821AbgEHGkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 02:40:15 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65A1C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 23:40:13 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z1so446460pfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 23:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JdXyPOJQpTSYz0o6bZPVoAxc8JEprJkuWJfRQIr5NY0=;
        b=e0qe+uKWWnpDhziM3t5spYTSuMsXq6+AF6XiOPyF18/SyRwTmD2rMyHRwnZQ1TbbS8
         VdEO2Fd5TlezSYNnMKE39oUlruBGWCuyvhWKMhKxLGejW8SCWK4wmwDrg+wCYy64Fz1y
         /UeOocRS+gtjS0zSHRSlgVN4sWu2kAUvRnjjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JdXyPOJQpTSYz0o6bZPVoAxc8JEprJkuWJfRQIr5NY0=;
        b=Arv4F0ymbzrUeNVg+G7BQoNEdoud+NJlGctbCIegGPAEH6PjBNBoGOYVlSDlu6TC3a
         upO8tkmZ9ioZEK2tOwFmtJOTelMYEyKvsRZKnYR5GymfHqTdMpvdRhiE1TJayoOD1A2l
         B7V2u1hyAkeY5LeNQXb6m2WBJ4+IRVvngq6boLPMmn8Soxz5lRuGHBZOhrJ/Sjy6L8Ml
         PiwpK5EnieLe4/vzCLYhG5a9tRv9KaOvOIhWIc7ZBvlkb1TJDN9p1OgUDbXRPszgHsF9
         /5yH+WOsT2MBWGZVEKZ+4XegLgCDbh1lS8MVxusOtDLP2GZ0YXocZV0Ivh8pB5Lr0yoB
         Nayg==
X-Gm-Message-State: AGi0PuaBKAC2xxHKRu3tkEQwC3X2mriiWGrC8HcHC1HwdHjWCJrlWDif
        I6pXLLJ046r4ZboU0CvkzEHYFg==
X-Google-Smtp-Source: APiQypI90odZV2jsIE8Wx5fA87oydWTMxAfk81N4Wxn/Fp0elZ5/LCbsNYCT0YzR2lHvefT80T8TSQ==
X-Received: by 2002:a63:f30a:: with SMTP id l10mr931307pgh.372.1588920013293;
        Thu, 07 May 2020 23:40:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p10sm720661pff.210.2020.05.07.23.40.12
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
Subject: [PATCH v4 01/12] printk: Introduce kmsg_dump_reason_str()
Date:   Thu,  7 May 2020 23:39:53 -0700
Message-Id: <20200508064004.57898-2-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508064004.57898-1-keescook@chromium.org>
References: <20200508064004.57898-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pstore subsystem already had a private version of this function.
With the coming addition of the pstore/zone driver, this needs to be
shared. As it really should live with printk, move it there instead.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/kmsg_dump.h |  7 +++++++
 kernel/printk/printk.c    | 21 +++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
index cfc042066be7..b3ddb0b2ee40 100644
--- a/include/linux/kmsg_dump.h
+++ b/include/linux/kmsg_dump.h
@@ -72,6 +72,8 @@ void kmsg_dump_rewind(struct kmsg_dumper *dumper);
 int kmsg_dump_register(struct kmsg_dumper *dumper);
 
 int kmsg_dump_unregister(struct kmsg_dumper *dumper);
+
+const char *kmsg_dump_reason_str(enum kmsg_dump_reason reason);
 #else
 static inline void kmsg_dump(enum kmsg_dump_reason reason)
 {
@@ -113,6 +115,11 @@ static inline int kmsg_dump_unregister(struct kmsg_dumper *dumper)
 {
 	return -EINVAL;
 }
+
+static inline const char *kmsg_dump_reason_str(enum kmsg_dump_reason reason)
+{
+	return "Disabled";
+}
 #endif
 
 #endif /* _LINUX_KMSG_DUMP_H */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1aab69a8a2bf..67a284830d74 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3144,6 +3144,27 @@ EXPORT_SYMBOL_GPL(kmsg_dump_unregister);
 static bool always_kmsg_dump;
 module_param_named(always_kmsg_dump, always_kmsg_dump, bool, S_IRUGO | S_IWUSR);
 
+const char *kmsg_dump_reason_str(enum kmsg_dump_reason reason)
+{
+	switch (reason) {
+	case KMSG_DUMP_PANIC:
+		return "Panic";
+	case KMSG_DUMP_OOPS:
+		return "Oops";
+	case KMSG_DUMP_EMERG:
+		return "Emergency";
+	case KMSG_DUMP_RESTART:
+		return "Restart";
+	case KMSG_DUMP_HALT:
+		return "Halt";
+	case KMSG_DUMP_POWEROFF:
+		return "Poweroff";
+	default:
+		return "Unknown";
+	}
+}
+EXPORT_SYMBOL_GPL(kmsg_dump_reason_str);
+
 /**
  * kmsg_dump - dump kernel log to kernel message dumpers.
  * @reason: the reason (oops, panic etc) for dumping
-- 
2.20.1

