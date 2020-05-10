Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB19C54E8C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 20:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D630206F5
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 20:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M/cJvL8h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgEJUYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 16:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729227AbgEJUYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 16:24:45 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D43C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 13:24:45 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r10so3061341pgv.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 13:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ftIoYymBGMn0ProUbxAIjGCP6irGe3xnecuHwaJ2BU=;
        b=M/cJvL8hlN3LxOR7YqQKrAGHR739tSJqQTIBdmpAhjDy0nybQzRtcOtAPrHiKVhUKj
         hsB2XqjX4rZjw8Kbgv6P7obB7m7yi8bCOQa2muYfgmO3VhYbWa1JIbtFntpsUdFnBvpg
         z2URti78Yz+e3DuPLhwr8YZHxwRBn4DNVm9MI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ftIoYymBGMn0ProUbxAIjGCP6irGe3xnecuHwaJ2BU=;
        b=A8fHXJTZDUpGOaAhAkjWYE8lHyHbTbNFEXpADpdLbFLTCrKZ2W+x5I9rLxggJq3H2V
         /LKxN9Cd3Tvbtuh2nqgbNC99tSowULx9sfOKH3N2O6ZO7o9ifOVOFu88DN++rsWq1Wdk
         CmUOOYCaU26W6uVUIfd0K5SUJpe8eE6hJE1lf+XNys0WtW+86x4JktJOKF6PlJHNpnj0
         UPJ4jDLGb8UohzmXEZSZfZXybuIBa0DTBqxKRksXFP6YMfsmEPW1jmIorx7Ug0RuGwvp
         szTdx7r/d6rZkJ/z6u09dVu1u4m0/fU+Jw2tuPJLpOAYI1LRpKsvkPMlhfrUWD+2zBRQ
         Wzow==
X-Gm-Message-State: AGi0PuYHxgRXIQpvxTBKAoCdnjFbXuPtQWogTCQHxPmb01qjimEfdBfO
        E9/SOKOydkkwgt4irGfMKFNodg==
X-Google-Smtp-Source: APiQypKkKbidaXA2M8XJ6HvdzKsXRV/+gbI2nQYSE78Rxu8a98OLbZfjBGurl33BBe6rQc0sYAewRw==
X-Received: by 2002:a62:2cd7:: with SMTP id s206mr12711308pfs.183.1589142284913;
        Sun, 10 May 2020 13:24:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n9sm8014797pjt.29.2020.05.10.13.24.41
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
Subject: [PATCH v7 04/18] pstore/platform: Use backend name for console registration
Date:   Sun, 10 May 2020 13:24:22 -0700
Message-Id: <20200510202436.63222-5-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200510202436.63222-1-keescook@chromium.org>
References: <20200510202436.63222-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the pstore backend changes, there's no indication in the logs what
the console is (it always says "pstore"). Instead, pass through the
active backend's name.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/platform.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index bf7fa7b278bd..90d146fbc7d2 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -519,13 +519,15 @@ static void pstore_console_write(struct console *con, const char *s, unsigned c)
 }
 
 static struct console pstore_console = {
-	.name	= "pstore",
 	.write	= pstore_console_write,
 	.index	= -1,
 };
 
 static void pstore_register_console(void)
 {
+	/* Show which backend is going to get console writes. */
+	strscpy(pstore_console.name, psinfo->name,
+		sizeof(pstore_console.name));
 	/*
 	 * Always initialize flags here since prior unregister_console()
 	 * calls may have changed settings (specifically CON_ENABLED).
-- 
2.20.1

