Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C04C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 08:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 641BF207CD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 08:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="g+dH1d/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgGDIwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 04:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGDIwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 04:52:34 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12ACC061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 01:52:33 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f139so36404291wmf.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 01:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VwOjxo+AYrnIugDfwLwRdUzbVsmnTWEdefeWvuTDVmc=;
        b=g+dH1d/PFd20ixl7FsBGTfs3j7Y9QoCZDBDayErBIX0wTDCFA72uArnuQl8kKjy3FC
         gg5prSYGe1M/TdA6rApF1FQmwhI1i2ylfNHCtSCHvBh4tKhPjfdfOWjb+9LS781wd265
         dcOXOWnlRnbona/kVOTImz6keVcM9jPw6pBNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VwOjxo+AYrnIugDfwLwRdUzbVsmnTWEdefeWvuTDVmc=;
        b=aEvpW0A/zVaUlGQTo+ah1qLQe5EtKfLNvQY2Cz4QCPjrMo7vgvOEOHuA+sduVIUOuV
         GXr7f0IKRyvUV+1IuXe3+Cp14cSzHZjhrTiB8V0w8NaaI5mbGH3PRto4k1pfEY98oQUu
         d/VTc+UGt+53Ia/oO0F7PAmfto2qlj/DYwKSLmIswMO7f9qyC8t1WEwfyChAdkCFAtAT
         UBApyH2hN1D4tdnFhxZisaCszOPZjqfMUe+5ay8x8eg6nQ+vexSxUOvRnQuDApvhEV8o
         c2bE2UXJjYxt3+Ksdak7X3wnatOQLb09zcv6/fKv8GGQFnQMxSaZs7GglTkVHPpueoaj
         G6JQ==
X-Gm-Message-State: AOAM533adsilRwurVsmVsbUmLWWmVt6dhrB5HBNnKB+Tx98YGSdba2Ck
        8vDBsa/sLOxb+wGDu8/TtXpZ4A==
X-Google-Smtp-Source: ABdhPJzbsB/S1RZFY2pfB6F0q/fG0RsNXwC0NA2OpOF5V3aDTPpH9dguOKD805O7ndqiZ43XdahrUw==
X-Received: by 2002:a7b:cf10:: with SMTP id l16mr40618406wmg.93.1593852752398;
        Sat, 04 Jul 2020 01:52:32 -0700 (PDT)
Received: from localhost.localdomain (88-144-169-139.host.pobb.as13285.net. [88.144.169.139])
        by smtp.gmail.com with ESMTPSA id a22sm15195915wmb.4.2020.07.04.01.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 01:52:31 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        brendanhiggins@google.com, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, kernel-team@cloudflare.com
Subject: [PATCH v2 1/3] um/kconfig: introduce CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS
Date:   Sat,  4 Jul 2020 09:52:11 +0100
Message-Id: <20200704085213.444645-2-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200704085213.444645-1-ignat@cloudflare.com>
References: <20200704085213.444645-1-ignat@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For statically linked UML build it is important to take into account the
standard C-library implementation. Some implementations, notably glibc have
caveats: even when linked statically, the final program might require some
runtime dependencies, if certain functions are used within the code.

Consider the following program:
int main(void)
{
	getpwent();
	return 0;
}

Compiling this program and linking statically with glibc produces the following
warning from the linker:
/usr/sbin/ld: /tmp/ccuthw1o.o: in function `main':
test.c:(.text+0x5): warning: Using 'getpwent' in statically linked
applications requires at runtime the shared libraries from the glibc version
used for linking

We will use the flag to detect such C-library implementation build time and
possibly disable static linking for UML to avoid producing a binary with
unexpected behaviour and dependencies.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 init/Kconfig           | 6 ++++++
 scripts/cc-can-link.sh | 5 +++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index a46aa8f3174d..717a3ada765e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -57,6 +57,12 @@ config CC_CAN_LINK_STATIC
 	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) -static $(m64-flag)) if 64BIT
 	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) -static $(m32-flag))
 
+config CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS
+	bool
+	depends on UML && CC_CAN_LINK_STATIC
+	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) -static -Xlinker --fatal-warnings $(m64-flag)) if 64BIT
+	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) -static -Xlinker --fatal-warnings $(m32-flag))
+
 config CC_HAS_ASM_GOTO
 	def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
 
diff --git a/scripts/cc-can-link.sh b/scripts/cc-can-link.sh
index 6efcead31989..e5011a46103e 100755
--- a/scripts/cc-can-link.sh
+++ b/scripts/cc-can-link.sh
@@ -2,10 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0
 
 cat << "END" | $@ -x c - -o /dev/null >/dev/null 2>&1
-#include <stdio.h>
+#include <sys/types.h>
+#include <pwd.h>
 int main(void)
 {
-	printf("");
+	getpwent();
 	return 0;
 }
 END
-- 
2.20.1

