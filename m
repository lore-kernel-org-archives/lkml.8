Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3D8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AD5B206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592873054;
	bh=VWjVUGNmFlVkvNEThVXbyf9Imml5f0wPVHRhk67aEU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=06pKk8NNsl+p9J0jxtipBWRjTwV15trmCnaJZT5g4OwjPzDVXW39jRaT5jSr7RRzk
	 GO3nGzxXCeRbep2nGQOw00bM1ixQJjrqaer+MtDduUxAGZpUVImuHQZAMeCvIur7PH
	 01X8d39KigqLA5F9XVrRSeKqSb+0bnnAk37Wfvh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbgFWAoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:44:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732151AbgFWAng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:43:36 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BD5C20780;
        Tue, 23 Jun 2020 00:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592873015;
        bh=VWjVUGNmFlVkvNEThVXbyf9Imml5f0wPVHRhk67aEU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rnEmpZkIHFrWoSSrNmjzXdITRuekXzwXZjqXSn0zi+oVujIagEpVoz0UEnCzmDUUO
         0ORBoQDmBh+qMGzhVE9NEFDApmYqWf5ZmIqTRj+7fUhbSHC7VG9A36fhhYKBYSUbeL
         JZv8ya+WgGkByFE0qdiGij8kc5SAFSUOBjz/Q1mw=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/10] x86/mm/pat: Mark an intentional data race
Date:   Mon, 22 Jun 2020 17:43:25 -0700
Message-Id: <20200623004333.27227-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai <cai@lca.pw>

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
Acked-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 77e0430..d1b2a88 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -135,7 +135,7 @@ static inline void cpa_inc_2m_checked(void)
 
 static inline void cpa_inc_4k_install(void)
 {
-	cpa_4k_install++;
+	data_race(cpa_4k_install++);
 }
 
 static inline void cpa_inc_lp_sameprot(int level)
-- 
2.9.5

