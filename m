Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4FDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 21:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D91207D3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 21:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0DdLWIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgFDVCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 17:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgFDVCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 17:02:14 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66295C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 14:02:14 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r10so4049752pgv.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 14:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UbOCf4CZQIjVvKPTW34WUTuN7W9J+r0FOwoqsB6YilE=;
        b=K0DdLWIKVytyVtUrmZ92o+Ycscu+97VU7haUaI+y6Zq16y7xltTRU/mQuG+yaHpm1j
         bEU+TZ+8WCxha7p2fVQj1HuS470kqdd4xBO6b2vzWncC/nriKYPWrQj4wOdEy5xQ0itt
         aDjCVQ+CN1/WsouzHRYrHbAKNCu1FpuLnLJDJdFZPbocGfws1Z+B1i44arYQbWH9pbYV
         Gg7cyYgM1husWWdm4E7XhV0Ux7V5elDeFqqgGlToBXESd3z0+AwMdg1x6sM+83PapCsi
         UqGa5Z4XOFFi61jFqNWHVW/bbljF/bbFfj7zFQg3+uNuW701/gJa5P5ShrJNmRBdfJOl
         9zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UbOCf4CZQIjVvKPTW34WUTuN7W9J+r0FOwoqsB6YilE=;
        b=itqNDmPXNSmYsxhkPhJyIoUk8f+cEg6sX7id7pEJ1v7/lV1kwBhW/GLoRJXp8euGZa
         cf5a1cOFw+4b/nZ4O8CqYQcjC4MIsWY8TW0xD6MC0kgQAawJrGIXuGrsL4aj/AAwhRIB
         KJBsL5qF3J/3f3TDzXmR2D0jmdwZhNN/ZILPws1u39TafGD/RYrz46uS+rfvNB+Gj3ya
         uiu7qgUXfAmypHxL8gbfWGL11m2e7xtLP8lBIWNsCLLHuT+/WVzZsk5MB1lGHV8CcSq2
         jLW8Vn3CaKsJIASmJbWiUXIH0iCmTe9uM071tiRhmmifNcX/9RHzR/dG2ZsT3PdhvWwq
         cHKA==
X-Gm-Message-State: AOAM530UMtJJEoZiGkx/s8gA2JbQcuN5qaYofu42ouhTujnRryCTyPrA
        JnC85+rdIj2e8FJTLWSEugsadDkS
X-Google-Smtp-Source: ABdhPJydDJDXbMaoUwR2gUPbmUV6QoArZAoFJ+0cy0ZUpo6/BiqqpeKAKFyMnv1kdLzrCJjJ9R0DIA==
X-Received: by 2002:a05:6a00:801:: with SMTP id m1mr6223073pfk.200.1591304533827;
        Thu, 04 Jun 2020 14:02:13 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:7571:e536:944d:12bc])
        by smtp.gmail.com with ESMTPSA id l63sm5617281pfd.122.2020.06.04.14.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 14:02:13 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] kernel/modules: fix build without ARCH_HAS_STRICT_MODULE_RWX
Date:   Thu,  4 Jun 2020 14:01:15 -0700
Message-Id: <20200604210115.16826-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On configurations with CONFIG_ARCH_HAS_STRICT_MODULE_RWX disabled kernel
build fails with the following message:

  kernel/module.c:3593:2: error: implicit declaration of function
  ‘module_enable_ro’;

Add empty module_enable_ro definition to fix the build.

Fixes: e6eff4376e28 ("module: Make module_enable_ro() static again")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 kernel/module.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/module.c b/kernel/module.c
index bca993c5f1bc..a74a29001814 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2038,6 +2038,7 @@ static void module_enable_x(const struct module *mod)
 #else /* !CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
 static void module_enable_nx(const struct module *mod) { }
 static void module_enable_x(const struct module *mod) { }
+static void module_enable_ro(const struct module *mod, bool after_init) {}
 #endif /* CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
 
 
-- 
2.20.1

