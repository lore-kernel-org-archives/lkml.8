Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A242FC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F59F2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbgIDPbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:31:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49858 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725984AbgIDPbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:31:08 -0400
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-BXwHKNZsMHCrcunBTyN79g-1; Fri, 04 Sep 2020 11:31:06 -0400
X-MC-Unique: BXwHKNZsMHCrcunBTyN79g-1
Received: by mail-ej1-f72.google.com with SMTP id y10so2709974ejd.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bHdVf3niRzHqO3Je3Anrnq6r1Um2aQYUFrOux9Di8JU=;
        b=EzlPBl+C1MtaIFV1TXWxiWjosiBmOhCY2Ukh/SRSf6oaWyGBkq9hAJ30/oSYwl2ww3
         e3EYn4X5KntJ+GIL/Y9903cqXGaIirHjEqIU1a40cePiC/6mpFwKvL10KHZSr1gDCkt7
         fHpKeqk5fYQxD6rhEEkMHfxyx5GMjankQ45Pa8NUviri1yvIEXjyI8tL2eXpinfb5hcd
         wX+ShrEBJt6up/T0nh8+3Q6oPalXkdAr0vIBwJwpVNlWBW3O26mxFGQXnaxToxvegw7s
         VEDtcFCWf0SrRoofAv8hoUXodbOHgLvNlYy4ddZvTF4QPTTxjPGtCJZ+o6fr3e837k0o
         Jo4g==
X-Gm-Message-State: AOAM530eSV1R4Y+39wBUAQ6QuhHE/JKnHHXO45zIe/FahSXf82dBTtRL
        Kctt4/hD1WCV6yKP1qkTO0o6tvy/TvilLvqJkZ4BvMz3vsG0IEDYO4VydJ9lx4lxzuw7HOeP3PR
        R0YaQCjLrDo9jUAJ22RalTZiu
X-Received: by 2002:a17:906:2552:: with SMTP id j18mr7781966ejb.476.1599233464549;
        Fri, 04 Sep 2020 08:31:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwS+AbUWXvKYDf2oRJHYf2cHj51JgvJ1WI1zVP4o5h8HUG+FebL0VdQ1Ocp6MNWRpSlHc0MKQ==
X-Received: by 2002:a17:906:2552:: with SMTP id j18mr7781938ejb.476.1599233464333;
        Fri, 04 Sep 2020 08:31:04 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id j92sm6446284edc.82.2020.09.04.08.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:31:03 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v3 01/10] objtool: Group headers to check in a single list
Date:   Fri,  4 Sep 2020 16:30:19 +0100
Message-Id: <20200904153028.32676-2-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200904153028.32676-1-jthierry@redhat.com>
References: <20200904153028.32676-1-jthierry@redhat.com>
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

