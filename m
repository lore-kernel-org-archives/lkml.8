Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26263C54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BE8221EB
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jOtKOWyT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgCYP1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:27:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36181 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbgCYP0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:26:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id g62so3190510wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 08:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gr2YowP7xZurwhXRmAY/lGUCfPPt09BjXH0RtGSlGeM=;
        b=jOtKOWyTFlnI/HR751jZDGLmFII6PtQqnMWGGc6Kuplu+oLGGOyoVx/n2KE9AEXfa7
         S7Q8DjwzxNI5Dfx0qEYkavRH2hNu9bmEzzUZFSVfmmJw1Ox0SZ3iel47ilMw1cLL+ETj
         R8OXrs1soxud01CII8flpnkTsDNk6QMVRbGkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gr2YowP7xZurwhXRmAY/lGUCfPPt09BjXH0RtGSlGeM=;
        b=afx+5A//kAOWkHaBG0TOxqphfJi1NH4KHOaFHTNO+anpMswBrTIVlwebLhOsWXdQEY
         d1qt+0W3GEkUwW90/o1yc/SLOjUiw8cBU4HAjE2PmDKu6PglktyjcmzV01+5uEFQt2q/
         plY6isdPBAXrBhvwHW8JpCSiwu0avtUpI+3NtSSHNoxjFrOOknKonZVGTtnzWD5DnijB
         PbX7StUae8HZK+SqFeU8RInfqHOaKSiGcJdQAiCsnGLJoWnDfzZl6bMJeC7LGwTpgZ/l
         z7PUM51srAB8SK755yu+iIKO3gVRqXtp2v4OkXypnX1OSnqfI19qNRwgxvaazVz6jei/
         Duag==
X-Gm-Message-State: ANhLgQ3ggJ6y4sT2sFeqbKaqt41n3cN678/ip3cL8SJV/jEmtUjqN+Ni
        rMI1X3zmMimOpMARpEWJOLXY5HxbhHQ=
X-Google-Smtp-Source: ADFU+vvy259BxeGiK8c7t1ayuKqsAgNDwtV6vzhjuhUBg/FiqUoeBqmrE08UcneZC4pHHld1lJDKpw==
X-Received: by 2002:a1c:df07:: with SMTP id w7mr3820469wmg.7.1585150000943;
        Wed, 25 Mar 2020 08:26:40 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id a2sm4033701wrp.13.2020.03.25.08.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 08:26:40 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Kees Cook <keescook@chromium.org>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH bpf-next v6 3/8] bpf: lsm: provide attachment points for BPF LSM programs
Date:   Wed, 25 Mar 2020 16:26:24 +0100
Message-Id: <20200325152629.6904-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325152629.6904-1-kpsingh@chromium.org>
References: <20200325152629.6904-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

When CONFIG_BPF_LSM is enabled, nop functions, bpf_lsm_<hook_name>, are
generated for each LSM hook. These functions are initialized as LSM
hooks in a subsequent patch.

Signed-off-by: KP Singh <kpsingh@google.com>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf_lsm.h | 22 ++++++++++++++++++++++
 kernel/bpf/bpf_lsm.c    | 14 ++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 include/linux/bpf_lsm.h

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
new file mode 100644
index 000000000000..83b96895829f
--- /dev/null
+++ b/include/linux/bpf_lsm.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (C) 2020 Google LLC.
+ */
+
+#ifndef _LINUX_BPF_LSM_H
+#define _LINUX_BPF_LSM_H
+
+#include <linux/bpf.h>
+#include <linux/lsm_hooks.h>
+
+#ifdef CONFIG_BPF_LSM
+
+#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
+	RET bpf_lsm_##NAME(__VA_ARGS__);
+#include <linux/lsm_hook_defs.h>
+#undef LSM_HOOK
+
+#endif /* CONFIG_BPF_LSM */
+
+#endif /* _LINUX_BPF_LSM_H */
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 82875039ca90..1210a819ca52 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -7,6 +7,20 @@
 #include <linux/filter.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
+#include <linux/lsm_hooks.h>
+#include <linux/bpf_lsm.h>
+
+/* For every LSM hook that allows attachment of BPF programs, declare a nop
+ * function where a BPF program can be attached.
+ */
+#define LSM_HOOK(RET, DEFAULT, NAME, ...) 	\
+noinline __weak RET bpf_lsm_##NAME(__VA_ARGS__)	\
+{						\
+	return DEFAULT;				\
+}
+
+#include <linux/lsm_hook_defs.h>
+#undef LSM_HOOK
 
 const struct bpf_prog_ops lsm_prog_ops = {
 };
-- 
2.20.1

