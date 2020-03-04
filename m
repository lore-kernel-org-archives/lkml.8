Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B4AC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 03:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A692072D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 03:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="NEIRv/73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387536AbgCDDP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 22:15:59 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34977 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387400AbgCDDP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 22:15:59 -0500
Received: by mail-qt1-f196.google.com with SMTP id v15so354784qto.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 19:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4kiEZ5DesLUkAEBTkuBnO20IBPZNQsn0omcUZaMfRT4=;
        b=NEIRv/73SzSmWJ0yLUM11OLMogRLYSsMwLvGgZNKYbP0T9ndjtkpPfmMXoeezvmBSM
         14CdeAfCTzDtxPOSnGpcNs+a0SxqYqHwmkAJZbIBzdFB4nFCdUefwK/bGk4LFadylX7/
         JlTELnaZTI5yKnXtaniGiJKR5HuV6xSXHOQpy174eeoW782y2BZ40FoWkiDCGd++bpwk
         IttQUBWsNnziLNmRMCesIX1knHZBNMXmCOXGGDtKBBBH6kRsYCJcS8jkLngWOGjbSgSQ
         O+LilhhYOS6Gnxrpa1ZgYexSnk47pvFxLNTH0yV1x4yssZiRlgAVB4B8Fs0kYJtynBZL
         jp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4kiEZ5DesLUkAEBTkuBnO20IBPZNQsn0omcUZaMfRT4=;
        b=HcJr2YEu/3knjp+GnDXg95hVmEARJZ3KDlBHKCcDWe+7mMbY+yt8+uqXzS4kyxjhd+
         JfgH8NayT0HaHXQE9Zuzh+gCTZN6QRvL73SWWKiu56y1bZCg0huylXahdrGfJ3e0W1Ey
         1zaQOORoZY1cKxVl1AZ3p+eL5tV4ztmee61gjqx1ldQ/6SRSc4S9QQ0xyyap+Kk16b6R
         ozFbaRP2R/kKPR2ofBslWVluMX3T5p4dlQe7+QRfGwL2UgKwuVwkMSmjyMl/GND/h/43
         +5myTwz7CpeNgPJr2zji5IyW7+ExuPCM+lvCs6c8Tu4puvvy6mKLPKL1HB0Whtp2Sqzc
         rqzg==
X-Gm-Message-State: ANhLgQ0c+zZc23Liovnl7pJVIG8W1Vh68FLSs2i20p0M0OqezVwDhRYU
        NvcC70/g7QV5HjfmOcq0sg7k7Q==
X-Google-Smtp-Source: ADFU+vuBBXJ4wMw3FSQsRPxi7wztl7TklF1G1fpylm1IVQc53ECSYCK9r4Iq/mPZED08lRgTyOHg6w==
X-Received: by 2002:aed:32a3:: with SMTP id z32mr609371qtd.216.1583291758233;
        Tue, 03 Mar 2020 19:15:58 -0800 (PST)
Received: from ovpn-121-139.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id k13sm8094668qkk.113.2020.03.03.19.15.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2020 19:15:57 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     paulmck@kernel.org
Cc:     willy@infradead.org, elver@google.com,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] lib: disable KCSAN for XArray
Date:   Tue,  3 Mar 2020 22:15:51 -0500
Message-Id: <20200304031551.1326-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions like xas_find_marked(), xas_set_mark(), and xas_clear_mark()
could happen concurrently result in data races, but those operate only
on a single bit that are pretty much harmless. For example,

 write to 0xffffa0020ee705c8 of 8 bytes by task 39718 on cpu 0:
  xas_set_mark+0x8e/0x190
  arch___test_and_set_bit at arch/x86/include/asm/bitops.h:152
  (inlined by) __test_and_set_bit at include/asm-generic/bitops/instrumented-non-atomic.h:72
  (inlined by) node_set_mark at lib/xarray.c:93
  (inlined by) xas_set_mark at lib/xarray.c:879
  __test_set_page_writeback+0x5de/0x8c0
  iomap_writepage_map+0x8c6/0xf90
  iomap_do_writepage+0x12b/0x450
  write_cache_pages+0x523/0xb20
  iomap_writepages+0x47/0x80
  xfs_file_fsync+0xeb/0x450 [xfs]
  do_writepages+0x5e/0x130
  __filemap_fdatawrite_range+0x19e/0x1f0
  file_write_and_wait_range+0xc0/0x100
  xfs_file_fsync+0xeb/0x450 [xfs]
  vfs_fsync_range+0x71/0x110
  __x64_sys_msync+0x210/0x2a0
  do_syscall_64+0x91/0xb05
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

 read to 0xffffa0020ee705c8 of 8 bytes by task 39717 on cpu 5:
  xas_find_marked+0xe9/0x750
  xas_find_chunk at include/linux/xarray.h:1625
  (inlined by) xas_find_marked at lib/xarray.c:1198
  find_get_pages_range_tag+0x1bf/0xa90
  pagevec_lookup_range_tag+0x46/0x70
  __filemap_fdatawait_range+0xbb/0x270
  file_write_and_wait_range+0xe0/0x100
  xfs_file_fsync+0xeb/0x450 [xfs]
  vfs_fsync_range+0x71/0x110
  __x64_sys_msync+0x210/0x2a0
  do_syscall_64+0x91/0xb05
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Signed-off-by: Qian Cai <cai@lca.pw>
---
 lib/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/Makefile b/lib/Makefile
index 523dfe2063e2..989e702c275b 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -28,6 +28,11 @@ endif
 # Used by KCSAN while enabled, avoid recursion.
 KCSAN_SANITIZE_random32.o := n
 
+# This produces frequent data race reports: most of them are due to races on
+# the same word but accesses to a single bit of that word. Re-enable KCSAN
+# for this when we have more consensus on what to do about them.
+KCSAN_SANITIZE_xarray.o := n
+
 lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 rbtree.o radix-tree.o timerqueue.o xarray.o \
 	 idr.o extable.o sha1.o irq_regs.o argv_split.o \
-- 
2.21.0 (Apple Git-122.2)

