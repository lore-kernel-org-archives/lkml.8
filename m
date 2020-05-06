Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7972DC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5312F2080D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KwX6/DXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgEFPVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728821AbgEFPVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:21:43 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E492AC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 08:21:42 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id y6so1061254pjc.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 08:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0GrsnLomqX5Yv3Tom3gIH7C/pCQ9LgRpoJPzGqJICzI=;
        b=KwX6/DXeNIsWsWlTUx2Lg/+bGBqtRwjeQ/X4DL9YgbOhA9d/lBCEIBp3b/fQ0YELmd
         mpAXQ5mJx36IzvHTcFqzSez/beBvtlCZ/ax0p/OKpzb4sYSZw6NEdMJcdB1uR5fwMtGX
         rlKVbttCR4kfIy8VdJPR8LCi8kESkUr09VpFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0GrsnLomqX5Yv3Tom3gIH7C/pCQ9LgRpoJPzGqJICzI=;
        b=hj2yk4iSPqQJ6ddhR3+gtW1zHQXXgyANrKKyotJ1lB32wWA7qi3k5ItPreAlJePPHQ
         6zlhR0f8vQ5hI9Sjo1bcnHIl4AabulkJj08vtTQGKli04QlHNQ96o9yNutzMW1leP3uP
         ZxKYPLYE1jyCSCcw+KkANCfF7lDpDVTzOKU1wu15l/yClfHTZ8HOZpDgHmlsnPn2zaeu
         H8pMpwn42j34gRicDbZpWi5p6R7aMCNY/TvZt+We4tSq6lVq23tC5OAR+Sdr9v7cX5dh
         vlsDzixIk1dxWW8SJZPiCgMcj83R788ux+tbwJJtGwYsPu4AgF7Ybke3dTevyukFrsz6
         +qrQ==
X-Gm-Message-State: AGi0PuZKwXasLQ2ejgfFCltzQOwSUvuXlz9r4gr8DBbCsZu+Ok7dxTT7
        rLk+6IsHeUIaxBi6rErycdU0UzUNn8c=
X-Google-Smtp-Source: APiQypL1hTpo9FfJpbePD6l9WWohDd139O1SoPM9Xu90TAINWMR+B4rfGx5aoPGQ2ExTdUcYl6HEIQ==
X-Received: by 2002:a17:90a:1941:: with SMTP id 1mr9515679pjh.65.1588778502424;
        Wed, 06 May 2020 08:21:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a22sm2085212pfg.169.2020.05.06.08.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 08:21:41 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Luis Henriques <lhenriques@suse.com>
Subject: [PATCH 01/10] pstore: Drop useless try_module_get() for backend
Date:   Wed,  6 May 2020 08:21:05 -0700
Message-Id: <20200506152114.50375-2-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506152114.50375-1-keescook@chromium.org>
References: <20200506152114.50375-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to be doing a module get/put in pstore_register(),
since the module calling pstore_register() cannot be unloaded since it
hasn't finished its initialization. Remove it so there is no confusion
about how registration ordering works.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/platform.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 408277ee3cdb..44f8b9742263 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -555,8 +555,6 @@ static int pstore_write_user_compat(struct pstore_record *record,
  */
 int pstore_register(struct pstore_info *psi)
 {
-	struct module *owner = psi->owner;
-
 	if (backend && strcmp(backend, psi->name)) {
 		pr_warn("ignoring unexpected backend '%s'\n", psi->name);
 		return -EPERM;
@@ -591,10 +589,6 @@ int pstore_register(struct pstore_info *psi)
 	sema_init(&psinfo->buf_lock, 1);
 	spin_unlock(&pstore_lock);
 
-	if (owner && !try_module_get(owner)) {
-		psinfo = NULL;
-		return -EINVAL;
-	}
 
 	if (psi->flags & PSTORE_FLAGS_DMESG)
 		allocate_buf_for_compression();
@@ -626,8 +620,6 @@ int pstore_register(struct pstore_info *psi)
 
 	pr_info("Registered %s as persistent store backend\n", psi->name);
 
-	module_put(owner);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pstore_register);
-- 
2.20.1

