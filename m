Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85FEC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 04:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5DB22522
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 04:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="tBAYxoa0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgA2EUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 23:20:30 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43192 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgA2EUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 23:20:30 -0500
Received: by mail-qt1-f196.google.com with SMTP id d18so12246232qtj.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 20:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YM4OJsNfZ+Cg/1QyXpcZd//8p772lihOuiLpGLKYKgo=;
        b=tBAYxoa0LP9S6BVo0xwNO6RFKmWwFseh0I4ad83I/ovAIpLNwY3jGjSbvb8/EE11jA
         322Jc3BAu4ampLF0Kl0KZdrvmplWNQ+pwXTMicz0kgsot56ugzrbCVtzGj8NA72lopiF
         IXNVRujAb/kjdeh3Wjnw3iylsl2vKXQv9YpJsJNECeT2Xsh3nZfOIx8OLTL0QRSymD9o
         s4R79a+qgLO7MTiQ7Zwo9BsRq/+siFKiMK1W+Zt7aTRzKW1JWLmLHo4ZWdX9rzLaTRLf
         192X3yGqDaGtIqNcgVLoBFpvyCobAD4pFybkMYtPChUyGuhI0xW6Qai35x1YL8aR0mOc
         6IfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YM4OJsNfZ+Cg/1QyXpcZd//8p772lihOuiLpGLKYKgo=;
        b=swqjp9a+ifdzPCiwFRcVXk4oHgsAYbK5lwUOF6cBYpsmmNpW47eCSrP9/1l2JUT2Ev
         zQ/DOrNgjGNsHTOSunGZaPY6Q+ykvOMgx1vLI/KT0Ue5y+2FofrH9ZHPMbRmJyfj4ZfE
         fB4KzAK3w3oC3NNYhGJ64Jb/CKbjKgtUMRdx0MnhKR+V/RWS/gFOMNGl0er4HuNTdG91
         E3PnQIAB+U9lQswdZta8vIyUTGSxN1cqz+EMCZfM1VNx+XorcZV1PO2i3pFz3zJte3Qm
         BcGoRAanX1jSFkMtn5by5svvwezgM5HQMY4ZPjbj12E/PhygjRG9aMAr/usx0Pd7TU+d
         yhWA==
X-Gm-Message-State: APjAAAVcUyKNnOe2bMrKoApx/go4eqKE+cA8xAyJUhjmBChoTtteqEoB
        yAl5GKoeQwXPSGXTw+7jMCOkTADODE4JzQ==
X-Google-Smtp-Source: APXvYqxNOUDfMDbEmpgP46ytX31I8ri4xVc/Mgt9EiYdhovVnqIvbJLp4JcBOFq+G4DAiJFilo9jug==
X-Received: by 2002:ac8:6f5b:: with SMTP id n27mr14407953qtv.96.1580271628969;
        Tue, 28 Jan 2020 20:20:28 -0800 (PST)
Received: from ovpn-120-127.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id i28sm487275qtc.57.2020.01.28.20.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jan 2020 20:20:28 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm/page_counter: mark intentional data races
Date:   Tue, 28 Jan 2020 23:20:19 -0500
Message-Id: <20200129042019.3632-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 3e32cb2e0a12 ("mm: memcontrol: lockless page counters")
had memcg->memsw->failcnt and ->watermark could be accessed concurrently
as reported by KCSAN,

 Reported by Kernel Concurrency Sanitizer on:
 BUG: KCSAN: data-race in page_counter_try_charge / page_counter_try_charge

 read to 0xffff8fb18c4cd190 of 8 bytes by task 1081 on cpu 59:
  page_counter_try_charge+0x4d/0x150 mm/page_counter.c:138
  try_charge+0x131/0xd50
  __memcg_kmem_charge_memcg+0x58/0x140
  __memcg_kmem_charge+0xcc/0x280
  __alloc_pages_nodemask+0x1e1/0x450
  alloc_pages_current+0xa6/0x120
  pte_alloc_one+0x17/0xd0
  __pte_alloc+0x3a/0x1f0
  copy_p4d_range+0xc36/0x1990
  copy_page_range+0x21d/0x360
  dup_mmap+0x5f5/0x7a0
  dup_mm+0xa2/0x240
  copy_process+0x1b3f/0x3460
  _do_fork+0xaa/0xa20
  __x64_sys_clone+0x13b/0x170
  do_syscall_64+0x91/0xb47
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

 write to 0xffff8fb18c4cd190 of 8 bytes by task 1153 on cpu 120:
  page_counter_try_charge+0x5b/0x150 mm/page_counter.c:139
  try_charge+0x131/0xd50
  mem_cgroup_try_charge+0x159/0x460
  mem_cgroup_try_charge_delay+0x3d/0xa0
  wp_page_copy+0x14d/0x930
  do_wp_page+0x107/0x7b0
  __handle_mm_fault+0xce6/0xd40
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x6f9
  page_fault+0x34/0x40

Since the failcnt and watermark are tolerant of some inaccuracy, a data
race will not be harmful, thus mark them as intentional data races with
the data_race() macro.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/page_counter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/page_counter.c b/mm/page_counter.c
index de31470655f6..13934636eafd 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -82,8 +82,8 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
 		 * This is indeed racy, but we can live with some
 		 * inaccuracy in the watermark.
 		 */
-		if (new > c->watermark)
-			c->watermark = new;
+		if (data_race(new > c->watermark))
+			data_race(c->watermark = new);
 	}
 }
 
@@ -126,7 +126,7 @@ bool page_counter_try_charge(struct page_counter *counter,
 			 * This is racy, but we can live with some
 			 * inaccuracy in the failcnt.
 			 */
-			c->failcnt++;
+			data_race(c->failcnt++);
 			*fail = c;
 			goto failed;
 		}
@@ -135,8 +135,8 @@ bool page_counter_try_charge(struct page_counter *counter,
 		 * Just like with failcnt, we can live with some
 		 * inaccuracy in the watermark.
 		 */
-		if (new > c->watermark)
-			c->watermark = new;
+		if (data_race(new > c->watermark))
+			data_race(c->watermark = new);
 	}
 	return true;
 
-- 
2.21.0 (Apple Git-122.2)

