Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A4EC54E49
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 20:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93BD8206F5
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 20:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vu8u0y3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbgEJUYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 16:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729227AbgEJUYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 16:24:43 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C20C05BD09
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 13:24:43 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a5so6763068pjh.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 13:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a6bXV7bt3FJwO+6h7hS9wdbWbj+cKT2R8klgQdvy5V4=;
        b=Vu8u0y3g/EsMOqGf92rFyvezCvoeKBq6M4OIMjHDXZQuVY5ATlo2kh28eB6tVdSW2u
         HeG9wciptveXO5MHRNtJSHj4Ogkp9s7OktTbZhn/Vvp42lUU1KrIa9rIQ0bGpNOCOKeO
         EC9TBt8Z9Lh9M/kLz05YI4DHvIcGjrjtQpGgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a6bXV7bt3FJwO+6h7hS9wdbWbj+cKT2R8klgQdvy5V4=;
        b=rbvQ4eLLiMkD81JjW1viU32/EGpbyFpsn2fQdTCWEgsesrUuT13Fr2VEXhHQgybZpW
         QJIsAANHjF3smLGvWh7KMe6vbpDkIkFnidk9QHwlk3RrvoeWRMX5sib9SYsK45ds2lbh
         vgW3jFOE/hMg9vnxeccUktJCqQgitVUtfFCzJXxugJFB05VAxXq+wFVt61nlliyTRylh
         13wFVK8wIlcXsMYk27ZsRjlcwZoyrQXYDl+oyni4xezSPonP216ZZDefah1gbBwn3pza
         gJItbrkLkeTjJ/hHbSWr0R+XclbrpZRT952kxWcr8IsWELjlYt9AopiaePlJ8Cg2IAyz
         GAsA==
X-Gm-Message-State: AGi0PuYw12CbfpBkf8VFDNlUJMnFyYGf+wdS+pLO+8moQVQc0VoS2lkJ
        PJuK8J4oT/T3Gt/zCADoGWR8xQ==
X-Google-Smtp-Source: APiQypL4ftL5PXuI6WbPG1D/aF+OyzdmBrwXgZqbvh107ELfxtW4oGZxzd33g34wmpY9M28zk4hvsQ==
X-Received: by 2002:a17:90b:374e:: with SMTP id ne14mr17664828pjb.145.1589142283365;
        Sun, 10 May 2020 13:24:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y6sm7866882pjw.15.2020.05.10.13.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 13:24:41 -0700 (PDT)
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
Subject: [PATCH v7 02/18] pstore/platform: Switch pstore_info::name to const
Date:   Sun, 10 May 2020 13:24:20 -0700
Message-Id: <20200510202436.63222-3-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200510202436.63222-1-keescook@chromium.org>
References: <20200510202436.63222-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to more cleanly pass around backend names, make the "name" member
const. This means the module param needs to be dynamic (technically, it
was before, so this actually cleans up a minor memory leak if a backend
was specified and then gets unloaded.)

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/platform.c   | 3 ++-
 include/linux/pstore.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index b882919b8784..e7bf22f01928 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -626,7 +626,7 @@ int pstore_register(struct pstore_info *psi)
 	 * Update the module parameter backend, so it is visible
 	 * through /sys/module/pstore/parameters/backend
 	 */
-	backend = psi->name;
+	backend = kstrdup(psi->name, GFP_KERNEL);
 
 	pr_info("Registered %s as persistent store backend\n", psi->name);
 
@@ -669,6 +669,7 @@ void pstore_unregister(struct pstore_info *psi)
 	free_buf_for_compression();
 
 	psinfo = NULL;
+	kfree(backend);
 	backend = NULL;
 	mutex_unlock(&psinfo_lock);
 }
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index 16a1fdafc167..eb93a54cff31 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -176,7 +176,7 @@ struct pstore_record {
  */
 struct pstore_info {
 	struct module	*owner;
-	char		*name;
+	const char	*name;
 
 	struct semaphore buf_lock;
 	char		*buf;
-- 
2.20.1

