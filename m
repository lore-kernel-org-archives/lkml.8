Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679D8C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F06621734
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AmE1UPqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgBLUV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:21:56 -0500
Received: from mail-wm1-f73.google.com ([209.85.128.73]:41241 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgBLUVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:21:55 -0500
Received: by mail-wm1-f73.google.com with SMTP id f207so1416536wme.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 12:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2DNPHWOep8QcJ95jz+HxlpBWa5iebLnkE4jUyw5CpGo=;
        b=AmE1UPqTX9ECKV1YOGGpTha7cgV8T6d/rPVacICrc/OXRYCbnBHxDeSLdQeDusdnhl
         pg616Kby5BUfC/GvJbkaSRg0+yW583b0Hpzvv04B12STCq0v5jMx/rj1DfyecIMEYyn6
         P8x/1+EELKbWBjW+op+08FEyAhUBcv8Dn0Q3aE73P8wgao1vwzR8y1VgvGygT/b9VXg+
         +/NfD9LLHWw0Us14UJ8xwrqwXfe40qCQD1giLHfF+XywXDa55D3G8MTjROb3yiRYt6iT
         xpUL+UtzHu8lETu8k0iRcrOkOh9QnGat/DvTebiMkllmPTemjiedUdsnvOivFVCGAHw0
         JqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2DNPHWOep8QcJ95jz+HxlpBWa5iebLnkE4jUyw5CpGo=;
        b=UV5Jp11Ff8X9HKOP3o1bCFCwK/a3kCOnqgwf88OjuZeFh250A/EEJo7xd9ja5djQSj
         vUoocTUZjfQPbRb40JbhrygiBLa04iPE9vshGE1gcRLwllDk/2HjV31vRugQFcnnPzao
         b6B9MmBjehXncpKheyGREb/Jz53dAEec+TRgM1bEJMRzfwPSDL3muM+qsZXvSPKq1kbR
         qKkhkuxnoUwsu4ukBguW0U+toOeZOoLIEGqbOS6W6EQx+TEETL+EUZn9sn/5w8Jucxmj
         +OYYk+u85AuySN7PltXfX1vc4liYZTzaBPVqIoQDHk1tOE8FkijioiFPoOaoGhEaCyqE
         MoOA==
X-Gm-Message-State: APjAAAX1JHyPzDeS1U4FqPv/jaTSmJvoED7LAqUHILBH9RfVtnNALZ9e
        6u5WjtSoEuNQG1xt6hP6+EYa1Zk9rw2y
X-Google-Smtp-Source: APXvYqzcCNVWLNt31ErqgahD9QaDO6dVOb7MlaAO1yWuVxRAhzBghE+Nw1/FCs7acOk1CtCAyB1K5ahOpBz7
X-Received: by 2002:a5d:4f0f:: with SMTP id c15mr17922390wru.251.1581538911573;
 Wed, 12 Feb 2020 12:21:51 -0800 (PST)
Date:   Wed, 12 Feb 2020 20:21:40 +0000
In-Reply-To: <20200212202140.138092-1-qperret@google.com>
Message-Id: <20200212202140.138092-4-qperret@google.com>
Mime-Version: 1.0
References: <20200212202140.138092-1-qperret@google.com>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v4 3/3] kbuild: generate autoksyms.h early
From:   Quentin Perret <qperret@google.com>
To:     masahiroy@kernel.org, nico@fluxnic.net
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        maennich@google.com, kernel-team@android.com, jeyu@kernel.org,
        hch@infradead.org, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing a cold build, autoksyms.h starts empty, and is updated late
in the build process to have visibility over the symbols used by in-tree
drivers. But since the symbol whitelist is known upfront, it can be used
to pre-populate autoksyms.h and maximize the amount of code that can be
compiled to its final state in a single pass, hence reducing build time.

Do this by using gen_autoksyms.sh to initialize autoksyms.h instead of
creating an empty file.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 Makefile                 | 7 +++++--
 scripts/gen_autoksyms.sh | 3 ++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 84b71845c43f..17b7e7f441bd 100644
--- a/Makefile
+++ b/Makefile
@@ -1062,9 +1062,12 @@ endif
 
 autoksyms_h := $(if $(CONFIG_TRIM_UNUSED_KSYMS), include/generated/autoksyms.h)
 
+quiet_cmd_autoksyms_h = GEN     $@
+      cmd_autoksyms_h = mkdir -p $(dir $@); $(CONFIG_SHELL) \
+			$(srctree)/scripts/gen_autoksyms.sh $@
+
 $(autoksyms_h):
-	$(Q)mkdir -p $(dir $@)
-	$(Q)touch $@
+	$(call cmd,autoksyms_h)
 
 ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 
diff --git a/scripts/gen_autoksyms.sh b/scripts/gen_autoksyms.sh
index 2cea433616a8..f52b93ad122c 100755
--- a/scripts/gen_autoksyms.sh
+++ b/scripts/gen_autoksyms.sh
@@ -32,7 +32,8 @@ cat > "$output_file" << EOT
 
 EOT
 
-sed 's/ko$/mod/' modules.order |
+[ -f modules.order ] && modlist=modules.order || modlist=/dev/null
+sed 's/ko$/mod/' $modlist |
 xargs -n1 sed -n -e '2{s/ /\n/g;/^$/!p;}' -- |
 cat - "$ksym_wl" |
 sort -u |
-- 
2.25.0.225.g125e21ebc7-goog

