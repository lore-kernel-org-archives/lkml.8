Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16129C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 04:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E350D20773
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 04:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rshZLHgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgG0EI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 00:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgG0EIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 00:08:25 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FF7C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 21:08:25 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ha11so1162566pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 21:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tarpEr+y8dvf5YqqJhNCEMeOnj/wqkO4uosi6NOPsXg=;
        b=rshZLHgYTPzlmsZXSvPSsEIrxd5T489BxOj61781QgMqSkYUPT4A4/kAhvnmqcgogY
         /JksjEVS06HNdYfaO1hXnCAT1RvYj2zAkqVru5c2iJJPw/UYGQgO9FyB0wdtTcKkqezE
         wXDZOdQU1C2VlMfEdu81AqVEaGwgOYimnckE0mRArsHSPzd7ZNedFyx4wM9jGLScgC7P
         E6QcVggCqZ4E+bhpXmLfktROTO7YvWpVoFT8h02IPPl5AcFVGdRrZzNVTS17wc4Zm+yh
         aucElyh/WIhywiJWaHw3oG5x2YVgqkHFjp0itMHmgNbsQuF7p3kp2RuuIrppOmg9A02h
         DgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tarpEr+y8dvf5YqqJhNCEMeOnj/wqkO4uosi6NOPsXg=;
        b=FSm6wX/X6OEYQ90t+n3DiExsGSGQB0kEJgZ6qGXO6a9J6KOxDxrD6oGCBsCWRXRo4l
         j5Dtza95j/gNbn0NmNX6P6VxQm39HrfiGbXkgTrv3abVbq7NjCasmWET15XJnWdwooRy
         2MmUz8PeGDD/mGCdQCs1MsxITsd9OCuJmYJJE4AoM0laPOxcQHTBzCVO0KC6d8gF8XeU
         D/73rri6oXJgnY+t37hxzWfWUmN6+SGFB5/n+o2JHVtdl88G7eBvSIc0dcDXTm79f5RR
         qi9hebItuBgilrhrgq3/zuGojTmV+/izIv+iO9+6UmcF/sYuNuR7K5AKBLwojysTjqo1
         hBYg==
X-Gm-Message-State: AOAM531U/C7/TqWsOKFZqF4vVv6gOJlZ+9YTFdyy02dgIkPnIUhhDpo0
        npxckIpYN5SqZg6VxhKxWxCw+Tj9OdjuPw==
X-Google-Smtp-Source: ABdhPJx22dIbQOJlX/lm/yfMB1qi9la3wa+EpGz5z5H1wq7NEGPPdDA5VM7qqDSfPOBzu591GV+6Ew==
X-Received: by 2002:a17:90b:2056:: with SMTP id ji22mr15966274pjb.61.1595822905151;
        Sun, 26 Jul 2020 21:08:25 -0700 (PDT)
Received: from glados.lan ([2601:647:4c01:6541:fa16:54ff:fed1:1bd6])
        by smtp.gmail.com with ESMTPSA id e129sm6542501pfe.94.2020.07.26.21.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 21:08:24 -0700 (PDT)
From:   Thomas Hebb <tommyhebb@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Hebb <tommyhebb@gmail.com>
Subject: [PATCH 2/3] tools lib api: Get rid of useless conditional assignments
Date:   Sun, 26 Jul 2020 21:08:15 -0700
Message-Id: <2bd8fdf9c54d336f5c47383b545c79e64c794c0a.1595822871.git.tommyhebb@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <0a6e69d1736b0fa231a648f50b0cce5d8a6734ef.1595822871.git.tommyhebb@gmail.com>
References: <0a6e69d1736b0fa231a648f50b0cce5d8a6734ef.1595822871.git.tommyhebb@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conditional assignment does not work properly for variables that Make
implicitly sets, among which are CC and AR. To quote
tools/scripts/Makefile.include, which handles this properly:

  # Makefiles suck: This macro sets a default value of $(2) for the
  # variable named by $(1), unless the variable has been set by
  # environment or command line. This is necessary for CC and AR
  # because make sets default values, so the simpler ?= approach
  # won't work as expected.

In other words, the conditional assignments will not run even if the
variables are not overridden in the environment; Make will set CC and AR
to default values when it starts[1], meaning they're not empty by the
time the conditional assignments are evaluated.

Since the assignments never run, we can just get rid of them. CC and AR
are already set properly by Makefile.include using the macro mentioned
in the quote above. In addition, we can get rid of the LD assignment,
because it's also set by Makefile.include.

[1] https://www.gnu.org/software/make/manual/html_node/Implicit-Variables.html

Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
---

 tools/lib/api/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
index a13e9c7f1fc5..5f2e3f8acbd0 100644
--- a/tools/lib/api/Makefile
+++ b/tools/lib/api/Makefile
@@ -9,10 +9,6 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
 #$(info Determined 'srctree' to be $(srctree))
 endif
 
-CC ?= $(CROSS_COMPILE)gcc
-AR ?= $(CROSS_COMPILE)ar
-LD ?= $(CROSS_COMPILE)ld
-
 MAKEFLAGS += --no-print-directory
 
 LIBFILE = $(OUTPUT)libapi.a
-- 
2.27.0

