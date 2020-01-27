Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6B3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 19:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB272467F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 19:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i9rSgBNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgA0TgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 14:36:21 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:40852 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgA0TgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 14:36:20 -0500
Received: by mail-pj1-f73.google.com with SMTP id ev1so4643015pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 11:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aJSm85atyJnx3aV4XPhE+g3+E/dOnaGn6esbhO+jJI0=;
        b=i9rSgBNIxezXPNrIZBLBWaZ68vA2x6JkVm3NwUao1U2o8TMtQzX5PgavtMtNsEhRJA
         n65HaX89soVklGfFrqwsBeACCt7X6G4eW0Xplt7Eh5NlIrL9IAcOWf5OwUcjjzoM1l69
         RbCgK+SLmK+feNuDXLwqkdm7aYoTirSUubKAojSlY3U9rOZ0moGCxuHpoam3sfjEt7LW
         6zkqi4E/pJ0MLuvUJrYAPZA4KlRlfkcmCW3v+L2vosOLEhQaXnsr0mEM2ktpkPdw1J1r
         75LHvA3aoP8DFei9T7jimGok+SFDX5BhppLZJyta/+nvtYGKMtKqjNAbMK97KJ23LeAd
         xjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aJSm85atyJnx3aV4XPhE+g3+E/dOnaGn6esbhO+jJI0=;
        b=udeIqzvuYSlYpbXGZfApBnixmO4K9Lff8PNF2A3qXv/u+XjpxgB0vfPIQNDqNVTZLZ
         O86rRC6i4oi9qygn5+aqrOQCWSUnBiJPpaSdsA2FNX1m9mKWDVdhEI4WpYJA4uq2oUz7
         1Z5olnT0irnSvlBVcF3fwLpM++07sdC33ey/80nh1d90HB/MIvDdoAdcLSWJY8sHrzam
         zWElnX5C/s2HMXm9O0+uj2fmPUBxG54Fbuwf0BPN76g/NGoVxe9coL8KclIfCsLwO5zN
         S5qxZnrY2/1+KOjOQJyqG84QPNgA6CvKNCnCotwxcXfk5Cbz2oywB4frw41GcrF5ggS2
         fBSA==
X-Gm-Message-State: APjAAAWnIIgylfFbfa4UZgqw4VW0GJ8yiNavfHExbB6meCAKB2k/WdlN
        7tNuZA65LVLG9XW6vWSqWEbrfEy2HNuUAvrt6Ptnfw==
X-Google-Smtp-Source: APXvYqx9pC2152Lu4FZNg/IOp3Cj3cc0+Gbq3g83KkqaaPhmlvpxER9ACv7DQBzKaGqCe/nHonqQCN7/GAI1hHq/dImN6A==
X-Received: by 2002:a63:6e0e:: with SMTP id j14mr20400073pgc.361.1580153780074;
 Mon, 27 Jan 2020 11:36:20 -0800 (PST)
Date:   Mon, 27 Jan 2020 11:35:48 -0800
In-Reply-To: <20200127193549.187419-1-brendanhiggins@google.com>
Message-Id: <20200127193549.187419-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200127193549.187419-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [RFC v1 1/2] kbuild: add arch specific dependency for BTF support
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        akpm@linux-foundation.org, changbin.du@intel.com,
        yamada.masahiro@socionext.com, rdunlap@infradead.org,
        keescook@chromium.org, andriy.shevchenko@linux.intel.com
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        davidgow@google.com, heidifahim@google.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some archs (like UM) do not build with CONFIG_DEBUG_INFO_BTF=y, so add
an options for archs to select to opt-in or out of BTF typeinfo support.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 lib/Kconfig.debug | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e4676b992eae9..f5bcb391f1b7d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -238,9 +238,12 @@ config DEBUG_INFO_DWARF4
 	  But it significantly improves the success of resolving
 	  variables in gdb on optimized code.
 
+config ARCH_NO_BTF_TYPEINFO
+	bool
+
 config DEBUG_INFO_BTF
 	bool "Generate BTF typeinfo"
-	depends on DEBUG_INFO
+	depends on DEBUG_INFO && !ARCH_NO_BTF_TYPEINFO
 	help
 	  Generate deduplicated BTF type information from DWARF debug info.
 	  Turning this on expects presence of pahole tool, which will convert
-- 
2.25.0.341.g760bfbb309-goog

