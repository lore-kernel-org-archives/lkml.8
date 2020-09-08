Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BB0C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27A00206E7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G2Tb/SZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732076AbgIHQph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732033AbgIHQpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:45:24 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F715C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 09:45:23 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id c196so5954954pfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 09:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JKomSZvpghf+Dm6gfTAHJMQNUQfDrL4+0Wofl7/YKHc=;
        b=G2Tb/SZv9au0w+jWONcGBkz3Pn1Gv7zGqRZNLpc6yB4T2bvTqCq/HNRFmyfjv//WqQ
         htKcXZfzpKdmWQ+bShSHZUnZMw8E5228XwrISWlz563nhyyw5skHbRJUBt9CeAA8+2BY
         UEVD2xI9WB0Jjw95PAKo7Tf24K5TTONAZ/GjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JKomSZvpghf+Dm6gfTAHJMQNUQfDrL4+0Wofl7/YKHc=;
        b=C43uDG1XAqk+2PmfUdC1tUEZbEd6HVfyFxCcoxBu6W5Dyg9FnRK9txul7KjRvBwicQ
         XUE8nlP65VjTtG8sFZMem6nhhEtg48/KtiyE7vKBoWL0E5TFCFawn8zB0Gkyc4KInWux
         X/tmWGmqPBzY74nY1+WVD/tdcJ4BstzGyCgEjq4yoQFC09o7ffqcf4roYMj5YlZRmz3d
         7qklWKQKd+dL28t4LkzjXeuqJJ58kJ/AWDwnalJQsptcm7P9zJ0bRWczTFwqKQ2IOl0c
         VP31o1uiEtgWVjJaknonz8eEqnYzYcY8WoQr1950W9NoxaxTALysu3v5sk7I/LOJFnmr
         xk8g==
X-Gm-Message-State: AOAM530p5dpPrAxV3gk+NhDhET+zOD2x3Ahn7wXfJqIIg19hOfo799Vw
        F+ej7mnUBeL553a+6yzWHH0zyg==
X-Google-Smtp-Source: ABdhPJx7hCIV8BKIAJvn+AgXwDgqtxxvOnxMasosT+3CIGDwdB9jTGsy08u1wjbNvbMLh+oYBPgclg==
X-Received: by 2002:a62:178d:0:b029:13e:d13d:a0f8 with SMTP id 135-20020a62178d0000b029013ed13da0f8mr1914804pfx.20.1599583522692;
        Tue, 08 Sep 2020 09:45:22 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id d20sm2696pjv.39.2020.09.08.09.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 09:45:21 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-mips@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        james.quinlan@broadcom.com
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH v1] MIPS: uasm: false warning on use of uasm_i_lui()
Date:   Tue,  8 Sep 2020 12:45:06 -0400
Message-Id: <20200908164512.15379-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the example uasm code

	uasm_i_lui(p, tmp, 0xa000);

issues a warning at Linux boot when the code is "assembled".  This is
because the "lui" instruction is defined by the macro "Ip_u1s2(_lui)" -- I
believe it should be Ip_u1u2(_lui) -- and its definition is associated with
the SIMM macro -- I believe it should be the UIMM macro.  The current code
takes a 32bit number and checks that it can be converted to a 16bit signed
immediate.  This check fails of course for an immediate such as 0x0000a000.

This is fixed.  However, there are two uses of uasm_i_lui() in
UASM_i_LA_mostly() which use 16bit signed immediates in the form of a
sign-extended 32 bit number.  Left alone these may now cause a warning when
being processed by build_imm().  These two uses have been modified by first
calling build_simm() on the argument to uasm_i_lui() as to convert it to a
proper 16 bit unsigned integer.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 arch/mips/include/asm/uasm.h  | 2 +-
 arch/mips/mm/uasm-micromips.c | 2 +-
 arch/mips/mm/uasm-mips.c      | 2 +-
 arch/mips/mm/uasm.c           | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index f7effca791a5..7ea1d338570b 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -127,7 +127,7 @@ Ip_u2s3u1(_lh);
 Ip_u2s3u1(_lhu);
 Ip_u2s3u1(_ll);
 Ip_u2s3u1(_lld);
