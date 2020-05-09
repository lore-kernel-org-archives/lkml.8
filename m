Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED4FC54E49
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D59E821775
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gzyOjTw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgEIXlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 19:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728455AbgEIXlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 19:41:14 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73475C05BD0A
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 16:41:14 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x10so2301376plr.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 16:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JdXyPOJQpTSYz0o6bZPVoAxc8JEprJkuWJfRQIr5NY0=;
        b=gzyOjTw8wRwrP8LbYjjrZKjGDPqzhgOFFIE7x9uWrBClM8f0xdaIMYNtJ4l1DtvQiZ
         KQWgbA5GX6ciOsSN2UI77AP9fV54X3TgepFPP7DxqTc8F+G74Ayg20aikN3drFKJeHiu
         E9lO/k/J4unHGzTz2cKSUxIS1WkFJIjRUNDv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JdXyPOJQpTSYz0o6bZPVoAxc8JEprJkuWJfRQIr5NY0=;
        b=OwqHyyuBj9lYoc7jiM/Bqyhy3kg/1QXLvTCU+aN42lPgViMY4l+VQW5tRG2u7W1+y5
         M5H6lyZph0Jc0/JLF0EFPeRi0tA25s3esn3gSS+MeNdtSTOsbYrbuHhtZVBwDZ2xbBSG
         b8Obq0ANQ+42CnHeF4Vw+x5HM0nQa9HoeRK7pUis0d+HTATMxAYaQt8y/zmzCvCGyL9I
         ZAtCRLk1p3iZjXdmQ/Ek7+5z1t2ZUkwZA9eepd1CeZUsTMNaIbLbVGIntZ32nKfbFPu4
         IuPfO7R+b+2vFTzGABlAF+0hkrhEBNwey5OTrk4GAemUrCv+UUpfQ6FC3CL/pAMcimrk
         n/8w==
X-Gm-Message-State: AGi0PubHmf/JydlDG+ehaYh0CHpbtt/8vyIPy9iHLQ04zAqAPVD0CjeB
        FtPFbzbaDWUMgZNeUoLksjn5WA==
X-Google-Smtp-Source: APiQypKzEu4VjYBffDUIaD632JEgmc2vVCn2Az2FJiIbuinys2BzwB9eEF2pbusMs65ChacYQa84VQ==
X-Received: by 2002:a17:902:9044:: with SMTP id w4mr9070425plz.83.1589067673972;
        Sat, 09 May 2020 16:41:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m18sm5886805pjl.14.2020.05.09.16.41.09
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
Subject: [PATCH v6 07/18] printk: Introduce kmsg_dump_reason_str()
Date:   Sat,  9 May 2020 16:40:52 -0700
Message-Id: <20200509234103.46544-8-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200509234103.46544-1-keescook@chromium.org>
References: <20200509234103.46544-1-keescook@chromium.org>
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

