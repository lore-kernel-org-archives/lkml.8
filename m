Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D79C433EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 01:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 282C92086A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 01:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgGXBZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 21:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgGXBZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 21:25:47 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC45C0619D3;
        Thu, 23 Jul 2020 18:25:47 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jymT4-001Gc8-Bj; Fri, 24 Jul 2020 01:25:46 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 01/20] xtensa: fix access check in csum_and_copy_from_user
Date:   Fri, 24 Jul 2020 02:25:27 +0100
Message-Id: <20200724012546.302155-1-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200724012512.GK2786714@ZenIV.linux.org.uk>
References: <20200724012512.GK2786714@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Filippov <jcmvbkbc@gmail.com>

Commit d341659f470b ("xtensa: switch to providing
csum_and_copy_from_user()") introduced access check, but incorrectly
tested dst instead of src.
Fix access_ok argument in csum_and_copy_from_user.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Fixes: d341659f470b ("xtensa: switch to providing csum_and_copy_from_user()")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/xtensa/include/asm/checksum.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/include/asm/checksum.h b/arch/xtensa/include/asm/checksum.h
index d8292cc9ebdf..243a5fe79d3c 100644
--- a/arch/xtensa/include/asm/checksum.h
+++ b/arch/xtensa/include/asm/checksum.h
@@ -57,7 +57,7 @@ static inline
 __wsum csum_and_copy_from_user(const void __user *src, void *dst,
 				   int len, __wsum sum, int *err_ptr)
 {
-	if (access_ok(dst, len))
+	if (access_ok(src, len))
 		return csum_partial_copy_generic((__force const void *)src, dst,
 					len, sum, err_ptr, NULL);
 	if (len)
-- 
2.11.0

