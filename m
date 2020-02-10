Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1990EC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28AD20714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Tup2u5IF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgBJOKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:10:32 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43541 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbgBJOKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:10:31 -0500
Received: by mail-qk1-f196.google.com with SMTP id p7so1609830qkh.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 06:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=o1FO2aoDKh5++SWDchty/IeRtGGhMroFxwtbPC/sRDE=;
        b=Tup2u5IFZdERxE1QBLvBxHOiArZ00RWuTCUSg63tlZfALHeOk/zrvdi87Y2k6nVUgl
         DBYJvJ8ZUU/KInRZFp3KeDKl5Jc21flL84qLaoZh/H8TO1dFDG8wHy8iBqEAeEdGidgW
         +tFURH6zj5TH4HKV/o8GZF88GQ2kBbhcQxOCLO3zGyTGQxWV6exCew9LHVYEGWjAIvBY
         HfrKhxL6wGubFuR2b3pGATEKh9BHuuMKGG16Fl4hXS5fkN4Fz6ZDUrZDM6vBrtnoJevF
         F9wi+b5e9J9Gc8RpkhgHFzcJmGkg4b+9GOJuC4pjma1Fv5Pw8sixWTNZp+MU6jFOdlb7
         HfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o1FO2aoDKh5++SWDchty/IeRtGGhMroFxwtbPC/sRDE=;
        b=ctQ3mB1ZUCE8lM6fwbrA3hVV7EReDRaPrx7XlSl75+XUYgUma0FvZI+UwO2PRlbibf
         dH5Qp2nOmcXdFJmtUCLNfqLhQDK8SImqA89wj2c3tZD3MFrHaIt6EI9k/1KIoSptLNCS
         OlUZRNuF5CKf1/Heb6iulPr4oHdSNjZ5RUcKpfH06EP2GeqUYsNW3rMF479BZy6O4pb3
         Ez4yjUsR9kDrh0Rp0GPQ/Sk5OGBG4zSWFd6P4paFmmoFEaJdoZm9Y8xo2VysH1BxbD0H
         325sfZLDkDdJcn9HeTadebhQdKckEQwrt2ltRIBrsgrDU5B6A81u73YHyG7ljPnjlsFW
         3r7w==
X-Gm-Message-State: APjAAAWwMV61NAu4iexjbmklJr5XTKnXfwHFywrmYF8NRIqM3NXhcoyN
        5m2FwQOLrs5ZveND0gQ8fJdu1Q==
X-Google-Smtp-Source: APXvYqzDz/UPzz38CvJM8x23GvvG1Z5D+kIpsV+8HBycvRSnI83xRRWGT9BVs5DNzjWtb305Kpivfw==
X-Received: by 2002:a37:9d8c:: with SMTP id g134mr1494240qke.73.1581343830661;
        Mon, 10 Feb 2020 06:10:30 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d17sm199223qkc.9.2020.02.10.06.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Feb 2020 06:10:29 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        elver@google.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] x86/mm/pat: mark an intentional data race
Date:   Mon, 10 Feb 2020 09:10:16 -0500
Message-Id: <1581343816-6490-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpa_4k_install could be accessed concurrently as noticed by KCSAN,

read to 0xffffffffaa59a000 of 8 bytes by interrupt on cpu 7:
cpa_inc_4k_install arch/x86/mm/pat/set_memory.c:131 [inline]
__change_page_attr+0x10cf/0x1840 arch/x86/mm/pat/set_memory.c:1514
__change_page_attr_set_clr+0xce/0x490 arch/x86/mm/pat/set_memory.c:1636
__set_pages_np+0xc4/0xf0 arch/x86/mm/pat/set_memory.c:2148
__kernel_map_pages+0xb0/0xc8 arch/x86/mm/pat/set_memory.c:2178
kernel_map_pages include/linux/mm.h:2719 [inline] <snip>

write to 0xffffffffaa59a000 of 8 bytes by task 1 on cpu 6:
cpa_inc_4k_install arch/x86/mm/pat/set_memory.c:131 [inline]
__change_page_attr+0x10ea/0x1840 arch/x86/mm/pat/set_memory.c:1514
__change_page_attr_set_clr+0xce/0x490 arch/x86/mm/pat/set_memory.c:1636
__set_pages_p+0xc4/0xf0 arch/x86/mm/pat/set_memory.c:2129
__kernel_map_pages+0x2e/0xc8 arch/x86/mm/pat/set_memory.c:2176
kernel_map_pages include/linux/mm.h:2719 [inline] <snip>

Both accesses are due to the same "cpa_4k_install++" in
cpa_inc_4k_install. A data race here could be potentially undesirable:
depending on compiler optimizations or how x86 executes a non-LOCK'd
increment, it may lose increments, corrupt the counter, etc. Since this
counter only seems to be used for printing some stats, this data race
itself is unlikely to cause harm to the system though. Thus, mark this
intentional data race using the data_race() marco.

Suggested-by: Macro Elver <elver@google.com>
Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/x86/mm/pat/set_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index c4aedd00c1ba..ea0b6df950ee 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -128,7 +128,7 @@ static inline void cpa_inc_2m_checked(void)
 
 static inline void cpa_inc_4k_install(void)
 {
-	cpa_4k_install++;
+	data_race(cpa_4k_install++);
 }
 
 static inline void cpa_inc_lp_sameprot(int level)
-- 
1.8.3.1

