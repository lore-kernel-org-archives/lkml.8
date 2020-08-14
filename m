Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCF8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52F1B2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MpeccDbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgHNR2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728703AbgHNR2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:28:10 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D716C061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:10 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id j2so3610474wrr.14
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zi4RvguO5V6krMCBAUSDmKnZjdOOk8JOKWNtsbuVl1k=;
        b=MpeccDbAmyi9zM+1C8dkn9B/K4wceTNQ+tgcRDm6+AgQur9nWRGo8BEGb8+vArokqc
         IW2bWkZP3jiKyf9bYyFJBUkxRKVAf2Q++mSmPf6yMZGRtTtBdzg3pRP6EQFuJXfkLvpX
         eB+KAJ1HEYfvJOrMIUN4mgwLwhTY0ol+7kOJqYVCAIGbkauE3yWAQuQZYOvYx3rSLbhl
         NmUGdNfY8bwRRHD1QQ03HPw64mDJ8yz0ultoUUq2xTqHAKzpqdv7kojqWmoGjQkfzwuc
         0ynqhDy7TcxwWoXQTproKjfj5IP6dX/0XwWTdaSRRnQ3wR7gGzf+ZlydxaY0zVve9rQf
         oFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zi4RvguO5V6krMCBAUSDmKnZjdOOk8JOKWNtsbuVl1k=;
        b=k+wMiZoGWcYbVLlxug7qPOyCtjNp/48mO/qNf6M0kTB7NRCMPbhlAeLVr3H8YWRrtH
         fJKz2krprF19zQUv156VozNQRwVxXV2PVly+bBKEqkYu7JxnxyRF+9QhgG8ADnDLW3Nz
         //eRj1BT4dQP/m0hcCNqflQCmi3fB6L2ro8MDWh9NRzAbke3GAcmWQfwdj1M4gZTEqPV
         h94Omn39I+hcombJ6injT2CPDs6ElBcajPQmK82zM5qUo3Nt020VWpUGf4/znAzcj5IS
         LuoLS7IRJk++SGGDAxw4SXdb9B1PXhtJkyFiWe/2guLIgSYMayGPxXoPnKGdSldmePUq
         btoA==
X-Gm-Message-State: AOAM533URDkS1MTiUBbTZc9W4e3D6nXjskRVdePltFInNJaeg5nY8/CY
        aJUXPMATLa2LE7A9rhZvTN95Ut9UoEVXvF17
X-Google-Smtp-Source: ABdhPJzq9OwNzATVl4TndqLv6+0Tp14X5TVHCU7ZPirTCFmbUTEDo8lEUat6Xbd7IquaS/4zCQSouYUdw0JF7qhI
X-Received: by 2002:a7b:c219:: with SMTP id x25mr3405298wmi.101.1597426088961;
 Fri, 14 Aug 2020 10:28:08 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:27:01 +0200
In-Reply-To: <cover.1597425745.git.andreyknvl@google.com>
Message-Id: <5185661d553238884613a432cf1d71b1480a23ba.1597425745.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 19/35] kasan: don't allow SW_TAGS with ARM64_MTE
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Software tag-based KASAN provides its own tag checking machinery that
can conflict with MTE. Don't allow enabling software tag-based KASAN
when MTE is enabled.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/Kconfig.kasan | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index b4cf6c519d71..e500c18cbe79 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -69,6 +69,7 @@ config KASAN_GENERIC
 config KASAN_SW_TAGS
 	bool "Software tag-based mode"
 	depends on HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS
+	depends on !ARM64_MTE
 	help
 	  Enables software tag-based KASAN mode.
 
-- 
2.28.0.220.ged08abb693-goog

