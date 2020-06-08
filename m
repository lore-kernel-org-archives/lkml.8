Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664A4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CE7C2078C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZiArzDaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbgFHP2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:28:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58148 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729902AbgFHP2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591630081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TZeVBYC4bUKUHMH3+mjXO799G61EdyUgn/CvhGPsWA8=;
        b=ZiArzDaJ6u/FgE+u554C0NsPYazMyU47RmGRFKzpgFn83L/yC62TP3UTvmkkrjRba+R2e4
        LP/JIgy4NMu2Atj8h1vkNprbdTrAF9nD9LOhkDp0vVJGJxcA62qDvYkN9+RV7TZ8RJ+Gq9
        Jl+YEKGbmVTVBYkIRh0Xlgaq1hgvYLQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-fuZrwyuDMrqDGwmPrVOQwA-1; Mon, 08 Jun 2020 11:28:00 -0400
X-MC-Unique: fuZrwyuDMrqDGwmPrVOQwA-1
Received: by mail-wr1-f71.google.com with SMTP id o1so7258674wrm.17
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 08:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TZeVBYC4bUKUHMH3+mjXO799G61EdyUgn/CvhGPsWA8=;
        b=WqvJOAr3YQOzmV1tJmkduPfASac+ukvddRGGrvDV2DNQhqOkQmJ1ZZNMnmuczHxxwi
         dhAjdtgvwgo9/fdnuYhBFJbyPFNFI3Oa9aPNYMqX4O8vArFgtD2/8lwXNZUUDDWSzVOt
         O1D7eTXMvE77oQR/TDIj6J7oSF6Idor5fG60YIeGyRHXFjR5NBzKbDFAAs1PxGaj7F1J
         TvHN72hZ8gLLnAnIEPxLzuxD2VfkpwV/YT1pRCD+CTPqRvBosPabWaewxKRvVkmFVzEY
         l16KaHdYuIh700ShB0jGGcTSF+4j9xdV2MQJhLwRVWkm+elUnhsl8mbSl23J68lSTOS9
         3LTQ==
X-Gm-Message-State: AOAM531CIEFMGFoNrvemK7gJwj5a+cKPNvwwtptOgqBFEcZktTHGB4mB
        dcvw9hTOgFiyMwhhDjlPPH82BghBK9xUVd0QINwpdI5F3gojGADoyJwzNmHLt2+CQIP5hryb3p8
        tVVOXU4jP1Rng5Xgn2+5wxFse
X-Received: by 2002:a7b:c1d4:: with SMTP id a20mr16597700wmj.153.1591630078419;
        Mon, 08 Jun 2020 08:27:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeEWF+JP+9p5+BHLgFvYmnviO0uLEtGaRlpt0JQKcZGSL3bQfO+4Ku9FaMkDZAML4HHxeRSQ==
X-Received: by 2002:a7b:c1d4:: with SMTP id a20mr16597680wmj.153.1591630078195;
        Mon, 08 Jun 2020 08:27:58 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id u130sm23981707wmg.32.2020.06.08.08.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 08:27:57 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 1/7] objtool: Group headers to check in a single list
Date:   Mon,  8 Jun 2020 16:27:48 +0100
Message-Id: <20200608152754.2483-2-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200608152754.2483-1-jthierry@redhat.com>
References: <20200608152754.2483-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support multiple architectures and potentially different
sets of header to compare against their kernel equivalent, it is simpler
to have all headers to check in a single list.

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
2.21.1

