Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF95FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAB2D206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mha/1v4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgFPHuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgFPHts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:49:48 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DFDC08C5C6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:49:45 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id s23so9104428pfh.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aNHAhNI6ZTS0Tgwm1Tz8nA62WMbjyUFexQ8Av4x5DPE=;
        b=Mha/1v4ZCwL99EzxQ318yAgdODuTalg/C5a5af5exiokd8c5p7ofhUjPq9F2KXq+2Z
         y7yP3+k5eNCRMrakWOPlm6eIxB24HvrLbf760fTeCcQu5b/qlXMhpecyVB/F0VkMtoBL
         zMVf+teQCmyVijKGcfvhfnSjCaUXm3PFBJyUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aNHAhNI6ZTS0Tgwm1Tz8nA62WMbjyUFexQ8Av4x5DPE=;
        b=iqOJ8GEF6nE6aw4SJE1acko/ZkfzEoWTh6NW/gzmzCirSW/xXK6zNxoIS+AMQygXXg
         olbqj0+Cl8uE4TtYcqr9xYQ/3ifr9SRzO7yGhoV0WnVc5Xb1znLllOwkk5xX1uHaI4Bt
         yzPTf5Rc2frc9B1xbLpP/OjspnQ+T56UfUe2tTdEHnU9/Y6DowaOTDHGNR8HMJFpv7AY
         aUsjx0vd1eCpQe9M0oRrb6iRO77zUFeQVJBV6rvXDmAP29cVZopfyczfF78ekKNa1MGb
         P3+3k7iopVoKd5A3Lhe//ZuO1iXQZK83DZnVYUpb+E5i+z9W0xmTTAreyPG0H1/7OO0f
         XRuA==
X-Gm-Message-State: AOAM532WH/kAsNZRQs3cLn0QEfTNNx3n9j1xInV1+asS7FF9hJ0oODnc
        FeUGAAk+hw97F9IbW3HbjvxfiQ==
X-Google-Smtp-Source: ABdhPJxI3CY4yrnJgeIk7sRjLPfxIjZxfINYy/6N9uGIlb1gaIy+PlZdT78JgpuwV7WO9L49REPdQw==
X-Received: by 2002:aa7:972b:: with SMTP id k11mr1003541pfg.299.1592293785373;
        Tue, 16 Jun 2020 00:49:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t76sm14171409pfc.220.2020.06.16.00.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:49:42 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Hehuazhen <hehuazhen@huawei.com>, x86@kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 2/8] seccomp: Use pr_fmt
Date:   Tue, 16 Jun 2020 00:49:28 -0700
Message-Id: <20200616074934.1600036-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200616074934.1600036-1-keescook@chromium.org>
References: <20200616074934.1600036-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid open-coding "seccomp: " prefixes for pr_*() calls.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/seccomp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 0016cad0e605..a319700c04c4 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -13,6 +13,7 @@
  * Mode 2 allows user-defined system call filters in the form
  *        of Berkeley Packet Filters/Linux Socket Filters.
  */
+#define pr_fmt(fmt) "seccomp: " fmt
 
 #include <linux/refcount.h>
 #include <linux/audit.h>
@@ -1873,7 +1874,7 @@ static int __init seccomp_sysctl_init(void)
 
 	hdr = register_sysctl_paths(seccomp_sysctl_path, seccomp_sysctl_table);
 	if (!hdr)
-		pr_warn("seccomp: sysctl registration failed\n");
+		pr_warn("sysctl registration failed\n");
 	else
 		kmemleak_not_leak(hdr);
 
-- 
2.25.1