-Ip_u1s2(_lui);
+Ip_u1u2(_lui);
 Ip_u2s3u1(_lw);
 Ip_u2s3u1(_lwu);
 Ip_u3u1u2(_lwx);
diff --git a/arch/mips/mm/uasm-micromips.c b/arch/mips/mm/uasm-micromips.c
index 75ef90486fe6..86ee1499e120 100644
--- a/arch/mips/mm/uasm-micromips.c
+++ b/arch/mips/mm/uasm-micromips.c
@@ -82,7 +82,7 @@ static const struct insn insn_table_MM[insn_invalid] = {
 	[insn_lh]	= {M(mm_lh32_op, 0, 0, 0, 0, 0), RT | RS | SIMM},
 	[insn_ll]	= {M(mm_pool32c_op, 0, 0, (mm_ll_func << 1), 0, 0), RS | RT | SIMM},
 	[insn_lld]	= {0, 0},
-	[insn_lui]	= {M(mm_pool32i_op, mm_lui_op, 0, 0, 0, 0), RS | SIMM},
+	[insn_lui]	= {M(mm_pool32i_op, mm_lui_op, 0, 0, 0, 0), RS | UIMM},
 	[insn_lw]	= {M(mm_lw32_op, 0, 0, 0, 0, 0), RT | RS | SIMM},
 	[insn_mfc0]	= {M(mm_pool32a_op, 0, 0, 0, mm_mfc0_op, mm_pool32axf_op), RT | RS | RD},
 	[insn_mfhi]	= {M(mm_pool32a_op, 0, 0, 0, mm_mfhi32_op, mm_pool32axf_op), RS},
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index 7154a1d99aad..b45c15111d68 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -132,7 +132,7 @@ static const struct insn insn_table[insn_invalid] = {
 	[insn_ll]	= {M6(spec3_op, 0, 0, 0, ll6_op),  RS | RT | SIMM9},
 	[insn_lld]	= {M6(spec3_op, 0, 0, 0, lld6_op),  RS | RT | SIMM9},
 #endif
-	[insn_lui]	= {M(lui_op, 0, 0, 0, 0, 0),	RT | SIMM},
+	[insn_lui]	= {M(lui_op, 0, 0, 0, 0, 0),	RT | UIMM},
 	[insn_lw]	= {M(lw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
 	[insn_lwu]	= {M(lwu_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
 	[insn_lwx]	= {M(spec3_op, 0, 0, 0, lwx_op, lx_op), RS | RT | RD},
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index c56f129c9a4b..ca5d47da3bd1 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -327,7 +327,7 @@ I_u2s3u1(_lh)
 I_u2s3u1(_lhu)
 I_u2s3u1(_ll)
 I_u2s3u1(_lld)
-I_u1s2(_lui)
+I_u1u2(_lui)
 I_u2s3u1(_lw)
 I_u2s3u1(_lwu)
 I_u1u2u3(_mfc0)
@@ -457,7 +457,7 @@ UASM_EXPORT_SYMBOL(uasm_rel_lo);
 void UASM_i_LA_mostly(u32 **buf, unsigned int rs, long addr)
 {
 	if (!uasm_in_compat_space_p(addr)) {
-		uasm_i_lui(buf, rs, uasm_rel_highest(addr));
+		uasm_i_lui(buf, rs, build_simm(uasm_rel_highest(addr)));
 		if (uasm_rel_higher(addr))
 			uasm_i_daddiu(buf, rs, rs, uasm_rel_higher(addr));
 		if (uasm_rel_hi(addr)) {
@@ -468,7 +468,7 @@ void UASM_i_LA_mostly(u32 **buf, unsigned int rs, long addr)
 		} else
 			uasm_i_dsll32(buf, rs, rs, 0);
 	} else
-		uasm_i_lui(buf, rs, uasm_rel_hi(addr));
+		uasm_i_lui(buf, rs, build_simm(uasm_rel_hi(addr)));
 }
 UASM_EXPORT_SYMBOL(UASM_i_LA_mostly);
 
-- 
2.17.1

