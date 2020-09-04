Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E57C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2715720770
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbgIDP2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:28:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44670 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730224AbgIDP2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:28:05 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-UNr5EU4HOti7zKsrqzy5gA-1; Fri, 04 Sep 2020 11:28:03 -0400
X-MC-Unique: UNr5EU4HOti7zKsrqzy5gA-1
Received: by mail-ed1-f70.google.com with SMTP id m88so2875354ede.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bHdVf3niRzHqO3Je3Anrnq6r1Um2aQYUFrOux9Di8JU=;
        b=CpFv9ylqxosMfpwVCjWJLa0gb0LHmWvscRobaHhykCMoHAzjNG/0pViR3cf3zkxIBj
         5FA8+2cfKWtZH5/sTujKLVJMXkaH4ryJ/qWwVoTxxOSgbtCMtMCAeTE7R0d/ERVTWpwW
         GKhMz9z322CFFgw4vn+W3Xk6f+/m5VhsO6DbsFL9OkKogKXf+ep5SPDoUi06WyGsfWed
         fb/0E11KUWI17FV51nFKear3VBQLCdwT9wCc3rnPlAuzuR74HgcUtcD5xn57/OSyVy/4
         9cK5LdSz4tlswF8MfsXcNdJjTH257ZKDNVZDryMnkeqGmP8RNpPvZqGFmkYMk5U2l5Hk
         RcEQ==
X-Gm-Message-State: AOAM531TdBofGZ7DyuJFV5iA4w+19cdoRfoglgvMfy91+o6QLWJoWO5k
        0RwBSMcuWtt6QOREWsfghG7bpqGJcmJOOl9KgykT8kG42k+fTLetEpybWCf44DDamWincfGopsc
        eTKn+q62WDXFhLSwLTm1VdCpO
X-Received: by 2002:a17:906:c8d2:: with SMTP id gc18mr8487567ejb.467.1599233281648;
        Fri, 04 Sep 2020 08:28:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxo37yp/J5b0e5yObdqYjDtmGRsP25mQDjjBOfCMOKT4HIvNK9e2E3cNKN1u/Jqk+ZfpQ5V3g==
X-Received: by 2002:a17:906:c8d2:: with SMTP id gc18mr8487553ejb.467.1599233281485;
        Fri, 04 Sep 2020 08:28:01 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id a18sm6357110ejy.71.2020.09.04.08.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:28:01 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v3 01/10] objtool: Group headers to check in a single list
Date:   Fri,  4 Sep 2020 16:27:46 +0100
Message-Id: <20200904152755.32372-2-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200904152755.32372-1-jthierry@redhat.com>
References: <20200904152755.32372-1-jthierry@redhat.com>
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
index 2a1261bfbb62..c9674877419c 100755
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
+done <<< "$FILES"
-- 
2.21.3

