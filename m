Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A647C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00360215A4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="MsltEajV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbgBQQsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:48:39 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46637 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbgBQQsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:48:39 -0500
Received: by mail-qt1-f195.google.com with SMTP id i14so5241681qtv.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 08:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=et9GtBlMwNyxXKtY81oCoU0p2n7F0NO/hCNz4eL9vi4=;
        b=MsltEajVC7Lm/8rj+VK0/bBou9ueubcoYM1ggoVVaK1xxTGTPTHah7qcq/2NnPYrQn
         3v+ldGqaICuedwbPKZnqJFID347yBwxclCc/mlWjX02kVSDodn5UZpjJCZtJeiEZ9iV1
         PK2z2pLj9gMhtNlfP7D/DwsUhx0dT18QaY1PAOTTDuEivFQwmiioNAf3pygnOgIQsQxG
         BwxGL95/gwlXDxc1aKE5nn9VQE045CxPeVeVQk0IcoUf0vLgDBzZmvOUd/E5MAKSbcvp
         hOKKYsUTYmXpaWBg9lNmk7+ETCeBEeyPhVl+8a+wRJx/UB5gCWEHwNk8yhG5Z2dnX9C4
         XRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=et9GtBlMwNyxXKtY81oCoU0p2n7F0NO/hCNz4eL9vi4=;
        b=dKmiKkgmL71PX7suJmcxN1QlpR5qglnga8cdMdfAFeYdyQTKqf5PuyvW+DMGY23YVs
         Ga33Nn8aV058r2hVe28Elk6zMI02P3nsT6d3TbHrmXvq0jxlV3eVuDINFf33T/45wSou
         yXFBhATn0X7hlHpZj6aNoJXrxtV+HQa64EvmKeEeZ//xLvQO6AW+4Jq3MCyPicGHxv2s
         xTy4xWlggAGT/DVVOcVKbFsHimC6S5xxAYbXYWtx8WyV17qlRbT2fYb888KNUxgAfkld
         +65PnQ0oeDFGdLmeb2W7FbBS5HDKlgXE1/0ZtE+hE7HdvQA6VFsaUVjMZL544vBFD08t
         5Siw==
X-Gm-Message-State: APjAAAXV+Vdg0duY0EAOdVIzDEnqTRTCyuZ+W82Py0I8JrDXadeXeS3k
        7Zo+KIftllpdaTDCe2T9XKcx1A==
X-Google-Smtp-Source: APXvYqxrKwMoVogoFbUxH1yhlHkDUk5WxvIvhRaGwwYyjVjQnDoFqAia0cI5ZzRTsqQHqmWwYcFzEQ==
X-Received: by 2002:ac8:3fa9:: with SMTP id d38mr13115689qtk.333.1581958118352;
        Mon, 17 Feb 2020 08:48:38 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id b12sm476086qkl.0.2020.02.17.08.48.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2020 08:48:37 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     pbonzini@redhat.com
Cc:     sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v2] kvm/emulate: fix a -Werror=cast-function-type
Date:   Mon, 17 Feb 2020 11:48:26 -0500
Message-Id: <1581958106-16668-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/x86/kvm/emulate.c: In function 'x86_emulate_insn':
arch/x86/kvm/emulate.c:5686:22: error: cast between incompatible
function types from 'int (*)(struct x86_emulate_ctxt *)' to 'void
(*)(struct fastop *)' [-Werror=cast-function-type]
    rc = fastop(ctxt, (fastop_t)ctxt->execute);

Fix it by using an unnamed union of a (*execute) function pointer and a
(*fastop) function pointer.

Fixes: 3009afc6e39e ("KVM: x86: Use a typedef for fastop functions")
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: use an unnamed union.

 arch/x86/include/asm/kvm_emulate.h | 13 ++++++++++++-
 arch/x86/kvm/emulate.c             | 36 ++++++++++++++----------------------
 2 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/kvm_emulate.h b/arch/x86/include/asm/kvm_emulate.h
index 03946eb3e2b9..2a8f2bd2e5cf 100644
--- a/arch/x86/include/asm/kvm_emulate.h
+++ b/arch/x86/include/asm/kvm_emulate.h
@@ -292,6 +292,14 @@ enum x86emul_mode {
 #define X86EMUL_SMM_MASK             (1 << 6)
 #define X86EMUL_SMM_INSIDE_NMI_MASK  (1 << 7)
 
+/*
+ * fastop functions are declared as taking a never-defined fastop parameter,
+ * so they can't be called from C directly.
+ */
+struct fastop;
+
+typedef void (*fastop_t)(struct fastop *);
+
 struct x86_emulate_ctxt {
 	const struct x86_emulate_ops *ops;
 
@@ -324,7 +332,10 @@ struct x86_emulate_ctxt {
 	struct operand src;
 	struct operand src2;
 	struct operand dst;
-	int (*execute)(struct x86_emulate_ctxt *ctxt);
+	union {
+		int (*execute)(struct x86_emulate_ctxt *ctxt);
+		fastop_t fop;
+	};
 	int (*check_perm)(struct x86_emulate_ctxt *ctxt);
 	/*
 	 * The following six fields are cleared together,
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index ddbc61984227..dd19fb3539e0 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -191,25 +191,6 @@
 #define NR_FASTOP (ilog2(sizeof(ulong)) + 1)
 #define FASTOP_SIZE 8
 
-/*
- * fastop functions have a special calling convention:
- *
- * dst:    rax        (in/out)
- * src:    rdx        (in/out)
- * src2:   rcx        (in)
- * flags:  rflags     (in/out)
- * ex:     rsi        (in:fastop pointer, out:zero if exception)
- *
- * Moreover, they are all exactly FASTOP_SIZE bytes long, so functions for
- * different operand sizes can be reached by calculation, rather than a jump
- * table (which would be bigger than the code).
- *
- * fastop functions are declared as taking a never-defined fastop parameter,
- * so they can't be called from C directly.
- */
-
-struct fastop;
-
 struct opcode {
 	u64 flags : 56;
 	u64 intercept : 8;
@@ -311,8 +292,19 @@ static void invalidate_registers(struct x86_emulate_ctxt *ctxt)
 #define ON64(x)
 #endif
 
-typedef void (*fastop_t)(struct fastop *);
-
+/*
+ * fastop functions have a special calling convention:
+ *
+ * dst:    rax        (in/out)
+ * src:    rdx        (in/out)
+ * src2:   rcx        (in)
+ * flags:  rflags     (in/out)
+ * ex:     rsi        (in:fastop pointer, out:zero if exception)
+ *
+ * Moreover, they are all exactly FASTOP_SIZE bytes long, so functions for
+ * different operand sizes can be reached by calculation, rather than a jump
+ * table (which would be bigger than the code).
+ */
 static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 
 #define __FOP_FUNC(name) \
@@ -5683,7 +5675,7 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
 
 	if (ctxt->execute) {
 		if (ctxt->d & Fastop)
-			rc = fastop(ctxt, (fastop_t)ctxt->execute);
+			rc = fastop(ctxt, ctxt->fop);
 		else
 			rc = ctxt->execute(ctxt);
 		if (rc != X86EMUL_CONTINUE)
-- 
1.8.3.1

