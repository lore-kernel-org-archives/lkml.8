Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB5BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 273E72078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fce5lMZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgHZRCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 13:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgHZRAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 13:00:52 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9115FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 10:00:51 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id g13so2846151ioo.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 10:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TT/nPbomDmh8NQShHOC8FZBWwCU19NUKn3EZB0b0q/I=;
        b=Fce5lMZPmSr/R6QTYB7eE6nL3eFrkLLX7rJdVbaoCg7NYYWUOFtn4jZPNhguFFE0Ww
         h0t8AECaIll/C9E6AEcxUoJ5le0j7fFyRKNONqAaRXBJnN0KLBLAQ6tGEt4vlttY7Irt
         8ykSWtiAR+VTO+UpMmiH+94GgFSa8xkKNW414kXDcTWCcgUp7wHg+/0FAlbiTnFGQZRd
         yWEHyK34HqJ8LhWzwexYM1kssLa7LBk/nCIcve+q3U4MBqz1RGTdHqBlk9an4wtlFMBy
         jpM0KSbhTeS7lR3i9cIExK0K18jOaaBOZs9YPIGbC5Upj3gY2ddewNA8VEyQ0cNBtdjx
         InCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TT/nPbomDmh8NQShHOC8FZBWwCU19NUKn3EZB0b0q/I=;
        b=Pn6Dr0tYDkhIRAdmoO7rdSjNWGoiPZvSiX8cBrruqxazE7YauGxrARrIadUF4T8+QF
         DZ3PyFhFrC9DTZd2TQHlpbIKM7HqGxmodQw7yr4GvHkjTGaDJvLNCyY2aJ9iCwsauPzf
         R2m+Exo7xqyXjQtyu19TMktFvmd8P3d1jsoLtNDy6Q+teyyKu9p4Nu6KyYX6XALBU3C1
         CnIber6PfSv8Y7fEadE239j+5iELIVS9BrOliu6rLv5lxjZn0jXm3OkaT1qdJpfcWT68
         XNgrurctcCf2ZaN3Du2Cq6rxj4B8o8OBvmi0H5F/i8NexVJPhwAGw5++qRNBup8+X4ha
         fGDg==
X-Gm-Message-State: AOAM531/Pp/R1Vuwl9fCtdPM/ncsyrSJ3hecTMiyQzUd6WD5I/J+4+hu
        2ilsgxXdztFb5ksUFPC0P4N0/YQNKVli2A==
X-Google-Smtp-Source: ABdhPJxy5A5rKdHB0JGFzyPbJaQvXJ1YHzMRzjOYm2I0ca1HWwoG3rk1JxilvNBEZOnEKffrPVxEDw==
X-Received: by 2002:a6b:7411:: with SMTP id s17mr10699072iog.192.1598461250478;
        Wed, 26 Aug 2020 10:00:50 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8203:5970::c4c])
        by smtp.googlemail.com with ESMTPSA id p78sm1479606iod.0.2020.08.26.10.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 10:00:49 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        jbaron@akamai.com
Cc:     Jim Cromie <jim.cromie@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 1/4] drm-printk: POC caller of dynamic-debug-exec-queries
Date:   Wed, 26 Aug 2020 11:00:38 -0600
Message-Id: <20200826170041.2497546-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200826170041.2497546-1-jim.cromie@gmail.com>
References: <20200826170041.2497546-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export of dynamic-debug-exec-queries exists for users like drm.

This commit is a 1st user-test; it adds a 2nd knob, __drm_debug2,
similar in function to __drm_debug.  module_param_cb wires it to a
callback which maps the input value to one of: "module=drm* +/-p".

The include is needed to see the exported function prototype.

Notes:

The define DEBUG at top of drm-printk enables all pr_debug()s,
independent of CONFIG_DYNAMIC_DEBUG_CORE.

drm-printk is an independent print control system using __drm_debug
bits.  The plan is to find the low-level macros in which to insert a
pr_debug call, their eventual callsites will have distinct METADATA,
so will be itemized in control, and individually selectable.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 111b932cf2a9..52abaf2ae053 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -27,6 +27,7 @@
 
 #include <stdarg.h>
 
+#include <linux/dynamic_debug.h>
 #include <linux/io.h>
 #include <linux/moduleparam.h>
 #include <linux/seq_file.h>
@@ -54,6 +55,40 @@ MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug cat
 "\t\tBit 8 (0x100) will enable DP messages (displayport code)");
 module_param_named(debug, __drm_debug, int, 0600);
 
+/* POC for callback -> ddebug_exec_queries */
+unsigned int __drm_debug2;
+EXPORT_SYMBOL(__drm_debug2);
+
+static int param_set_dyndbg(const char *val, const struct kernel_param *kp)
+{
+	int chgct, result;
+
+	result = kstrtouint(val, 0, (unsigned int *)kp->arg);
+	pr_warn("set_dyndbg: result:%d from %s\n", result, val);
+
+	if (result)
+		chgct = dynamic_debug_exec_queries("module=drm* +p", NULL);
+	else
+		chgct = dynamic_debug_exec_queries("module=drm* -p", NULL);
+
+	pr_warn("change ct:%d\n", chgct);
+	return 0;
+}
+static int param_get_dyndbg(char *buffer, const struct kernel_param *kp)
+{
+	return scnprintf(buffer, PAGE_SIZE, "%u\n",
+			 *((unsigned int *)kp->arg));
+}
+static const struct kernel_param_ops param_ops_dyndbg = {
+	.set = param_set_dyndbg,
+	.get = param_get_dyndbg,
+};
+
+MODULE_PARM_DESC(debug_dyn, "Enable debug output, where each bit enables a debug category.\n"
+		 "\t\tthese wont work yet\n");
+module_param_cb(debug_dyn, &param_ops_dyndbg, &__drm_debug2, 0644);
+
+
 void __drm_puts_coredump(struct drm_printer *p, const char *str)
 {
 	struct drm_print_iterator *iterator = p->arg;
-- 
2.26.2

