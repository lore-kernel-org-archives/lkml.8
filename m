Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AD7C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3875C2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BF7dxg/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgBLUVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:21:52 -0500
Received: from mail-wr1-f73.google.com ([209.85.221.73]:48905 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgBLUVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:21:50 -0500
Received: by mail-wr1-f73.google.com with SMTP id r1so1288693wrc.15
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 12:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JKxkzP8uaZCnNh4oNiG48Pj6ASO+gJyC+moaUvI0Kbc=;
        b=BF7dxg/pIyT2JH5txBoS129DR/XhzOKn5wnado0bTUoBxu2pvFN2hZ+Am3snqcltep
         pLlv6wzGnFU/hiU3sYj6rVAyDggfTx3JOaMXmxBhUd2Yyj4QPoX0duS77IsjFbWOJcCQ
         I8yP8VizpMqAHGSqE7djh/3IOfE4FwafJ67IaTx3hHvMaNXTykeLmD1mdjBc2Rb4p1/R
         gXfFvlDwmzUn2nT9DvGZ3jdA54iVo5rhBP7iymJt06pNPJj+EL7o1gsljJrJmpf9WgY1
         wkn2UYjxYnPSmqRSQGl7ioBT2oL1eTNT7yOugOpTi4ea+HhHdsGJAX3s8tA5Xi9v5g7e
         kflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JKxkzP8uaZCnNh4oNiG48Pj6ASO+gJyC+moaUvI0Kbc=;
        b=Pw8i3kpDLKOmkMjutrkv01EfOaYVScNfxbh9x9Jr2J9WjKiVLVefT416s8EQmqmV7D
         yxj74g1kD0xpIwxs65bEJ9/HhmZGV9I6z3HYp4UgUilfX7R7ob6UMSiD7v8GA2O5GoiW
         t3rfUniWi5aUewim8VVplzKoOwnWKPItfVcRbUbsUjdcE0BJRfJxPD+KP/VTZtWnR8G1
         zhLdGDdaILYsWlsFYwbhTj1npUXtttGdRMMhe9Kfxa2R2+M+Md9IakTF80NDWtwX+8kA
         UirpvgoIUcq2Qc8K4viwnXvRno/1RXM5+ix20ogfAag3sDFuSRRZGdTuEqCyQHwGZUag
         5R4Q==
X-Gm-Message-State: APjAAAUxlSVoZwv3WI/T3EKPvt4v5WwrNYRJpsyiWrbIMsIvmhNkyVQL
        b+OVH/7cfSP2IY1qwYyNbkNwwpBz2W64
X-Google-Smtp-Source: APXvYqwAoqq5zHen+A+j49ybZqkCMYBt0W9plpkVvpe0SW52v27p5TgIA1iFCtkxw/Ck8x32ku8DetUVpz1F
X-Received: by 2002:adf:a285:: with SMTP id s5mr17894312wra.118.1581538908791;
 Wed, 12 Feb 2020 12:21:48 -0800 (PST)
Date:   Wed, 12 Feb 2020 20:21:39 +0000
In-Reply-To: <20200212202140.138092-1-qperret@google.com>
Message-Id: <20200212202140.138092-3-qperret@google.com>
Mime-Version: 1.0
References: <20200212202140.138092-1-qperret@google.com>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v4 2/3] kbuild: split adjust_autoksyms.sh in two parts
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

In order to prepare the ground for a build-time optimization, split
adjust_autoksyms.sh into two scripts: one that generates autoksyms.h
based on all currently available information (whitelist, and .mod
files), and the other to inspect the diff between two versions of
autoksyms.h and trigger appropriate rebuilds.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 scripts/adjust_autoksyms.sh | 29 ++++--------------------
 scripts/gen_autoksyms.sh    | 44 +++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 25 deletions(-)
 create mode 100755 scripts/gen_autoksyms.sh

diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
index 93f4d10e66e6..2b366d945ccb 100755
--- a/scripts/adjust_autoksyms.sh
+++ b/scripts/adjust_autoksyms.sh
@@ -1,14 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-only
 
-# Script to create/update include/generated/autoksyms.h and dependency files
+# Script to update include/generated/autoksyms.h and dependency files
 #
 # Copyright:	(C) 2016  Linaro Limited
 # Created by:	Nicolas Pitre, January 2016
 #
 
-# Create/update the include/generated/autoksyms.h file from the list
-# of all module's needed symbols as recorded on the second line of *.mod files.
+# Update the include/generated/autoksyms.h file.
 #
 # For each symbol being added or removed, the corresponding dependency
 # file's timestamp is updated to force a rebuild of the affected source
@@ -38,28 +37,8 @@ esac
 # We need access to CONFIG_ symbols
 . include/config/auto.conf
 
-# Use 'eval' to expand the whitelist path and check if it is relative
-eval ksym_wl="${CONFIG_UNUSED_KSYMS_WHITELIST:-/dev/null}"
-[ "${ksym_wl:0:1}" = "/" ] || ksym_wl="$abs_srctree/$ksym_wl"
-
-# Generate a new ksym list file with symbols needed by the current
-# set of modules.
-cat > "$new_ksyms_file" << EOT
-/*
- * Automatically generated file; DO NOT EDIT.
- */
-
-EOT
-sed 's/ko$/mod/' modules.order |
-xargs -n1 sed -n -e '2{s/ /\n/g;/^$/!p;}' -- |
-cat - "$ksym_wl" |
-sort -u |
-sed -e 's/\(.*\)/#define __KSYM_\1 1/' >> "$new_ksyms_file"
-
-# Special case for modversions (see modpost.c)
-if [ -n "$CONFIG_MODVERSIONS" ]; then
-	echo "#define __KSYM_module_layout 1" >> "$new_ksyms_file"
-fi
+# Generate a new symbol list file
+$CONFIG_SHELL $srctree/scripts/gen_autoksyms.sh "$new_ksyms_file"
 
 # Extract changes between old and new list and touch corresponding
 # dependency files.
diff --git a/scripts/gen_autoksyms.sh b/scripts/gen_autoksyms.sh
new file mode 100755
index 000000000000..2cea433616a8
--- /dev/null
+++ b/scripts/gen_autoksyms.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-only
+
+# Create an autoksyms.h header file from the list of all module's needed symbols
+# as recorded on the second line of *.mod files and the user-provided symbol
+# whitelist.
+
+set -e
+
+output_file="$1"
+
+# Use "make V=1" to debug this script.
+case "$KBUILD_VERBOSE" in
+*1*)
+	set -x
+	;;
+esac
+
+# We need access to CONFIG_ symbols
+. include/config/auto.conf
+
+# Use 'eval' to expand the whitelist path and check if it is relative
+eval ksym_wl="${CONFIG_UNUSED_KSYMS_WHITELIST:-/dev/null}"
+[ "${ksym_wl:0:1}" = "/" ] || ksym_wl="$abs_srctree/$ksym_wl"
+
+# Generate a new ksym list file with symbols needed by the current
+# set of modules.
+cat > "$output_file" << EOT
+/*
+ * Automatically generated file; DO NOT EDIT.
+ */
+
+EOT
+
+sed 's/ko$/mod/' modules.order |
+xargs -n1 sed -n -e '2{s/ /\n/g;/^$/!p;}' -- |
+cat - "$ksym_wl" |
+sort -u |
+sed -e 's/\(.*\)/#define __KSYM_\1 1/' >> "$output_file"
+
+# Special case for modversions (see modpost.c)
+if [ -n "$CONFIG_MODVERSIONS" ]; then
+	echo "#define __KSYM_module_layout 1" >> "$output_file"
+fi
-- 
2.25.0.225.g125e21ebc7-goog

