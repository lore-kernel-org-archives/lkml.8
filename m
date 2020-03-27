Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C922AC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C1E2082D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgC0C3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:29:01 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47824 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgC0C2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:28:40 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHejd-003hFr-My; Fri, 27 Mar 2020 02:28:37 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH v2 4/8] objtool: whitelist __sanitizer_cov_trace_switch()
Date:   Fri, 27 Mar 2020 02:28:32 +0000
Message-Id: <20200327022836.881203-4-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327022836.881203-1-viro@ZenIV.linux.org.uk>
References: <x86: unsafe_put-style macro for sigmask>
 <20200327022836.881203-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

it's not really different from e.g. __sanitizer_cov_trace_cmp4();
as it is, the switches that generate an array of labels get
rejected by objtool, while slightly different set of cases
that gets compiled into a series of comparisons is accepted.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4768d91c6d68..3667c5d7453a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -478,6 +478,7 @@ static const char *uaccess_safe_builtin[] = {
 	"__sanitizer_cov_trace_cmp2",
 	"__sanitizer_cov_trace_cmp4",
 	"__sanitizer_cov_trace_cmp8",
+	"__sanitizer_cov_trace_switch",
 	/* UBSAN */
 	"ubsan_type_mismatch_common",
 	"__ubsan_handle_type_mismatch",
-- 
2.11.0

