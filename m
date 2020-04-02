Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84537C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B602080C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ShO3r9RV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387731AbgDBISl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:18:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45752 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387673AbgDBISk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:18:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id r14so1390537pfl.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 01:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=hpN1+n5xYd8iTmuJk5my6MaX1tvwBISzriW+LumWFUk=;
        b=ShO3r9RVFJZ69eJ6byI7q2iz1t91raVXjWEe0QObFryEOAOkMf+jsr93cWzT2A07ay
         tOt9WfOyads4m3eR2gKxGs+lp/CkGNsVymK8DVt+GBfZkqswyJCJEMSLyklId+ltw9bg
         /SMxHpXFUrXKGVqyyDgp6/5QGvCoFedfuQIhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hpN1+n5xYd8iTmuJk5my6MaX1tvwBISzriW+LumWFUk=;
        b=U8Y9tfACjXiTfWgWRpqFpzGJFTn/lNm3x+a+gZNM3UPBjAS0eHzPLJPwpr64nvMkze
         9SGY5JL1oFa0vYJpLw8jDFM1aGzjgh7JgPgGeCZRwoaxlHtxtfjo85q41qfhxbxVK2Br
         PZFr6ryiXIDOCGzNEGzur+lt2VtyCNofkITczMAxUX+v4ievxjV8aaHR3ByThFutkpDW
         1CAIeSaD5HIw1S9d+uIaM8Hdd6atulT0TE+g1GiVSzbuCLu2nU7AcGd+OHPNvtzt3aDi
         pq1G0pff3GRdaytiAhFratxfzOLna6DsLw2CN8q7Xg53nD1rD6pJ74jAFRXUACt0GCGv
         tbxg==
X-Gm-Message-State: AGi0PuYboF43T72EDqBjDJ46uAabukQwp4gfOIq/GHluQF8CQbbIZTzQ
        cIuO4abOXc8/k8XpoiAe2fUpzw==
X-Google-Smtp-Source: APiQypJGZejXGc9mrFy8cHSjQCYyLuOnjdp6HTJplaYQQdQOXUNLWSE37UneYZaXLMb8oNDqC1GelA==
X-Received: by 2002:a62:64d5:: with SMTP id y204mr1940179pfb.227.1585815519516;
        Thu, 02 Apr 2020 01:18:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l9sm1340387pff.16.2020.04.02.01.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 01:18:38 -0700 (PDT)
Date:   Thu, 2 Apr 2020 01:18:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: mkcompile_h: Include $LD version in /proc/version
Message-ID: <202004020117.6E434C035@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing Clang builds of the kernel, it is possible to link with
either ld.bfd (binutils) or ld.lld (LLVM), but it is not possible to
discover this from a running kernel. Add the "$LD -v" output to
/proc/version.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 init/Makefile       | 2 +-
 scripts/mkcompile_h | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/init/Makefile b/init/Makefile
index 6246a06364d0..82c15bdb42d7 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -35,4 +35,4 @@ include/generated/compile.h: FORCE
 	@$($(quiet)chk_compile.h)
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkcompile_h $@	\
 	"$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CONFIG_PREEMPT)"	\
-	"$(CONFIG_PREEMPT_RT)" "$(CC) $(KBUILD_CFLAGS)"
+	"$(CONFIG_PREEMPT_RT)" "$(LD)" "$(CC) $(KBUILD_CFLAGS)"
diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
index 3a5a4b210c86..f98c07709370 100755
--- a/scripts/mkcompile_h
+++ b/scripts/mkcompile_h
@@ -6,7 +6,8 @@ ARCH=$2
 SMP=$3
 PREEMPT=$4
 PREEMPT_RT=$5
-CC=$6
+LD=$6
+CC=$7
 
 vecho() { [ "${quiet}" = "silent_" ] || echo "$@" ; }
 
@@ -72,7 +73,10 @@ UTS_VERSION="$(echo $UTS_VERSION $CONFIG_FLAGS $TIMESTAMP | cut -b -$UTS_LEN)"
   printf '#define LINUX_COMPILE_BY "%s"\n' "$LINUX_COMPILE_BY"
   echo \#define LINUX_COMPILE_HOST \"$LINUX_COMPILE_HOST\"
 
-  echo \#define LINUX_COMPILER \"`$CC -v 2>&1 | grep ' version ' | sed 's/[[:space:]]*$//'`\"
+  CC_VERSION=$($CC -v 2>&1 | grep ' version ' | sed 's/[[:space:]]*$//')
+  LD_VERSION=$($LD -v | head -n1 | sed 's/(compatible with [^)]*)//' \
+		      | sed 's/[[:space:]]*$//')
+  printf '#define LINUX_COMPILER "%s"\n' "$CC_VERSION, $LD_VERSION"
 } > .tmpcompile
 
 # Only replace the real compile.h if the new one is different,
-- 
2.20.1


-- 
Kees Cook
