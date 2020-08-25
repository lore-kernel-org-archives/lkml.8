Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2650C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8258F20767
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTkrgs0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgHYMsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:48:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36382 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726551AbgHYMry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598359673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zglq0vOI//KuVKJ2M/RQ4QygBvZQL1YIWMQ/tBpIyuY=;
        b=ZTkrgs0n7lOFGuohiv2C8cXwmMN+8+pMWKiCZ64X8H11iYPRP35NSF3i2PfrP2BkSAvVSM
        EW9d0lHMGmUs8cYVng4iUaH8mcMV/8qhwA8/IeJW75X7XMLF/LsnFKghchkJsiF9hj+6bs
        yhhUX9/CAVXojLITIcVAYqmoNBZOmWY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-oe-9TsfUN1mytl9sIbJg1Q-1; Tue, 25 Aug 2020 08:47:51 -0400
X-MC-Unique: oe-9TsfUN1mytl9sIbJg1Q-1
Received: by mail-wr1-f72.google.com with SMTP id w2so4871896wrr.19
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 05:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zglq0vOI//KuVKJ2M/RQ4QygBvZQL1YIWMQ/tBpIyuY=;
        b=Rpqo9V72PxLSbjRKfPCrvqS4Mo73RF+pPxR0lXkMU8iuk5kIigEkfGQRL720cO5fAz
         99ceR+I9iT9okRG6kSeFyyP+CB9caDYsvQ/rFybbSNMhcFfx+H2wS5SWPYbB2SY5SGSt
         aweUjOC5X/zIiotYUbDFhSDxXCm2A/yIPKf6qFXI6RBuiWF0zyPw0eDErZPOFhebMygl
         QtxFcWw/aIEBiLQsgmcfr0Cn+89IzIuvhSX/vUZbStMASQG990sPvLwjlfm6z3e90SsK
         lEcQ0jhMsrz1/Q/5F39P1uU8OYerjKsPlX64MyfjkpxylG7C+3kHoFKOp3CO2u6Fw21I
         a8yA==
X-Gm-Message-State: AOAM531wBcmrx8G1B1TX/9qJD3T75p9PI+D97pFfJHtOJTA3A7uQ0cj8
        AQKQl7qANC+vlClbOznt54ovZhBEyQP8KmkOvQhFC1goIgGd/w2eUZWPmr984fak/caG81xHKBR
        cqKDYSVXAho2Z1JN2yLOiy8W3
X-Received: by 2002:a1c:ddd4:: with SMTP id u203mr1968297wmg.68.1598359670153;
        Tue, 25 Aug 2020 05:47:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxR2ePLTiLPRqNp7jTWB/BAbT9feWHGtVJFaiKfxqRwDqFmE5Oiq3aEmgnUngSQeg2gFFkj4A==
X-Received: by 2002:a1c:ddd4:: with SMTP id u203mr1968279wmg.68.1598359669886;
        Tue, 25 Aug 2020 05:47:49 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id u6sm27469306wrn.95.2020.08.25.05.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 05:47:49 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        benh@kernel.crashing.org, Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v4 4/4] objtool: check: Use orc definition only when needed
Date:   Tue, 25 Aug 2020 13:47:42 +0100
Message-Id: <20200825124742.29782-5-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200825124742.29782-1-jthierry@redhat.com>
References: <20200825124742.29782-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implementation of ORC requires some definitions that are currently
provided by the target architecture headers. Do not depend on these
definitions when the orc subcommand is not implemented.

This avoid requiring arches with no orc implementation to provide dummy
orc definitions.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/Makefile | 4 ++++
 tools/objtool/arch.h   | 2 ++
 tools/objtool/check.h  | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 7770edcda3a0..33d1e3ca8efd 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -55,6 +55,10 @@ ifeq ($(SRCARCH),x86)
 	SUBCMD_ORC := y
 endif
 
+ifeq ($(SUBCMD_ORC),y)
+	CFLAGS += -DINSN_USE_ORC
+endif
+
 export SUBCMD_CHECK SUBCMD_ORC
 export srctree OUTPUT CFLAGS SRCARCH AWK
 include $(srctree)/tools/build/Makefile.include
diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index 2e2ce089b0e9..b18c5f61d42d 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -11,7 +11,9 @@
 #include "objtool.h"
 #include "cfi.h"
 
+#ifdef INSN_USE_ORC
 #include <asm/orc_types.h>
+#endif
 
 enum insn_type {
 	INSN_JUMP_CONDITIONAL,
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 061aa96e15d3..0abdf8efdbc0 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -42,7 +42,9 @@ struct instruction {
 	struct symbol *func;
 	struct list_head stack_ops;
 	struct cfi_state cfi;
+#ifdef INSN_USE_ORC
 	struct orc_entry orc;
+#endif
 };
 
 struct instruction *find_insn(struct objtool_file *file,
-- 
2.21.3

