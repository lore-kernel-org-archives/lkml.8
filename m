Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0A1C35250
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA512465B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z5jI4GcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgBGSIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 13:08:07 -0500
Received: from mail-wr1-f74.google.com ([209.85.221.74]:56291 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgBGSIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 13:08:05 -0500
Received: by mail-wr1-f74.google.com with SMTP id m15so27727wrs.22
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 10:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=A7PWbQJvwTT2txufQoHkwkpHKFDGayZbc6KQ+5UBHbA=;
        b=Z5jI4GcK8Flh69AYYAPiQsc3vSjflTiRzzJWbXZv1sESVps0TUOOG2oybAfZ2UjS/v
         mqz0Wvy3w6uMYPlrlJ7ypDEOEAnndwWsdp1KbarRJ+9WipW14lAPEBt+MIG++VFad4rc
         HZfDmLDsPzu1cEO3+xzL5CX+8C2hnFtWOfH5p9fGrWRIgKTJBNXcCQ9l+o2bHE54C9W1
         6Ue6HBEWW2jBxomU0c9i5IXpOe/aDrvW/IBQT/X/UBh7zM4gm+Fhgc1kK8YBG1D3qLgo
         ChKnw6N7f0J4w3iHixWWUZhMAfJpI4fwril4/nTiHRfUt/U4YeJlf6vd5BMqHAyc6tyd
         h0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A7PWbQJvwTT2txufQoHkwkpHKFDGayZbc6KQ+5UBHbA=;
        b=cJmNxY3iIGzejM1RZYEbIQgzFJEHIxskoO1xqFmBCLcdQK1cCtm/3fuxWq1l+Xctht
         tyWpgAF0+/Y00BEIn/HwnAH52bd/i2vCpHcer0XALtQmU4F0q7DLLSTriAHyHfGIET5h
         Ma5Jg4NNVV0fdKWauLwBDINy1xAoBEvEarzUm5F6DgGbfnTFFp6Dm1EKrtu4GtcPA6R8
         soYLuBX9MBEo8XEDcDNP6BN1KHLMekKyFf7SebEqNQkRlIUr2oZB1MDTff5dmOFKSSJe
         z3YQVKwEvTexfBDmrGbE0pcWWmKSEIlq6PsyA5AJ2OAAbvebUfAJzymOJURwxXTyQB+H
         IcBw==
X-Gm-Message-State: APjAAAVw5+s+LuyuiZxmE8TdJ77I6Nvu2f3+4oJs/oIu8Rl2SO7LdZWU
        YPsFTo71mrwyaHZ1Hn5HLgayIBWTr3+S
X-Google-Smtp-Source: APXvYqwxH/wYNA3xn5eSjBa7Rig0zjIiv+h+bHvXQRoTPp3XHf1Mkt4SfMFNgVOpvFmJVmkVSpCUg1ES2qlP
X-Received: by 2002:adf:e543:: with SMTP id z3mr195066wrm.369.1581098884370;
 Fri, 07 Feb 2020 10:08:04 -0800 (PST)
Date:   Fri,  7 Feb 2020 18:07:54 +0000
In-Reply-To: <20200207180755.100561-1-qperret@google.com>
Message-Id: <20200207180755.100561-3-qperret@google.com>
Mime-Version: 1.0
References: <20200207180755.100561-1-qperret@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v3 2/3] kbuild: split adjust_autoksyms.sh in two parts
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
 scripts/adjust_autoksyms.sh | 32 ++++-----------------------
 scripts/gen_autoksyms.sh    | 44 +++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 28 deletions(-)
 create mode 100755 scripts/gen_autoksyms.sh

diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
index 58335eee4b38..ae1e65e9009c 100755
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
@@ -35,31 +34,8 @@ case "$KBUILD_VERBOSE" in
 	;;
 esac
 
-# We need access to CONFIG_ symbols
-. include/config/auto.conf
-
-# The symbol whitelist, relative to the source tree
-eval ksym_wl="${CONFIG_UNUSED_KSYMS_WHITELIST:-/dev/null}"
-[[ "$ksym_wl" =~ ^/ ]] || ksym_wl="$abs_srctree/$ksym_wl"
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
+$srctree/scripts/gen_autoksyms.sh "$new_ksyms_file"
 
 # Extract changes between old and new list and touch corresponding
 # dependency files.
diff --git a/scripts/gen_autoksyms.sh b/scripts/gen_autoksyms.sh
new file mode 100755
index 000000000000..ce0919c3791a
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
+# The symbol whitelist, relative to the source tree
+eval ksym_wl="${CONFIG_UNUSED_KSYMS_WHITELIST:-/dev/null}"
+[[ "$ksym_wl" =~ ^/ ]] || ksym_wl="$abs_srctree/$ksym_wl"
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
2.25.0.341.g760bfbb309-goog

