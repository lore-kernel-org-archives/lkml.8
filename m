Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C57C433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E28C2206B5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTIufmJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgHHXHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHHXHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:07:09 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BECDC061756
        for <linux-kernel@vger.kernel.org>; Sat,  8 Aug 2020 16:07:09 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m34so2860878pgl.11
        for <linux-kernel@vger.kernel.org>; Sat, 08 Aug 2020 16:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S+PYM2LWPubAwsecp2cm9Eg9qZYacd1EtMsG3lIYCHo=;
        b=tTIufmJ0TWMbd03xb8vnegxRX7bK+EaEleQwIcF1OSAOhCGoEhjxnNl3NeMEAatVKV
         AT14Tfkj9Sh8mHs9WSq4oKZF/urVFxOZKsNulnD3p8EKzyy4Lh/AkWTnCw9PBdLYhlMj
         rOgKwq6r9M1v9DM7fViMn4+QC/DpWWxQdxQosa2CCopnZYKw/Mwnp5cqnQ0uJUvmg72Z
         ZTK2vzs2THaJOFBdR38/KNjZfeI4QQaUsARbCsfOjN+S767We5MAWaIQKb5hWjA83v5O
         /apmaclkvqE5DpoAQpNLOodEZmbw0TmqPay5E3vMZFwNjJmERcAEDdks4mi7xuoiVgeL
         Pg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S+PYM2LWPubAwsecp2cm9Eg9qZYacd1EtMsG3lIYCHo=;
        b=iuL0NKBeyIiwE5/VZu+Fo1ZLkPWAqtKISd9aHPcm4a+nuZ4HBFgbkir37CPKiLun3i
         DSR4Tz+g0x187+UNa4YDr2gC61kIrK/h1cqIH31l0pVtGPjuBoOIy5hueXSMCc9HxqGI
         NQvtGekTIlU4SQpTQF018yNhGZ9A/UmmGjftPe/L0dVRvt1vPymm84WMzZjr0/ifemzG
         Exc9n7mDUfCfOm9gWdq7/s1CWXn9ZbEy4Hqh7opknFWaE6xM4bKXfxkUEVFMdG4frqaX
         s2/yA7rCIk/yDL6kQ2QlQz3yoyDAhIIiQUhWae2D19CZGOCYKEIIciGUH4V2HRAl/ulC
         BalQ==
X-Gm-Message-State: AOAM531AaY5PPPdmSgwVGEOwRtzZDyIVyR28We/iePS9wTntdyvawMjy
        UrDd79jOycNPDOsgAJQiEirqrCBb
X-Google-Smtp-Source: ABdhPJzGYJUpa9rN7iaUH+qm57gmZJfvQVG0zFjfB6O5iv/opID3H8mIBoZdP0o0WBYzAeZ+fg3c+w==
X-Received: by 2002:a62:b417:: with SMTP id h23mr18259041pfn.118.1596928028346;
        Sat, 08 Aug 2020 16:07:08 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id x7sm17623887pfc.209.2020.08.08.16.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 16:07:07 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Stafford Horne <shorne@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: [PATCH v3 3/6] openrisc: uaccess: Use static inline function in access_ok
Date:   Sun,  9 Aug 2020 08:06:44 +0900
Message-Id: <20200808230647.833047-4-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200808230647.833047-1-shorne@gmail.com>
References: <20200808230647.833047-1-shorne@gmail.com>
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
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
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

