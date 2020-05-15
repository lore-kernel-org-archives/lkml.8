Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09105C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D336E20728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FFCdriJS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgEOSpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 14:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgEOSol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 14:44:41 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C5AC05BD0F
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 11:44:41 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k22so1245561pls.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 11:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jsyBNCdfoL98sYl7cnpntA0QaiVdKf/pQHgqAm6lCYc=;
        b=FFCdriJSY7EREhlVw7IxRxRBK6Ih8PscgoyfU0YOxFmw+mYa4P8kbYTdI3Abj2xsbv
         dSBqe5xNx4EdU6OBEbPL6+Ktp8r1MwV2GC+z42GBSCy/OKACQ/TjY0Z+0HyakSj6TLKK
         bj22i9zQWZ2HwbBoxp38600+xxhVI0OIEt8ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jsyBNCdfoL98sYl7cnpntA0QaiVdKf/pQHgqAm6lCYc=;
        b=SaW08K56RPlUclAEBAkwvOOCPtadY35wXQLYrfEjfHDJ/sN4yhgLBAYMZXT6fCuFcP
         L8i9AJ3tuokkNAofR7edtdslpI5YsztpQ9iudibZLAECYmAVdRnUyuYB9PtthXsjAq67
         61rnU0+Darjm4HCC0CuGkAzu2LyCp7nPK39HJf2089aJu3sDPc2VnqJK5fMEjY4+3suR
         pFwTccy8sj10wLB5zpI5H7ZBzio5cya9+zg18M9EpMrHbfB+xYKSn9P9fCMp2g4OeKln
         kB8t9CHiveycgaqL/MUtTc6FY5WdAMIiWolPi6Or/TZaTUpCYNgmedRMLjZozwUs9bk9
         9uyg==
X-Gm-Message-State: AOAM530MIdq6WT2p+pWlEYevnIMA80cwtQgB46lvCnz6IrhY+e2qfBIw
        BhiosV8F7ky6RU6+NHGI6NBZXw==
X-Google-Smtp-Source: ABdhPJxBfb/RPReNIGiBtLiME/PRnLfy/gMnbNQWUG6b6p1tr5eRGW/FhmqI7QvZ6RmEUD62weuFvQ==
X-Received: by 2002:a17:90a:7f83:: with SMTP id m3mr5175792pjl.147.1589568281062;
        Fri, 15 May 2020 11:44:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z190sm2549307pfb.1.2020.05.15.11.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 11:44:38 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Kees Cook <keescook@chromium.org>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Benson Leung <bleung@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 3/6] printk: Introduce kmsg_dump_reason_str()
Date:   Fri, 15 May 2020 11:44:31 -0700
Message-Id: <20200515184434.8470-4-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515184434.8470-1-keescook@chromium.org>
References: <20200515184434.8470-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pstore subsystem already had a private version of this function.
With the coming addition of the pstore/zone driver, this needs to be
shared. As it really should live with printk, move it there instead.

Link: https://lore.kernel.org/lkml/20200510202436.63222-8-keescook@chromium.org/
Acked-by: Petr Mladek <pmladek@suse.com>
Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/platform.c      | 18 +-----------------
 include/linux/kmsg_dump.h |  7 +++++++
 kernel/printk/printk.c    | 17 +++++++++++++++++
 3 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 90d74ebaa70a..5e6c6022deb9 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -135,22 +135,6 @@ enum pstore_type_id pstore_name_to_type(const char *name)
 }
 EXPORT_SYMBOL_GPL(pstore_name_to_type);
 
-static const char *get_reason_str(enum kmsg_dump_reason reason)
-{
-	switch (reason) {
-	case KMSG_DUMP_PANIC:
-		return "Panic";
-	case KMSG_DUMP_OOPS:
-		return "Oops";
-	case KMSG_DUMP_EMERG:
-		return "Emergency";
-	case KMSG_DUMP_SHUTDOWN:
-		return "Shutdown";
-	default:
-		return "Unknown";
-	}
-}
-
 static void pstore_timer_kick(void)
 {
 	if (pstore_update_ms < 0)
@@ -403,7 +387,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 	unsigned int	part = 1;
 	int		ret;
 
-	why = get_reason_str(reason);
+	why = kmsg_dump_reason_str(reason);
 
 	if (down_trylock(&psinfo->buf_lock)) {
 		/* Failed to acquire lock: give up if we cannot wait. */
diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
index 9826014771ab..3378bcbe585e 100644
--- a/include/linux/kmsg_dump.h
+++ b/include/linux/kmsg_dump.h
@@ -70,6 +70,8 @@ void kmsg_dump_rewind(struct kmsg_dumper *dumper);
 int kmsg_dump_register(struct kmsg_dumper *dumper);
 
 int kmsg_dump_unregister(struct kmsg_dumper *dumper);
+
+const char *kmsg_dump_reason_str(enum kmsg_dump_reason reason);
 #else
 static inline void kmsg_dump(enum kmsg_dump_reason reason)
 {
@@ -111,6 +113,11 @@ static inline int kmsg_dump_unregister(struct kmsg_dumper *dumper)
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
index a121c2255737..14ca4d05d902 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3144,6 +3144,23 @@ EXPORT_SYMBOL_GPL(kmsg_dump_unregister);
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
+	case KMSG_DUMP_SHUTDOWN:
+		return "Shutdown";
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

