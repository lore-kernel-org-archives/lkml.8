Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691F3C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4320C20936
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n0RKQ4Pv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgEFPWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbgEFPVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:21:48 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B775C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 08:21:47 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o18so916049pgg.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 08:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6FPHhltyts4CbjXyjzAz4UzPIGw8eB8kjsShSwpY9GA=;
        b=n0RKQ4Pvfh57lj8l+w7gRc28SobAcNrostqD2b+3d/Tm4/w1v7ec2dpBWqsALFCaFt
         mNozt1CXfQCJueFPxbU9SbxEbBmal9djZSkRG29EyWpcIpiJnPRFfBv+faC+IoD6wKCZ
         8W7sKMBJKZCHAqKJ7fcpJQw0TyKK/+SUh65Oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6FPHhltyts4CbjXyjzAz4UzPIGw8eB8kjsShSwpY9GA=;
        b=bAeoCmeNYTrmIcSYWQJlYHvlrQB2A4Wn4iVXM/dyxuotn60Tk7jayu+8Jw28Y02XF5
         Prz5P5if9N1SQ/hF4zh8g54bLmYc1zquS0GhnYL56jCTiLOPIXIxa/MsPvcta0bwfLtw
         V6hfv6jiRibRiG868EcAx2o5w8EeXzgDJ2JUIEOU3PsCpgW/meZyYrN46Os1/ojL0ERd
         eESLIRe+fty+rL6GN7jPFfwZlXrrFS1s9Ef8lfohqtjxVoiJA2Sd26XrSdCcxr5iR63T
         s7dXLndztx4Za6lMRH0vJxKLSGWUdhf2GSVxrxYFakB3rqu9QGJzlVQ4m7LQmgPOMJjH
         Yg1A==
X-Gm-Message-State: AGi0PuZZEtzvXtgwXMIIiqMcIWVu3OFIt58MJcuf9E1+nOaUDBjjyldj
        doyEcRq/h3caq6g8MZMTRyh/Mg==
X-Google-Smtp-Source: APiQypLh9RvGoT0iwrPdwog7Mjn6D6HHWosykg+YX13mR5pqaXMKMBjVJQn6T/AVtBF9pPq01E4uTA==
X-Received: by 2002:a62:1bd0:: with SMTP id b199mr8648232pfb.283.1588778506852;
        Wed, 06 May 2020 08:21:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a2sm2130015pfg.106.2020.05.06.08.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 08:21:45 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Luis Henriques <lhenriques@suse.com>
Subject: [PATCH 06/10] pstore: Add proper unregister lock checking
Date:   Wed,  6 May 2020 08:21:10 -0700
Message-Id: <20200506152114.50375-7-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506152114.50375-1-keescook@chromium.org>
References: <20200506152114.50375-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pstore backend lock wasn't being used during pstore_unregister().
Add sanity check and locking.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/platform.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index d0ce22237589..03bc847a6951 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -69,8 +69,9 @@ static void pstore_dowork(struct work_struct *);
 static DECLARE_WORK(pstore_work, pstore_dowork);
 
 /*
- * psinfo_lock just protects "psinfo" during
- * calls to pstore_register()
+ * psinfo_lock protects "psinfo" during calls to
+ * pstore_register(), pstore_unregister(), and
+ * the filesystem mount/unmount routines.
  */
 static DEFINE_MUTEX(psinfo_lock);
 struct pstore_info *psinfo;
@@ -626,6 +627,18 @@ EXPORT_SYMBOL_GPL(pstore_register);
 
 void pstore_unregister(struct pstore_info *psi)
 {
+	/* It's okay to unregister nothing. */
+	if (!psi)
+		return;
+
+	mutex_lock(&psinfo_lock);
+
+	/* Only one backend can be registered at a time. */
+	if (WARN_ON(psi != psinfo)) {
+		mutex_unlock(&psinfo_lock);
+		return;
+	}
+
 	/* Stop timer and make sure all work has finished. */
 	pstore_update_ms = -1;
 	del_timer_sync(&pstore_timer);
@@ -644,6 +657,7 @@ void pstore_unregister(struct pstore_info *psi)
 
 	psinfo = NULL;
 	backend = NULL;
+	mutex_unlock(&psinfo_lock);
 }
 EXPORT_SYMBOL_GPL(pstore_unregister);
 
-- 
2.20.1

