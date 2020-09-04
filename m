Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9201C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B08132074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgIDPbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:31:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26751 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725966AbgIDPbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:31:40 -0400
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-dVpwi6skMvmJO3UTP9hXaA-1; Fri, 04 Sep 2020 11:31:38 -0400
X-MC-Unique: dVpwi6skMvmJO3UTP9hXaA-1
Received: by mail-ej1-f69.google.com with SMTP id lx11so932836ejb.19
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sTVaUKOi0aF37HK7y42Hr9S0gENRHKDvAY/ufMMaMVw=;
        b=dyogT420Lwz/zQIo3w3HSbCkwePnZj3xd6MsxZWHoxY1dxISwqyTAQF1fjNVDgnvtW
         WOxYLuMytdpm4OpEkGb7cnJocz/QJWUCpXl91DzENar5cELSVg59SuNzYhPEBMV5gWeX
         Q9trRyKZRZZZr9PEEuwflswXQgxpo+an3frexVFzGTmRsljlqsXl0UEfaexrtktxqZiL
         hI4jaVofQigZNhzwLyFxZo0sNMLEj/w4cYVYFHMg+N4uk7UyrvTLS3AJuBFXCiDvU13f
         NCNrE9/4TdJmh1+eRNHyHzKWPQj+azS8SFQmoCrtoQepIxuHO6WBp8mletiCoNOnlpHt
         JFWg==
X-Gm-Message-State: AOAM530Wj+ePeGKi6+4I3rtgWkcmFThMxoTrzByPhUZcH2uZAxlJlzQl
        nWp1soowBCIqF7o0Z87ZHq/cJee3gjaEnnhdUFv5Sri8P8gR7oA7Hyv9BslTKzRyGVQlnPPmc/T
        I3Udw6hdtXmxrKNsxz8nfjCLy
X-Received: by 2002:a17:906:7fca:: with SMTP id r10mr7889701ejs.534.1599233496701;
        Fri, 04 Sep 2020 08:31:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwO1EjGm+adMxasbh+R5/cmLtMLmQ7kLed3U6aSutUV1AKHrjmy7Qy3/g5mgsnQ4TT4Xf5iw==
X-Received: by 2002:a17:906:7fca:: with SMTP id r10mr7889675ejs.534.1599233496484;
        Fri, 04 Sep 2020 08:31:36 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id g25sm4415100edu.53.2020.09.04.08.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:31:36 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v3 02/10] objtool: Make sync-check consider the target architecture
Date:   Fri,  4 Sep 2020 16:30:20 +0100
Message-Id: <20200904153028.32676-3-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200904153028.32676-1-jthierry@redhat.com>
References: <20200904153028.32676-1-jthierry@redhat.com>
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
index 33d1e3ca8efd..20df5541ca43 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -64,7 +64,7 @@ export srctree OUTPUT CFLAGS SRCARCH AWK
 include $(srctree)/tools/build/Makefile.include
 
 $(OBJTOOL_IN): fixdep FORCE
-	@$(CONFIG_SHELL) ./sync-check.sh
+	@$(CONFIG_SHELL) ./sync-check.sh $(SRCARCH)
 	@$(MAKE) $(build)=objtool
 
 $(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index c9674877419c..07249900db1c 100755
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

