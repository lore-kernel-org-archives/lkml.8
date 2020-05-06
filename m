Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0DEC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C761D20936
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kPtoH17W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgEFPV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729475AbgEFPVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:21:51 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6AAC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 08:21:51 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l12so909879pgr.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 08:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q0K/lv5zGYyr82mHQzUYrmx/oxfMBXzRZFC8ZU0cokw=;
        b=kPtoH17WkQd61pRXa7oPU+5nNu/1tOIwbo0X5iltCrgz2x55XhK9IkHhRBZax+/hPn
         RQaXT11HlV17Qsaww9Zx7Hy0rCQQht4TZKq2ixUgrjQ5uQ0T6UBmuuFEn7VrFfCdHDpd
         0+Xzaj7d6hIrmiOBPVeQZ80HZQeecxnfjBH40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q0K/lv5zGYyr82mHQzUYrmx/oxfMBXzRZFC8ZU0cokw=;
        b=TRwdENyVLiAZM5NBPoqlovBqiPFtwOmIgNhkqANLD3pcOqJAhR44d1xzEKVfE19TUU
         B364ONaGXDeP5w87wQnnZ8X0GlXwTsskF7BZpWWwkBorUPnZbUSUgwA6AygdLY2+D6qe
         ziXW0Zmfz8mXubSP1900DTlUlg1uuqu8MxHASSLLnze2E0RwFqg8qn1IEu30xj/+m3PH
         aA2SDh0S+tVNIM19Nypxvx4gE0OVFIpXmZWuD6YLtx43I0x1yND2qo3jK82m3vog+VvJ
         G+L0vJjQ8uhbk6VXCwdsCwCoEOuDMkvP2ErdJQU/4wRVRjVMwk0kv3EJP60ywUb+ra7N
         2KkA==
X-Gm-Message-State: AGi0PuY3cnd+02mG2TGPVO3jz+pzhuH/PsiiZRk/kkpdKyj01NUIpL3P
        G05TOVyAwwBPYs6+10Tv2RTHK7/jqEU=
X-Google-Smtp-Source: APiQypKNchaOE6ot5taOOUNgl3Z8z+GYVPXEzgFz1dmxosOo9OHMPnXGr4EpN87kFA2OoZmLG6BE+g==
X-Received: by 2002:a62:f247:: with SMTP id y7mr8794147pfl.200.1588778510702;
        Wed, 06 May 2020 08:21:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h13sm1752842pgm.69.2020.05.06.08.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 08:21:45 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Luis Henriques <lhenriques@suse.com>
Subject: [PATCH 09/10] pstore: Do not leave timer disabled for next backend
Date:   Wed,  6 May 2020 08:21:13 -0700
Message-Id: <20200506152114.50375-10-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506152114.50375-1-keescook@chromium.org>
References: <20200506152114.50375-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pstore.update_ms value was being disabled during pstore_unregister(),
which would cause any prior value to go unnoticed on the next
pstore_register(). Instead, just let del_timer() stop the timer, which
was always sufficient. This additionally refactors the timer reset code
and allows the timer to be enabled if the module parameter is changed
away from the default.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/platform.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 55f46837a7f4..03a17b401533 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -44,7 +44,7 @@ static int pstore_update_ms = -1;
 module_param_named(update_ms, pstore_update_ms, int, 0600);
 MODULE_PARM_DESC(update_ms, "milliseconds before pstore updates its content "
 		 "(default is -1, which means runtime updates are disabled; "
-		 "enabling this option is not safe, it may lead to further "
+		 "enabling this option may not be safe; it may lead to further "
 		 "corruption on Oopses)");
 
 /* Names should be in the same order as the enum pstore_type_id */
@@ -150,6 +150,14 @@ static const char *get_reason_str(enum kmsg_dump_reason reason)
 	}
 }
 
+static void pstore_timer_kick(void)
+{
+	if (pstore_update_ms < 0)
+		return;
+
+	mod_timer(&pstore_timer, jiffies + msecs_to_jiffies(pstore_update_ms));
+}
+
 /*
  * Should pstore_dump() wait for a concurrent pstore_dump()? If
  * not, the current pstore_dump() will report a failure to dump
@@ -460,8 +468,10 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 		}
 
 		ret = psinfo->write(&record);
-		if (ret == 0 && reason == KMSG_DUMP_OOPS)
+		if (ret == 0 && reason == KMSG_DUMP_OOPS) {
 			pstore_new_entry = 1;
+			pstore_timer_kick();
+		}
 
 		total += record.size;
 		part++;
@@ -606,11 +616,7 @@ int pstore_register(struct pstore_info *psi)
 		pstore_register_pmsg();
 
 	/* Start watching for new records, if desired. */
-	if (pstore_update_ms >= 0) {
-		pstore_timer.expires = jiffies +
-			msecs_to_jiffies(pstore_update_ms);
-		add_timer(&pstore_timer);
-	}
+	pstore_timer_kick();
 
 	/*
 	 * Update the module parameter backend, so it is visible
@@ -638,11 +644,7 @@ void pstore_unregister(struct pstore_info *psi)
 		return;
 	}
 
-	/* Stop timer and make sure all work has finished. */
-	pstore_update_ms = -1;
-	del_timer_sync(&pstore_timer);
-	flush_work(&pstore_work);
-
+	/* Unregister all callbacks. */
 	if (psi->flags & PSTORE_FLAGS_PMSG)
 		pstore_unregister_pmsg();
 	if (psi->flags & PSTORE_FLAGS_FTRACE)
@@ -652,6 +654,10 @@ void pstore_unregister(struct pstore_info *psi)
 	if (psi->flags & PSTORE_FLAGS_DMESG)
 		pstore_unregister_kmsg();
 
+	/* Stop timer and make sure all work has finished. */
+	del_timer_sync(&pstore_timer);
+	flush_work(&pstore_work);
+
 	free_buf_for_compression();
 
 	psinfo = NULL;
@@ -793,9 +799,7 @@ static void pstore_timefunc(struct timer_list *unused)
 		schedule_work(&pstore_work);
 	}
 
-	if (pstore_update_ms >= 0)
-		mod_timer(&pstore_timer,
-			  jiffies + msecs_to_jiffies(pstore_update_ms));
+	pstore_timer_kick();
 }
 
 static void __init pstore_choose_compression(void)
-- 
2.20.1

