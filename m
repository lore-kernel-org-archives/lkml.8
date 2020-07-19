Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F77C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 21:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 546FD21744
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 21:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YGqE2kBo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgGSVCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 17:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgGSVCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 17:02:39 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1046AC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 14:02:39 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a15so966745wrh.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 14:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AB7aSgKZXEiLixC1bE1ZYkp9PgBC2tt87UCkWirjmZc=;
        b=YGqE2kBoO0fMgIKHmN7Hv1yUFgWMl6rnvOn2kmMuwq10ORWq63SUxQgm28U39wXDwP
         7khSKwtwrQWhqXVkmGtGoi98Y5OCiyMEtgTTvIXdptqtyI1hgCrANIQYdcZQa+TayMNI
         4qN7jlqjejPMH88o8dpdzwTtuDqT6iM4AAyYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AB7aSgKZXEiLixC1bE1ZYkp9PgBC2tt87UCkWirjmZc=;
        b=i0fViEGtm8OyKipbCGttOM6RDyf+9GKjtE3aAsPoOCMF5Z0QQvK9B2pVC71muOCznJ
         Ivoa9g1H5UCsQDkuA7dfBzG0Ne9vWAQE4YKxxkKAHcJqGW7VCciHWLzilISD0az1S6vC
         /1Ppsh+kFkDH7UmRbhODoC1DY2lobYnaYlRhwCbMHVatn7UXBcjsHZif/djRJz28p6fL
         8EGuTJy6tva8UZZ5z7kli4Jmri5r+URUPPhHwoPTCxAbCXG0EerP8biIzABgqYTumymC
         RVnEovEX3FhU6pU4iXul4H/8LegfiLbVmtWmKVjjEL/AvOxkEBmLNF4kFzHIE/cxfL2T
         Vvpw==
X-Gm-Message-State: AOAM531V8H9zaLjkkhXsYOfCL95gLR865Ayuu+KfgcWokqQDq+c3hK5z
        CyubiG0T0aSrQDzLmfbLyEY/ng==
X-Google-Smtp-Source: ABdhPJwWlI0mShLYZ09VHskv0FNSXx6LewAtWZh/l3XU4jKPuCxLSgjoNf9dF9WJGJ7qHCnN9xBazA==
X-Received: by 2002:a5d:4051:: with SMTP id w17mr18555406wrp.183.1595192557557;
        Sun, 19 Jul 2020 14:02:37 -0700 (PDT)
Received: from localhost.localdomain ([88.144.89.224])
        by smtp.gmail.com with ESMTPSA id l15sm27408453wro.33.2020.07.19.14.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 14:02:36 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        brendanhiggins@google.com, masahiroy@kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, kernel-team@cloudflare.com
Subject: [PATCH v4 1/3] um/kconfig: introduce CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS
Date:   Sun, 19 Jul 2020 22:02:20 +0100
Message-Id: <20200719210222.2811-2-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200719210222.2811-1-ignat@cloudflare.com>
References: <20200719210222.2811-1-ignat@cloudflare.com>
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
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
---
 init/Kconfig           | 6 ++++++
 scripts/cc-can-link.sh | 5 +++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 0498af567f70..0a1ec56c9f33 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -57,6 +57,12 @@ config CC_CAN_LINK_STATIC
 	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m64-flag) -static) if 64BIT
 	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m32-flag) -static)
 
+config CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS
+	bool
+	depends on UML && CC_CAN_LINK_STATIC
+	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m64-flag) -static -Xlinker --fatal-warnings) if 64BIT
+	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m32-flag) -static -Xlinker --fatal-warnings)
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

