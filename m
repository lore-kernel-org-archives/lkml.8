Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A39AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 21:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B4072063A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 21:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xp/XrIDu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgHEVHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 17:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbgHEVHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 17:07:53 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A691C061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 14:07:53 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kr4so5413359pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 14:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6FQQh9grVE9WmqeYXdehIdQwW9U/dAMb893sRAt75ZM=;
        b=Xp/XrIDuVUyJT5+h+fRWdH5AGHClQV7LL1pHflyIiX8/g2oGRbaiwj44x+auCBuIqW
         F1xntosLaa0foveAwMoJm41zcfdOWJ6QH9H+98AWkjkB68iNHiQIF2DVNiUOiahyUHto
         EbxIOaGuaKyZF7mgvzR4afLhNSOyzQRhiyS2ulRKQtM617jIAT8t+oc5Q8Ia0MEO3HHM
         h3kMcYxnqcXdSfnFCU3WRfVvpt9dMW5Qur2O9sLIjtcd+5t7kAqh3UZsF7MSl9i2Fhle
         alPzl0llmRhxNspuyVpOpnfRC5axu3UolPonDCRgnP/EcbnOwwYgFLKvEp30LVehnyUe
         +zYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6FQQh9grVE9WmqeYXdehIdQwW9U/dAMb893sRAt75ZM=;
        b=mcizX5Os2qIBSQu2mp5EpnyWlnBek4sljnGQouIW6dvHaJbBKpXNh08Sr/mDQmpeeB
         1EN8Ob4MtssRW7Fb4foCEDZQzLfwWLq5nE+xwyhIIKrOs/8EAyxj6QbKU9Nrmuu/spdl
         kLkkKpZVlC8IcdIEBown4yHcwV0r0vyYeID1X1bJ402e4fqWfOoBhZUypmVfEk1MoAaV
         Z9OeFlEn9bX01rWqvpxn5bs1gq7pP4QT+DYCxxrLJ8LWZ1/2zKRH0DJwA+HuNcZngtUq
         qeJSHIQA7DP4l11UUhUTTb63sF964qENy5YFNfdTjMy7RFmWzsjPpjRlIBzILEdr2LxB
         rSYA==
X-Gm-Message-State: AOAM531orIUTPKBylH3geRPwStHZ4BizlpuMS7CYhKoLwv1vqt48qINB
        /VFHWRqtZz+jUDgfBELyt0ccEkh4
X-Google-Smtp-Source: ABdhPJzRiGMTYMevkiMEA0rjmyQMTuKQcrG6ioSC88DSO2hfVm9V39SQ0lntBlhFGO9QVpuFTu5Ygw==
X-Received: by 2002:a17:902:9042:: with SMTP id w2mr4959522plz.9.1596661672016;
        Wed, 05 Aug 2020 14:07:52 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id s61sm4270907pjb.57.2020.08.05.14.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 14:07:50 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        openrisc@lists.librecores.org
Subject: [PATCH v2 3/6] openrisc: uaccess: Use static inline function in access_ok
Date:   Thu,  6 Aug 2020 06:07:22 +0900
Message-Id: <20200805210725.310301-4-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200805210725.310301-1-shorne@gmail.com>
References: <20200805210725.310301-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Linus when reviewing commit 9cb2feb4d21d
("arch/openrisc: Fix issues with access_ok()") last year; making
__range_ok an inline function also fixes the used twice issue that the
commit was fixing.  I agree it's a good cleanup.  This patch addresses
that as I am currently working on the access_ok macro to fixup sparse
annotations in OpenRISC.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/uaccess.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
index f2fc5c4b88c3..4b59dc9ad300 100644
--- a/arch/openrisc/include/asm/uaccess.h
+++ b/arch/openrisc/include/asm/uaccess.h
@@ -48,16 +48,19 @@
 /* Ensure that the range from addr to addr+size is all within the process'
  * address space
  */
-#define __range_ok(addr, size) (size <= get_fs() && addr <= (get_fs()-size))
+static inline int __range_ok(unsigned long addr, unsigned long size)
+{
+	const mm_segment_t fs = get_fs();
+
+	return size <= fs && addr <= (fs - size);
+}
 
 /* Ensure that addr is below task's addr_limit */
 #define __addr_ok(addr) ((unsigned long) addr < get_fs())
 
 #define access_ok(addr, size)						\
 ({ 									\
-	unsigned long __ao_addr = (unsigned long)(addr);		\
-	unsigned long __ao_size = (unsigned long)(size);		\
-	__range_ok(__ao_addr, __ao_size);				\
+	__range_ok((unsigned long)(addr), (size));			\
 })
 
 /*
-- 
2.26.2

