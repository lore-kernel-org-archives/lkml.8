Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A68CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 783B0206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYYXVR0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbgFHP2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:28:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56928 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729961AbgFHP2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591630083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e6ldx0MlwgMZ7eYGwNs6t50sH9muEKSQEPCznWlog1s=;
        b=KYYXVR0JtUSaCCl5dgqidIDjaZ7i1oG1tZapHD+bjCalApsYDx9o47ka5cUR7GA3IP9TDG
        mcSC+AmyihgWT1fQuXYHvVUEMc1koye9sfQMiljDD967TkxVtxWWfcI79JHaHLh5xe21UL
        3kiUslCfRdd+J0opqsmVb/rm5ltv/vM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-bYofDwdmN6epDt2XMB9yNQ-1; Mon, 08 Jun 2020 11:28:02 -0400
X-MC-Unique: bYofDwdmN6epDt2XMB9yNQ-1
Received: by mail-wr1-f72.google.com with SMTP id p10so7319635wrn.19
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 08:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e6ldx0MlwgMZ7eYGwNs6t50sH9muEKSQEPCznWlog1s=;
        b=h8F5O2+sUaw+w3Ay6VLMkd97x/VH6ZDb6XLIKExem97K92gNE+dCJkab8l+fHT+yAb
         ekwyuy7/iwS+xUhF5wtlNDFYnKy7EZWax0hIpIloGbB4koj2d8HEBpGNawn5GsbPzcl9
         xLiGzlO4M7DvLLqVsw07b8uZUhBL1S03gTwmI85aUNur42kPFDMqECu4qVbuEyze4YVU
         C8n7b5i8Z0yfqivAAELvyIub3TGtas0MyhHJIDHSNmVLejMnJU27Td8o4yVCRHJUyM0m
         lX38a2Cpux0YrOsw84f9VZR/sDArGxhBAblFLDjZB2r8DDtRzO4o4bvXiWejoxsHLYOc
         aDEg==
X-Gm-Message-State: AOAM533mLDmeGd1J1sMp3HlbRwunTuvnc184UYy1bltp1pdMFZYV0UOk
        yDCsfveOMqwcZTOfO42x2cWS5jYi3otqt+Flu6Khvv0rSBjQNOZXtcJnqCZgZH7iPupsJhj1nle
        zZCVTao/M8+tOBmKLtZp4gM4i
X-Received: by 2002:a7b:c951:: with SMTP id i17mr16396580wml.44.1591630080541;
        Mon, 08 Jun 2020 08:28:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFp19h0hngiQNhLm87FFRipY8xehU63BYMW/ntBlxgoy/lT9Jx4TWE19125CnGnuxhQanGcA==
X-Received: by 2002:a7b:c951:: with SMTP id i17mr16396567wml.44.1591630080316;
        Mon, 08 Jun 2020 08:28:00 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id u130sm23981707wmg.32.2020.06.08.08.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 08:27:59 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 3/7] objtool: Move macros describing structures to arch-dependent code
Date:   Mon,  8 Jun 2020 16:27:50 +0100
Message-Id: <20200608152754.2483-4-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200608152754.2483-1-jthierry@redhat.com>
References: <20200608152754.2483-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some macros are defined to describe the size and layout of structures
exception_table_entry, jump_entry and alt_instr. These values can vary
from one architecture to another.

Have the values be defined by arch specific code.

Suggested-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/x86/include/arch_special.h | 20 +++++++++++++++++++
 tools/objtool/special.c                       | 16 +--------------
 2 files changed, 21 insertions(+), 15 deletions(-)
 create mode 100644 tools/objtool/arch/x86/include/arch_special.h

diff --git a/tools/objtool/arch/x86/include/arch_special.h b/tools/objtool/arch/x86/include/arch_special.h
new file mode 100644
index 000000000000..d818b2bffa02
--- /dev/null
+++ b/tools/objtool/arch/x86/include/arch_special.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _X86_ARCH_SPECIAL_H
+#define _X86_ARCH_SPECIAL_H
+
+#define EX_ENTRY_SIZE		12
+#define EX_ORIG_OFFSET		0
+#define EX_NEW_OFFSET		4
+
+#define JUMP_ENTRY_SIZE		16
+#define JUMP_ORIG_OFFSET	0
+#define JUMP_NEW_OFFSET		4
+
+#define ALT_ENTRY_SIZE		13
+#define ALT_ORIG_OFFSET		0
+#define ALT_NEW_OFFSET		4
+#define ALT_FEATURE_OFFSET	8
+#define ALT_ORIG_LEN_OFFSET	10
+#define ALT_NEW_LEN_OFFSET	11
+
+#endif /* _X86_ARCH_SPECIAL_H */
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index e74e0189de22..2bd57db0881f 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -14,21 +14,7 @@
 #include "builtin.h"
 #include "special.h"
 #include "warn.h"
-
-#define EX_ENTRY_SIZE		12
-#define EX_ORIG_OFFSET		0
-#define EX_NEW_OFFSET		4
-
-#define JUMP_ENTRY_SIZE		16
-#define JUMP_ORIG_OFFSET	0
-#define JUMP_NEW_OFFSET		4
-
-#define ALT_ENTRY_SIZE		13
-#define ALT_ORIG_OFFSET		0
-#define ALT_NEW_OFFSET		4
-#define ALT_FEATURE_OFFSET	8
-#define ALT_ORIG_LEN_OFFSET	10
-#define ALT_NEW_LEN_OFFSET	11
+#include "arch_special.h"
 
 #define X86_FEATURE_POPCNT (4*32+23)
 #define X86_FEATURE_SMAP   (9*32+20)
-- 
2.21.1

