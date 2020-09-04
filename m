Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1F3C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 778462074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQi4syS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgIDPgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:36:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23070 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726259AbgIDPf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599233757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aA/GaEdgmx+d6YnPebJs7OqlE9n6hxYfx/XBzQ3R5pg=;
        b=NQi4syS54wAqlHi4Pt4nrp5litATMjvWj6l4dKlvVzfJnx/kNTAqnyB2cAQcI2Q84WFtWY
        sPTVNrGC87N78Cd0P66mO6AxRgQ4OcVo9MZGPtEUdyee62qejMOoZXi7c93yubxs8FQ7bz
        jZftLn7l5HqgQtUDW8k6ml31HBNCQhk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-5rLT6SKkOG2hPG_stWd4Dg-1; Fri, 04 Sep 2020 11:35:55 -0400
X-MC-Unique: 5rLT6SKkOG2hPG_stWd4Dg-1
Received: by mail-ej1-f71.google.com with SMTP id l18so2661372ejn.17
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aA/GaEdgmx+d6YnPebJs7OqlE9n6hxYfx/XBzQ3R5pg=;
        b=rd1RUv5VoxLAZt9jl+7ZQTfRki1kCXigeioKIzdPW44Oex16FqkSn0H5d8vl7E47aZ
         NRYnyIaChGjeX/ccIrr/Eis7SO69qqUKHtUE/X6BHKCIudPclkEKXkyoodG5jSEvG9F/
         G5RbQMHxay1D9G6e4TbqqbVPlIvpeHoeZMbin+kSfFJLFC6WA+2QfTQPuaqkisrqnhwD
         tQLmzE28QwXR13svwZepmcTb6J4Ap9dAg5/Uw/P6slAwoZaztNooXuwMI3FtiydJco3D
         eLNVLropnRyYzQbMOs3ukhSj59DNqyBiwyGQfTAQ1HeSyZpwd51Tgfe6mn09oN3icIOL
         hMBw==
X-Gm-Message-State: AOAM532rJoO1Czsh/dHSoI3cQgOOiBLgr1BV1x3i5zNzhGCJrmM6S8ay
        J5ONGSMoOJVjE3y8mGRFG/+baWAJDThO45JeRsn8mJGkZ2TZlnmEV9YoO3oWmKMFQcJzMsLGaUo
        tmJ5zw84dkYeYxRm6TpXO4glo
X-Received: by 2002:aa7:db47:: with SMTP id n7mr4885256edt.315.1599233751253;
        Fri, 04 Sep 2020 08:35:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzugaDmcJcGP17FJhS6d+oqgcJCmL73sWJ9egSAXyvB9ndfUJkNsWPZXr/t56E9RwHaaAYVgA==
X-Received: by 2002:aa7:db47:: with SMTP id n7mr4885232edt.315.1599233751077;
        Fri, 04 Sep 2020 08:35:51 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id r16sm6418192ejb.110.2020.09.04.08.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:35:50 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v3 10/10] objtool: Decode unwind hint register depending on architecture
Date:   Fri,  4 Sep 2020 16:30:28 +0100
Message-Id: <20200904153028.32676-11-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200904153028.32676-1-jthierry@redhat.com>
References: <20200904153028.32676-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The set of registers that can be included in an unwind hint and their
encoding will depend on the architecture. Have arch specific code to
decode that register.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch.h            |  2 ++
 tools/objtool/arch/x86/decode.c | 37 +++++++++++++++++++++++++++++++++
 tools/objtool/check.c           | 27 +-----------------------
 3 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index b18c5f61d42d..4a84c3081b8e 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -88,4 +88,6 @@ unsigned long arch_dest_reloc_offset(int addend);
 
 const char *arch_nop_insn(int len);
 
+int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg);
+
 #endif /* _ARCH_H */
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 1967370440b3..cde9c36e40ae 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -15,6 +15,7 @@
 #include "../../elf.h"
 #include "../../arch.h"
 #include "../../warn.h"
+#include <asm/orc_types.h>
 
 static unsigned char op_to_cfi_reg[][2] = {
 	{CFI_AX, CFI_R8},
@@ -583,3 +584,39 @@ const char *arch_nop_insn(int len)
 
 	return nops[len-1];
 }
+
+int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg)
+{
+	struct cfi_reg *cfa = &insn->cfi.cfa;
+
+	switch (sp_reg) {
+	case ORC_REG_UNDEFINED:
+		cfa->base = CFI_UNDEFINED;
+		break;
+	case ORC_REG_SP:
+		cfa->base = CFI_SP;
+		break;
+	case ORC_REG_BP:
+		cfa->base = CFI_BP;
+		break;
+	case ORC_REG_SP_INDIRECT:
+		cfa->base = CFI_SP_INDIRECT;
+		break;
+	case ORC_REG_R10:
+		cfa->base = CFI_R10;
+		break;
+	case ORC_REG_R13:
+		cfa->base = CFI_R13;
+		break;
+	case ORC_REG_DI:
+		cfa->base = CFI_DI;
+		break;
+	case ORC_REG_DX:
+		cfa->base = CFI_DX;
+		break;
+	default:
+		return -1;
+	}
+
+	return 0;
+}
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 60e23c8f93e0..8630a2d5e68c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1261,32 +1261,7 @@ static int read_unwind_hints(struct objtool_file *file)
 
 		insn->hint = true;
 
-		switch (hint->sp_reg) {
-		case ORC_REG_UNDEFINED:
-			cfa->base = CFI_UNDEFINED;
-			break;
-		case ORC_REG_SP:
-			cfa->base = CFI_SP;
-			break;
-		case ORC_REG_BP:
-			cfa->base = CFI_BP;
-			break;
-		case ORC_REG_SP_INDIRECT:
-			cfa->base = CFI_SP_INDIRECT;
-			break;
-		case ORC_REG_R10:
-			cfa->base = CFI_R10;
-			break;
-		case ORC_REG_R13:
-			cfa->base = CFI_R13;
-			break;
-		case ORC_REG_DI:
-			cfa->base = CFI_DI;
-			break;
-		case ORC_REG_DX:
-			cfa->base = CFI_DX;
-			break;
-		default:
+		if (arch_decode_hint_reg(insn, hint->sp_reg)) {
 			WARN_FUNC("unsupported unwind_hint sp base reg %d",
 				  insn->sec, insn->offset, hint->sp_reg);
 			return -1;
-- 
2.21.3

