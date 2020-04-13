Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1557C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 23:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72BCA20739
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 23:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uuJSa5gi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389955AbgDMXKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 19:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389929AbgDMXKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 19:10:20 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A20C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 16:10:20 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id m25so9893195pgl.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 16:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vuPWpOEpABdmh/1VI4/up8dAs2XH63GBNImm7d32EIk=;
        b=uuJSa5giC8TYDkne2taIdNZXmrgXcjt5CgpmGdHhNkQ5j9v4VYPqCbuOp/KxDtbpN/
         4cEve/TUCY86wv/6A7knM+8e9X2X26bBtQI1pCE3hfpB0tNpS2C6uuPLmBbXCsDUsLCt
         yGMJ+F5vrbUcoQa3o341Dx9C5iCe89I30q1guImO4DyqZb4diH3XCeHvbcpviNeozcws
         gj+8/im9ix9ynfMpIso42JYQXromt7QpwqYKI74mEYsJhq5j9oGEAXhJZ135kR2imQDD
         3m4Qjg55XxOsQiFJaEkVMAaVkGz41KeMuqSEUp5ld97t/FXZdGOxaDPNmBYTGbIKMZAN
         aCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vuPWpOEpABdmh/1VI4/up8dAs2XH63GBNImm7d32EIk=;
        b=NG+4r7zxdwwH4PZ21UruB0ermEUaghddwpP7zhFJVa+7KZ9ERzfuJh/bgi/u2fC0kS
         8HCZwuemKalLLQCfe7HsBOndUbHuLP5nbPswHtdX4cPVGMsN7JA0ggNuetE7r84ja4cA
         8nOtM/06mKUeySOp3PFuQLEUvmufex/Y8dziBwWzTWCtcvTnOJ4cslUGi6k+0ARhWLxc
         anJ4R5HGnvT3CXD0IomEimuSHKMsWzVYL0KovNgb6vmFVr3CxrQkcdgCnTfyLpw6gbmM
         agwNUCey0mcRy5cgmODf7slPO04FTrTtLwopOFgHAeJfmIUUazEuGq6I4Ik7xUrX2blW
         4syA==
X-Gm-Message-State: AGi0PuZDoRN267XPc+0VlJL6KvQa4p4xvh53AGTlti6v4CI9lhkg9KRF
        mJkFvOgVM6czUsKR9qdx6I+Bhz40q3eY
X-Google-Smtp-Source: APiQypLAo/3dWG3aUJ9m8iimrYZneDDZJRDeReO1X+fvoW4FdoVomY39iYtNWeyL4ijSeh5b/qrZUHHF+4CD
X-Received: by 2002:a63:b256:: with SMTP id t22mr18355736pgo.92.1586819420186;
 Mon, 13 Apr 2020 16:10:20 -0700 (PDT)
Date:   Mon, 13 Apr 2020 16:10:16 -0700
Message-Id: <20200413231016.250737-1-maskray@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH] arm64: kvm: Delete duplicated label: in invalid_vector
From:   Fangrui Song <maskray@google.com>
To:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SYM_CODE_START defines \label , so it is redundant to define \label again.
A redefinition at the same place is accepted by GNU as
(https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=159fbb6088f17a341bcaaac960623cab881b4981)
but rejected by the clang integrated assembler.

Fixes: 617a2f392c92 ("arm64: kvm: Annotate assembly using modern annoations")
Link: https://github.com/ClangBuiltLinux/linux/issues/988
Signed-off-by: Fangrui Song <maskray@google.com>
---
 arch/arm64/kvm/hyp/hyp-entry.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index c2a13ab3c471..9c5cfb04170e 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -198,7 +198,6 @@ SYM_CODE_END(__hyp_panic)
 .macro invalid_vector	label, target = __hyp_panic
 	.align	2
 SYM_CODE_START(\label)
-\label:
 	b \target
 SYM_CODE_END(\label)
 .endm
-- 
2.26.0.110.g2183baf09c-goog

