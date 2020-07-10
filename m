Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16119C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 18:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D83F020720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 18:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TXrXcnxK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgGJSwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 14:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbgGJSwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 14:52:02 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EF0C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 11:52:02 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d10so2618977pll.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 11:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mb9O2vonY58SmLkrA3ALuyeYbHan5/59dl3EopR+4JI=;
        b=TXrXcnxKeeytSI744NwwayynrsSw5XkLlrMUku+ZJ9lCRP+fqO8/uh5+RqffjiJrXE
         z7D39x700Z7u5J8Bvh/KbH0pD3iXeAwzCBsarSibgGL/sMg1qvJ1zb0yDDW5utUeUkus
         sUOunu6eHh9IuBkOdk7DUEOImLHM8qT9H/QuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mb9O2vonY58SmLkrA3ALuyeYbHan5/59dl3EopR+4JI=;
        b=VlLiQHAvNkW/YmVWKn+li8PR5c9QXhrWBiD6ue48YD/ZISA/WSrsYEMNHpNGTEqNw6
         y6sxzUUBgKDNPKOcgcJCwBTmTII3by01lI7nbktns92bIjPxLc9nPqTKvnPp37GUtckp
         IX53LOnLFXTNoNppPQ+FWHlCUN0K9KczNSEW4y6CXkkSYETTys+mqtBMDxIX95NKrgai
         jvQoXV3EjB1BjqOYWDzKjDDGJPnwe6KWdv0v5vTUNPPMBK3b66ydB4Vrf1wXWH3SPYkY
         Z6L/uihY1sPQ+iQLZ3PmIT9qavXOzXN+PnMm+U+/NyyBGN0kvMf4ek0RBcwWDcJ538LH
         Pm0w==
X-Gm-Message-State: AOAM531utUxpxh0/ABGZqroKv6OgLx1gdl03NTVywonk092r7KjxXnei
        NpjW7o+LcJUMwrQT1UAwE6WIQQ==
X-Google-Smtp-Source: ABdhPJyxCk0Y6nYMLmC0PiBcu1x/20ofDeWPHvD1zPrvpGZOML90rH3EEcNAiYpy3Wvvq16rxEVM8g==
X-Received: by 2002:a17:90a:e602:: with SMTP id j2mr6867543pjy.200.1594407121965;
        Fri, 10 Jul 2020 11:52:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o42sm6776191pje.10.2020.07.10.11.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 11:51:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>, linux-kernel@vger.kernel.org
Subject: [PATCH for-next/seccomp 2/2] selftests/seccomp: Set NNP for TSYNC ESRCH flag test
Date:   Fri, 10 Jul 2020 11:51:56 -0700
Message-Id: <20200710185156.2437687-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710185156.2437687-1-keescook@chromium.org>
References: <20200710185156.2437687-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TSYNC ESRCH flag test will fail for regular users because NNP was
not set yet. Add NNP setting.

Fixes: 51891498f2da ("seccomp: allow TSYNC and USER_NOTIF together")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 08bfbb7fc1c2..93de2f1e3a99 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3238,6 +3238,11 @@ TEST(user_notification_with_tsync)
 	int ret;
 	unsigned int flags;
 
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
 	/* these were exclusive */
 	flags = SECCOMP_FILTER_FLAG_NEW_LISTENER |
 		SECCOMP_FILTER_FLAG_TSYNC;
-- 
2.25.1

