Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E238BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDF3120838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tx465ux6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgG3JrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:47:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53525 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726707AbgG3JrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 05:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596102422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uEUXNi8FuTHtKTWiuRiwhCN+81e6ShR67jAab4C3cSM=;
        b=Tx465ux6e9JiGUNxMMEGhj1d6yw2ib8jTVHK8MLxINQt+ZElucs323CanTDYI6f8VmGHDr
        HyupkLIi6hOsvXKvflkhPJ9MP8cv9ZBc9ZfrfYQma65zm3v5ZJMIts0SmC2T/nffV8Sl38
        YRGqCFtXVuCgXwps2NSOK+CYtB81INE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-TdNjdUwmM42I9sEqk_OaIg-1; Thu, 30 Jul 2020 05:47:00 -0400
X-MC-Unique: TdNjdUwmM42I9sEqk_OaIg-1
Received: by mail-wr1-f69.google.com with SMTP id w7so7743715wrt.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 02:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uEUXNi8FuTHtKTWiuRiwhCN+81e6ShR67jAab4C3cSM=;
        b=Ty8OmcN0PfTqKypNhJczd+T0Iftce0i/+gthUyIHDMV4q0Pj0qIYQYdqV5F0qjfajW
         eCEZEDJJQgAJWk6oSk7RRsrm+UmRNUFjqVG4Rv1NsSJypObWkrQj9JXh6uOw1WacxeUy
         e6t7GMNLv0WID9ogTD+brn1zkKOHEPp+fA6OL6mHiOWu1KhYMtYM288jC7i41ILJ4YXl
         D2ZBkkYyqrt5P+jnhOfDPCwgClYcRlXqT3r0wWoxEfdlGnETl41usR98u3VW4eij2OO6
         Nl50Ly5tvOB11hR+kUNwsGqgd0dZGLRx3G0zhPbXKkS1L5L6oFz3tIA1gGEoG9ofJvsj
         ZXwQ==
X-Gm-Message-State: AOAM532LgZyqjrhswUJPvkufPQ1MDUtrifydaRuDkSg0dVz3Pzff7S/p
        QA8g0JLaUC136aAZTlOUFQ9mWoI6YV90A8YeYSjhres4rmRYJkzlnIQgj/E8mBcVkIaAhPnEC4Q
        nE1M4SU7q56oemCwzVzP4kMOh
X-Received: by 2002:a1c:2485:: with SMTP id k127mr12230499wmk.138.1596102418673;
        Thu, 30 Jul 2020 02:46:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeEI3246HUP3tv3Z2NH8Xk0MgRWEizY4u51RgxaIoGvoVdiFD2Iwc75kIudLbeRli/nAHUog==
X-Received: by 2002:a1c:2485:: with SMTP id k127mr12230479wmk.138.1596102418465;
        Thu, 30 Jul 2020 02:46:58 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id j6sm9009645wro.25.2020.07.30.02.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 02:46:57 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v2 2/9] objtool: Make sync-check consider the target architecture
Date:   Thu, 30 Jul 2020 10:46:45 +0100
Message-Id: <20200730094652.28297-3-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200730094652.28297-1-jthierry@redhat.com>
References: <20200730094652.28297-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not take into account outdated headers unrelated to the build of the
current architecture.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/Makefile      | 2 +-
 tools/objtool/sync-check.sh | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 7770edcda3a0..614b87278260 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -60,7 +60,7 @@ export srctree OUTPUT CFLAGS SRCARCH AWK
 include $(srctree)/tools/build/Makefile.include
 
 $(OBJTOOL_IN): fixdep FORCE
-	@$(CONFIG_SHELL) ./sync-check.sh
+	@$(CONFIG_SHELL) ./sync-check.sh $(SRCARCH)
 	@$(MAKE) $(build)=objtool
 
 $(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index 13e4fca28015..f01b5a4d12ac 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
+TARGET_ARCH=$1
+
+if [ "$TARGET_ARCH" == "x86" ]; then
 FILES="
 arch/x86/include/asm/inat_types.h
 arch/x86/include/asm/orc_types.h
@@ -12,6 +15,7 @@ arch/x86/include/asm/insn.h     -I '^#include [\"<]\(asm/\)*inat.h[\">]'
 arch/x86/lib/inat.c             -I '^#include [\"<]\(../include/\)*asm/insn.h[\">]'
 arch/x86/lib/insn.c             -I '^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]' -I '^#include [\"<]\(../include/\)*asm/emulate_prefix.h[\">]'
 "
+fi
 
 check_2 () {
   file1=$1
-- 
2.21.3

