Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210B8C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 04:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02DA2073D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 04:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ZDK/UqEw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgAUEMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 23:12:13 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:46028 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgAUEMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 23:12:12 -0500
Received: by mail-qv1-f66.google.com with SMTP id l14so819715qvu.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 20:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zAi8wBwQtdv/htMLe3u3FcIw3h3KwZj8juXiFcTYGYs=;
        b=ZDK/UqEw0XqiZnYO+Pky67ulRYAWc1L5B6GP6w5ao6rISw8tZp9p64KZt1+uYotG60
         Lb1UJMTpR08GeLxPirtTO3I2jBnzDWOd8taSYJ+qCL/v9Ev6JJBH8o+44xI929H2ybh/
         Gu8JOMZdyrWUnGdVgmnAfFemEwgnFFps2z+GZO42PjXRZPeED4w23AYNTi+6yacPmRSb
         wc18GflbmLgFOQlUVXBUePxieneLesJQlzspGzfR0d4Cq0IGw1tE1nbrO3f72v1eUnGA
         +SnZ1x+yxGVXDb/qZJYfCw7XGIKvkC+755MWXk3ZuXcznI3KXxuu/T0TLF78VF4iR9A0
         amEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zAi8wBwQtdv/htMLe3u3FcIw3h3KwZj8juXiFcTYGYs=;
        b=HMAetbQhmIRpQrYN1KFn6faw39oFZbmD9sv1DdPlH5GK7Kxjj7oRDVklrOY9ehDfZo
         gpYOW02v2SzzOUFcBrcZxchE3X/wzhPm1W8yQ2WNnfdsDzaDD0jJ+YepY55Dnru6KvuO
         F1Pd3eoMsDxIvVelq7ed2rnBx1HAoPM0U9vzMQubRxM3V/rXrUjClEjapzg14it2KRl/
         rtiLHyLKrt3ZETp8y2ncMXCHmxwzmw9Rj2tTfw9uD4CszIVIE9RIFNBWn3TNgUuyqqn0
         rTkFSHvwyKeAhBPjX/slnVlij4t6Eq4G24mjn9+rGZpE8/ThPwGbOYD6tzO/YNLjBgaX
         2Flg==
X-Gm-Message-State: APjAAAX+A/DmxI8sUh1YjzUUJcu/BpPsRKk5Naftm1oJkL4Bt17irZGl
        rU8Tb0qwNDqNEV6RUSihsBKBoQ==
X-Google-Smtp-Source: APXvYqyFENq2WQaf/Har1fozdBolPwXesQ8aZ9+9Paq/FZHhoKT2LRY5j9fzCgoLBxlmfInQlQDiKQ==
X-Received: by 2002:a0c:904b:: with SMTP id o69mr3089139qvo.218.1579579931501;
        Mon, 20 Jan 2020 20:12:11 -0800 (PST)
Received: from ovpn-123-97.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y18sm16566705qki.0.2020.01.20.20.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 20:12:10 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        elver@google.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] x86/mm/pat: fix a data race in cpa_inc_4k_install
Date:   Mon, 20 Jan 2020 23:12:00 -0500
Message-Id: <20200121041200.2260-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macro Elver mentioned,

"Yes. I was finally able to reproduce this data race on linux-next (my
system doesn't crash though, maybe not enough cores?). Here is a trace
with line numbers:

read to 0xffffffffaa59a000 of 8 bytes by interrupt on cpu 7:
cpa_inc_4k_install arch/x86/mm/pat/set_memory.c:131 [inline]
__change_page_attr+0x10cf/0x1840 arch/x86/mm/pat/set_memory.c:1514
__change_page_attr_set_clr+0xce/0x490 arch/x86/mm/pat/set_memory.c:1636
__set_pages_np+0xc4/0xf0 arch/x86/mm/pat/set_memory.c:2148
__kernel_map_pages+0xb0/0xc8 arch/x86/mm/pat/set_memory.c:2178
kernel_map_pages include/linux/mm.h:2719 [inline]
<snip>

write to 0xffffffffaa59a000 of 8 bytes by task 1 on cpu 6:
cpa_inc_4k_install arch/x86/mm/pat/set_memory.c:131 [inline]
__change_page_attr+0x10ea/0x1840 arch/x86/mm/pat/set_memory.c:1514
__change_page_attr_set_clr+0xce/0x490 arch/x86/mm/pat/set_memory.c:1636
__set_pages_p+0xc4/0xf0 arch/x86/mm/pat/set_memory.c:2129
__kernel_map_pages+0x2e/0xc8 arch/x86/mm/pat/set_memory.c:2176
kernel_map_pages include/linux/mm.h:2719 [inline]
<snip>

Both accesses are due to the same "cpa_4k_install++" in
cpa_inc_4k_install. Now you can see that a data race here could be
potentially undesirable: depending on compiler optimizations or how
x86 executes a non-LOCK'd increment, you may lose increments, corrupt
the counter, etc. Since this counter only seems to be used for
printing some stats, this data race itself is unlikely to cause harm
to the system though."

This will generate a lot of noise on a debug kernel with debug_pagealloc
with KCSAN enabled which could render the system unusable. Fix it by
adding a pair of READ_ONCE() and WRITE_ONCE().

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/x86/mm/pat/set_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 20823392f4f2..31e4a73ae70e 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -128,7 +128,7 @@ static inline void cpa_inc_2m_checked(void)
 
 static inline void cpa_inc_4k_install(void)
 {
-	cpa_4k_install++;
+	WRITE_ONCE(cpa_4k_install, READ_ONCE(cpa_4k_install) + 1);
 }
 
 static inline void cpa_inc_lp_sameprot(int level)
-- 
2.21.0 (Apple Git-122.2)

