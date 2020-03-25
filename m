Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDA5C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34E4206F6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPVlsj1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgCYImX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:42:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:57187 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727450AbgCYImT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585125738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2qAIsNPbUeit8zA2dMkgRwMCGJOGJ4HMvWIxREwTod4=;
        b=SPVlsj1zziItwSKv4Qv6mE7x11oZ0XAeeGh43OzAZpACYAZIMXPD3TWtjCLDZDm+W8lpjb
        qGl4JRedah/yv35esgr6GM+Qeyw2D5udQlDnXPILVlRqJfeizm8OUNsT2kXe6x/MEjC6Ux
        vZKNwTda2OqrNP1bCQQeOMV0bgnBZ28=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-YwZYQbwPOI-PM0bvfXVXag-1; Wed, 25 Mar 2020 04:42:15 -0400
X-MC-Unique: YwZYQbwPOI-PM0bvfXVXag-1
Received: by mail-wm1-f69.google.com with SMTP id g9so2222620wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 01:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2qAIsNPbUeit8zA2dMkgRwMCGJOGJ4HMvWIxREwTod4=;
        b=K1E8N8C+/AF3nPmh2di8es0HM7TnYZwKj2OzCBtXGTjIBdmIafDH+ge1aba/RStAT/
         xz32/ur5h/98SQMY5Cf3oVTH1+iWZatkYtMHc5FL9x9h4Yl3sA9c6SZ93HsE89SYvK1K
         VUpwZGDUJ9/Q4toPAMkYBNcuG1APBboDhMzOcSW0to0addK14sMxr6PcMm/hMd4OMbTJ
         rpymVNJwV/dZTqoMA4B72zNNbxgi0AlkTD0lunpglx33Jujn7fjFNiHKdnrApebMwo2k
         nI8YjmaaW+O8WNvVtjZl678Oq19pOEUEzHln5avHOKalnTbCJLjjTo3meFF9m0Yr2wwL
         v13w==
X-Gm-Message-State: ANhLgQ1klI5RMtf05KQrUm2qdHOTjjVbHfyUerPQW2ygj9Yr3YVSUhXV
        tnUFTq0QglXaUq0QuyHjSgsbI+jPGPL9yszL1kHRMnUwwdhDXOyg1mYEF7N1yIyi/v79LpvVMpm
        aHq+GQOQBi6BnOwJuToLN3bX7
X-Received: by 2002:a5d:5386:: with SMTP id d6mr2284685wrv.92.1585125733931;
        Wed, 25 Mar 2020 01:42:13 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt7S1Bk6wjwuZycIOSbbEksE/h4lCPt6PRAvCOxIrre14/mA55s9ob1RIVLqShpjIy99dQSZg==
X-Received: by 2002:a5d:5386:: with SMTP id d6mr2284677wrv.92.1585125733796;
        Wed, 25 Mar 2020 01:42:13 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id f12sm8055323wmf.24.2020.03.25.01.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 01:42:13 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 03/10] objtool: check: Clean instruction state before each function validation
Date:   Wed, 25 Mar 2020 08:41:56 +0000
Message-Id: <20200325084203.17005-4-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325084203.17005-1-jthierry@redhat.com>
References: <20200325084203.17005-1-jthierry@redhat.com>
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
index 44a3abbb0b0b..0ccf6882d8ce 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2406,13 +2406,6 @@ static int validate_functions(struct objtool_file *file)
 	struct insn_state state;
 	int ret, warnings = 0;
 
-	clear_insn_state(&state);
-
-	state.cfa = initial_func_cfi.cfa;
-	memcpy(&state.regs, &initial_func_cfi.regs,
-	       CFI_NUM_REGS * sizeof(struct cfi_reg));
-	state.stack_size = initial_func_cfi.cfa.offset;
-
 	for_each_sec(file, sec) {
 		list_for_each_entry(func, &sec->symbol_list, list) {
 			if (func->type != STT_FUNC)
@@ -2431,6 +2424,12 @@ static int validate_functions(struct objtool_file *file)
 			if (!insn || insn->ignore || insn->visited)
 				continue;
 
+			clear_insn_state(&state);
+			state.cfa = initial_func_cfi.cfa;
+			memcpy(&state.regs, &initial_func_cfi.regs,
+			       CFI_NUM_REGS * sizeof(struct cfi_reg));
+			state.stack_size = initial_func_cfi.cfa.offset;
+
 			state.uaccess = func->uaccess_safe;
 
 			ret = validate_branch(file, func, insn, state);
-- 
2.21.1

