Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCA3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4728C2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FviaNV7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgG3JrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:47:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38718 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725892AbgG3JrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 05:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596102420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7QKe25EPZp6OZWasdlbk3IR58sh7KuM9Wi5SyR0ZQjs=;
        b=FviaNV7mdzfF9WjwXMZ7ZKO1p/+3/aG6xJF2scDU7OC5F1ZbKlTjcEKrkb0+RKtKULb0j0
        KaC5Jm6xspkfxtQ/q1h2t5b8eq82UTBg7XYlh7dzSpyzdCvf24fZ8ZNUpazO6cOWmiDyki
        +5T09/hE4QSqO3H93BMMSOdQ/hC6/wg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-bSzb02fJMHKfMh6qabH6bQ-1; Thu, 30 Jul 2020 05:46:59 -0400
X-MC-Unique: bSzb02fJMHKfMh6qabH6bQ-1
Received: by mail-wm1-f72.google.com with SMTP id h13so1221573wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 02:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7QKe25EPZp6OZWasdlbk3IR58sh7KuM9Wi5SyR0ZQjs=;
        b=NlBQ9aBWFWXhWzhaZdf/R3ggGm2J//BwHpvhEMRDPlOfCxMu3EJWvckPEfPc6DzIli
         iEazXM4O80PdlDQi4WOE5a17h7gGSCA5M2recMIRDHMRpphtt/jzsf2y2ORPxsAy8uHC
         9uiGgMGd9zYOk9CKv5Op3s25d9McQDoqxFpFhaB2OxQWPtDzFGa7keyKJmKBKwwBN/Qg
         rq5hZ0TFp4D8RIo/ZZXOlCPIbLMxxzH4IkqW9pMReGgPgZjIvjGSZqXKhvLgzKr2tM6M
         Ko00uWfzoAQX/f8nKjD6KxFcQtqo/LpgVVdxZ7Mx979WbVBHGazKlcBq11EgBBFXekal
         yULg==
X-Gm-Message-State: AOAM533TvnlQAwcvtTRwuu+BeWYd7LKnCIILYiF0BTlEjEIoJdcPx6ra
        GTKHk09Gw9d4t24/jHCdwtIItmAhDD0bVtBJBMNDk0Sd9GmMW6D+4UYsJuDove2jEMGoFLZAKOk
        kbHpySGBbhaxCN1TQPzev+wAa
X-Received: by 2002:adf:9463:: with SMTP id 90mr32811589wrq.223.1596102417510;
        Thu, 30 Jul 2020 02:46:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqziuuxcBGpfUF2OyMa1lWO0Zdva/HK9BLakylsBVRnyL7BUGWcIb/Gg4cNRmRgIklSncJrg==
X-Received: by 2002:adf:9463:: with SMTP id 90mr32811571wrq.223.1596102417327;
        Thu, 30 Jul 2020 02:46:57 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id j6sm9009645wro.25.2020.07.30.02.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 02:46:56 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v2 1/9] objtool: Group headers to check in a single list
Date:   Thu, 30 Jul 2020 10:46:44 +0100
Message-Id: <20200730094652.28297-2-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200730094652.28297-1-jthierry@redhat.com>
References: <20200730094652.28297-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support multiple architectures and potentially different
sets of header to compare against their kernel equivalent, it is simpler
to have all headers to check in a single list.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/sync-check.sh | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index 2a1261bfbb62..13e4fca28015 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -1,13 +1,17 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
-FILES='
+FILES="
 arch/x86/include/asm/inat_types.h
 arch/x86/include/asm/orc_types.h
 arch/x86/include/asm/emulate_prefix.h
 arch/x86/lib/x86-opcode-map.txt
 arch/x86/tools/gen-insn-attr-x86.awk
-'
+arch/x86/include/asm/inat.h     -I '^#include [\"<]\(asm/\)*inat_types.h[\">]'
+arch/x86/include/asm/insn.h     -I '^#include [\"<]\(asm/\)*inat.h[\">]'
+arch/x86/lib/inat.c             -I '^#include [\"<]\(../include/\)*asm/insn.h[\">]'
+arch/x86/lib/insn.c             -I '^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]' -I '^#include [\"<]\(../include/\)*asm/emulate_prefix.h[\">]'
+"
 
 check_2 () {
   file1=$1
@@ -40,11 +44,10 @@ fi
 
 cd ../..
 
-for i in $FILES; do
-  check $i
-done
+while read -r file_entry; do
+    if [ -z "$file_entry" ]; then
+	continue
+    fi
 
-check arch/x86/include/asm/inat.h     '-I "^#include [\"<]\(asm/\)*inat_types.h[\">]"'
-check arch/x86/include/asm/insn.h     '-I "^#include [\"<]\(asm/\)*inat.h[\">]"'
-check arch/x86/lib/inat.c             '-I "^#include [\"<]\(../include/\)*asm/insn.h[\">]"'
-check arch/x86/lib/insn.c             '-I "^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]" -I "^#include [\"<]\(../include/\)*asm/emulate_prefix.h[\">]"'
+    check $file_entry
+done <<< $FILES
-- 
2.21.3

