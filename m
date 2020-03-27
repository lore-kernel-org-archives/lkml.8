Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F66C2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E392820774
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DuKrnVrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgC0P3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:29:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:59854 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727725AbgC0P3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 11:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585322943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c5+B4C2+5e2TyPoBaB+IOu52gh+Qc7weu81l9ECmgdY=;
        b=DuKrnVrTuI/x8/jMFDI9rXHKHk+9/ggo3HIsCm9Bg9VhTBy0r2qI1k2ekUHwv8rfEBRPXe
        JaOAOmZ75Wa5FoaNdRjcNLUfAo8xFuuEincCW7pAnu83nAS8Sw1Rkh/SYoBogflPD/KerA
        fpLUYsCawhzu2wsf6CGuhcEWvh0km+M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-UIoayCJBMl66j00nA6gbEQ-1; Fri, 27 Mar 2020 11:29:00 -0400
X-MC-Unique: UIoayCJBMl66j00nA6gbEQ-1
Received: by mail-wm1-f70.google.com with SMTP id y1so4505733wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 08:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c5+B4C2+5e2TyPoBaB+IOu52gh+Qc7weu81l9ECmgdY=;
        b=DU1zwzhJkx5P3X4XCuPUutdqiLg2OimUNWo7GbAwnghNXXs3EERdoDPWqCzWlKQsyv
         vpLhZ4JHBBp0uL1i2Q/QpJA58G1TP4xc1/QjIMMeo3FFd8UaZz4CToqMaGkiaZXRAgFC
         H8xhblS5r9th2J19nZMjPyJm1E1h9LlqPIUhDeBrIajshCW6VdGg7maal2FgF9Pv+NAk
         ONWfncsDFf0BWYInl/+tQdkiNK04qaTC8Mb/5LinWuNmGHgHTAaI9SWMSl7ycKKqPblb
         Lu+x8pVjkaxEVQjVDUHGVZfwW4Lwqi6AcnJjrcpMPlOSqfUOKlaYYxSyCZtooUO3kl7t
         1+hQ==
X-Gm-Message-State: ANhLgQ0XUFGCf6O09VRrJp8JPM/R0PtGUB63dJawAcr6Ooi3beHpTfXa
        7zO+ON5L/TE4lvTdzag0fEoQG+Rn1NV9TU8bAQzz5xtfwG5DvgPAnNtxB7PApHW9SUHpyj0a3gC
        tb0ggcOcICWl7mGiOXt6wEJXx
X-Received: by 2002:a1c:197:: with SMTP id 145mr5789515wmb.42.1585322938404;
        Fri, 27 Mar 2020 08:28:58 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtzXVmK7AszkLRPPQuhSvaoR7KF0cl0sjzsfkv/NC7G43LpQRWyUXej2+pCODrXV30DdQaVCw==
X-Received: by 2002:a1c:197:: with SMTP id 145mr5789499wmb.42.1585322938204;
        Fri, 27 Mar 2020 08:28:58 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id i8sm8906856wrb.41.2020.03.27.08.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 08:28:56 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v2 03/10] objtool: check: Clean instruction state before each function validation
Date:   Fri, 27 Mar 2020 15:28:40 +0000
Message-Id: <20200327152847.15294-4-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200327152847.15294-1-jthierry@redhat.com>
References: <20200327152847.15294-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a function fails its validation, it might leave a stale state
that will be used for the validation of other functions. That would
cause false warnings on potentially valid functions.

Reset the instruction state before the validation of each individual
function.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/check.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3ab87e3aa750..74353b2c39ce 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2400,13 +2400,6 @@ static int validate_section(struct objtool_file *file, struct section *sec)
 	struct insn_state state;
 	int ret, warnings = 0;
 
-	clear_insn_state(&state);
-
-	state.cfa = initial_func_cfi.cfa;
-	memcpy(&state.regs, &initial_func_cfi.regs,
-	       CFI_NUM_REGS * sizeof(struct cfi_reg));
-	state.stack_size = initial_func_cfi.cfa.offset;
-
 	list_for_each_entry(func, &sec->symbol_list, list) {
 		if (func->type != STT_FUNC)
 			continue;
@@ -2424,6 +2417,12 @@ static int validate_section(struct objtool_file *file, struct section *sec)
 		if (!insn || insn->ignore || insn->visited)
 			continue;
 
+		clear_insn_state(&state);
+		state.cfa = initial_func_cfi.cfa;
+		memcpy(&state.regs, &initial_func_cfi.regs,
+		       CFI_NUM_REGS * sizeof(struct cfi_reg));
+		state.stack_size = initial_func_cfi.cfa.offset;
+
 		state.uaccess = func->uaccess_safe;
 
 		ret = validate_branch(file, func, insn, state);
-- 
2.21.1

