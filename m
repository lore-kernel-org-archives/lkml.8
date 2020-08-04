Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDFBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 04:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 259682070A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 04:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uBZEqpyk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbgHDEYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 00:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHDEYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 00:24:20 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4022AC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 21:24:20 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t10so16823449plz.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 21:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6FQQh9grVE9WmqeYXdehIdQwW9U/dAMb893sRAt75ZM=;
        b=uBZEqpykqt1c/NtoFtFkiYRPjXq/DjkOC0dqEIKQYgA2z0nQlsMOqtZvNnnfjhBavS
         yxgafmW7t7eLvEI95aD4U3Q++5esqlDcoAha32yxun7dmQcnCodO7Q26e6yB+zvXjHBR
         Ptg2VdD7gcpq05vmN5IaF6kFxdeSiV2kgF40qS2kmBwEBqyL6K9GGSl+TqoKva7HX8YS
         EhM27dQ1eauN2I4rZh7uozUGDyngS1OqWLpLzpTqNugz+hLtY//Oz3TST/Zh+K/fnNwx
         WVygcl1Sxfi7L++kT6MTKKOgHiHPQ2YIxyNddZR+FC+URSgoATOvCJiiQ+bNWWdcYyjA
         dpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6FQQh9grVE9WmqeYXdehIdQwW9U/dAMb893sRAt75ZM=;
        b=awWettHnOfAVp3JjmYq94VGN02BXxezcAT+WcjBc0MgmtHFTS5eUJIbUCuz/e4z+i2
         Z6XaPz8Pie9lPdALxsPxd8GzhCEHiBq4zG5FioUmir9seMsscvDGz71xiKQcUBKdNJhA
         daNHFHAZQYyciYG+f/1uG+qhFh2mJlDZBkhPFVkkTEsWEzE57sbdZPjXFxLmuXgbnSfd
         WhoBUDhyygXiFFcDrU64X3ZEANg+xhPfxwj2wFe2CWhhrSYaDTYKz8TbqvotMsAIbWe1
         250vdlGf8KiZaRazHl8VctJSq3LrbzkxV4Ap/IIHIo9Q7+BNoBdGxff76tyc6aHgfK0s
         IIYw==
X-Gm-Message-State: AOAM531rSFbVSd8hJtbHv5CJKzhOjPhbDr2TxNtueGKt7ZVnEAgsW1r/
        r0u6KMFpKjrVX4BQofa4q5I6d66x
X-Google-Smtp-Source: ABdhPJw6I1I1rhc5642O2n0pcD89AvC3Qz39sDbhZYqzI6laUlHGgX4EZG7iZEJLlzdMM+3COArm+g==
X-Received: by 2002:a17:902:9349:: with SMTP id g9mr17504812plp.313.1596515059299;
        Mon, 03 Aug 2020 21:24:19 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id r15sm12279933pfq.189.2020.08.03.21.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 21:24:18 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        openrisc@lists.librecores.org
Subject: [PATCH 3/6] openrisc: uaccess: Use static inline function in access_ok
Date:   Tue,  4 Aug 2020 13:23:51 +0900
Message-Id: <20200804042354.3930694-4-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200804042354.3930694-1-shorne@gmail.com>
References: <20200804042354.3930694-1-shorne@gmail.com>
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

